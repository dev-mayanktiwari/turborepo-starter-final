-- CreateEnum
CREATE TYPE "TxnStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED');

-- CreateTable
CREATE TABLE "admin" (
    "adminId" TEXT NOT NULL,
    "walletAddress" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "admin_pkey" PRIMARY KEY ("adminId")
);

-- CreateTable
CREATE TABLE "task" (
    "taskId" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "maxParticipants" INTEGER NOT NULL DEFAULT 10,
    "totalReward" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "trasactionHash" TEXT NOT NULL,
    "adminId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "task_pkey" PRIMARY KEY ("taskId")
);

-- CreateTable
CREATE TABLE "user" (
    "userId" TEXT NOT NULL,
    "walletAddress" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "pendingAmount" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "lockedAmount" DOUBLE PRECISION NOT NULL DEFAULT 0.0,

    CONSTRAINT "user_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "time_analytics" (
    "id" SERIAL NOT NULL,
    "timeTaken" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    "taskId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "time_analytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "option" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "taskId" INTEGER NOT NULL,

    CONSTRAINT "option_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payout" (
    "payoutId" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "status" "TxnStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payout_pkey" PRIMARY KEY ("payoutId")
);

-- CreateTable
CREATE TABLE "submission" (
    "submissionId" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "taskId" INTEGER NOT NULL,
    "optionId" INTEGER NOT NULL,
    "submittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "submission_pkey" PRIMARY KEY ("submissionId")
);

-- CreateIndex
CREATE UNIQUE INDEX "admin_walletAddress_key" ON "admin"("walletAddress");

-- CreateIndex
CREATE UNIQUE INDEX "user_walletAddress_key" ON "user"("walletAddress");

-- CreateIndex
CREATE UNIQUE INDEX "time_analytics_userId_taskId_key" ON "time_analytics"("userId", "taskId");

-- CreateIndex
CREATE UNIQUE INDEX "submission_userId_taskId_key" ON "submission"("userId", "taskId");

-- AddForeignKey
ALTER TABLE "task" ADD CONSTRAINT "task_adminId_fkey" FOREIGN KEY ("adminId") REFERENCES "admin"("adminId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "time_analytics" ADD CONSTRAINT "time_analytics_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "time_analytics" ADD CONSTRAINT "time_analytics_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "task"("taskId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "option" ADD CONSTRAINT "option_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "task"("taskId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payout" ADD CONSTRAINT "payout_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "submission" ADD CONSTRAINT "submission_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "submission" ADD CONSTRAINT "submission_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "task"("taskId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "submission" ADD CONSTRAINT "submission_optionId_fkey" FOREIGN KEY ("optionId") REFERENCES "option"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
