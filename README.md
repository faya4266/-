# 803 / 804 语文打卡积分统计

## 打开方式

- 教师端：<https://faya4266.github.io/-/index.html>
- 班级展示屏：<https://faya4266.github.io/-/display.html>（也可打开 `语文打卡展示屏.html`）

> 仓库名为 `-`，所以地址里带有 `/-/`。功能不受影响。

## 多设备共用数据

GitHub Pages 上请使用 Supabase 同步（WorkBuddy 云端仅适用于原来的分享链接）：

1. 在 Supabase 新建项目，进入 SQL Editor，执行本仓库的 `supabase_sync.sql`。
2. 进入 Project Settings → API，复制 Project URL 和 anon public key（不要用 service_role）。
3. 打开教师端页面 →「云端同步」→ 粘贴 URL 和 anon key → 连接。
4. 展示屏打开同一页面后会自动读取同一份数据。

也可以把 URL 和 key 填入 `config.js` 后重新提交，这样所有打开页面的人都不用手动输入。

## 文件说明

- `index.html`：教师端（打卡、积分、免作业、统计、设置、云端同步入口）
- `display.html` / `语文打卡展示屏.html`：只读展示屏
- `config.js`：可选的 Supabase 配置
- `supabase_sync.sql`：建表与同步函数脚本
- `.nojekyll`：保证 GitHub Pages 正确处理文件
