document.addEventListener('DOMContentLoaded', function() {
    const previewText = document.getElementById('preview-text');
    const fontSizeSlider = document.getElementById('font-size');
    const fontSizeDisplay = document.getElementById('font-size-display');
    const fontPreview = document.getElementById('font-preview');

    // プレビューテキストの更新
    if (previewText && fontPreview) {
      previewText.addEventListener('input', function() {
        const text = this.value || 'サンプルテキスト';
        fontPreview.textContent = text;
      });
    }

    // フォントサイズの更新
    if (fontSizeSlider && fontSizeDisplay && fontPreview) {
      fontSizeSlider.addEventListener('input', function() {
        const size = this.value;
        fontSizeDisplay.textContent = size + 'px';
        fontPreview.style.fontSize = size + 'px';
      });
    }
});