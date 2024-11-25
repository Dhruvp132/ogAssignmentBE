-- DropForeignKey
ALTER TABLE "Replies" DROP CONSTRAINT "Replies_id_fkey";

-- AlterTable
ALTER TABLE "Replies" ADD COLUMN     "parentId" TEXT;

-- AddForeignKey
ALTER TABLE "Replies" ADD CONSTRAINT "Replies_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Posts"("postId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Replies" ADD CONSTRAINT "Replies_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Replies"("id") ON DELETE SET NULL ON UPDATE CASCADE;
