-- DropForeignKey
ALTER TABLE "Replies" DROP CONSTRAINT "Replies_parentId_fkey";

-- DropForeignKey
ALTER TABLE "Replies" DROP CONSTRAINT "Replies_postId_fkey";

-- AlterTable
ALTER TABLE "Replies" ALTER COLUMN "Like" SET DEFAULT false,
ALTER COLUMN "DisLike" SET DEFAULT false;

-- AddForeignKey
ALTER TABLE "Replies" ADD CONSTRAINT "Replies_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Posts"("postId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replies" ADD CONSTRAINT "Replies_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Replies"("id") ON DELETE CASCADE ON UPDATE CASCADE;
