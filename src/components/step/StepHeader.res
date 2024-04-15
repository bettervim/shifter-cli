open Ink
open InkUI

@react.component
let make = (~number, ~children) => {
  <Box gap={1}>
    <Badge color="green"> {(number + 1)->Int.toString->s} </Badge>
    <Text> {children} </Text>
  </Box>
}
