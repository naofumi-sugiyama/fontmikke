function adjustDropdownPosition() {
  const dropdown = document.getElementById('user-dropdown');
  const button = document.getElementById('user-menu-button');
  
  if (!dropdown || !button) return;
  
  // まず初期状態にリセット
  dropdown.style.left = '0';
  dropdown.style.right = 'auto';
  dropdown.classList.remove('dropdown-right');
  
  // 位置を再計算
  setTimeout(() => {
    const dropdownRect = dropdown.getBoundingClientRect();
    const windowWidth = window.innerWidth;
    const scrollbarWidth = 20;
    
    console.log('ドロップダウンの右端:', dropdownRect.right);
    console.log('ウィンドウ幅:', windowWidth);
    
    if (dropdownRect.right > windowWidth - scrollbarWidth) {
      dropdown.style.left = 'auto';
      dropdown.style.right = '0';
      dropdown.classList.add('dropdown-right');
      console.log('ドロップダウンを右寄せに調整しました');
    } else {
      console.log('ドロップダウンは通常位置で表示中');
    }
  }, 50);
}

// ★統合されたDOMContentLoadedイベント
document.addEventListener('DOMContentLoaded', function() {
  
  // ===========================================
  // モバイルメニュー制御
  // ===========================================
  const mobileMenuButton = document.getElementById('mobile-menu-button');
  const mobileMenu = document.getElementById('mobile-menu');

  if (mobileMenuButton && mobileMenu) {
    mobileMenuButton.addEventListener('click', function() {
      mobileMenu.classList.toggle('hidden');
    });

    // メニュー外をクリックしたら閉じる
    document.addEventListener('click', function(event) {
      if (!mobileMenuButton.contains(event.target) && !mobileMenu.contains(event.target)) {
        mobileMenu.classList.add('hidden');
      }
    });
  }

  // ===========================================
  // デスクトップ用：ユーザーメニューのプルダウン制御
  // ===========================================
  const userMenuButton = document.getElementById('user-menu-button');
  const userDropdown = document.getElementById('user-dropdown');
  const dropdownArrow = document.getElementById('dropdown-arrow');

  if (userMenuButton && userDropdown) {
    
    // ★クリック制御（デスクトップ・モバイル共通）
    userMenuButton.addEventListener('click', function(e) {
      e.stopPropagation();
      const isHidden = userDropdown.classList.contains('hidden');
      
      if (isHidden) {
        // メニューを表示
        userDropdown.classList.remove('hidden');
        userDropdown.style.display = 'block';
        if (dropdownArrow) dropdownArrow.style.transform = 'rotate(180deg)';
        
        // 位置調整を実行
        adjustDropdownPosition();
      } else {
        // メニューを非表示
        userDropdown.classList.add('hidden');
        userDropdown.style.display = 'none';
        if (dropdownArrow) dropdownArrow.style.transform = 'rotate(0deg)';
      }
    });

    // ★ホバー制御（デスクトップのみ - 画面幅768px以上）
    function handleHover() {
      if (window.innerWidth >= 768) {
        
        userMenuButton.addEventListener('mouseenter', function() {
          if (userDropdown.classList.contains('hidden')) {
            userDropdown.classList.remove('hidden');
            userDropdown.style.display = 'block';
            if (dropdownArrow) dropdownArrow.style.transform = 'rotate(180deg)';
            
            setTimeout(() => {
              adjustDropdownPosition();
            }, 10);
          }
        });

        userMenuButton.addEventListener('mouseleave', function() {
          setTimeout(() => {
            if (!userDropdown.matches(':hover') && !userMenuButton.matches(':hover')) {
              userDropdown.classList.add('hidden');
              userDropdown.style.display = 'none';
              if (dropdownArrow) dropdownArrow.style.transform = 'rotate(0deg)';
            }
          }, 100);
        });

        userDropdown.addEventListener('mouseenter', function() {
          userDropdown.classList.remove('hidden');
          userDropdown.style.display = 'block';
        });
        
        userDropdown.addEventListener('mouseleave', function() {
          userDropdown.classList.add('hidden');
          userDropdown.style.display = 'none';
          if (dropdownArrow) dropdownArrow.style.transform = 'rotate(0deg)';
        });
      }
    }

    // 初回実行
    handleHover();

    // 外部クリックでユーザーメニューを閉じる
    document.addEventListener('click', function(event) {
      if (!userMenuButton.contains(event.target) && !userDropdown.contains(event.target)) {
        userDropdown.classList.add('hidden');
        userDropdown.style.display = 'none';
        if (dropdownArrow) dropdownArrow.style.transform = 'rotate(0deg)';
      }
    });

    // ウィンドウリサイズ時の処理
    window.addEventListener('resize', function() {
      if (!userDropdown.classList.contains('hidden')) {
        adjustDropdownPosition();
      }
      
      // 画面サイズが変わったらホバーイベントを再設定
      handleHover();
    });
  }

  // ===========================================
  // モバイル用：アカウント設定サブメニューの制御
  // ===========================================
  const mobileAccountToggle = document.getElementById('mobile-account-toggle');
  const mobileAccountSubmenu = document.getElementById('mobile-account-submenu');
  const mobileAccountArrow = document.getElementById('mobile-account-arrow');

  if (mobileAccountToggle && mobileAccountSubmenu && mobileAccountArrow) {
    mobileAccountToggle.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      
      const isHidden = mobileAccountSubmenu.classList.contains('hidden');
      
      if (isHidden) {
        mobileAccountSubmenu.classList.remove('hidden');
        mobileAccountArrow.style.transform = 'rotate(180deg)';
      } else {
        mobileAccountSubmenu.classList.add('hidden');
        mobileAccountArrow.style.transform = 'rotate(0deg)';
      }
    });
  }
});