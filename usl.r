benchmark <- read.csv("cisco-bench.txt", sep="")
usl <- nls(
    tput ~ lambda * size / (1 + sigma * (size-1) + kappa * size * (size-1)),
    benchmark,
    start=c(sigma=0.1, kappa=0.01, lambda=1000)
)
summary(usl)
lambda <- coef(usl)['lambda']
sigma <- coef(usl)['sigma']
kappa <- coef(usl)['kappa']

u = function(x) {
    y = x * lambda / (1 + sigma * (x-1) + kappa * x * (x-1))
}
plot(u, 0, max(benchmark$size) * 2, xlab="N concurrency threads/nodes", ylab="X(N) throughput QPS", lty="dashed")
points(benchmark$size, benchmark$tput)
