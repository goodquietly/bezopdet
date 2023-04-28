import { Controller } from '@hotwired/stimulus';
import flatpickr from 'flatpickr';
import { Russian } from 'flatpickr/dist/l10n/ru.js';

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    document.addEventListener('turbo:load', function () {
      flatpickr('.notice_time', {
        enableTime: true,
        dateFormat: 'j F Y h:i',
        time_24hr: true,
        locale: Russian,
        minDate: 'today',
        minTime: '08:00',
      });
    });
  }
}
