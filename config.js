/* ============================================================
   云端共享配置（GitHub Pages 专用）
   把你的 Supabase 项目地址和 anon public key 填到下面两个引号里。
   填一次即可，教师端和展示屏都会读取这里，实现所有设备共用同一份数据。

   获取方式：Supabase 项目后台 → Project Settings → API
     - Project URL：形如 https://xxxx.supabase.co
     - anon public key：以 eyJhbGciOi 开头的长字符串（不要用 service_role）

   先在该 Supabase 项目 SQL Editor 执行 supabase_sync.sql 建表脚本。
   ============================================================ */
window.SUPABASE_CONFIG = {
  url: 'https://ooqyttmnkhxkpmyltbyi.supabase.co',
  key: 'sb_publishable_QRLtkWQxf2EzhEVyM3f49Q_-9mlQVy9'
};
