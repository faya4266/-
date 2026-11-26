# 803 / 804 语文打卡积分统计

## 两个版本

- **国内分享链接（学校用）**：<https://chinese-checkin-scores.app.workbuddy.host/?sharecode=5S7FOHNU2K>
  - 固定使用 WorkBuddy 云端，不依赖 github.io / supabase.co
  - 学校网络只需浏览器打开，不用安装任何软件
  - 展示屏：<https://chinese-checkin-scores.app.workbuddy.host/语文打卡展示屏.html?sharecode=5S7FOHNU2K>
- **GitHub Pages 版本（校外用）**：<https://faya4266.github.io/-/index.html>
  - 使用 Supabase 同步，配置在 `config.js`

> 两套版本的数据源不同，分别独立。学校统一用国内链接即可。

## 本目录说明

当前目录内容已切回 WorkBuddy 云端版，用于发布国内分享链接。
页面加载时会主动清除浏览器里残留的 Supabase 配置，避免覆盖默认云端；
云端网关短暂失败后会自动重试并在恢复时更新同步状态。

- `index.html`：教师端
- `display.html` / `语文打卡展示屏.html`：只读展示屏
- `supabase_sync.sql`：GitHub 版使用的 Supabase 建表脚本
- `.nojekyll`：GitHub Pages 配置
