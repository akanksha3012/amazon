//import from packages
const express = require('express');
const mongoose = require('mongoose');
//import 'package:express/express.dart'

//import from other files
const authRouter = require('./routes/auth.js');
const adminRouter = require('./routes/admin.js');
const productRouter = require('./routes/product.js');
const userRouter = require('./routes/user.js');

//init
const port=3000;
const app = express();
const DB="mongodb+srv://burnwalakanksha30:Khushi123%25@cluster0.lz19obz.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

//middleware
//client -> middleware -> server -> client
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);
//GET, PUT, POST, DELETE, UPDATE -> CRUD

//connection
mongoose.connect(DB).then(() => {
console.log('connection successsful');
}).catch((e) => {
    console.log(e);
});
app.listen(port, "0.0.0.0", () => {
    console.log(`connect at port ${port}`);
})
//localhost