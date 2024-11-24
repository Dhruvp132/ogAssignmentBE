const express = require("express");
const cors = require("cors");
const PORT = require("./config");
const { PrismaClient } = require("@prisma/client");

const app = express()

const prisma = new PrismaClient();

app.use(express.json())
app.use(cors()); 

app.post("/createPost", async (req, res) => {
    const post = await prisma.posts.create({
        data: {
            Content : req.body.Content, 
            DateCreated: new Date(), 
            Like: false, 
            DisLike: false
        }, 
    })
    res.status(200).json({
        post, 
        message : "post created succesfully"
    })
})

app.get("/posts/:postId", async (req, res) => {
    const post = await prisma.posts.findUnique({
        where: { postId: req.params.postId },
        include: {
            Replies: {
                orderBy: { DateCreated: "desc" },
                include: {
                    ChildReplies: {
                        orderBy: { DateCreated: "desc" },
                        include: {
                            ChildReplies: {
                                orderBy: { DateCreated: "desc" },
                            },
                        },
                    },
                },
            },
        },
    });
    if (!post) {
        return res.status(404).json({ error: "Post not found" });
    }
    res.status(200).json({ post });
});


app.get("/posts", async (req, res) => {
    const posts = await prisma.posts.findMany({
        orderBy: { DateCreated: "desc" },
    });
    res.status(200).json({ posts });
});



app.post("/reply", async (req, res) => {
    const { postId, content, parentId } = req.body;  

    const reply = await prisma.replies.create({
        data: {
            Content: content,
            postId: postId,
            parentId: parentId || null,  
            Like: false,
            DisLike: false
        }
    });
    res.status(200).json({
        reply, message: "created reply"
    });
});

app.get("/replies/:id", async (req, res) => {
    const { id } = req.params;
    const replies = await prisma.replies.findMany({
        where: {
            OR: [
                { postId: id },
                { parentId: id }
            ]
        },
        orderBy: { DateCreated: 'desc' }
    });
    res.status(200).json({ replies });
});


app.delete("/deletePost/:postId", async (req, res) => {
    const { postId } = req.params;
    await prisma.replies.deleteMany({
        where: {
            postId: postId
        }
    });

    const deletedPost = await prisma.posts.delete({
        where: {
            postId: postId
        }
    });

    res.status(200).json({
        message: "Post deleted successfully",
        deletedPost
    });
});

app.delete("/deleteReply/:replyId", async (req, res) => {
    const { replyId } = req.params;

    const deletedReply = await prisma.replies.delete({
        where: {
            id: replyId
        }
    });

    res.status(200).json({
        message: "Reply deleted successfully",
        deletedReply
    });
    
});

app.listen(PORT, () => {
    console.log("listening on port");
    console.log(PORT)
}); 
