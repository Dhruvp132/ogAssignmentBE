-- CreateTable
CREATE TABLE "Posts" (
    "postId" TEXT NOT NULL,
    "Content" TEXT NOT NULL,
    "DateCreated" TIMESTAMP(3) NOT NULL,
    "Like" BOOLEAN NOT NULL,
    "DisLike" BOOLEAN NOT NULL,

    CONSTRAINT "Posts_pkey" PRIMARY KEY ("postId")
);

-- CreateTable
CREATE TABLE "Replies" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "Content" TEXT NOT NULL,
    "Like" BOOLEAN NOT NULL,
    "DisLike" BOOLEAN NOT NULL,

    CONSTRAINT "Replies_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Replies" ADD CONSTRAINT "Replies_id_fkey" FOREIGN KEY ("id") REFERENCES "Posts"("postId") ON DELETE RESTRICT ON UPDATE CASCADE;
