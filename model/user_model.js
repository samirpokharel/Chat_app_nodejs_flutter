const mongoose = require("mongoose");
const becryptjs = require("bcryptjs");

const userSchema = new mongoose.Schema({
  username: {
    type: String,
    lowercase: true,
    unique: true,
    required: [true, "Please Enter Username"],
  },
  password: {
    type: String,
    minLength: [6, "Enter more than 6 character "],
    require: [true, "Please enter Password"],
  },
  isActive: { type: Boolean, rquired: true, default: false },
});
userSchema.pre("save", async function (next) {
  const salt = await becryptjs.genSalt(10);
  const hashPassword = await becryptjs.hash(this.password, salt);
  this.password = hashPassword;
});

userSchema.statics.login = async function (username, password) {
  const user = await this.findOne({ username });
  if (user) {
    const auth = await becryptjs.compare(password, user.password);
    if (auth) return user;
    throw Error("Invalid Password");
  }
  throw Error("Invalid Username");
};

const User = mongoose.model("users", userSchema);
module.exports.User = User;
module.exports.userSchema = userSchema;
