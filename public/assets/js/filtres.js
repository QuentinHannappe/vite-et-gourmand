const form = document.querySelector('form');

if (form) {
    form.addEventListener('change', function() {
      const formData = new FormData(form);
      const params = new URLSearchParams(formData);

    fetch('/menus?' + params.toString())
     .then(response => response.text())
     .then(html => {
      const parser = new DOMParser();
      const doc = parser.parseFromString(html, 'text/html');
      const newMenus = doc.querySelector('#menus-container');
      document.querySelector('#menus-container').innerHTML = newMenus.innerHTML;
    });
    });
}