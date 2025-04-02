import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
    connect() {
        this.showNotification()
    }

    
    showNotification() {
        document.getElementById("task-notification-modal").classList.remove("hidden");
        document.getElementById("task-notification-modal").innerHTML()
        document.getElementById("close_modal").addEventListener("click", function() {
            document.getElementById("task-notification-modal").classList.add("hidden");
        })
    }
}