{
  function f(x, y) {
    mstore(0x80, x)
    if calldataload(0) { sstore(y, y) }
  }

  f(0, 0)
}
// ====
// EVMVersion: >=shanghai
// stackOptimization: true
// ----
//     /* "":90:97   */
//   tag_2
//     /* "":95:96   */
//   0x00
//     /* "":90:97   */
//   dup1
//   tag_1
//   jump	// in
// tag_2:
//     /* "":0:99   */
//   stop
//     /* "":4:86   */
// tag_1:
//     /* "":34:38   */
//   0x80
//     /* "":27:42   */
//   mstore
//     /* "":63:64   */
//   0x00
//     /* "":50:65   */
//   calldataload
//     /* "":47:82   */
//   tag_3
//   jumpi
//     /* "":21:86   */
// tag_4:
//     /* "":4:86   */
//   pop
//   jump	// out
//     /* "":66:82   */
// tag_3:
//     /* "":68:80   */
//   dup1
//   sstore
//     /* "":66:82   */
//   0x00
//   jump(tag_4)
