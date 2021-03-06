\name{cm2}
\alias{cm2}
\title{
Conditional Maximization Routine for the Indirect Estimation of Origin-Destination Migration Flow Table with Known Margins.
}
\description{
The \code{cm2} function finds the maximum likelihood estimates for parameters in the log-linear model:
\deqn{ \log y_{ij} = \log \alpha_i + \log \beta_j + \log m_{ij} }
as introduced by Willekens (1999). The  \eqn{\alpha_i} and  \eqn{\beta_j} represent background information related to  the characteristics of the origin and destinations respectively. The  \eqn{m_{ij}} factor represents auxiliary information on migration flows, which imposes its interaction structure onto the estimated flow matrix.
}
\usage{
cm2(rtot = NULL, ctot = NULL, m = matrix(1, length(rtot), length(ctot)), 
    tol = 1e-05, maxit = 500, verbose = TRUE)
}
\arguments{
  \item{rtot}{
Origin (row) totals to constrain indirect estimates to.
}
  \item{ctot}{
Destination (column) totals to constrain indirect estimates to.
}
  \item{m}{
Auxiliary matrix. By default set to 1 for all origin-destination combinations.
}
  \item{tol}{
Tolerance level for parameter estimation.
}
  \item{maxit}{
Maximum number of iterations for parameter estimation.
}
  \item{verbose}{
Print the parameter estimates at each iteration. By default \code{TRUE}.
}
}
\details{
Parameter estimates are obtained using the EM algorithm outlined in Willekens (1999). This is equivalent to a conditional maximization of the likelihood, as discussed by Raymer et. al. (2007). It also provides identical indirect estimates to those obtained from the \code{\link{ipf2}} routine. 

The user must ensure that the row and column totals are equal in sum. Care must also be taken to allow the dimension of the auxiliary matrix (\code{m}) to equal those provided in the row (\code{rtot}) and column (\code{ctot}) arguments.
}
\value{
Returns a \code{list} object with
  \item{N }{Origin-Destination matrix of indirect estimates}
  \item{theta }{Collection of parameter estimates}
}
\references{
Raymer, J., G. J. Abel, and P. W. F. Smith (2007). Combining census and registration data to estimate detailed elderly migration flows in England and Wales. \emph{Journal of the Royal Statistical Society: Series A (Statistics in Society)} 170 (4), 891--908.

Willekens, F. (1999). Modelling Approaches to the Indirect Estimation of Migration Flows: From Entropy to EM. \emph{Mathematical Population Studies} 7 (3), 239--78.
}
\author{
Guy J. Abel
}
\seealso{
\code{\link{ipf2}}
}
\examples{
## with Willekens (1999) data
dn <- LETTERS[1:2]
y <- cm2(rtot = c(18, 20), ctot = c(16, 22), m = matrix(c(5, 1, 2, 7), ncol = 2, 
        dimnames = list(orig = dn, dest = dn)))
y

## with all elements of offset equal (independence fit)
y <- cm2(rtot = c(18, 20), ctot = c(16, 22))
y

## with bigger matrix
dn <- LETTERS[1:3]
y <- cm2(rtot = c(170, 120, 410), ctot = c(500, 140, 60), 
        m = matrix(c(50, 10, 220, 120, 120, 30, 545, 0, 10), ncol = 3, 
        dimnames = list(orig = dn, dest = dn)))
# display with row and col totals
round(addmargins(y$N)) 
}
