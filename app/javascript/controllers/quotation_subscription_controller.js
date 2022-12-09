import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="quotation-subscription"
export default class extends Controller {
  static values = { quotationId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "QuotationChannel", id: this.quotationIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
    setTimeout(() => {
      this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
    }, 10);
  }

  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }

  resetForm(event) {
    event.target.reset();
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom");
    this.channel.unsubscribe();
  }
}
