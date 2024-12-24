{
    function f(a, b) -> r {
        let x := add(a,b)
        r := sub(x,a)
    }
    function g() {
        sstore(0x01, 0x0101)
    }
    function h(x) {
        h(f(x, 0))
        g()
    }
    function i() -> v, w {
        v := 0x0202
        w := 0x0303
    }
    let x, y := i()
    h(x)
    h(y)
    // This calla of g() is unreachable too as the one in h() but we wanna cover both cases.
    g()
}
// ----
// digraph CFG {
// nodesep=0.7;
// node[shape=box];
//
// Entry [label="Entry"];
// Entry -> Block0;
// Block0 [label="\
// [ ]\l\
// [ RET[i] ]\l\
// i\l\
// [ TMP[i, 0] TMP[i, 1] ]\l\
// [ TMP[i, 0] TMP[i, 1] ]\l\
// Assignment(x, y)\l\
// [ x y ]\l\
// [ x ]\l\
// h\l\
// [ ]\l\
// [ ]\l\
// "];
// Block0Exit [label="Terminated"];
// Block0 -> Block0Exit;
//
// FunctionEntry_f [label="function f(a, b) -> r\l\
// [ RET b a ]"];
// FunctionEntry_f -> Block1;
// Block1 [label="\
// [ RET a b ]\l\
// [ RET a b a ]\l\
// add\l\
// [ RET a TMP[add, 0] ]\l\
// [ RET a TMP[add, 0] ]\l\
// Assignment(x)\l\
// [ RET a x ]\l\
// [ RET a x ]\l\
// sub\l\
// [ RET TMP[sub, 0] ]\l\
// [ RET TMP[sub, 0] ]\l\
// Assignment(r)\l\
// [ RET r ]\l\
// [ r RET ]\l\
// "];
// Block1Exit [label="FunctionReturn[f]"];
// Block1 -> Block1Exit;
//
// FunctionEntry_h [label="function h(x)\l\
// [ RET x ]"];
// FunctionEntry_h -> Block2;
// Block2 [label="\
// [ RET[f] 0x00 x ]\l\
// [ RET[f] 0x00 x ]\l\
// f\l\
// [ TMP[f, 0] ]\l\
// [ TMP[f, 0] ]\l\
// h\l\
// [ ]\l\
// [ ]\l\
// "];
// Block2Exit [label="Terminated"];
// Block2 -> Block2Exit;
//
// FunctionEntry_i [label="function i() -> v, w\l\
// [ RET ]"];
// FunctionEntry_i -> Block3;
// Block3 [label="\
// [ RET ]\l\
// [ RET 0x0202 ]\l\
// Assignment(v)\l\
// [ RET v ]\l\
// [ v RET 0x0303 ]\l\
// Assignment(w)\l\
// [ v RET w ]\l\
// [ v w RET ]\l\
// "];
// Block3Exit [label="FunctionReturn[i]"];
// Block3 -> Block3Exit;
//
// }
