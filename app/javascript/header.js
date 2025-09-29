document.addEventListener('DOMContentLoaded', function() {

  // モバイルメニュー制御
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

  // デスクトップ用：ユーザーメニューのプルダウン制御
  const userMenuButton = document.getElementById('user-menu-button');
  const userDropdown = document.getElementById('user-dropdown');
  const dropdownArrow = document.getElementById('dropdown-arrow');

  if (userMenuButton && userDropdown) {
    userMenuButton.addEventListener('click', function(e) {
      e.stopPropagation(); // イベントバブリングを防ぐ
      const isHidden = userDropdown.classList.contains('hidden');
      
      if (isHidden) {
        userDropdown.classList.remove('hidden');
        dropdownArrow.style.transform = 'rotate(180deg)';
      } else {
        userDropdown.classList.add('hidden');
        dropdownArrow.style.transform = 'rotate(0deg)';
      }
    });

    // 外部クリックでユーザーメニューを閉じる
    document.addEventListener('click', function(event) {
      if (!userMenuButton.contains(event.target) && !userDropdown.contains(event.target)) {
        userDropdown.classList.add('hidden');
        dropdownArrow.style.transform = 'rotate(0deg)';
      }
    });
  }

  // モバイル用：アカウント設定サブメニューの制御
  const mobileAccountToggle = document.getElementById('mobile-account-toggle');
  const mobileAccountSubmenu = document.getElementById('mobile-account-submenu');
  const mobileAccountArrow = document.getElementById('mobile-account-arrow');

  if (mobileAccountToggle && mobileAccountSubmenu && mobileAccountArrow) {
    mobileAccountToggle.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation(); // イベントバブリングを防ぐ
      
      const isHidden = mobileAccountSubmenu.classList.contains('hidden');
      
      if (isHidden) {
        // 展開
        mobileAccountSubmenu.classList.remove('hidden');
        mobileAccountArrow.style.transform = 'rotate(180deg)';
      } else {
        // 折りたたみ
        mobileAccountSubmenu.classList.add('hidden');
        mobileAccountArrow.style.transform = 'rotate(0deg)';
      }
    });
  }
});

function adjustDropdownPosition() {
  const dropdown = document.getElementById('user-dropdown');
  const button = document.getElementById('user-menu-button');
  
  if (!dropdown || !button) return;
  
  // ドロップダウンの位置とサイズを取得
  const dropdownRect = dropdown.getBoundingClientRect();
  const windowWidth = window.innerWidth;
  
  // 画面右端からはみ出る場合（10pxのマージンを考慮）
  if (dropdownRect.right > windowWidth - 10) {
    // 右寄せに変更
    dropdown.style.left = 'auto';
    dropdown.style.right = '0';
    dropdown.classList.add('dropdown-right');
    console.log('ドロップダウンを右寄せに調整しました'); // デバッグ用
  } else {
    // 通常の左寄せ
    dropdown.style.left = '0';
    dropdown.style.right = 'auto';
    dropdown.classList.remove('dropdown-right');
    console.log('ドロップダウンを左寄せで表示しています'); // デバッグ用
  }
}

// DOMContentLoadedイベントで初期化
document.addEventListener('DOMContentLoaded', function() {
  const userMenuButton = document.getElementById('user-menu-button');
  const userDropdown = document.getElementById('user-dropdown');
  
  if (userMenuButton && userDropdown) {
    // ホバー時に位置調整を実行
    userMenuButton.addEventListener('mouseenter', function() {
      userDropdown.style.display = 'block';
      // 少し遅延させて位置調整（描画完了後に実行）
      setTimeout(() => {
        adjustDropdownPosition();
      }, 10);
    });
    
    userMenuButton.addEventListener('mouseleave', function(e) {
      // マウスがドロップダウンメニューに向かっている場合は非表示にしない
      setTimeout(() => {
        if (!userDropdown.matches(':hover') && !userMenuButton.matches(':hover')) {
          userDropdown.style.display = 'none';
        }
      }, 100); // 100ms遅延させてチェック
    });

    userDropdown.addEventListener('mouseenter', function() {
      // メニューにホバー中は表示を維持
      userDropdown.style.display = 'block';
    });
    
    userDropdown.addEventListener('mouseleave', function() {
      // メニューから離れたら非表示
      userDropdown.style.display = 'none';
    });
    
    // ウィンドウリサイズ時も調整
    window.addEventListener('resize', function() {
      if (userDropdown.style.display === 'block') {
        adjustDropdownPosition();
      }
    });
  }
});