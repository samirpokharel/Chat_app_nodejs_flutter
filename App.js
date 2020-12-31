const express = require("express");
const mongoose = require("mongoose");
const userRouter = require("./router/user_router");
const chatRouter = require("./router/conversation_route");
const cors = require("cors");
const app = express();

//middleware
app.use(express.json());
app.use(cors())

//Mongodb connection
mongoose
  .connect("mongodb://localhost/ChatApp", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then((val) => console.log("Connected to mongo db"))
  .catch((err) => console.log("Could not connect to mongo db"));
//Router
app.use("/api/users", userRouter);
app.use("/api/chat", chatRouter);

//listening to port
const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Listening to port ${port}...`));
