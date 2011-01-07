##==============================================================================
##           A Notation for Electronic Analog Computing (%analog)
##
## Main File (Run.e)                                Charlie Care - November 2004
##==============================================================================

## Definitons of EDDI tables and their ADD/REMOVE procedures
include("tables.eddi");

## Definitons of procedures that update state and perform the integration
## using information stored in EDDI tables
include("integrators.e");

## Definitions of the clocking process (including rep-op)
include("clock.e");

## Definitons to enable switching between the five modes of operation
include("modes.e");

## The definitions used to parse the notation (uses the AOP version 2.04)
include("parser.e");
