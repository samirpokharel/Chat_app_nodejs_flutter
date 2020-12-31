const { User } = require("../model/user_model");
const jwt = require("jsonwebtoken");

//handel error
function handelError(err) {
  let errors = { error: true, username: "", password: "" };
  if (err.message.includes("users validation failed")) {
    Object.values(err.errors).forEach(({ properties }) => {
      errors[properties.path] = properties.message;
    });
    return errors;
  }
  if (err.code === 11000) {
    errors.username = "That Username is already taken";
    return errors;
  }

  if (err.message.includes("Invalid Password")) {
    errors.password = "Password is incorrect";
    return errors;
  }

  if (err.message.includes("Invalid Username")) {
    errors.username = "That username is not registered";
    return errors;
  }
}
const createJWT = (id) => jwt.sign({ id }, "Chat app api key");

// control login
module.exports.login_post = async (req, res) => {
  const { username, password } = req.body;
  try {
    const user = await User.login(username, password);
    const token = createJWT(user._id);
    res.send({
      id: user._id,
      error: false,
      username: user.username,
      isActive: user.isActive,
      token,
    });
  } catch (err) {
    console.log(err);
    res.send(handelError(err));
  }
};

//control register
module.exports.signup_post = async (req, res) => {
  const { username, password } = req.body;
  try {
    const user = await User.create({ username, password });
    const token = createJWT(user._id);
    res.send({
      id: user.id,
      error: false,
      username: user.username,
      isActive: user.isActive,
      token: token,
    });
  } catch (err) {
    res.status(401).send(handelError(err));
  }
};

//list all user
module.exports.listUsers_get = async (req, res) => {
  const users = await User.find().select("_id username");
  res.send(users);
};
