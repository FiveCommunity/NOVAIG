function RequestManager() {
  var _this = this;
  setInterval(function () {
    _this.tick();
  }, 1000);
  this.requests = [];
  this.div = document.createElement("div");
  this.div.classList.add("requestManager");
  document.body.appendChild(this.div);
}

RequestManager.prototype.buildText = function (text, time) {
  return `
    <div class="content">
      <div class="message">
        <div class="icon">
          <img src="./belt.svg">
        </div>
        <div class="text">
          <h3>REQUEST</h3>
          <p>${text}</p>
        </div>
      </div>
      <p>15:65</p>
    </div>
    <div class="actions">
      <div class="action">
        <div class="icon">Y</div>
        <p>ACEITAR</p>
      </div>
      <div class="action">
        <div class="icon">U</div>
        <p>RECUSAR</p>
      </div>
    </div>
	`;
};

RequestManager.prototype.addRequest = function (id, text, time) {
  const request = {};
  request.div = document.createElement("div");
  request.div.classList.add("request");
  request.id = id;
  request.time = time - 1;
  request.text = text;
  request.div.innerHTML = this.buildText(text, time - 1);
  this.requests.push(request);
  this.div.appendChild(request.div);
};

RequestManager.prototype.respond = function (ok) {
  if (this.requests.length > 0) {
    var request = this.requests[0];
    if (this.onResponse) this.onResponse(request.id, ok);
    this.div.removeChild(request.div);
    this.requests.splice(0, 1);
  }
};

RequestManager.prototype.tick = function () {
  for (var i = this.requests.length - 1; i >= 0; i--) {
    var request = this.requests[i];
    request.time -= 1;
    request.div.innerHTML = this.buildText(request.text, request.time);
    if (request.time <= 0) {
      this.div.removeChild(request.div);
      this.requests.splice(i, 1);
    }
  }
};
