Grover.configure do |config|
  config.options = {
    format: 'A4',
    display_url: 'http://213.139.211.121',
    style_tag_options: [
      { path: './app/assets/builds/application.css' },
      { url: 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css' }
    ],
    script_tag_options: [
      { path: './app/javascript/application.js' },
      { url: 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js' }
    ],
    user_agent: 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0',
    prefer_css_page_size: true,
    emulate_media: 'screen',
    bypass_csp: true,
    scale: 1.033,
    print_background: true,
    media_features: [{ name: 'prefers-color-scheme', value: 'dark' }],
    timezone: 'Europe/Moscow',
    vision_deficiency: 'deuteranopia',
    extra_http_headers: { 'Accept-Language': 'ru-RU' },
    geolocation: { latitude: 59.95, longitude: 30.31667 },
    cache: false,
    timeout: 0,
    launch_args: ['--font-render-hinting=medium'],
    wait_until: %w[networkidle0 load domcontentloaded networkidle2]
  }
end
