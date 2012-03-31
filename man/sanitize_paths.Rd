\name{sanitize_paths}
\alias{sanitize_paths}
\title{Verify paths for copy and move operations}
\usage{
  sanitize_paths(from_path, to_path = NULL)
}
\arguments{
  \item{from_path}{source path}

  \item{to_path}{destination path. Leave blank for dropbox
  root.}
}
\value{
  list with clean paths
}
\description{
  Function is meant for internal use in
  \code{\link{dropbox_move}} and \code{\link{dropbox_copy}}
}
\examples{
\dontrun{
santize_paths(from_path, to_path)
}
}

