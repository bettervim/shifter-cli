open Ink
open InkUI

@react.component
let make = (~number, ~children) => {
  <Box gap={1}>
    <Badge color="green"> <Text bold=true>{(number + 1)->Int.toString->s}</Text> </Badge>
    <Text> {children} </Text>
  </Box>
}
