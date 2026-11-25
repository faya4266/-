-- 语文打卡积分统计 / 展示屏 —— Supabase 共享数据库
-- 直接在 Supabase 项目左侧 SQL Editor 新建查询，粘贴全部内容后 Run。
--
-- 重要：表名、行 id、函数名和参数名必须与本脚本一致，
-- 因为网页里已经按这些名字读写：
--   表：public.checkin_data
--   主数据行：id = 'main'
--   RPC：public.save_checkin(p_payload, p_expect_rev)
--
-- 本脚本采用“整份数据一个 JSONB 字段 + 版本号”的方案：
-- 多设备同时打卡时，网页会带上版本号写入；版本不一致会自动重试合并，
-- 避免后写的设备把先写的数据整份覆盖。

-- 1. 建表
create table if not exists public.checkin_data (
  id          text        primary key,
  payload     jsonb       not null default '{}'::jsonb,
  rev         bigint      not null default 0,
  updated_at  timestamptz not null default now()
);

comment on table public.checkin_data is '语文打卡积分统计共享数据：整份应用状态存 payload，rev 用于多设备冲突检测';

-- 2. 开启行级安全
alter table public.checkin_data enable row level security;

-- 3. 授权给匿名和登录用户
-- 这个班级应用无需登录，所有拿到链接的设备共用同一份数据。
-- 如果你希望只有登录用户能写，请去掉 anon 的写权限并自行加登录校验。
grant select, insert, update, delete on public.checkin_data to anon, authenticated;

-- 4. 行级安全策略：允许读取和更新这一份共享数据
drop policy if exists checkin_all on public.checkin_data;
create policy checkin_all
  on public.checkin_data
  for all
  to anon, authenticated
  using (true)
  with check (true);

-- 5. 初始化主数据行
insert into public.checkin_data (id, payload, rev)
values ('main', '{}'::jsonb, 0)
on conflict (id) do nothing;

-- 6. 原子保存函数：版本号匹配才写入，防止多设备互相覆盖
create or replace function public.save_checkin(
  p_payload jsonb,
  p_expect_rev bigint
)
returns bigint
language plpgsql
security invoker
set search_path = public
as $$
declare
  new_rev bigint;
begin
  update public.checkin_data
     set payload = p_payload,
         rev = rev + 1,
         updated_at = now()
   where id = 'main'
     and rev = p_expect_rev
  returning rev into new_rev;

  if new_rev is null then
    raise exception 'revision conflict';
  end if;

  return new_rev;
end;
$$;

-- 7. 函数执行权限
revoke all on function public.save_checkin(jsonb, bigint) from public;
grant execute on function public.save_checkin(jsonb, bigint) to anon, authenticated;

-- 8. 可选验证：执行后应看到 id=main、rev=0（或已有版本号）
-- select id, rev, updated_at, jsonb_object_keys(payload) from public.checkin_data where id = 'main';
