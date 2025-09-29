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