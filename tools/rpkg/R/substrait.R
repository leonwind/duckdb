#' Query DuckDB using Substrait
#' Method for interpreting a Substrait BLOB plan as a DuckDB Query Plan
#' It interprets and executes the query.
#'
#' @param conn A DuckDB connection, created by `dbConnect()`.
#' @param query The Protobuf-encoded Substrait Query Plan. Qack!
#' @param arrow Whether the result should be in Arrow format
#' @return A DuckDB Query Result
#' @export
duckdb_prepare_substrait <- function(conn, query, arrow = FALSE) {
  stopifnot(dbIsValid(conn))
  stopifnot(is.raw(query))
  stmt_lst <- rapi_prepare_substrait(conn@conn_ref, query)
  duckdb_result(
    connection = conn,
    stmt_lst = stmt_lst,
    arrow = arrow
  )
}

#' Query DuckDB using Substrait
#' Method for interpreting a Substrait JSON plan as a DuckDB Query Plan
#' It interprets and executes the query.
#'
#' @param conn A DuckDB connection, created by `dbConnect()`.
#' @param json The Json Query Plan. Qack!
#' @param arrow Whether the result should be in Arrow format
#' @return A DuckDB Query Result
#' @export
duckdb_prepare_substrait_json <- function(conn, json, arrow = FALSE) {
  stopifnot(dbIsValid(conn))
  stopifnot(is.character(json))
  stmt_lst <- rapi_prepare_substrait_json(conn@conn_ref, json)
  duckdb_result(
      connection = conn,
      stmt_lst = stmt_lst,
      arrow = arrow
    )
}




#' Get the Substrait plan for a SQL query
#' Transforms a SQL query into a raw vector containing the serialized Substrait query blob
#'
#' @param conn A DuckDB connection, created by `dbConnect()`.
#' @param query The query string in SQL
#' @return A raw vector containing the substrait protobuf blob
#' @export
duckdb_get_substrait <- function(conn, query) {
  stopifnot(dbIsValid(conn))
  stopifnot(is.character(query))
  rapi_get_substrait(conn@conn_ref, query)
}


#' Get the Substrait plan for a SQL query in the JSON format
#' Transforms a SQL query into a vector containing the serialized Substrait query JSON
#'
#' @param conn A DuckDB connection, created by `dbConnect()`.
#' @param query The query string in SQL
#' @return A vector containing the substrait protobuf JSON
#' @export
duckdb_get_substrait_json <- function(conn, query) {
  stopifnot(dbIsValid(conn))
  stopifnot(is.character(query))
  rapi_get_substrait_json(conn@conn_ref, query)
}
