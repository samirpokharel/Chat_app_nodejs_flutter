const Conversation = require("../model/conversation");
module.exports.message_post = async (req, res) => {
  const user1 = [req.params.senderId, req.params.reciverId];
  const user2 = [req.params.reciverId, req.params.senderId];

  const message = { sendby: req.params.senderId, message: req.body.message };
  try {
    const result = await Conversation.findOneAndUpdate(
      { $or: [{ users: user1 }, { users: user2 }] },
      { $push: { message } },
      { upsert: true, new: true, setDefaultsOnInsert: true }
    ).populate("users", "username _id");
    res.send(result);
  } catch (e) {
    console.log(e);
  }
};

module.exports.message_get = async (req, res) => {
  const user1 = [req.params.senderId, req.params.reciverId];
  const user2 = [req.params.reciverId, req.params.senderId];

  const result = await Conversation.find()
    .or([{ users: user1 }, { users: user2 }])
    .populate("users", "username _id");
  res.send(result);
};
