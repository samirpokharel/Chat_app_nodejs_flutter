const { Router } = require("express");
const userController = require("../controller/user_controller");
const router = Router();

router.post("/login", userController.login_post);
router.post("/signup", userController.signup_post);
router.get('/',userController.listUsers_get)

module.exports = router;
