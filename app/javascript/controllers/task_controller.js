import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
    connect(){
        console.log("Tasks controller connected");
    }
    static targets = ["taskForm", "titleField", "descriptionField", "titleErrorMessage", "descriptionErrorMessage"];
    toggleForm(event) {
        event.preventDefault();
        const form = this.taskFormTarget;
        if (form.classList.contains("hidden")) {
            form.classList.remove("hidden");
        } else {
            form.classList.add("hidden");
        }
    }
    validate(event) {
        let isValid = true;
        const title = this.titleFieldTarget;
        const description = this.descriptionFieldTarget;
        const titleErrorMessage = this.titleErrorMessageTarget;
        const descriptionErrorMessage = this.descriptionErrorMessageTarget;
        if(title.value.trim() === "") {
            titleErrorMessage.classList.remove("hidden");
            isValid = false;
        }
        else {
            titleErrorMessage.classList.add("hidden");
        }
        if(description.value.trim() === "") {
            descriptionErrorMessage.classList.remove("hidden");
            isValid = false;
        }
        else {
            descriptionErrorMessage.classList.add("hidden");
        }
        if(!isValid) {
            event.preventDefault();
        } else{

        }
    }
}