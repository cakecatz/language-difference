/*
  型付け   : 弱い動的型付け
  パラダイム: スクリプティング、オブジェクト指向、命令型、関数型
*/

// Primitive

var string     = "String"
var number     = 12345
var bool       = true
var _null      = null
var _undefined = undefined

// New in ECMAScript 6
var sym        = Symbol("foo");

// Function

function func(args) {

}

var func = function(args) {

}

// Note: Two above functions is not equal.