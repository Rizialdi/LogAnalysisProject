#!/usr/bin/env python
# newsdata.py -- implementation of a Log analysis
import psycopg2


def connect(databASe_name="news"):
    try:
        db = psycopg2.connect("dbname={}".format(databASe_name))
        cursor = db.cursor()
        return db, cursor
    except:
        print("<error message>")


def get_query_results(query):
    db, cursor = connect()
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    db.close()
    return result


"""Which articles have been accessed the most
    a sorted list with the most popular article at the top."""
popularArticles = get_query_results(
                "SELECT articles.title AS Title, "
                "count(path) AS Time FROM articles JOIN Log ON "
                "trans(articles.slug) = Log.path GROUP BY Title"
                " ORDER BY Time DESC;")
"""Which articles have been accessed the most
    a sorted list with the most popular article at the top."""
author_rank = get_query_results("SELECT * FROM author_rank ;")
"""On which days did more than 1% of requests lead to errors.
        it return the date in format YYYY, MM, DD the corresponding
        error percentage """
error_day = get_query_results("SELECT * FROM days WHERE value > 2;")


if __name__ == '__main__':
    print "The most popular articles:"
    for article in popularArticles:
        print article[0] + " - " + str(article[1]) + " views"
    print "The most read author:"
    for author in author_rank:
        print author[0] + " - " + str(author[1]) + " views"
    print "The day with more than 2 percent error:"
    for error in error_day:
        print str(error[0]) + " - " + str(error[1]) + " %"
