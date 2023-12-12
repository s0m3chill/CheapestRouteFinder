# CheapestRouteFinder

An app that assists users in finding the cheapest routes between destinations using Dijkstra's Algorithm

## Prerequisites

Swift 5.9

XCode 15.0.1 (15A507)

## Achieved

Completed all 5 requirements (along with BONUS one) and followed all the instructions

Used TDD, Protocol - oriented programming and separations of concerns

Added logical checks before calculating route: Are cities set and not empty, are cities different and not the same

Handled loading and error states of the app

Anticipated and implemented L10N logic

## Possible improvements

General UI/UX. I was mostly focused on app architecture rather than UI, because one can always find a room for for UI improvements :)

Need to add support for different JSON models. As for now only supports JSON from the URL from test assignment. <br/>

Usage of single 'AutocompleteObject' instead of 2 for different text fields.

Performance improvement of offloading cheapest route calculation from the main thread (not needed for small number of Connections like in the test url)
