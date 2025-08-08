// フォントプレビュー機能
document.addEventListener('DOMContentLoaded', function() {
    console.log('Font preview script loaded!');
    
    const textInput = document.getElementById('preview-text');
    const fontSizeSlider = document.getElementById('font-size');
    const fontSizeDisplay = document.getElementById('font-size-display');
    const styleFilter = document.getElementById('style-filter');
    const genreFilter = document.getElementById('genre-filter');
    const previewTexts = document.querySelectorAll('.preview-text');
    const fontCards = document.querySelectorAll('[data-style]');
    
    // 要素の存在確認
    if (!textInput || !fontSizeSlider || !previewTexts.length) {
      console.log('必要な要素が見つかりません');
      return;
    }
    
    // テキスト更新機能
    function updatePreviewText() {
      const inputValue = textInput.value || 'こんにちは';
      previewTexts.forEach(function(element) {
        element.textContent = inputValue;
      });
    }
    
    // 文字サイズ更新機能
    function updateFontSize() {
      const fontSize = fontSizeSlider.value + 'px';
      fontSizeDisplay.textContent = fontSize;
      previewTexts.forEach(function(element) {
        element.style.fontSize = fontSize;
      });
    }
    
    // フィルター機能
    function applyFilters() {
      if (!styleFilter || !genreFilter || !fontCards.length) return;
      
      const selectedStyle = styleFilter.value;
      const selectedGenre = genreFilter.value;
      
      fontCards.forEach(function(card) {
        const cardStyle = card.dataset.style;
        const cardGenre = card.dataset.genre;
        
        const showCard = (!selectedStyle || cardStyle === selectedStyle) && 
                        (!selectedGenre || cardGenre === selectedGenre);
        
        card.style.display = showCard ? 'block' : 'none';
      });
    }
    
    // イベントリスナー設定
    textInput.addEventListener('input', updatePreviewText);
    fontSizeSlider.addEventListener('input', updateFontSize);
    
    if (styleFilter) styleFilter.addEventListener('change', applyFilters);
    if (genreFilter) genreFilter.addEventListener('change', applyFilters);
    
    // 初期化
    updatePreviewText();
    updateFontSize();
  });
