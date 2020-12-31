const { Router } = require("express");
const chatController = require("../controller/conversation_controller");
const router = Router();

router.post("/:senderId/:reciverId", chatController.message_post);
router.get("/:senderId/:reciverId", chatController.message_get);

module.exports = router;
