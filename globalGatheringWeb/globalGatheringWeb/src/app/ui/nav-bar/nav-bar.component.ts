import { Component ,Renderer2 } from '@angular/core';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrl: './nav-bar.component.css'
})
export class NavBarComponent {

  constructor(private renderer: Renderer2) {}

 toggleSidebar() {
  const sidebar = document.querySelector('.docs-sidebar');
  if (sidebar) {
    if (sidebar.classList.contains('hidden')) {
      this.renderer.removeClass(sidebar, 'hidden');
    } else {
      this.renderer.addClass(sidebar, 'hidden');
    }
  }
}

}
