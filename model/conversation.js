const mongoose = require("mongoose");

const conversationSchema = new mongoose.Schema({
  users: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "users",
      required: true,
    },
  ],
  message: [
    {
      sendby: mongoose.Schema.Types.ObjectId,
      message: { required: true, type: String },
    },
  ],
});

const Conversation = mongoose.model("conversatons", conversationSchema);
module.exports = Conversation;
