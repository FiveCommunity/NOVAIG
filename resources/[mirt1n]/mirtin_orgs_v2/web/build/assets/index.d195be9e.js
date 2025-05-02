function zd(e, t) {
  for (var n = 0; n < t.length; n++) {
      const r = t[n];
      if (typeof r != "string" && !Array.isArray(r)) {
          for (const i in r)
              if (i !== "default" && !(i in e)) {
                  const o = Object.getOwnPropertyDescriptor(r, i);
                  o && Object.defineProperty(e, i, o.get ? o : {
                      enumerable: !0,
                      get: () => r[i]
                  })
              }
      }
  }
  return Object.freeze(Object.defineProperty(e, Symbol.toStringTag, {
      value: "Module"
  }))
}
(function() {
  const t = document.createElement("link").relList;
  if (t && t.supports && t.supports("modulepreload"))
      return;
  for (const i of document.querySelectorAll('link[rel="modulepreload"]'))
      r(i);
  new MutationObserver(i => {
      for (const o of i)
          if (o.type === "childList")
              for (const a of o.addedNodes)
                  a.tagName === "LINK" && a.rel === "modulepreload" && r(a)
  }
  ).observe(document, {
      childList: !0,
      subtree: !0
  });
  function n(i) {
      const o = {};
      return i.integrity && (o.integrity = i.integrity),
      i.referrerpolicy && (o.referrerPolicy = i.referrerpolicy),
      i.crossorigin === "use-credentials" ? o.credentials = "include" : i.crossorigin === "anonymous" ? o.credentials = "omit" : o.credentials = "same-origin",
      o
  }
  function r(i) {
      if (i.ep)
          return;
      i.ep = !0;
      const o = n(i);
      fetch(i.href, o)
  }
}
)();
function El(e) {
  return e && e.__esModule && Object.prototype.hasOwnProperty.call(e, "default") ? e.default : e
}
var E = {
  exports: {}
}
, H = {};
/**
* @license React
* react.production.min.js
*
* Copyright (c) Facebook, Inc. and its affiliates.
*
* This source code is licensed under the MIT license found in the
* LICENSE file in the root directory of this source tree.
*/
var pi = Symbol.for("react.element")
, np = Symbol.for("react.portal")
, rp = Symbol.for("react.fragment")
, ip = Symbol.for("react.strict_mode")
, op = Symbol.for("react.profiler")
, ap = Symbol.for("react.provider")
, sp = Symbol.for("react.context")
, lp = Symbol.for("react.forward_ref")
, up = Symbol.for("react.suspense")
, cp = Symbol.for("react.memo")
, dp = Symbol.for("react.lazy")
, Bu = Symbol.iterator;
function fp(e) {
  return e === null || typeof e != "object" ? null : (e = Bu && e[Bu] || e["@@iterator"],
  typeof e == "function" ? e : null)
}
var Hd = {
  isMounted: function() {
      return !1
  },
  enqueueForceUpdate: function() {},
  enqueueReplaceState: function() {},
  enqueueSetState: function() {}
}
, Bd = Object.assign
, $d = {};
function dr(e, t, n) {
  this.props = e,
  this.context = t,
  this.refs = $d,
  this.updater = n || Hd
}
dr.prototype.isReactComponent = {};
dr.prototype.setState = function(e, t) {
  if (typeof e != "object" && typeof e != "function" && e != null)
      throw Error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.");
  this.updater.enqueueSetState(this, e, t, "setState")
}
;
dr.prototype.forceUpdate = function(e) {
  this.updater.enqueueForceUpdate(this, e, "forceUpdate")
}
;
function Ud() {}
Ud.prototype = dr.prototype;
function Nl(e, t, n) {
  this.props = e,
  this.context = t,
  this.refs = $d,
  this.updater = n || Hd
}
var Cl = Nl.prototype = new Ud;
Cl.constructor = Nl;
Bd(Cl, dr.prototype);
Cl.isPureReactComponent = !0;
var $u = Array.isArray
, Zd = Object.prototype.hasOwnProperty
, Pl = {
  current: null
}
, Gd = {
  key: !0,
  ref: !0,
  __self: !0,
  __source: !0
};
function Wd(e, t, n) {
  var r, i = {}, o = null, a = null;
  if (t != null)
      for (r in t.ref !== void 0 && (a = t.ref),
      t.key !== void 0 && (o = "" + t.key),
      t)
          Zd.call(t, r) && !Gd.hasOwnProperty(r) && (i[r] = t[r]);
  var s = arguments.length - 2;
  if (s === 1)
      i.children = n;
  else if (1 < s) {
      for (var l = Array(s), u = 0; u < s; u++)
          l[u] = arguments[u + 2];
      i.children = l
  }
  if (e && e.defaultProps)
      for (r in s = e.defaultProps,
      s)
          i[r] === void 0 && (i[r] = s[r]);
  return {
      $$typeof: pi,
      type: e,
      key: o,
      ref: a,
      props: i,
      _owner: Pl.current
  }
}
function mp(e, t) {
  return {
      $$typeof: pi,
      type: e.type,
      key: t,
      ref: e.ref,
      props: e.props,
      _owner: e._owner
  }
}
function Al(e) {
  return typeof e == "object" && e !== null && e.$$typeof === pi
}
function hp(e) {
  var t = {
      "=": "=0",
      ":": "=2"
  };
  return "$" + e.replace(/[=:]/g, function(n) {
      return t[n]
  })
}
var Uu = /\/+/g;
function Na(e, t) {
  return typeof e == "object" && e !== null && e.key != null ? hp("" + e.key) : t.toString(36)
}
function Wi(e, t, n, r, i) {
  var o = typeof e;
  (o === "undefined" || o === "boolean") && (e = null);
  var a = !1;
  if (e === null)
      a = !0;
  else
      switch (o) {
      case "string":
      case "number":
          a = !0;
          break;
      case "object":
          switch (e.$$typeof) {
          case pi:
          case np:
              a = !0
          }
      }
  if (a)
      return a = e,
      i = i(a),
      e = r === "" ? "." + Na(a, 0) : r,
      $u(i) ? (n = "",
      e != null && (n = e.replace(Uu, "$&/") + "/"),
      Wi(i, t, n, "", function(u) {
          return u
      })) : i != null && (Al(i) && (i = mp(i, n + (!i.key || a && a.key === i.key ? "" : ("" + i.key).replace(Uu, "$&/") + "/") + e)),
      t.push(i)),
      1;
  if (a = 0,
  r = r === "" ? "." : r + ":",
  $u(e))
      for (var s = 0; s < e.length; s++) {
          o = e[s];
          var l = r + Na(o, s);
          a += Wi(o, t, n, l, i)
      }
  else if (l = fp(e),
  typeof l == "function")
      for (e = l.call(e),
      s = 0; !(o = e.next()).done; )
          o = o.value,
          l = r + Na(o, s++),
          a += Wi(o, t, n, l, i);
  else if (o === "object")
      throw t = String(e),
      Error("Objects are not valid as a React child (found: " + (t === "[object Object]" ? "object with keys {" + Object.keys(e).join(", ") + "}" : t) + "). If you meant to render a collection of children, use an array instead.");
  return a
}
function Ai(e, t, n) {
  if (e == null)
      return e;
  var r = []
    , i = 0;
  return Wi(e, r, "", "", function(o) {
      return t.call(n, o, i++)
  }),
  r
}
function pp(e) {
  if (e._status === -1) {
      var t = e._result;
      t = t(),
      t.then(function(n) {
          (e._status === 0 || e._status === -1) && (e._status = 1,
          e._result = n)
      }, function(n) {
          (e._status === 0 || e._status === -1) && (e._status = 2,
          e._result = n)
      }),
      e._status === -1 && (e._status = 0,
      e._result = t)
  }
  if (e._status === 1)
      return e._result.default;
  throw e._result
}
var ke = {
  current: null
}
, Qi = {
  transition: null
}
, gp = {
  ReactCurrentDispatcher: ke,
  ReactCurrentBatchConfig: Qi,
  ReactCurrentOwner: Pl
};
function Qd() {
  throw Error("act(...) is not supported in production builds of React.")
}
H.Children = {
  map: Ai,
  forEach: function(e, t, n) {
      Ai(e, function() {
          t.apply(this, arguments)
      }, n)
  },
  count: function(e) {
      var t = 0;
      return Ai(e, function() {
          t++
      }),
      t
  },
  toArray: function(e) {
      return Ai(e, function(t) {
          return t
      }) || []
  },
  only: function(e) {
      if (!Al(e))
          throw Error("React.Children.only expected to receive a single React element child.");
      return e
  }
};
H.Component = dr;
H.Fragment = rp;
H.Profiler = op;
H.PureComponent = Nl;
H.StrictMode = ip;
H.Suspense = up;
H.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = gp;
H.act = Qd;
H.cloneElement = function(e, t, n) {
  if (e == null)
      throw Error("React.cloneElement(...): The argument must be a React element, but you passed " + e + ".");
  var r = Bd({}, e.props)
    , i = e.key
    , o = e.ref
    , a = e._owner;
  if (t != null) {
      if (t.ref !== void 0 && (o = t.ref,
      a = Pl.current),
      t.key !== void 0 && (i = "" + t.key),
      e.type && e.type.defaultProps)
          var s = e.type.defaultProps;
      for (l in t)
          Zd.call(t, l) && !Gd.hasOwnProperty(l) && (r[l] = t[l] === void 0 && s !== void 0 ? s[l] : t[l])
  }
  var l = arguments.length - 2;
  if (l === 1)
      r.children = n;
  else if (1 < l) {
      s = Array(l);
      for (var u = 0; u < l; u++)
          s[u] = arguments[u + 2];
      r.children = s
  }
  return {
      $$typeof: pi,
      type: e.type,
      key: i,
      ref: o,
      props: r,
      _owner: a
  }
}
;
H.createContext = function(e) {
  return e = {
      $$typeof: sp,
      _currentValue: e,
      _currentValue2: e,
      _threadCount: 0,
      Provider: null,
      Consumer: null,
      _defaultValue: null,
      _globalName: null
  },
  e.Provider = {
      $$typeof: ap,
      _context: e
  },
  e.Consumer = e
}
;
H.createElement = Wd;
H.createFactory = function(e) {
  var t = Wd.bind(null, e);
  return t.type = e,
  t
}
;
H.createRef = function() {
  return {
      current: null
  }
}
;
H.forwardRef = function(e) {
  return {
      $$typeof: lp,
      render: e
  }
}
;
H.isValidElement = Al;
H.lazy = function(e) {
  return {
      $$typeof: dp,
      _payload: {
          _status: -1,
          _result: e
      },
      _init: pp
  }
}
;
H.memo = function(e, t) {
  return {
      $$typeof: cp,
      type: e,
      compare: t === void 0 ? null : t
  }
}
;
H.startTransition = function(e) {
  var t = Qi.transition;
  Qi.transition = {};
  try {
      e()
  } finally {
      Qi.transition = t
  }
}
;
H.unstable_act = Qd;
H.useCallback = function(e, t) {
  return ke.current.useCallback(e, t)
}
;
H.useContext = function(e) {
  return ke.current.useContext(e)
}
;
H.useDebugValue = function() {}
;
H.useDeferredValue = function(e) {
  return ke.current.useDeferredValue(e)
}
;
H.useEffect = function(e, t) {
  return ke.current.useEffect(e, t)
}
;
H.useId = function() {
  return ke.current.useId()
}
;
H.useImperativeHandle = function(e, t, n) {
  return ke.current.useImperativeHandle(e, t, n)
}
;
H.useInsertionEffect = function(e, t) {
  return ke.current.useInsertionEffect(e, t)
}
;
H.useLayoutEffect = function(e, t) {
  return ke.current.useLayoutEffect(e, t)
}
;
H.useMemo = function(e, t) {
  return ke.current.useMemo(e, t)
}
;
H.useReducer = function(e, t, n) {
  return ke.current.useReducer(e, t, n)
}
;
H.useRef = function(e) {
  return ke.current.useRef(e)
}
;
H.useState = function(e) {
  return ke.current.useState(e)
}
;
H.useSyncExternalStore = function(e, t, n) {
  return ke.current.useSyncExternalStore(e, t, n)
}
;
H.useTransition = function() {
  return ke.current.useTransition()
}
;
H.version = "18.3.1";
(function(e) {
  e.exports = H
}
)(E);
const T = El(E.exports)
, kl = zd({
  __proto__: null,
  default: T
}, [E.exports]);
var Zo = {
  exports: {}
}
, Be = {}
, Kd = {
  exports: {}
}
, Yd = {};
/**
* @license React
* scheduler.production.min.js
*
* Copyright (c) Facebook, Inc. and its affiliates.
*
* This source code is licensed under the MIT license found in the
* LICENSE file in the root directory of this source tree.
*/
(function(e) {
  function t(b, I) {
      var _ = b.length;
      b.push(I);
      e: for (; 0 < _; ) {
          var F = _ - 1 >>> 1
            , Y = b[F];
          if (0 < i(Y, I))
              b[F] = I,
              b[_] = Y,
              _ = F;
          else
              break e
      }
  }
  function n(b) {
      return b.length === 0 ? null : b[0]
  }
  function r(b) {
      if (b.length === 0)
          return null;
      var I = b[0]
        , _ = b.pop();
      if (_ !== I) {
          b[0] = _;
          e: for (var F = 0, Y = b.length, rn = Y >>> 1; F < rn; ) {
              var at = 2 * (F + 1) - 1
                , Rn = b[at]
                , je = at + 1
                , on = b[je];
              if (0 > i(Rn, _))
                  je < Y && 0 > i(on, Rn) ? (b[F] = on,
                  b[je] = _,
                  F = je) : (b[F] = Rn,
                  b[at] = _,
                  F = at);
              else if (je < Y && 0 > i(on, _))
                  b[F] = on,
                  b[je] = _,
                  F = je;
              else
                  break e
          }
      }
      return I
  }
  function i(b, I) {
      var _ = b.sortIndex - I.sortIndex;
      return _ !== 0 ? _ : b.id - I.id
  }
  if (typeof performance == "object" && typeof performance.now == "function") {
      var o = performance;
      e.unstable_now = function() {
          return o.now()
      }
  } else {
      var a = Date
        , s = a.now();
      e.unstable_now = function() {
          return a.now() - s
      }
  }
  var l = []
    , u = []
    , f = 1
    , d = null
    , m = 3
    , p = !1
    , v = !1
    , x = !1
    , P = typeof setTimeout == "function" ? setTimeout : null
    , y = typeof clearTimeout == "function" ? clearTimeout : null
    , h = typeof setImmediate < "u" ? setImmediate : null;
  typeof navigator < "u" && navigator.scheduling !== void 0 && navigator.scheduling.isInputPending !== void 0 && navigator.scheduling.isInputPending.bind(navigator.scheduling);
  function g(b) {
      for (var I = n(u); I !== null; ) {
          if (I.callback === null)
              r(u);
          else if (I.startTime <= b)
              r(u),
              I.sortIndex = I.expirationTime,
              t(l, I);
          else
              break;
          I = n(u)
      }
  }
  function S(b) {
      if (x = !1,
      g(b),
      !v)
          if (n(l) !== null)
              v = !0,
              D(M);
          else {
              var I = n(u);
              I !== null && Me(S, I.startTime - b)
          }
  }
  function M(b, I) {
      v = !1,
      x && (x = !1,
      y(N),
      N = -1),
      p = !0;
      var _ = m;
      try {
          for (g(I),
          d = n(l); d !== null && (!(d.expirationTime > I) || b && !U()); ) {
              var F = d.callback;
              if (typeof F == "function") {
                  d.callback = null,
                  m = d.priorityLevel;
                  var Y = F(d.expirationTime <= I);
                  I = e.unstable_now(),
                  typeof Y == "function" ? d.callback = Y : d === n(l) && r(l),
                  g(I)
              } else
                  r(l);
              d = n(l)
          }
          if (d !== null)
              var rn = !0;
          else {
              var at = n(u);
              at !== null && Me(S, at.startTime - I),
              rn = !1
          }
          return rn
      } finally {
          d = null,
          m = _,
          p = !1
      }
  }
  var A = !1
    , C = null
    , N = -1
    , R = 5
    , O = -1;
  function U() {
      return !(e.unstable_now() - O < R)
  }
  function ue() {
      if (C !== null) {
          var b = e.unstable_now();
          O = b;
          var I = !0;
          try {
              I = C(!0, b)
          } finally {
              I ? pe() : (A = !1,
              C = null)
          }
      } else
          A = !1
  }
  var pe;
  if (typeof h == "function")
      pe = function() {
          h(ue)
      }
      ;
  else if (typeof MessageChannel < "u") {
      var ae = new MessageChannel
        , qe = ae.port2;
      ae.port1.onmessage = ue,
      pe = function() {
          qe.postMessage(null)
      }
  } else
      pe = function() {
          P(ue, 0)
      }
      ;
  function D(b) {
      C = b,
      A || (A = !0,
      pe())
  }
  function Me(b, I) {
      N = P(function() {
          b(e.unstable_now())
      }, I)
  }
  e.unstable_IdlePriority = 5,
  e.unstable_ImmediatePriority = 1,
  e.unstable_LowPriority = 4,
  e.unstable_NormalPriority = 3,
  e.unstable_Profiling = null,
  e.unstable_UserBlockingPriority = 2,
  e.unstable_cancelCallback = function(b) {
      b.callback = null
  }
  ,
  e.unstable_continueExecution = function() {
      v || p || (v = !0,
      D(M))
  }
  ,
  e.unstable_forceFrameRate = function(b) {
      0 > b || 125 < b ? console.error("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported") : R = 0 < b ? Math.floor(1e3 / b) : 5
  }
  ,
  e.unstable_getCurrentPriorityLevel = function() {
      return m
  }
  ,
  e.unstable_getFirstCallbackNode = function() {
      return n(l)
  }
  ,
  e.unstable_next = function(b) {
      switch (m) {
      case 1:
      case 2:
      case 3:
          var I = 3;
          break;
      default:
          I = m
      }
      var _ = m;
      m = I;
      try {
          return b()
      } finally {
          m = _
      }
  }
  ,
  e.unstable_pauseExecution = function() {}
  ,
  e.unstable_requestPaint = function() {}
  ,
  e.unstable_runWithPriority = function(b, I) {
      switch (b) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
          break;
      default:
          b = 3
      }
      var _ = m;
      m = b;
      try {
          return I()
      } finally {
          m = _
      }
  }
  ,
  e.unstable_scheduleCallback = function(b, I, _) {
      var F = e.unstable_now();
      switch (typeof _ == "object" && _ !== null ? (_ = _.delay,
      _ = typeof _ == "number" && 0 < _ ? F + _ : F) : _ = F,
      b) {
      case 1:
          var Y = -1;
          break;
      case 2:
          Y = 250;
          break;
      case 5:
          Y = 1073741823;
          break;
      case 4:
          Y = 1e4;
          break;
      default:
          Y = 5e3
      }
      return Y = _ + Y,
      b = {
          id: f++,
          callback: I,
          priorityLevel: b,
          startTime: _,
          expirationTime: Y,
          sortIndex: -1
      },
      _ > F ? (b.sortIndex = _,
      t(u, b),
      n(l) === null && b === n(u) && (x ? (y(N),
      N = -1) : x = !0,
      Me(S, _ - F))) : (b.sortIndex = Y,
      t(l, b),
      v || p || (v = !0,
      D(M))),
      b
  }
  ,
  e.unstable_shouldYield = U,
  e.unstable_wrapCallback = function(b) {
      var I = m;
      return function() {
          var _ = m;
          m = I;
          try {
              return b.apply(this, arguments)
          } finally {
              m = _
          }
      }
  }
}
)(Yd);
(function(e) {
  e.exports = Yd
}
)(Kd);
/**
* @license React
* react-dom.production.min.js
*
* Copyright (c) Facebook, Inc. and its affiliates.
*
* This source code is licensed under the MIT license found in the
* LICENSE file in the root directory of this source tree.
*/
var yp = E.exports
, ze = Kd.exports;
function L(e) {
  for (var t = "https://reactjs.org/docs/error-decoder.html?invariant=" + e, n = 1; n < arguments.length; n++)
      t += "&args[]=" + encodeURIComponent(arguments[n]);
  return "Minified React error #" + e + "; visit " + t + " for the full message or use the non-minified dev environment for full errors and additional helpful warnings."
}
var Xd = new Set
, Zr = {};
function kn(e, t) {
  tr(e, t),
  tr(e + "Capture", t)
}
function tr(e, t) {
  for (Zr[e] = t,
  e = 0; e < t.length; e++)
      Xd.add(t[e])
}
var Et = !(typeof window > "u" || typeof window.document > "u" || typeof window.document.createElement > "u")
, ds = Object.prototype.hasOwnProperty
, vp = /^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/
, Zu = {}
, Gu = {};
function xp(e) {
  return ds.call(Gu, e) ? !0 : ds.call(Zu, e) ? !1 : vp.test(e) ? Gu[e] = !0 : (Zu[e] = !0,
  !1)
}
function wp(e, t, n, r) {
  if (n !== null && n.type === 0)
      return !1;
  switch (typeof t) {
  case "function":
  case "symbol":
      return !0;
  case "boolean":
      return r ? !1 : n !== null ? !n.acceptsBooleans : (e = e.toLowerCase().slice(0, 5),
      e !== "data-" && e !== "aria-");
  default:
      return !1
  }
}
function Sp(e, t, n, r) {
  if (t === null || typeof t > "u" || wp(e, t, n, r))
      return !0;
  if (r)
      return !1;
  if (n !== null)
      switch (n.type) {
      case 3:
          return !t;
      case 4:
          return t === !1;
      case 5:
          return isNaN(t);
      case 6:
          return isNaN(t) || 1 > t
      }
  return !1
}
function Te(e, t, n, r, i, o, a) {
  this.acceptsBooleans = t === 2 || t === 3 || t === 4,
  this.attributeName = r,
  this.attributeNamespace = i,
  this.mustUseProperty = n,
  this.propertyName = e,
  this.type = t,
  this.sanitizeURL = o,
  this.removeEmptyString = a
}
var ve = {};
"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style".split(" ").forEach(function(e) {
  ve[e] = new Te(e,0,!1,e,null,!1,!1)
});
[["acceptCharset", "accept-charset"], ["className", "class"], ["htmlFor", "for"], ["httpEquiv", "http-equiv"]].forEach(function(e) {
  var t = e[0];
  ve[t] = new Te(t,1,!1,e[1],null,!1,!1)
});
["contentEditable", "draggable", "spellCheck", "value"].forEach(function(e) {
  ve[e] = new Te(e,2,!1,e.toLowerCase(),null,!1,!1)
});
["autoReverse", "externalResourcesRequired", "focusable", "preserveAlpha"].forEach(function(e) {
  ve[e] = new Te(e,2,!1,e,null,!1,!1)
});
"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope".split(" ").forEach(function(e) {
  ve[e] = new Te(e,3,!1,e.toLowerCase(),null,!1,!1)
});
["checked", "multiple", "muted", "selected"].forEach(function(e) {
  ve[e] = new Te(e,3,!0,e,null,!1,!1)
});
["capture", "download"].forEach(function(e) {
  ve[e] = new Te(e,4,!1,e,null,!1,!1)
});
["cols", "rows", "size", "span"].forEach(function(e) {
  ve[e] = new Te(e,6,!1,e,null,!1,!1)
});
["rowSpan", "start"].forEach(function(e) {
  ve[e] = new Te(e,5,!1,e.toLowerCase(),null,!1,!1)
});
var Tl = /[\-:]([a-z])/g;
function Ml(e) {
  return e[1].toUpperCase()
}
"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height".split(" ").forEach(function(e) {
  var t = e.replace(Tl, Ml);
  ve[t] = new Te(t,1,!1,e,null,!1,!1)
});
"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type".split(" ").forEach(function(e) {
  var t = e.replace(Tl, Ml);
  ve[t] = new Te(t,1,!1,e,"http://www.w3.org/1999/xlink",!1,!1)
});
["xml:base", "xml:lang", "xml:space"].forEach(function(e) {
  var t = e.replace(Tl, Ml);
  ve[t] = new Te(t,1,!1,e,"http://www.w3.org/XML/1998/namespace",!1,!1)
});
["tabIndex", "crossOrigin"].forEach(function(e) {
  ve[e] = new Te(e,1,!1,e.toLowerCase(),null,!1,!1)
});
ve.xlinkHref = new Te("xlinkHref",1,!1,"xlink:href","http://www.w3.org/1999/xlink",!0,!1);
["src", "href", "action", "formAction"].forEach(function(e) {
  ve[e] = new Te(e,1,!1,e.toLowerCase(),null,!0,!0)
});
function Ll(e, t, n, r) {
  var i = ve.hasOwnProperty(t) ? ve[t] : null;
  (i !== null ? i.type !== 0 : r || !(2 < t.length) || t[0] !== "o" && t[0] !== "O" || t[1] !== "n" && t[1] !== "N") && (Sp(t, n, i, r) && (n = null),
  r || i === null ? xp(t) && (n === null ? e.removeAttribute(t) : e.setAttribute(t, "" + n)) : i.mustUseProperty ? e[i.propertyName] = n === null ? i.type === 3 ? !1 : "" : n : (t = i.attributeName,
  r = i.attributeNamespace,
  n === null ? e.removeAttribute(t) : (i = i.type,
  n = i === 3 || i === 4 && n === !0 ? "" : "" + n,
  r ? e.setAttributeNS(r, t, n) : e.setAttribute(t, n))))
}
var kt = yp.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED
, ki = Symbol.for("react.element")
, On = Symbol.for("react.portal")
, Vn = Symbol.for("react.fragment")
, Rl = Symbol.for("react.strict_mode")
, fs = Symbol.for("react.profiler")
, qd = Symbol.for("react.provider")
, Jd = Symbol.for("react.context")
, bl = Symbol.for("react.forward_ref")
, ms = Symbol.for("react.suspense")
, hs = Symbol.for("react.suspense_list")
, Ol = Symbol.for("react.memo")
, Rt = Symbol.for("react.lazy")
, e1 = Symbol.for("react.offscreen")
, Wu = Symbol.iterator;
function yr(e) {
  return e === null || typeof e != "object" ? null : (e = Wu && e[Wu] || e["@@iterator"],
  typeof e == "function" ? e : null)
}
var te = Object.assign, Ca;
function kr(e) {
  if (Ca === void 0)
      try {
          throw Error()
      } catch (n) {
          var t = n.stack.trim().match(/\n( *(at )?)/);
          Ca = t && t[1] || ""
      }
  return `
` + Ca + e
}
var Pa = !1;
function Aa(e, t) {
  if (!e || Pa)
      return "";
  Pa = !0;
  var n = Error.prepareStackTrace;
  Error.prepareStackTrace = void 0;
  try {
      if (t)
          if (t = function() {
              throw Error()
          }
          ,
          Object.defineProperty(t.prototype, "props", {
              set: function() {
                  throw Error()
              }
          }),
          typeof Reflect == "object" && Reflect.construct) {
              try {
                  Reflect.construct(t, [])
              } catch (u) {
                  var r = u
              }
              Reflect.construct(e, [], t)
          } else {
              try {
                  t.call()
              } catch (u) {
                  r = u
              }
              e.call(t.prototype)
          }
      else {
          try {
              throw Error()
          } catch (u) {
              r = u
          }
          e()
      }
  } catch (u) {
      if (u && r && typeof u.stack == "string") {
          for (var i = u.stack.split(`
`), o = r.stack.split(`
`), a = i.length - 1, s = o.length - 1; 1 <= a && 0 <= s && i[a] !== o[s]; )
              s--;
          for (; 1 <= a && 0 <= s; a--,
          s--)
              if (i[a] !== o[s]) {
                  if (a !== 1 || s !== 1)
                      do
                          if (a--,
                          s--,
                          0 > s || i[a] !== o[s]) {
                              var l = `
` + i[a].replace(" at new ", " at ");
                              return e.displayName && l.includes("<anonymous>") && (l = l.replace("<anonymous>", e.displayName)),
                              l
                          }
                      while (1 <= a && 0 <= s);
                  break
              }
      }
  } finally {
      Pa = !1,
      Error.prepareStackTrace = n
  }
  return (e = e ? e.displayName || e.name : "") ? kr(e) : ""
}
function Ep(e) {
  switch (e.tag) {
  case 5:
      return kr(e.type);
  case 16:
      return kr("Lazy");
  case 13:
      return kr("Suspense");
  case 19:
      return kr("SuspenseList");
  case 0:
  case 2:
  case 15:
      return e = Aa(e.type, !1),
      e;
  case 11:
      return e = Aa(e.type.render, !1),
      e;
  case 1:
      return e = Aa(e.type, !0),
      e;
  default:
      return ""
  }
}
function ps(e) {
  if (e == null)
      return null;
  if (typeof e == "function")
      return e.displayName || e.name || null;
  if (typeof e == "string")
      return e;
  switch (e) {
  case Vn:
      return "Fragment";
  case On:
      return "Portal";
  case fs:
      return "Profiler";
  case Rl:
      return "StrictMode";
  case ms:
      return "Suspense";
  case hs:
      return "SuspenseList"
  }
  if (typeof e == "object")
      switch (e.$$typeof) {
      case Jd:
          return (e.displayName || "Context") + ".Consumer";
      case qd:
          return (e._context.displayName || "Context") + ".Provider";
      case bl:
          var t = e.render;
          return e = e.displayName,
          e || (e = t.displayName || t.name || "",
          e = e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef"),
          e;
      case Ol:
          return t = e.displayName || null,
          t !== null ? t : ps(e.type) || "Memo";
      case Rt:
          t = e._payload,
          e = e._init;
          try {
              return ps(e(t))
          } catch {}
      }
  return null
}
function Np(e) {
  var t = e.type;
  switch (e.tag) {
  case 24:
      return "Cache";
  case 9:
      return (t.displayName || "Context") + ".Consumer";
  case 10:
      return (t._context.displayName || "Context") + ".Provider";
  case 18:
      return "DehydratedFragment";
  case 11:
      return e = t.render,
      e = e.displayName || e.name || "",
      t.displayName || (e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef");
  case 7:
      return "Fragment";
  case 5:
      return t;
  case 4:
      return "Portal";
  case 3:
      return "Root";
  case 6:
      return "Text";
  case 16:
      return ps(t);
  case 8:
      return t === Rl ? "StrictMode" : "Mode";
  case 22:
      return "Offscreen";
  case 12:
      return "Profiler";
  case 21:
      return "Scope";
  case 13:
      return "Suspense";
  case 19:
      return "SuspenseList";
  case 25:
      return "TracingMarker";
  case 1:
  case 0:
  case 17:
  case 2:
  case 14:
  case 15:
      if (typeof t == "function")
          return t.displayName || t.name || null;
      if (typeof t == "string")
          return t
  }
  return null
}
function Kt(e) {
  switch (typeof e) {
  case "boolean":
  case "number":
  case "string":
  case "undefined":
      return e;
  case "object":
      return e;
  default:
      return ""
  }
}
function t1(e) {
  var t = e.type;
  return (e = e.nodeName) && e.toLowerCase() === "input" && (t === "checkbox" || t === "radio")
}
function Cp(e) {
  var t = t1(e) ? "checked" : "value"
    , n = Object.getOwnPropertyDescriptor(e.constructor.prototype, t)
    , r = "" + e[t];
  if (!e.hasOwnProperty(t) && typeof n < "u" && typeof n.get == "function" && typeof n.set == "function") {
      var i = n.get
        , o = n.set;
      return Object.defineProperty(e, t, {
          configurable: !0,
          get: function() {
              return i.call(this)
          },
          set: function(a) {
              r = "" + a,
              o.call(this, a)
          }
      }),
      Object.defineProperty(e, t, {
          enumerable: n.enumerable
      }),
      {
          getValue: function() {
              return r
          },
          setValue: function(a) {
              r = "" + a
          },
          stopTracking: function() {
              e._valueTracker = null,
              delete e[t]
          }
      }
  }
}
function Ti(e) {
  e._valueTracker || (e._valueTracker = Cp(e))
}
function n1(e) {
  if (!e)
      return !1;
  var t = e._valueTracker;
  if (!t)
      return !0;
  var n = t.getValue()
    , r = "";
  return e && (r = t1(e) ? e.checked ? "true" : "false" : e.value),
  e = r,
  e !== n ? (t.setValue(e),
  !0) : !1
}
function lo(e) {
  if (e = e || (typeof document < "u" ? document : void 0),
  typeof e > "u")
      return null;
  try {
      return e.activeElement || e.body
  } catch {
      return e.body
  }
}
function gs(e, t) {
  var n = t.checked;
  return te({}, t, {
      defaultChecked: void 0,
      defaultValue: void 0,
      value: void 0,
      checked: n != null ? n : e._wrapperState.initialChecked
  })
}
function Qu(e, t) {
  var n = t.defaultValue == null ? "" : t.defaultValue
    , r = t.checked != null ? t.checked : t.defaultChecked;
  n = Kt(t.value != null ? t.value : n),
  e._wrapperState = {
      initialChecked: r,
      initialValue: n,
      controlled: t.type === "checkbox" || t.type === "radio" ? t.checked != null : t.value != null
  }
}
function r1(e, t) {
  t = t.checked,
  t != null && Ll(e, "checked", t, !1)
}
function ys(e, t) {
  r1(e, t);
  var n = Kt(t.value)
    , r = t.type;
  if (n != null)
      r === "number" ? (n === 0 && e.value === "" || e.value != n) && (e.value = "" + n) : e.value !== "" + n && (e.value = "" + n);
  else if (r === "submit" || r === "reset") {
      e.removeAttribute("value");
      return
  }
  t.hasOwnProperty("value") ? vs(e, t.type, n) : t.hasOwnProperty("defaultValue") && vs(e, t.type, Kt(t.defaultValue)),
  t.checked == null && t.defaultChecked != null && (e.defaultChecked = !!t.defaultChecked)
}
function Ku(e, t, n) {
  if (t.hasOwnProperty("value") || t.hasOwnProperty("defaultValue")) {
      var r = t.type;
      if (!(r !== "submit" && r !== "reset" || t.value !== void 0 && t.value !== null))
          return;
      t = "" + e._wrapperState.initialValue,
      n || t === e.value || (e.value = t),
      e.defaultValue = t
  }
  n = e.name,
  n !== "" && (e.name = ""),
  e.defaultChecked = !!e._wrapperState.initialChecked,
  n !== "" && (e.name = n)
}
function vs(e, t, n) {
  (t !== "number" || lo(e.ownerDocument) !== e) && (n == null ? e.defaultValue = "" + e._wrapperState.initialValue : e.defaultValue !== "" + n && (e.defaultValue = "" + n))
}
var Tr = Array.isArray;
function Kn(e, t, n, r) {
  if (e = e.options,
  t) {
      t = {};
      for (var i = 0; i < n.length; i++)
          t["$" + n[i]] = !0;
      for (n = 0; n < e.length; n++)
          i = t.hasOwnProperty("$" + e[n].value),
          e[n].selected !== i && (e[n].selected = i),
          i && r && (e[n].defaultSelected = !0)
  } else {
      for (n = "" + Kt(n),
      t = null,
      i = 0; i < e.length; i++) {
          if (e[i].value === n) {
              e[i].selected = !0,
              r && (e[i].defaultSelected = !0);
              return
          }
          t !== null || e[i].disabled || (t = e[i])
      }
      t !== null && (t.selected = !0)
  }
}
function xs(e, t) {
  if (t.dangerouslySetInnerHTML != null)
      throw Error(L(91));
  return te({}, t, {
      value: void 0,
      defaultValue: void 0,
      children: "" + e._wrapperState.initialValue
  })
}
function Yu(e, t) {
  var n = t.value;
  if (n == null) {
      if (n = t.children,
      t = t.defaultValue,
      n != null) {
          if (t != null)
              throw Error(L(92));
          if (Tr(n)) {
              if (1 < n.length)
                  throw Error(L(93));
              n = n[0]
          }
          t = n
      }
      t == null && (t = ""),
      n = t
  }
  e._wrapperState = {
      initialValue: Kt(n)
  }
}
function i1(e, t) {
  var n = Kt(t.value)
    , r = Kt(t.defaultValue);
  n != null && (n = "" + n,
  n !== e.value && (e.value = n),
  t.defaultValue == null && e.defaultValue !== n && (e.defaultValue = n)),
  r != null && (e.defaultValue = "" + r)
}
function Xu(e) {
  var t = e.textContent;
  t === e._wrapperState.initialValue && t !== "" && t !== null && (e.value = t)
}
function o1(e) {
  switch (e) {
  case "svg":
      return "http://www.w3.org/2000/svg";
  case "math":
      return "http://www.w3.org/1998/Math/MathML";
  default:
      return "http://www.w3.org/1999/xhtml"
  }
}
function ws(e, t) {
  return e == null || e === "http://www.w3.org/1999/xhtml" ? o1(t) : e === "http://www.w3.org/2000/svg" && t === "foreignObject" ? "http://www.w3.org/1999/xhtml" : e
}
var Mi, a1 = function(e) {
  return typeof MSApp < "u" && MSApp.execUnsafeLocalFunction ? function(t, n, r, i) {
      MSApp.execUnsafeLocalFunction(function() {
          return e(t, n, r, i)
      })
  }
  : e
}(function(e, t) {
  if (e.namespaceURI !== "http://www.w3.org/2000/svg" || "innerHTML"in e)
      e.innerHTML = t;
  else {
      for (Mi = Mi || document.createElement("div"),
      Mi.innerHTML = "<svg>" + t.valueOf().toString() + "</svg>",
      t = Mi.firstChild; e.firstChild; )
          e.removeChild(e.firstChild);
      for (; t.firstChild; )
          e.appendChild(t.firstChild)
  }
});
function Gr(e, t) {
  if (t) {
      var n = e.firstChild;
      if (n && n === e.lastChild && n.nodeType === 3) {
          n.nodeValue = t;
          return
      }
  }
  e.textContent = t
}
var br = {
  animationIterationCount: !0,
  aspectRatio: !0,
  borderImageOutset: !0,
  borderImageSlice: !0,
  borderImageWidth: !0,
  boxFlex: !0,
  boxFlexGroup: !0,
  boxOrdinalGroup: !0,
  columnCount: !0,
  columns: !0,
  flex: !0,
  flexGrow: !0,
  flexPositive: !0,
  flexShrink: !0,
  flexNegative: !0,
  flexOrder: !0,
  gridArea: !0,
  gridRow: !0,
  gridRowEnd: !0,
  gridRowSpan: !0,
  gridRowStart: !0,
  gridColumn: !0,
  gridColumnEnd: !0,
  gridColumnSpan: !0,
  gridColumnStart: !0,
  fontWeight: !0,
  lineClamp: !0,
  lineHeight: !0,
  opacity: !0,
  order: !0,
  orphans: !0,
  tabSize: !0,
  widows: !0,
  zIndex: !0,
  zoom: !0,
  fillOpacity: !0,
  floodOpacity: !0,
  stopOpacity: !0,
  strokeDasharray: !0,
  strokeDashoffset: !0,
  strokeMiterlimit: !0,
  strokeOpacity: !0,
  strokeWidth: !0
}
, Pp = ["Webkit", "ms", "Moz", "O"];
Object.keys(br).forEach(function(e) {
  Pp.forEach(function(t) {
      t = t + e.charAt(0).toUpperCase() + e.substring(1),
      br[t] = br[e]
  })
});
function s1(e, t, n) {
  return t == null || typeof t == "boolean" || t === "" ? "" : n || typeof t != "number" || t === 0 || br.hasOwnProperty(e) && br[e] ? ("" + t).trim() : t + "px"
}
function l1(e, t) {
  e = e.style;
  for (var n in t)
      if (t.hasOwnProperty(n)) {
          var r = n.indexOf("--") === 0
            , i = s1(n, t[n], r);
          n === "float" && (n = "cssFloat"),
          r ? e.setProperty(n, i) : e[n] = i
      }
}
var Ap = te({
  menuitem: !0
}, {
  area: !0,
  base: !0,
  br: !0,
  col: !0,
  embed: !0,
  hr: !0,
  img: !0,
  input: !0,
  keygen: !0,
  link: !0,
  meta: !0,
  param: !0,
  source: !0,
  track: !0,
  wbr: !0
});
function Ss(e, t) {
  if (t) {
      if (Ap[e] && (t.children != null || t.dangerouslySetInnerHTML != null))
          throw Error(L(137, e));
      if (t.dangerouslySetInnerHTML != null) {
          if (t.children != null)
              throw Error(L(60));
          if (typeof t.dangerouslySetInnerHTML != "object" || !("__html"in t.dangerouslySetInnerHTML))
              throw Error(L(61))
      }
      if (t.style != null && typeof t.style != "object")
          throw Error(L(62))
  }
}
function Es(e, t) {
  if (e.indexOf("-") === -1)
      return typeof t.is == "string";
  switch (e) {
  case "annotation-xml":
  case "color-profile":
  case "font-face":
  case "font-face-src":
  case "font-face-uri":
  case "font-face-format":
  case "font-face-name":
  case "missing-glyph":
      return !1;
  default:
      return !0
  }
}
var Ns = null;
function Vl(e) {
  return e = e.target || e.srcElement || window,
  e.correspondingUseElement && (e = e.correspondingUseElement),
  e.nodeType === 3 ? e.parentNode : e
}
var Cs = null
, Yn = null
, Xn = null;
function qu(e) {
  if (e = vi(e)) {
      if (typeof Cs != "function")
          throw Error(L(280));
      var t = e.stateNode;
      t && (t = Yo(t),
      Cs(e.stateNode, e.type, t))
  }
}
function u1(e) {
  Yn ? Xn ? Xn.push(e) : Xn = [e] : Yn = e
}
function c1() {
  if (Yn) {
      var e = Yn
        , t = Xn;
      if (Xn = Yn = null,
      qu(e),
      t)
          for (e = 0; e < t.length; e++)
              qu(t[e])
  }
}
function d1(e, t) {
  return e(t)
}
function f1() {}
var ka = !1;
function m1(e, t, n) {
  if (ka)
      return e(t, n);
  ka = !0;
  try {
      return d1(e, t, n)
  } finally {
      ka = !1,
      (Yn !== null || Xn !== null) && (f1(),
      c1())
  }
}
function Wr(e, t) {
  var n = e.stateNode;
  if (n === null)
      return null;
  var r = Yo(n);
  if (r === null)
      return null;
  n = r[t];
  e: switch (t) {
  case "onClick":
  case "onClickCapture":
  case "onDoubleClick":
  case "onDoubleClickCapture":
  case "onMouseDown":
  case "onMouseDownCapture":
  case "onMouseMove":
  case "onMouseMoveCapture":
  case "onMouseUp":
  case "onMouseUpCapture":
  case "onMouseEnter":
      (r = !r.disabled) || (e = e.type,
      r = !(e === "button" || e === "input" || e === "select" || e === "textarea")),
      e = !r;
      break e;
  default:
      e = !1
  }
  if (e)
      return null;
  if (n && typeof n != "function")
      throw Error(L(231, t, typeof n));
  return n
}
var Ps = !1;
if (Et)
  try {
      var vr = {};
      Object.defineProperty(vr, "passive", {
          get: function() {
              Ps = !0
          }
      }),
      window.addEventListener("test", vr, vr),
      window.removeEventListener("test", vr, vr)
  } catch {
      Ps = !1
  }
function kp(e, t, n, r, i, o, a, s, l) {
  var u = Array.prototype.slice.call(arguments, 3);
  try {
      t.apply(n, u)
  } catch (f) {
      this.onError(f)
  }
}
var Or = !1
, uo = null
, co = !1
, As = null
, Tp = {
  onError: function(e) {
      Or = !0,
      uo = e
  }
};
function Mp(e, t, n, r, i, o, a, s, l) {
  Or = !1,
  uo = null,
  kp.apply(Tp, arguments)
}
function Lp(e, t, n, r, i, o, a, s, l) {
  if (Mp.apply(this, arguments),
  Or) {
      if (Or) {
          var u = uo;
          Or = !1,
          uo = null
      } else
          throw Error(L(198));
      co || (co = !0,
      As = u)
  }
}
function Tn(e) {
  var t = e
    , n = e;
  if (e.alternate)
      for (; t.return; )
          t = t.return;
  else {
      e = t;
      do
          t = e,
          (t.flags & 4098) !== 0 && (n = t.return),
          e = t.return;
      while (e)
  }
  return t.tag === 3 ? n : null
}
function h1(e) {
  if (e.tag === 13) {
      var t = e.memoizedState;
      if (t === null && (e = e.alternate,
      e !== null && (t = e.memoizedState)),
      t !== null)
          return t.dehydrated
  }
  return null
}
function Ju(e) {
  if (Tn(e) !== e)
      throw Error(L(188))
}
function Rp(e) {
  var t = e.alternate;
  if (!t) {
      if (t = Tn(e),
      t === null)
          throw Error(L(188));
      return t !== e ? null : e
  }
  for (var n = e, r = t; ; ) {
      var i = n.return;
      if (i === null)
          break;
      var o = i.alternate;
      if (o === null) {
          if (r = i.return,
          r !== null) {
              n = r;
              continue
          }
          break
      }
      if (i.child === o.child) {
          for (o = i.child; o; ) {
              if (o === n)
                  return Ju(i),
                  e;
              if (o === r)
                  return Ju(i),
                  t;
              o = o.sibling
          }
          throw Error(L(188))
      }
      if (n.return !== r.return)
          n = i,
          r = o;
      else {
          for (var a = !1, s = i.child; s; ) {
              if (s === n) {
                  a = !0,
                  n = i,
                  r = o;
                  break
              }
              if (s === r) {
                  a = !0,
                  r = i,
                  n = o;
                  break
              }
              s = s.sibling
          }
          if (!a) {
              for (s = o.child; s; ) {
                  if (s === n) {
                      a = !0,
                      n = o,
                      r = i;
                      break
                  }
                  if (s === r) {
                      a = !0,
                      r = o,
                      n = i;
                      break
                  }
                  s = s.sibling
              }
              if (!a)
                  throw Error(L(189))
          }
      }
      if (n.alternate !== r)
          throw Error(L(190))
  }
  if (n.tag !== 3)
      throw Error(L(188));
  return n.stateNode.current === n ? e : t
}
function p1(e) {
  return e = Rp(e),
  e !== null ? g1(e) : null
}
function g1(e) {
  if (e.tag === 5 || e.tag === 6)
      return e;
  for (e = e.child; e !== null; ) {
      var t = g1(e);
      if (t !== null)
          return t;
      e = e.sibling
  }
  return null
}
var y1 = ze.unstable_scheduleCallback
, ec = ze.unstable_cancelCallback
, bp = ze.unstable_shouldYield
, Op = ze.unstable_requestPaint
, ie = ze.unstable_now
, Vp = ze.unstable_getCurrentPriorityLevel
, Dl = ze.unstable_ImmediatePriority
, v1 = ze.unstable_UserBlockingPriority
, fo = ze.unstable_NormalPriority
, Dp = ze.unstable_LowPriority
, x1 = ze.unstable_IdlePriority
, Go = null
, ct = null;
function jp(e) {
  if (ct && typeof ct.onCommitFiberRoot == "function")
      try {
          ct.onCommitFiberRoot(Go, e, void 0, (e.current.flags & 128) === 128)
      } catch {}
}
var rt = Math.clz32 ? Math.clz32 : _p
, Ip = Math.log
, Fp = Math.LN2;
function _p(e) {
  return e >>>= 0,
  e === 0 ? 32 : 31 - (Ip(e) / Fp | 0) | 0
}
var Li = 64
, Ri = 4194304;
function Mr(e) {
  switch (e & -e) {
  case 1:
      return 1;
  case 2:
      return 2;
  case 4:
      return 4;
  case 8:
      return 8;
  case 16:
      return 16;
  case 32:
      return 32;
  case 64:
  case 128:
  case 256:
  case 512:
  case 1024:
  case 2048:
  case 4096:
  case 8192:
  case 16384:
  case 32768:
  case 65536:
  case 131072:
  case 262144:
  case 524288:
  case 1048576:
  case 2097152:
      return e & 4194240;
  case 4194304:
  case 8388608:
  case 16777216:
  case 33554432:
  case 67108864:
      return e & 130023424;
  case 134217728:
      return 134217728;
  case 268435456:
      return 268435456;
  case 536870912:
      return 536870912;
  case 1073741824:
      return 1073741824;
  default:
      return e
  }
}
function mo(e, t) {
  var n = e.pendingLanes;
  if (n === 0)
      return 0;
  var r = 0
    , i = e.suspendedLanes
    , o = e.pingedLanes
    , a = n & 268435455;
  if (a !== 0) {
      var s = a & ~i;
      s !== 0 ? r = Mr(s) : (o &= a,
      o !== 0 && (r = Mr(o)))
  } else
      a = n & ~i,
      a !== 0 ? r = Mr(a) : o !== 0 && (r = Mr(o));
  if (r === 0)
      return 0;
  if (t !== 0 && t !== r && (t & i) === 0 && (i = r & -r,
  o = t & -t,
  i >= o || i === 16 && (o & 4194240) !== 0))
      return t;
  if ((r & 4) !== 0 && (r |= n & 16),
  t = e.entangledLanes,
  t !== 0)
      for (e = e.entanglements,
      t &= r; 0 < t; )
          n = 31 - rt(t),
          i = 1 << n,
          r |= e[n],
          t &= ~i;
  return r
}
function zp(e, t) {
  switch (e) {
  case 1:
  case 2:
  case 4:
      return t + 250;
  case 8:
  case 16:
  case 32:
  case 64:
  case 128:
  case 256:
  case 512:
  case 1024:
  case 2048:
  case 4096:
  case 8192:
  case 16384:
  case 32768:
  case 65536:
  case 131072:
  case 262144:
  case 524288:
  case 1048576:
  case 2097152:
      return t + 5e3;
  case 4194304:
  case 8388608:
  case 16777216:
  case 33554432:
  case 67108864:
      return -1;
  case 134217728:
  case 268435456:
  case 536870912:
  case 1073741824:
      return -1;
  default:
      return -1
  }
}
function Hp(e, t) {
  for (var n = e.suspendedLanes, r = e.pingedLanes, i = e.expirationTimes, o = e.pendingLanes; 0 < o; ) {
      var a = 31 - rt(o)
        , s = 1 << a
        , l = i[a];
      l === -1 ? ((s & n) === 0 || (s & r) !== 0) && (i[a] = zp(s, t)) : l <= t && (e.expiredLanes |= s),
      o &= ~s
  }
}
function ks(e) {
  return e = e.pendingLanes & -1073741825,
  e !== 0 ? e : e & 1073741824 ? 1073741824 : 0
}
function w1() {
  var e = Li;
  return Li <<= 1,
  (Li & 4194240) === 0 && (Li = 64),
  e
}
function Ta(e) {
  for (var t = [], n = 0; 31 > n; n++)
      t.push(e);
  return t
}
function gi(e, t, n) {
  e.pendingLanes |= t,
  t !== 536870912 && (e.suspendedLanes = 0,
  e.pingedLanes = 0),
  e = e.eventTimes,
  t = 31 - rt(t),
  e[t] = n
}
function Bp(e, t) {
  var n = e.pendingLanes & ~t;
  e.pendingLanes = t,
  e.suspendedLanes = 0,
  e.pingedLanes = 0,
  e.expiredLanes &= t,
  e.mutableReadLanes &= t,
  e.entangledLanes &= t,
  t = e.entanglements;
  var r = e.eventTimes;
  for (e = e.expirationTimes; 0 < n; ) {
      var i = 31 - rt(n)
        , o = 1 << i;
      t[i] = 0,
      r[i] = -1,
      e[i] = -1,
      n &= ~o
  }
}
function jl(e, t) {
  var n = e.entangledLanes |= t;
  for (e = e.entanglements; n; ) {
      var r = 31 - rt(n)
        , i = 1 << r;
      i & t | e[r] & t && (e[r] |= t),
      n &= ~i
  }
}
var Z = 0;
function S1(e) {
  return e &= -e,
  1 < e ? 4 < e ? (e & 268435455) !== 0 ? 16 : 536870912 : 4 : 1
}
var E1, Il, N1, C1, P1, Ts = !1, bi = [], _t = null, zt = null, Ht = null, Qr = new Map, Kr = new Map, Vt = [], $p = "mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(" ");
function tc(e, t) {
  switch (e) {
  case "focusin":
  case "focusout":
      _t = null;
      break;
  case "dragenter":
  case "dragleave":
      zt = null;
      break;
  case "mouseover":
  case "mouseout":
      Ht = null;
      break;
  case "pointerover":
  case "pointerout":
      Qr.delete(t.pointerId);
      break;
  case "gotpointercapture":
  case "lostpointercapture":
      Kr.delete(t.pointerId)
  }
}
function xr(e, t, n, r, i, o) {
  return e === null || e.nativeEvent !== o ? (e = {
      blockedOn: t,
      domEventName: n,
      eventSystemFlags: r,
      nativeEvent: o,
      targetContainers: [i]
  },
  t !== null && (t = vi(t),
  t !== null && Il(t)),
  e) : (e.eventSystemFlags |= r,
  t = e.targetContainers,
  i !== null && t.indexOf(i) === -1 && t.push(i),
  e)
}
function Up(e, t, n, r, i) {
  switch (t) {
  case "focusin":
      return _t = xr(_t, e, t, n, r, i),
      !0;
  case "dragenter":
      return zt = xr(zt, e, t, n, r, i),
      !0;
  case "mouseover":
      return Ht = xr(Ht, e, t, n, r, i),
      !0;
  case "pointerover":
      var o = i.pointerId;
      return Qr.set(o, xr(Qr.get(o) || null, e, t, n, r, i)),
      !0;
  case "gotpointercapture":
      return o = i.pointerId,
      Kr.set(o, xr(Kr.get(o) || null, e, t, n, r, i)),
      !0
  }
  return !1
}
function A1(e) {
  var t = mn(e.target);
  if (t !== null) {
      var n = Tn(t);
      if (n !== null) {
          if (t = n.tag,
          t === 13) {
              if (t = h1(n),
              t !== null) {
                  e.blockedOn = t,
                  P1(e.priority, function() {
                      N1(n)
                  });
                  return
              }
          } else if (t === 3 && n.stateNode.current.memoizedState.isDehydrated) {
              e.blockedOn = n.tag === 3 ? n.stateNode.containerInfo : null;
              return
          }
      }
  }
  e.blockedOn = null
}
function Ki(e) {
  if (e.blockedOn !== null)
      return !1;
  for (var t = e.targetContainers; 0 < t.length; ) {
      var n = Ms(e.domEventName, e.eventSystemFlags, t[0], e.nativeEvent);
      if (n === null) {
          n = e.nativeEvent;
          var r = new n.constructor(n.type,n);
          Ns = r,
          n.target.dispatchEvent(r),
          Ns = null
      } else
          return t = vi(n),
          t !== null && Il(t),
          e.blockedOn = n,
          !1;
      t.shift()
  }
  return !0
}
function nc(e, t, n) {
  Ki(e) && n.delete(t)
}
function Zp() {
  Ts = !1,
  _t !== null && Ki(_t) && (_t = null),
  zt !== null && Ki(zt) && (zt = null),
  Ht !== null && Ki(Ht) && (Ht = null),
  Qr.forEach(nc),
  Kr.forEach(nc)
}
function wr(e, t) {
  e.blockedOn === t && (e.blockedOn = null,
  Ts || (Ts = !0,
  ze.unstable_scheduleCallback(ze.unstable_NormalPriority, Zp)))
}
function Yr(e) {
  function t(i) {
      return wr(i, e)
  }
  if (0 < bi.length) {
      wr(bi[0], e);
      for (var n = 1; n < bi.length; n++) {
          var r = bi[n];
          r.blockedOn === e && (r.blockedOn = null)
      }
  }
  for (_t !== null && wr(_t, e),
  zt !== null && wr(zt, e),
  Ht !== null && wr(Ht, e),
  Qr.forEach(t),
  Kr.forEach(t),
  n = 0; n < Vt.length; n++)
      r = Vt[n],
      r.blockedOn === e && (r.blockedOn = null);
  for (; 0 < Vt.length && (n = Vt[0],
  n.blockedOn === null); )
      A1(n),
      n.blockedOn === null && Vt.shift()
}
var qn = kt.ReactCurrentBatchConfig
, ho = !0;
function Gp(e, t, n, r) {
  var i = Z
    , o = qn.transition;
  qn.transition = null;
  try {
      Z = 1,
      Fl(e, t, n, r)
  } finally {
      Z = i,
      qn.transition = o
  }
}
function Wp(e, t, n, r) {
  var i = Z
    , o = qn.transition;
  qn.transition = null;
  try {
      Z = 4,
      Fl(e, t, n, r)
  } finally {
      Z = i,
      qn.transition = o
  }
}
function Fl(e, t, n, r) {
  if (ho) {
      var i = Ms(e, t, n, r);
      if (i === null)
          Fa(e, t, r, po, n),
          tc(e, r);
      else if (Up(i, e, t, n, r))
          r.stopPropagation();
      else if (tc(e, r),
      t & 4 && -1 < $p.indexOf(e)) {
          for (; i !== null; ) {
              var o = vi(i);
              if (o !== null && E1(o),
              o = Ms(e, t, n, r),
              o === null && Fa(e, t, r, po, n),
              o === i)
                  break;
              i = o
          }
          i !== null && r.stopPropagation()
      } else
          Fa(e, t, r, null, n)
  }
}
var po = null;
function Ms(e, t, n, r) {
  if (po = null,
  e = Vl(r),
  e = mn(e),
  e !== null)
      if (t = Tn(e),
      t === null)
          e = null;
      else if (n = t.tag,
      n === 13) {
          if (e = h1(t),
          e !== null)
              return e;
          e = null
      } else if (n === 3) {
          if (t.stateNode.current.memoizedState.isDehydrated)
              return t.tag === 3 ? t.stateNode.containerInfo : null;
          e = null
      } else
          t !== e && (e = null);
  return po = e,
  null
}
function k1(e) {
  switch (e) {
  case "cancel":
  case "click":
  case "close":
  case "contextmenu":
  case "copy":
  case "cut":
  case "auxclick":
  case "dblclick":
  case "dragend":
  case "dragstart":
  case "drop":
  case "focusin":
  case "focusout":
  case "input":
  case "invalid":
  case "keydown":
  case "keypress":
  case "keyup":
  case "mousedown":
  case "mouseup":
  case "paste":
  case "pause":
  case "play":
  case "pointercancel":
  case "pointerdown":
  case "pointerup":
  case "ratechange":
  case "reset":
  case "resize":
  case "seeked":
  case "submit":
  case "touchcancel":
  case "touchend":
  case "touchstart":
  case "volumechange":
  case "change":
  case "selectionchange":
  case "textInput":
  case "compositionstart":
  case "compositionend":
  case "compositionupdate":
  case "beforeblur":
  case "afterblur":
  case "beforeinput":
  case "blur":
  case "fullscreenchange":
  case "focus":
  case "hashchange":
  case "popstate":
  case "select":
  case "selectstart":
      return 1;
  case "drag":
  case "dragenter":
  case "dragexit":
  case "dragleave":
  case "dragover":
  case "mousemove":
  case "mouseout":
  case "mouseover":
  case "pointermove":
  case "pointerout":
  case "pointerover":
  case "scroll":
  case "toggle":
  case "touchmove":
  case "wheel":
  case "mouseenter":
  case "mouseleave":
  case "pointerenter":
  case "pointerleave":
      return 4;
  case "message":
      switch (Vp()) {
      case Dl:
          return 1;
      case v1:
          return 4;
      case fo:
      case Dp:
          return 16;
      case x1:
          return 536870912;
      default:
          return 16
      }
  default:
      return 16
  }
}
var jt = null
, _l = null
, Yi = null;
function T1() {
  if (Yi)
      return Yi;
  var e, t = _l, n = t.length, r, i = "value"in jt ? jt.value : jt.textContent, o = i.length;
  for (e = 0; e < n && t[e] === i[e]; e++)
      ;
  var a = n - e;
  for (r = 1; r <= a && t[n - r] === i[o - r]; r++)
      ;
  return Yi = i.slice(e, 1 < r ? 1 - r : void 0)
}
function Xi(e) {
  var t = e.keyCode;
  return "charCode"in e ? (e = e.charCode,
  e === 0 && t === 13 && (e = 13)) : e = t,
  e === 10 && (e = 13),
  32 <= e || e === 13 ? e : 0
}
function Oi() {
  return !0
}
function rc() {
  return !1
}
function $e(e) {
  function t(n, r, i, o, a) {
      this._reactName = n,
      this._targetInst = i,
      this.type = r,
      this.nativeEvent = o,
      this.target = a,
      this.currentTarget = null;
      for (var s in e)
          e.hasOwnProperty(s) && (n = e[s],
          this[s] = n ? n(o) : o[s]);
      return this.isDefaultPrevented = (o.defaultPrevented != null ? o.defaultPrevented : o.returnValue === !1) ? Oi : rc,
      this.isPropagationStopped = rc,
      this
  }
  return te(t.prototype, {
      preventDefault: function() {
          this.defaultPrevented = !0;
          var n = this.nativeEvent;
          n && (n.preventDefault ? n.preventDefault() : typeof n.returnValue != "unknown" && (n.returnValue = !1),
          this.isDefaultPrevented = Oi)
      },
      stopPropagation: function() {
          var n = this.nativeEvent;
          n && (n.stopPropagation ? n.stopPropagation() : typeof n.cancelBubble != "unknown" && (n.cancelBubble = !0),
          this.isPropagationStopped = Oi)
      },
      persist: function() {},
      isPersistent: Oi
  }),
  t
}
var fr = {
  eventPhase: 0,
  bubbles: 0,
  cancelable: 0,
  timeStamp: function(e) {
      return e.timeStamp || Date.now()
  },
  defaultPrevented: 0,
  isTrusted: 0
}, zl = $e(fr), yi = te({}, fr, {
  view: 0,
  detail: 0
}), Qp = $e(yi), Ma, La, Sr, Wo = te({}, yi, {
  screenX: 0,
  screenY: 0,
  clientX: 0,
  clientY: 0,
  pageX: 0,
  pageY: 0,
  ctrlKey: 0,
  shiftKey: 0,
  altKey: 0,
  metaKey: 0,
  getModifierState: Hl,
  button: 0,
  buttons: 0,
  relatedTarget: function(e) {
      return e.relatedTarget === void 0 ? e.fromElement === e.srcElement ? e.toElement : e.fromElement : e.relatedTarget
  },
  movementX: function(e) {
      return "movementX"in e ? e.movementX : (e !== Sr && (Sr && e.type === "mousemove" ? (Ma = e.screenX - Sr.screenX,
      La = e.screenY - Sr.screenY) : La = Ma = 0,
      Sr = e),
      Ma)
  },
  movementY: function(e) {
      return "movementY"in e ? e.movementY : La
  }
}), ic = $e(Wo), Kp = te({}, Wo, {
  dataTransfer: 0
}), Yp = $e(Kp), Xp = te({}, yi, {
  relatedTarget: 0
}), Ra = $e(Xp), qp = te({}, fr, {
  animationName: 0,
  elapsedTime: 0,
  pseudoElement: 0
}), Jp = $e(qp), e2 = te({}, fr, {
  clipboardData: function(e) {
      return "clipboardData"in e ? e.clipboardData : window.clipboardData
  }
}), t2 = $e(e2), n2 = te({}, fr, {
  data: 0
}), oc = $e(n2), r2 = {
  Esc: "Escape",
  Spacebar: " ",
  Left: "ArrowLeft",
  Up: "ArrowUp",
  Right: "ArrowRight",
  Down: "ArrowDown",
  Del: "Delete",
  Win: "OS",
  Menu: "ContextMenu",
  Apps: "ContextMenu",
  Scroll: "ScrollLock",
  MozPrintableKey: "Unidentified"
}, i2 = {
  8: "Backspace",
  9: "Tab",
  12: "Clear",
  13: "Enter",
  16: "Shift",
  17: "Control",
  18: "Alt",
  19: "Pause",
  20: "CapsLock",
  27: "Escape",
  32: " ",
  33: "PageUp",
  34: "PageDown",
  35: "End",
  36: "Home",
  37: "ArrowLeft",
  38: "ArrowUp",
  39: "ArrowRight",
  40: "ArrowDown",
  45: "Insert",
  46: "Delete",
  112: "F1",
  113: "F2",
  114: "F3",
  115: "F4",
  116: "F5",
  117: "F6",
  118: "F7",
  119: "F8",
  120: "F9",
  121: "F10",
  122: "F11",
  123: "F12",
  144: "NumLock",
  145: "ScrollLock",
  224: "Meta"
}, o2 = {
  Alt: "altKey",
  Control: "ctrlKey",
  Meta: "metaKey",
  Shift: "shiftKey"
};
function a2(e) {
  var t = this.nativeEvent;
  return t.getModifierState ? t.getModifierState(e) : (e = o2[e]) ? !!t[e] : !1
}
function Hl() {
  return a2
}
var s2 = te({}, yi, {
  key: function(e) {
      if (e.key) {
          var t = r2[e.key] || e.key;
          if (t !== "Unidentified")
              return t
      }
      return e.type === "keypress" ? (e = Xi(e),
      e === 13 ? "Enter" : String.fromCharCode(e)) : e.type === "keydown" || e.type === "keyup" ? i2[e.keyCode] || "Unidentified" : ""
  },
  code: 0,
  location: 0,
  ctrlKey: 0,
  shiftKey: 0,
  altKey: 0,
  metaKey: 0,
  repeat: 0,
  locale: 0,
  getModifierState: Hl,
  charCode: function(e) {
      return e.type === "keypress" ? Xi(e) : 0
  },
  keyCode: function(e) {
      return e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
  },
  which: function(e) {
      return e.type === "keypress" ? Xi(e) : e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
  }
})
, l2 = $e(s2)
, u2 = te({}, Wo, {
  pointerId: 0,
  width: 0,
  height: 0,
  pressure: 0,
  tangentialPressure: 0,
  tiltX: 0,
  tiltY: 0,
  twist: 0,
  pointerType: 0,
  isPrimary: 0
})
, ac = $e(u2)
, c2 = te({}, yi, {
  touches: 0,
  targetTouches: 0,
  changedTouches: 0,
  altKey: 0,
  metaKey: 0,
  ctrlKey: 0,
  shiftKey: 0,
  getModifierState: Hl
})
, d2 = $e(c2)
, f2 = te({}, fr, {
  propertyName: 0,
  elapsedTime: 0,
  pseudoElement: 0
})
, m2 = $e(f2)
, h2 = te({}, Wo, {
  deltaX: function(e) {
      return "deltaX"in e ? e.deltaX : "wheelDeltaX"in e ? -e.wheelDeltaX : 0
  },
  deltaY: function(e) {
      return "deltaY"in e ? e.deltaY : "wheelDeltaY"in e ? -e.wheelDeltaY : "wheelDelta"in e ? -e.wheelDelta : 0
  },
  deltaZ: 0,
  deltaMode: 0
})
, p2 = $e(h2)
, g2 = [9, 13, 27, 32]
, Bl = Et && "CompositionEvent"in window
, Vr = null;
Et && "documentMode"in document && (Vr = document.documentMode);
var y2 = Et && "TextEvent"in window && !Vr
, M1 = Et && (!Bl || Vr && 8 < Vr && 11 >= Vr)
, sc = String.fromCharCode(32)
, lc = !1;
function L1(e, t) {
  switch (e) {
  case "keyup":
      return g2.indexOf(t.keyCode) !== -1;
  case "keydown":
      return t.keyCode !== 229;
  case "keypress":
  case "mousedown":
  case "focusout":
      return !0;
  default:
      return !1
  }
}
function R1(e) {
  return e = e.detail,
  typeof e == "object" && "data"in e ? e.data : null
}
var Dn = !1;
function v2(e, t) {
  switch (e) {
  case "compositionend":
      return R1(t);
  case "keypress":
      return t.which !== 32 ? null : (lc = !0,
      sc);
  case "textInput":
      return e = t.data,
      e === sc && lc ? null : e;
  default:
      return null
  }
}
function x2(e, t) {
  if (Dn)
      return e === "compositionend" || !Bl && L1(e, t) ? (e = T1(),
      Yi = _l = jt = null,
      Dn = !1,
      e) : null;
  switch (e) {
  case "paste":
      return null;
  case "keypress":
      if (!(t.ctrlKey || t.altKey || t.metaKey) || t.ctrlKey && t.altKey) {
          if (t.char && 1 < t.char.length)
              return t.char;
          if (t.which)
              return String.fromCharCode(t.which)
      }
      return null;
  case "compositionend":
      return M1 && t.locale !== "ko" ? null : t.data;
  default:
      return null
  }
}
var w2 = {
  color: !0,
  date: !0,
  datetime: !0,
  "datetime-local": !0,
  email: !0,
  month: !0,
  number: !0,
  password: !0,
  range: !0,
  search: !0,
  tel: !0,
  text: !0,
  time: !0,
  url: !0,
  week: !0
};
function uc(e) {
  var t = e && e.nodeName && e.nodeName.toLowerCase();
  return t === "input" ? !!w2[e.type] : t === "textarea"
}
function b1(e, t, n, r) {
  u1(r),
  t = go(t, "onChange"),
  0 < t.length && (n = new zl("onChange","change",null,n,r),
  e.push({
      event: n,
      listeners: t
  }))
}
var Dr = null
, Xr = null;
function S2(e) {
  $1(e, 0)
}
function Qo(e) {
  var t = Fn(e);
  if (n1(t))
      return e
}
function E2(e, t) {
  if (e === "change")
      return t
}
var O1 = !1;
if (Et) {
  var ba;
  if (Et) {
      var Oa = "oninput"in document;
      if (!Oa) {
          var cc = document.createElement("div");
          cc.setAttribute("oninput", "return;"),
          Oa = typeof cc.oninput == "function"
      }
      ba = Oa
  } else
      ba = !1;
  O1 = ba && (!document.documentMode || 9 < document.documentMode)
}
function dc() {
  Dr && (Dr.detachEvent("onpropertychange", V1),
  Xr = Dr = null)
}
function V1(e) {
  if (e.propertyName === "value" && Qo(Xr)) {
      var t = [];
      b1(t, Xr, e, Vl(e)),
      m1(S2, t)
  }
}
function N2(e, t, n) {
  e === "focusin" ? (dc(),
  Dr = t,
  Xr = n,
  Dr.attachEvent("onpropertychange", V1)) : e === "focusout" && dc()
}
function C2(e) {
  if (e === "selectionchange" || e === "keyup" || e === "keydown")
      return Qo(Xr)
}
function P2(e, t) {
  if (e === "click")
      return Qo(t)
}
function A2(e, t) {
  if (e === "input" || e === "change")
      return Qo(t)
}
function k2(e, t) {
  return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var ot = typeof Object.is == "function" ? Object.is : k2;
function qr(e, t) {
  if (ot(e, t))
      return !0;
  if (typeof e != "object" || e === null || typeof t != "object" || t === null)
      return !1;
  var n = Object.keys(e)
    , r = Object.keys(t);
  if (n.length !== r.length)
      return !1;
  for (r = 0; r < n.length; r++) {
      var i = n[r];
      if (!ds.call(t, i) || !ot(e[i], t[i]))
          return !1
  }
  return !0
}
function fc(e) {
  for (; e && e.firstChild; )
      e = e.firstChild;
  return e
}
function mc(e, t) {
  var n = fc(e);
  e = 0;
  for (var r; n; ) {
      if (n.nodeType === 3) {
          if (r = e + n.textContent.length,
          e <= t && r >= t)
              return {
                  node: n,
                  offset: t - e
              };
          e = r
      }
      e: {
          for (; n; ) {
              if (n.nextSibling) {
                  n = n.nextSibling;
                  break e
              }
              n = n.parentNode
          }
          n = void 0
      }
      n = fc(n)
  }
}
function D1(e, t) {
  return e && t ? e === t ? !0 : e && e.nodeType === 3 ? !1 : t && t.nodeType === 3 ? D1(e, t.parentNode) : "contains"in e ? e.contains(t) : e.compareDocumentPosition ? !!(e.compareDocumentPosition(t) & 16) : !1 : !1
}
function j1() {
  for (var e = window, t = lo(); t instanceof e.HTMLIFrameElement; ) {
      try {
          var n = typeof t.contentWindow.location.href == "string"
      } catch {
          n = !1
      }
      if (n)
          e = t.contentWindow;
      else
          break;
      t = lo(e.document)
  }
  return t
}
function $l(e) {
  var t = e && e.nodeName && e.nodeName.toLowerCase();
  return t && (t === "input" && (e.type === "text" || e.type === "search" || e.type === "tel" || e.type === "url" || e.type === "password") || t === "textarea" || e.contentEditable === "true")
}
function T2(e) {
  var t = j1()
    , n = e.focusedElem
    , r = e.selectionRange;
  if (t !== n && n && n.ownerDocument && D1(n.ownerDocument.documentElement, n)) {
      if (r !== null && $l(n)) {
          if (t = r.start,
          e = r.end,
          e === void 0 && (e = t),
          "selectionStart"in n)
              n.selectionStart = t,
              n.selectionEnd = Math.min(e, n.value.length);
          else if (e = (t = n.ownerDocument || document) && t.defaultView || window,
          e.getSelection) {
              e = e.getSelection();
              var i = n.textContent.length
                , o = Math.min(r.start, i);
              r = r.end === void 0 ? o : Math.min(r.end, i),
              !e.extend && o > r && (i = r,
              r = o,
              o = i),
              i = mc(n, o);
              var a = mc(n, r);
              i && a && (e.rangeCount !== 1 || e.anchorNode !== i.node || e.anchorOffset !== i.offset || e.focusNode !== a.node || e.focusOffset !== a.offset) && (t = t.createRange(),
              t.setStart(i.node, i.offset),
              e.removeAllRanges(),
              o > r ? (e.addRange(t),
              e.extend(a.node, a.offset)) : (t.setEnd(a.node, a.offset),
              e.addRange(t)))
          }
      }
      for (t = [],
      e = n; e = e.parentNode; )
          e.nodeType === 1 && t.push({
              element: e,
              left: e.scrollLeft,
              top: e.scrollTop
          });
      for (typeof n.focus == "function" && n.focus(),
      n = 0; n < t.length; n++)
          e = t[n],
          e.element.scrollLeft = e.left,
          e.element.scrollTop = e.top
  }
}
var M2 = Et && "documentMode"in document && 11 >= document.documentMode
, jn = null
, Ls = null
, jr = null
, Rs = !1;
function hc(e, t, n) {
  var r = n.window === n ? n.document : n.nodeType === 9 ? n : n.ownerDocument;
  Rs || jn == null || jn !== lo(r) || (r = jn,
  "selectionStart"in r && $l(r) ? r = {
      start: r.selectionStart,
      end: r.selectionEnd
  } : (r = (r.ownerDocument && r.ownerDocument.defaultView || window).getSelection(),
  r = {
      anchorNode: r.anchorNode,
      anchorOffset: r.anchorOffset,
      focusNode: r.focusNode,
      focusOffset: r.focusOffset
  }),
  jr && qr(jr, r) || (jr = r,
  r = go(Ls, "onSelect"),
  0 < r.length && (t = new zl("onSelect","select",null,t,n),
  e.push({
      event: t,
      listeners: r
  }),
  t.target = jn)))
}
function Vi(e, t) {
  var n = {};
  return n[e.toLowerCase()] = t.toLowerCase(),
  n["Webkit" + e] = "webkit" + t,
  n["Moz" + e] = "moz" + t,
  n
}
var In = {
  animationend: Vi("Animation", "AnimationEnd"),
  animationiteration: Vi("Animation", "AnimationIteration"),
  animationstart: Vi("Animation", "AnimationStart"),
  transitionend: Vi("Transition", "TransitionEnd")
}
, Va = {}
, I1 = {};
Et && (I1 = document.createElement("div").style,
"AnimationEvent"in window || (delete In.animationend.animation,
delete In.animationiteration.animation,
delete In.animationstart.animation),
"TransitionEvent"in window || delete In.transitionend.transition);
function Ko(e) {
  if (Va[e])
      return Va[e];
  if (!In[e])
      return e;
  var t = In[e], n;
  for (n in t)
      if (t.hasOwnProperty(n) && n in I1)
          return Va[e] = t[n];
  return e
}
var F1 = Ko("animationend")
, _1 = Ko("animationiteration")
, z1 = Ko("animationstart")
, H1 = Ko("transitionend")
, B1 = new Map
, pc = "abort auxClick cancel canPlay canPlayThrough click close contextMenu copy cut drag dragEnd dragEnter dragExit dragLeave dragOver dragStart drop durationChange emptied encrypted ended error gotPointerCapture input invalid keyDown keyPress keyUp load loadedData loadedMetadata loadStart lostPointerCapture mouseDown mouseMove mouseOut mouseOver mouseUp paste pause play playing pointerCancel pointerDown pointerMove pointerOut pointerOver pointerUp progress rateChange reset resize seeked seeking stalled submit suspend timeUpdate touchCancel touchEnd touchStart volumeChange scroll toggle touchMove waiting wheel".split(" ");
function Jt(e, t) {
  B1.set(e, t),
  kn(t, [e])
}
for (var Da = 0; Da < pc.length; Da++) {
  var ja = pc[Da]
    , L2 = ja.toLowerCase()
    , R2 = ja[0].toUpperCase() + ja.slice(1);
  Jt(L2, "on" + R2)
}
Jt(F1, "onAnimationEnd");
Jt(_1, "onAnimationIteration");
Jt(z1, "onAnimationStart");
Jt("dblclick", "onDoubleClick");
Jt("focusin", "onFocus");
Jt("focusout", "onBlur");
Jt(H1, "onTransitionEnd");
tr("onMouseEnter", ["mouseout", "mouseover"]);
tr("onMouseLeave", ["mouseout", "mouseover"]);
tr("onPointerEnter", ["pointerout", "pointerover"]);
tr("onPointerLeave", ["pointerout", "pointerover"]);
kn("onChange", "change click focusin focusout input keydown keyup selectionchange".split(" "));
kn("onSelect", "focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(" "));
kn("onBeforeInput", ["compositionend", "keypress", "textInput", "paste"]);
kn("onCompositionEnd", "compositionend focusout keydown keypress keyup mousedown".split(" "));
kn("onCompositionStart", "compositionstart focusout keydown keypress keyup mousedown".split(" "));
kn("onCompositionUpdate", "compositionupdate focusout keydown keypress keyup mousedown".split(" "));
var Lr = "abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange resize seeked seeking stalled suspend timeupdate volumechange waiting".split(" ")
, b2 = new Set("cancel close invalid load scroll toggle".split(" ").concat(Lr));
function gc(e, t, n) {
  var r = e.type || "unknown-event";
  e.currentTarget = n,
  Lp(r, t, void 0, e),
  e.currentTarget = null
}
function $1(e, t) {
  t = (t & 4) !== 0;
  for (var n = 0; n < e.length; n++) {
      var r = e[n]
        , i = r.event;
      r = r.listeners;
      e: {
          var o = void 0;
          if (t)
              for (var a = r.length - 1; 0 <= a; a--) {
                  var s = r[a]
                    , l = s.instance
                    , u = s.currentTarget;
                  if (s = s.listener,
                  l !== o && i.isPropagationStopped())
                      break e;
                  gc(i, s, u),
                  o = l
              }
          else
              for (a = 0; a < r.length; a++) {
                  if (s = r[a],
                  l = s.instance,
                  u = s.currentTarget,
                  s = s.listener,
                  l !== o && i.isPropagationStopped())
                      break e;
                  gc(i, s, u),
                  o = l
              }
      }
  }
  if (co)
      throw e = As,
      co = !1,
      As = null,
      e
}
function Q(e, t) {
  var n = t[js];
  n === void 0 && (n = t[js] = new Set);
  var r = e + "__bubble";
  n.has(r) || (U1(t, e, 2, !1),
  n.add(r))
}
function Ia(e, t, n) {
  var r = 0;
  t && (r |= 4),
  U1(n, e, r, t)
}
var Di = "_reactListening" + Math.random().toString(36).slice(2);
function Jr(e) {
  if (!e[Di]) {
      e[Di] = !0,
      Xd.forEach(function(n) {
          n !== "selectionchange" && (b2.has(n) || Ia(n, !1, e),
          Ia(n, !0, e))
      });
      var t = e.nodeType === 9 ? e : e.ownerDocument;
      t === null || t[Di] || (t[Di] = !0,
      Ia("selectionchange", !1, t))
  }
}
function U1(e, t, n, r) {
  switch (k1(t)) {
  case 1:
      var i = Gp;
      break;
  case 4:
      i = Wp;
      break;
  default:
      i = Fl
  }
  n = i.bind(null, t, n, e),
  i = void 0,
  !Ps || t !== "touchstart" && t !== "touchmove" && t !== "wheel" || (i = !0),
  r ? i !== void 0 ? e.addEventListener(t, n, {
      capture: !0,
      passive: i
  }) : e.addEventListener(t, n, !0) : i !== void 0 ? e.addEventListener(t, n, {
      passive: i
  }) : e.addEventListener(t, n, !1)
}
function Fa(e, t, n, r, i) {
  var o = r;
  if ((t & 1) === 0 && (t & 2) === 0 && r !== null)
      e: for (; ; ) {
          if (r === null)
              return;
          var a = r.tag;
          if (a === 3 || a === 4) {
              var s = r.stateNode.containerInfo;
              if (s === i || s.nodeType === 8 && s.parentNode === i)
                  break;
              if (a === 4)
                  for (a = r.return; a !== null; ) {
                      var l = a.tag;
                      if ((l === 3 || l === 4) && (l = a.stateNode.containerInfo,
                      l === i || l.nodeType === 8 && l.parentNode === i))
                          return;
                      a = a.return
                  }
              for (; s !== null; ) {
                  if (a = mn(s),
                  a === null)
                      return;
                  if (l = a.tag,
                  l === 5 || l === 6) {
                      r = o = a;
                      continue e
                  }
                  s = s.parentNode
              }
          }
          r = r.return
      }
  m1(function() {
      var u = o
        , f = Vl(n)
        , d = [];
      e: {
          var m = B1.get(e);
          if (m !== void 0) {
              var p = zl
                , v = e;
              switch (e) {
              case "keypress":
                  if (Xi(n) === 0)
                      break e;
              case "keydown":
              case "keyup":
                  p = l2;
                  break;
              case "focusin":
                  v = "focus",
                  p = Ra;
                  break;
              case "focusout":
                  v = "blur",
                  p = Ra;
                  break;
              case "beforeblur":
              case "afterblur":
                  p = Ra;
                  break;
              case "click":
                  if (n.button === 2)
                      break e;
              case "auxclick":
              case "dblclick":
              case "mousedown":
              case "mousemove":
              case "mouseup":
              case "mouseout":
              case "mouseover":
              case "contextmenu":
                  p = ic;
                  break;
              case "drag":
              case "dragend":
              case "dragenter":
              case "dragexit":
              case "dragleave":
              case "dragover":
              case "dragstart":
              case "drop":
                  p = Yp;
                  break;
              case "touchcancel":
              case "touchend":
              case "touchmove":
              case "touchstart":
                  p = d2;
                  break;
              case F1:
              case _1:
              case z1:
                  p = Jp;
                  break;
              case H1:
                  p = m2;
                  break;
              case "scroll":
                  p = Qp;
                  break;
              case "wheel":
                  p = p2;
                  break;
              case "copy":
              case "cut":
              case "paste":
                  p = t2;
                  break;
              case "gotpointercapture":
              case "lostpointercapture":
              case "pointercancel":
              case "pointerdown":
              case "pointermove":
              case "pointerout":
              case "pointerover":
              case "pointerup":
                  p = ac
              }
              var x = (t & 4) !== 0
                , P = !x && e === "scroll"
                , y = x ? m !== null ? m + "Capture" : null : m;
              x = [];
              for (var h = u, g; h !== null; ) {
                  g = h;
                  var S = g.stateNode;
                  if (g.tag === 5 && S !== null && (g = S,
                  y !== null && (S = Wr(h, y),
                  S != null && x.push(ei(h, S, g)))),
                  P)
                      break;
                  h = h.return
              }
              0 < x.length && (m = new p(m,v,null,n,f),
              d.push({
                  event: m,
                  listeners: x
              }))
          }
      }
      if ((t & 7) === 0) {
          e: {
              if (m = e === "mouseover" || e === "pointerover",
              p = e === "mouseout" || e === "pointerout",
              m && n !== Ns && (v = n.relatedTarget || n.fromElement) && (mn(v) || v[Nt]))
                  break e;
              if ((p || m) && (m = f.window === f ? f : (m = f.ownerDocument) ? m.defaultView || m.parentWindow : window,
              p ? (v = n.relatedTarget || n.toElement,
              p = u,
              v = v ? mn(v) : null,
              v !== null && (P = Tn(v),
              v !== P || v.tag !== 5 && v.tag !== 6) && (v = null)) : (p = null,
              v = u),
              p !== v)) {
                  if (x = ic,
                  S = "onMouseLeave",
                  y = "onMouseEnter",
                  h = "mouse",
                  (e === "pointerout" || e === "pointerover") && (x = ac,
                  S = "onPointerLeave",
                  y = "onPointerEnter",
                  h = "pointer"),
                  P = p == null ? m : Fn(p),
                  g = v == null ? m : Fn(v),
                  m = new x(S,h + "leave",p,n,f),
                  m.target = P,
                  m.relatedTarget = g,
                  S = null,
                  mn(f) === u && (x = new x(y,h + "enter",v,n,f),
                  x.target = g,
                  x.relatedTarget = P,
                  S = x),
                  P = S,
                  p && v)
                      t: {
                          for (x = p,
                          y = v,
                          h = 0,
                          g = x; g; g = bn(g))
                              h++;
                          for (g = 0,
                          S = y; S; S = bn(S))
                              g++;
                          for (; 0 < h - g; )
                              x = bn(x),
                              h--;
                          for (; 0 < g - h; )
                              y = bn(y),
                              g--;
                          for (; h--; ) {
                              if (x === y || y !== null && x === y.alternate)
                                  break t;
                              x = bn(x),
                              y = bn(y)
                          }
                          x = null
                      }
                  else
                      x = null;
                  p !== null && yc(d, m, p, x, !1),
                  v !== null && P !== null && yc(d, P, v, x, !0)
              }
          }
          e: {
              if (m = u ? Fn(u) : window,
              p = m.nodeName && m.nodeName.toLowerCase(),
              p === "select" || p === "input" && m.type === "file")
                  var M = E2;
              else if (uc(m))
                  if (O1)
                      M = A2;
                  else {
                      M = C2;
                      var A = N2
                  }
              else
                  (p = m.nodeName) && p.toLowerCase() === "input" && (m.type === "checkbox" || m.type === "radio") && (M = P2);
              if (M && (M = M(e, u))) {
                  b1(d, M, n, f);
                  break e
              }
              A && A(e, m, u),
              e === "focusout" && (A = m._wrapperState) && A.controlled && m.type === "number" && vs(m, "number", m.value)
          }
          switch (A = u ? Fn(u) : window,
          e) {
          case "focusin":
              (uc(A) || A.contentEditable === "true") && (jn = A,
              Ls = u,
              jr = null);
              break;
          case "focusout":
              jr = Ls = jn = null;
              break;
          case "mousedown":
              Rs = !0;
              break;
          case "contextmenu":
          case "mouseup":
          case "dragend":
              Rs = !1,
              hc(d, n, f);
              break;
          case "selectionchange":
              if (M2)
                  break;
          case "keydown":
          case "keyup":
              hc(d, n, f)
          }
          var C;
          if (Bl)
              e: {
                  switch (e) {
                  case "compositionstart":
                      var N = "onCompositionStart";
                      break e;
                  case "compositionend":
                      N = "onCompositionEnd";
                      break e;
                  case "compositionupdate":
                      N = "onCompositionUpdate";
                      break e
                  }
                  N = void 0
              }
          else
              Dn ? L1(e, n) && (N = "onCompositionEnd") : e === "keydown" && n.keyCode === 229 && (N = "onCompositionStart");
          N && (M1 && n.locale !== "ko" && (Dn || N !== "onCompositionStart" ? N === "onCompositionEnd" && Dn && (C = T1()) : (jt = f,
          _l = "value"in jt ? jt.value : jt.textContent,
          Dn = !0)),
          A = go(u, N),
          0 < A.length && (N = new oc(N,e,null,n,f),
          d.push({
              event: N,
              listeners: A
          }),
          C ? N.data = C : (C = R1(n),
          C !== null && (N.data = C)))),
          (C = y2 ? v2(e, n) : x2(e, n)) && (u = go(u, "onBeforeInput"),
          0 < u.length && (f = new oc("onBeforeInput","beforeinput",null,n,f),
          d.push({
              event: f,
              listeners: u
          }),
          f.data = C))
      }
      $1(d, t)
  })
}
function ei(e, t, n) {
  return {
      instance: e,
      listener: t,
      currentTarget: n
  }
}
function go(e, t) {
  for (var n = t + "Capture", r = []; e !== null; ) {
      var i = e
        , o = i.stateNode;
      i.tag === 5 && o !== null && (i = o,
      o = Wr(e, n),
      o != null && r.unshift(ei(e, o, i)),
      o = Wr(e, t),
      o != null && r.push(ei(e, o, i))),
      e = e.return
  }
  return r
}
function bn(e) {
  if (e === null)
      return null;
  do
      e = e.return;
  while (e && e.tag !== 5);
  return e || null
}
function yc(e, t, n, r, i) {
  for (var o = t._reactName, a = []; n !== null && n !== r; ) {
      var s = n
        , l = s.alternate
        , u = s.stateNode;
      if (l !== null && l === r)
          break;
      s.tag === 5 && u !== null && (s = u,
      i ? (l = Wr(n, o),
      l != null && a.unshift(ei(n, l, s))) : i || (l = Wr(n, o),
      l != null && a.push(ei(n, l, s)))),
      n = n.return
  }
  a.length !== 0 && e.push({
      event: t,
      listeners: a
  })
}
var O2 = /\r\n?/g
, V2 = /\u0000|\uFFFD/g;
function vc(e) {
  return (typeof e == "string" ? e : "" + e).replace(O2, `
`).replace(V2, "")
}
function ji(e, t, n) {
  if (t = vc(t),
  vc(e) !== t && n)
      throw Error(L(425))
}
function yo() {}
var bs = null
, Os = null;
function Vs(e, t) {
  return e === "textarea" || e === "noscript" || typeof t.children == "string" || typeof t.children == "number" || typeof t.dangerouslySetInnerHTML == "object" && t.dangerouslySetInnerHTML !== null && t.dangerouslySetInnerHTML.__html != null
}
var Ds = typeof setTimeout == "function" ? setTimeout : void 0
, D2 = typeof clearTimeout == "function" ? clearTimeout : void 0
, xc = typeof Promise == "function" ? Promise : void 0
, j2 = typeof queueMicrotask == "function" ? queueMicrotask : typeof xc < "u" ? function(e) {
  return xc.resolve(null).then(e).catch(I2)
}
: Ds;
function I2(e) {
  setTimeout(function() {
      throw e
  })
}
function _a(e, t) {
  var n = t
    , r = 0;
  do {
      var i = n.nextSibling;
      if (e.removeChild(n),
      i && i.nodeType === 8)
          if (n = i.data,
          n === "/$") {
              if (r === 0) {
                  e.removeChild(i),
                  Yr(t);
                  return
              }
              r--
          } else
              n !== "$" && n !== "$?" && n !== "$!" || r++;
      n = i
  } while (n);
  Yr(t)
}
function Bt(e) {
  for (; e != null; e = e.nextSibling) {
      var t = e.nodeType;
      if (t === 1 || t === 3)
          break;
      if (t === 8) {
          if (t = e.data,
          t === "$" || t === "$!" || t === "$?")
              break;
          if (t === "/$")
              return null
      }
  }
  return e
}
function wc(e) {
  e = e.previousSibling;
  for (var t = 0; e; ) {
      if (e.nodeType === 8) {
          var n = e.data;
          if (n === "$" || n === "$!" || n === "$?") {
              if (t === 0)
                  return e;
              t--
          } else
              n === "/$" && t++
      }
      e = e.previousSibling
  }
  return null
}
var mr = Math.random().toString(36).slice(2)
, ut = "__reactFiber$" + mr
, ti = "__reactProps$" + mr
, Nt = "__reactContainer$" + mr
, js = "__reactEvents$" + mr
, F2 = "__reactListeners$" + mr
, _2 = "__reactHandles$" + mr;
function mn(e) {
  var t = e[ut];
  if (t)
      return t;
  for (var n = e.parentNode; n; ) {
      if (t = n[Nt] || n[ut]) {
          if (n = t.alternate,
          t.child !== null || n !== null && n.child !== null)
              for (e = wc(e); e !== null; ) {
                  if (n = e[ut])
                      return n;
                  e = wc(e)
              }
          return t
      }
      e = n,
      n = e.parentNode
  }
  return null
}
function vi(e) {
  return e = e[ut] || e[Nt],
  !e || e.tag !== 5 && e.tag !== 6 && e.tag !== 13 && e.tag !== 3 ? null : e
}
function Fn(e) {
  if (e.tag === 5 || e.tag === 6)
      return e.stateNode;
  throw Error(L(33))
}
function Yo(e) {
  return e[ti] || null
}
var Is = []
, _n = -1;
function en(e) {
  return {
      current: e
  }
}
function K(e) {
  0 > _n || (e.current = Is[_n],
  Is[_n] = null,
  _n--)
}
function G(e, t) {
  _n++,
  Is[_n] = e.current,
  e.current = t
}
var Yt = {}
, Ne = en(Yt)
, be = en(!1)
, En = Yt;
function nr(e, t) {
  var n = e.type.contextTypes;
  if (!n)
      return Yt;
  var r = e.stateNode;
  if (r && r.__reactInternalMemoizedUnmaskedChildContext === t)
      return r.__reactInternalMemoizedMaskedChildContext;
  var i = {}, o;
  for (o in n)
      i[o] = t[o];
  return r && (e = e.stateNode,
  e.__reactInternalMemoizedUnmaskedChildContext = t,
  e.__reactInternalMemoizedMaskedChildContext = i),
  i
}
function Oe(e) {
  return e = e.childContextTypes,
  e != null
}
function vo() {
  K(be),
  K(Ne)
}
function Sc(e, t, n) {
  if (Ne.current !== Yt)
      throw Error(L(168));
  G(Ne, t),
  G(be, n)
}
function Z1(e, t, n) {
  var r = e.stateNode;
  if (t = t.childContextTypes,
  typeof r.getChildContext != "function")
      return n;
  r = r.getChildContext();
  for (var i in r)
      if (!(i in t))
          throw Error(L(108, Np(e) || "Unknown", i));
  return te({}, n, r)
}
function xo(e) {
  return e = (e = e.stateNode) && e.__reactInternalMemoizedMergedChildContext || Yt,
  En = Ne.current,
  G(Ne, e),
  G(be, be.current),
  !0
}
function Ec(e, t, n) {
  var r = e.stateNode;
  if (!r)
      throw Error(L(169));
  n ? (e = Z1(e, t, En),
  r.__reactInternalMemoizedMergedChildContext = e,
  K(be),
  K(Ne),
  G(Ne, e)) : K(be),
  G(be, n)
}
var pt = null
, Xo = !1
, za = !1;
function G1(e) {
  pt === null ? pt = [e] : pt.push(e)
}
function z2(e) {
  Xo = !0,
  G1(e)
}
function tn() {
  if (!za && pt !== null) {
      za = !0;
      var e = 0
        , t = Z;
      try {
          var n = pt;
          for (Z = 1; e < n.length; e++) {
              var r = n[e];
              do
                  r = r(!0);
              while (r !== null)
          }
          pt = null,
          Xo = !1
      } catch (i) {
          throw pt !== null && (pt = pt.slice(e + 1)),
          y1(Dl, tn),
          i
      } finally {
          Z = t,
          za = !1
      }
  }
  return null
}
var zn = []
, Hn = 0
, wo = null
, So = 0
, Ge = []
, We = 0
, Nn = null
, gt = 1
, yt = "";
function ln(e, t) {
  zn[Hn++] = So,
  zn[Hn++] = wo,
  wo = e,
  So = t
}
function W1(e, t, n) {
  Ge[We++] = gt,
  Ge[We++] = yt,
  Ge[We++] = Nn,
  Nn = e;
  var r = gt;
  e = yt;
  var i = 32 - rt(r) - 1;
  r &= ~(1 << i),
  n += 1;
  var o = 32 - rt(t) + i;
  if (30 < o) {
      var a = i - i % 5;
      o = (r & (1 << a) - 1).toString(32),
      r >>= a,
      i -= a,
      gt = 1 << 32 - rt(t) + i | n << i | r,
      yt = o + e
  } else
      gt = 1 << o | n << i | r,
      yt = e
}
function Ul(e) {
  e.return !== null && (ln(e, 1),
  W1(e, 1, 0))
}
function Zl(e) {
  for (; e === wo; )
      wo = zn[--Hn],
      zn[Hn] = null,
      So = zn[--Hn],
      zn[Hn] = null;
  for (; e === Nn; )
      Nn = Ge[--We],
      Ge[We] = null,
      yt = Ge[--We],
      Ge[We] = null,
      gt = Ge[--We],
      Ge[We] = null
}
var _e = null
, Fe = null
, X = !1
, nt = null;
function Q1(e, t) {
  var n = Qe(5, null, null, 0);
  n.elementType = "DELETED",
  n.stateNode = t,
  n.return = e,
  t = e.deletions,
  t === null ? (e.deletions = [n],
  e.flags |= 16) : t.push(n)
}
function Nc(e, t) {
  switch (e.tag) {
  case 5:
      var n = e.type;
      return t = t.nodeType !== 1 || n.toLowerCase() !== t.nodeName.toLowerCase() ? null : t,
      t !== null ? (e.stateNode = t,
      _e = e,
      Fe = Bt(t.firstChild),
      !0) : !1;
  case 6:
      return t = e.pendingProps === "" || t.nodeType !== 3 ? null : t,
      t !== null ? (e.stateNode = t,
      _e = e,
      Fe = null,
      !0) : !1;
  case 13:
      return t = t.nodeType !== 8 ? null : t,
      t !== null ? (n = Nn !== null ? {
          id: gt,
          overflow: yt
      } : null,
      e.memoizedState = {
          dehydrated: t,
          treeContext: n,
          retryLane: 1073741824
      },
      n = Qe(18, null, null, 0),
      n.stateNode = t,
      n.return = e,
      e.child = n,
      _e = e,
      Fe = null,
      !0) : !1;
  default:
      return !1
  }
}
function Fs(e) {
  return (e.mode & 1) !== 0 && (e.flags & 128) === 0
}
function _s(e) {
  if (X) {
      var t = Fe;
      if (t) {
          var n = t;
          if (!Nc(e, t)) {
              if (Fs(e))
                  throw Error(L(418));
              t = Bt(n.nextSibling);
              var r = _e;
              t && Nc(e, t) ? Q1(r, n) : (e.flags = e.flags & -4097 | 2,
              X = !1,
              _e = e)
          }
      } else {
          if (Fs(e))
              throw Error(L(418));
          e.flags = e.flags & -4097 | 2,
          X = !1,
          _e = e
      }
  }
}
function Cc(e) {
  for (e = e.return; e !== null && e.tag !== 5 && e.tag !== 3 && e.tag !== 13; )
      e = e.return;
  _e = e
}
function Ii(e) {
  if (e !== _e)
      return !1;
  if (!X)
      return Cc(e),
      X = !0,
      !1;
  var t;
  if ((t = e.tag !== 3) && !(t = e.tag !== 5) && (t = e.type,
  t = t !== "head" && t !== "body" && !Vs(e.type, e.memoizedProps)),
  t && (t = Fe)) {
      if (Fs(e))
          throw K1(),
          Error(L(418));
      for (; t; )
          Q1(e, t),
          t = Bt(t.nextSibling)
  }
  if (Cc(e),
  e.tag === 13) {
      if (e = e.memoizedState,
      e = e !== null ? e.dehydrated : null,
      !e)
          throw Error(L(317));
      e: {
          for (e = e.nextSibling,
          t = 0; e; ) {
              if (e.nodeType === 8) {
                  var n = e.data;
                  if (n === "/$") {
                      if (t === 0) {
                          Fe = Bt(e.nextSibling);
                          break e
                      }
                      t--
                  } else
                      n !== "$" && n !== "$!" && n !== "$?" || t++
              }
              e = e.nextSibling
          }
          Fe = null
      }
  } else
      Fe = _e ? Bt(e.stateNode.nextSibling) : null;
  return !0
}
function K1() {
  for (var e = Fe; e; )
      e = Bt(e.nextSibling)
}
function rr() {
  Fe = _e = null,
  X = !1
}
function Gl(e) {
  nt === null ? nt = [e] : nt.push(e)
}
var H2 = kt.ReactCurrentBatchConfig;
function Er(e, t, n) {
  if (e = n.ref,
  e !== null && typeof e != "function" && typeof e != "object") {
      if (n._owner) {
          if (n = n._owner,
          n) {
              if (n.tag !== 1)
                  throw Error(L(309));
              var r = n.stateNode
          }
          if (!r)
              throw Error(L(147, e));
          var i = r
            , o = "" + e;
          return t !== null && t.ref !== null && typeof t.ref == "function" && t.ref._stringRef === o ? t.ref : (t = function(a) {
              var s = i.refs;
              a === null ? delete s[o] : s[o] = a
          }
          ,
          t._stringRef = o,
          t)
      }
      if (typeof e != "string")
          throw Error(L(284));
      if (!n._owner)
          throw Error(L(290, e))
  }
  return e
}
function Fi(e, t) {
  throw e = Object.prototype.toString.call(t),
  Error(L(31, e === "[object Object]" ? "object with keys {" + Object.keys(t).join(", ") + "}" : e))
}
function Pc(e) {
  var t = e._init;
  return t(e._payload)
}
function Y1(e) {
  function t(y, h) {
      if (e) {
          var g = y.deletions;
          g === null ? (y.deletions = [h],
          y.flags |= 16) : g.push(h)
      }
  }
  function n(y, h) {
      if (!e)
          return null;
      for (; h !== null; )
          t(y, h),
          h = h.sibling;
      return null
  }
  function r(y, h) {
      for (y = new Map; h !== null; )
          h.key !== null ? y.set(h.key, h) : y.set(h.index, h),
          h = h.sibling;
      return y
  }
  function i(y, h) {
      return y = Gt(y, h),
      y.index = 0,
      y.sibling = null,
      y
  }
  function o(y, h, g) {
      return y.index = g,
      e ? (g = y.alternate,
      g !== null ? (g = g.index,
      g < h ? (y.flags |= 2,
      h) : g) : (y.flags |= 2,
      h)) : (y.flags |= 1048576,
      h)
  }
  function a(y) {
      return e && y.alternate === null && (y.flags |= 2),
      y
  }
  function s(y, h, g, S) {
      return h === null || h.tag !== 6 ? (h = Wa(g, y.mode, S),
      h.return = y,
      h) : (h = i(h, g),
      h.return = y,
      h)
  }
  function l(y, h, g, S) {
      var M = g.type;
      return M === Vn ? f(y, h, g.props.children, S, g.key) : h !== null && (h.elementType === M || typeof M == "object" && M !== null && M.$$typeof === Rt && Pc(M) === h.type) ? (S = i(h, g.props),
      S.ref = Er(y, h, g),
      S.return = y,
      S) : (S = io(g.type, g.key, g.props, null, y.mode, S),
      S.ref = Er(y, h, g),
      S.return = y,
      S)
  }
  function u(y, h, g, S) {
      return h === null || h.tag !== 4 || h.stateNode.containerInfo !== g.containerInfo || h.stateNode.implementation !== g.implementation ? (h = Qa(g, y.mode, S),
      h.return = y,
      h) : (h = i(h, g.children || []),
      h.return = y,
      h)
  }
  function f(y, h, g, S, M) {
      return h === null || h.tag !== 7 ? (h = vn(g, y.mode, S, M),
      h.return = y,
      h) : (h = i(h, g),
      h.return = y,
      h)
  }
  function d(y, h, g) {
      if (typeof h == "string" && h !== "" || typeof h == "number")
          return h = Wa("" + h, y.mode, g),
          h.return = y,
          h;
      if (typeof h == "object" && h !== null) {
          switch (h.$$typeof) {
          case ki:
              return g = io(h.type, h.key, h.props, null, y.mode, g),
              g.ref = Er(y, null, h),
              g.return = y,
              g;
          case On:
              return h = Qa(h, y.mode, g),
              h.return = y,
              h;
          case Rt:
              var S = h._init;
              return d(y, S(h._payload), g)
          }
          if (Tr(h) || yr(h))
              return h = vn(h, y.mode, g, null),
              h.return = y,
              h;
          Fi(y, h)
      }
      return null
  }
  function m(y, h, g, S) {
      var M = h !== null ? h.key : null;
      if (typeof g == "string" && g !== "" || typeof g == "number")
          return M !== null ? null : s(y, h, "" + g, S);
      if (typeof g == "object" && g !== null) {
          switch (g.$$typeof) {
          case ki:
              return g.key === M ? l(y, h, g, S) : null;
          case On:
              return g.key === M ? u(y, h, g, S) : null;
          case Rt:
              return M = g._init,
              m(y, h, M(g._payload), S)
          }
          if (Tr(g) || yr(g))
              return M !== null ? null : f(y, h, g, S, null);
          Fi(y, g)
      }
      return null
  }
  function p(y, h, g, S, M) {
      if (typeof S == "string" && S !== "" || typeof S == "number")
          return y = y.get(g) || null,
          s(h, y, "" + S, M);
      if (typeof S == "object" && S !== null) {
          switch (S.$$typeof) {
          case ki:
              return y = y.get(S.key === null ? g : S.key) || null,
              l(h, y, S, M);
          case On:
              return y = y.get(S.key === null ? g : S.key) || null,
              u(h, y, S, M);
          case Rt:
              var A = S._init;
              return p(y, h, g, A(S._payload), M)
          }
          if (Tr(S) || yr(S))
              return y = y.get(g) || null,
              f(h, y, S, M, null);
          Fi(h, S)
      }
      return null
  }
  function v(y, h, g, S) {
      for (var M = null, A = null, C = h, N = h = 0, R = null; C !== null && N < g.length; N++) {
          C.index > N ? (R = C,
          C = null) : R = C.sibling;
          var O = m(y, C, g[N], S);
          if (O === null) {
              C === null && (C = R);
              break
          }
          e && C && O.alternate === null && t(y, C),
          h = o(O, h, N),
          A === null ? M = O : A.sibling = O,
          A = O,
          C = R
      }
      if (N === g.length)
          return n(y, C),
          X && ln(y, N),
          M;
      if (C === null) {
          for (; N < g.length; N++)
              C = d(y, g[N], S),
              C !== null && (h = o(C, h, N),
              A === null ? M = C : A.sibling = C,
              A = C);
          return X && ln(y, N),
          M
      }
      for (C = r(y, C); N < g.length; N++)
          R = p(C, y, N, g[N], S),
          R !== null && (e && R.alternate !== null && C.delete(R.key === null ? N : R.key),
          h = o(R, h, N),
          A === null ? M = R : A.sibling = R,
          A = R);
      return e && C.forEach(function(U) {
          return t(y, U)
      }),
      X && ln(y, N),
      M
  }
  function x(y, h, g, S) {
      var M = yr(g);
      if (typeof M != "function")
          throw Error(L(150));
      if (g = M.call(g),
      g == null)
          throw Error(L(151));
      for (var A = M = null, C = h, N = h = 0, R = null, O = g.next(); C !== null && !O.done; N++,
      O = g.next()) {
          C.index > N ? (R = C,
          C = null) : R = C.sibling;
          var U = m(y, C, O.value, S);
          if (U === null) {
              C === null && (C = R);
              break
          }
          e && C && U.alternate === null && t(y, C),
          h = o(U, h, N),
          A === null ? M = U : A.sibling = U,
          A = U,
          C = R
      }
      if (O.done)
          return n(y, C),
          X && ln(y, N),
          M;
      if (C === null) {
          for (; !O.done; N++,
          O = g.next())
              O = d(y, O.value, S),
              O !== null && (h = o(O, h, N),
              A === null ? M = O : A.sibling = O,
              A = O);
          return X && ln(y, N),
          M
      }
      for (C = r(y, C); !O.done; N++,
      O = g.next())
          O = p(C, y, N, O.value, S),
          O !== null && (e && O.alternate !== null && C.delete(O.key === null ? N : O.key),
          h = o(O, h, N),
          A === null ? M = O : A.sibling = O,
          A = O);
      return e && C.forEach(function(ue) {
          return t(y, ue)
      }),
      X && ln(y, N),
      M
  }
  function P(y, h, g, S) {
      if (typeof g == "object" && g !== null && g.type === Vn && g.key === null && (g = g.props.children),
      typeof g == "object" && g !== null) {
          switch (g.$$typeof) {
          case ki:
              e: {
                  for (var M = g.key, A = h; A !== null; ) {
                      if (A.key === M) {
                          if (M = g.type,
                          M === Vn) {
                              if (A.tag === 7) {
                                  n(y, A.sibling),
                                  h = i(A, g.props.children),
                                  h.return = y,
                                  y = h;
                                  break e
                              }
                          } else if (A.elementType === M || typeof M == "object" && M !== null && M.$$typeof === Rt && Pc(M) === A.type) {
                              n(y, A.sibling),
                              h = i(A, g.props),
                              h.ref = Er(y, A, g),
                              h.return = y,
                              y = h;
                              break e
                          }
                          n(y, A);
                          break
                      } else
                          t(y, A);
                      A = A.sibling
                  }
                  g.type === Vn ? (h = vn(g.props.children, y.mode, S, g.key),
                  h.return = y,
                  y = h) : (S = io(g.type, g.key, g.props, null, y.mode, S),
                  S.ref = Er(y, h, g),
                  S.return = y,
                  y = S)
              }
              return a(y);
          case On:
              e: {
                  for (A = g.key; h !== null; ) {
                      if (h.key === A)
                          if (h.tag === 4 && h.stateNode.containerInfo === g.containerInfo && h.stateNode.implementation === g.implementation) {
                              n(y, h.sibling),
                              h = i(h, g.children || []),
                              h.return = y,
                              y = h;
                              break e
                          } else {
                              n(y, h);
                              break
                          }
                      else
                          t(y, h);
                      h = h.sibling
                  }
                  h = Qa(g, y.mode, S),
                  h.return = y,
                  y = h
              }
              return a(y);
          case Rt:
              return A = g._init,
              P(y, h, A(g._payload), S)
          }
          if (Tr(g))
              return v(y, h, g, S);
          if (yr(g))
              return x(y, h, g, S);
          Fi(y, g)
      }
      return typeof g == "string" && g !== "" || typeof g == "number" ? (g = "" + g,
      h !== null && h.tag === 6 ? (n(y, h.sibling),
      h = i(h, g),
      h.return = y,
      y = h) : (n(y, h),
      h = Wa(g, y.mode, S),
      h.return = y,
      y = h),
      a(y)) : n(y, h)
  }
  return P
}
var ir = Y1(!0)
, X1 = Y1(!1)
, Eo = en(null)
, No = null
, Bn = null
, Wl = null;
function Ql() {
  Wl = Bn = No = null
}
function Kl(e) {
  var t = Eo.current;
  K(Eo),
  e._currentValue = t
}
function zs(e, t, n) {
  for (; e !== null; ) {
      var r = e.alternate;
      if ((e.childLanes & t) !== t ? (e.childLanes |= t,
      r !== null && (r.childLanes |= t)) : r !== null && (r.childLanes & t) !== t && (r.childLanes |= t),
      e === n)
          break;
      e = e.return
  }
}
function Jn(e, t) {
  No = e,
  Wl = Bn = null,
  e = e.dependencies,
  e !== null && e.firstContext !== null && ((e.lanes & t) !== 0 && (Re = !0),
  e.firstContext = null)
}
function Ye(e) {
  var t = e._currentValue;
  if (Wl !== e)
      if (e = {
          context: e,
          memoizedValue: t,
          next: null
      },
      Bn === null) {
          if (No === null)
              throw Error(L(308));
          Bn = e,
          No.dependencies = {
              lanes: 0,
              firstContext: e
          }
      } else
          Bn = Bn.next = e;
  return t
}
var hn = null;
function Yl(e) {
  hn === null ? hn = [e] : hn.push(e)
}
function q1(e, t, n, r) {
  var i = t.interleaved;
  return i === null ? (n.next = n,
  Yl(t)) : (n.next = i.next,
  i.next = n),
  t.interleaved = n,
  Ct(e, r)
}
function Ct(e, t) {
  e.lanes |= t;
  var n = e.alternate;
  for (n !== null && (n.lanes |= t),
  n = e,
  e = e.return; e !== null; )
      e.childLanes |= t,
      n = e.alternate,
      n !== null && (n.childLanes |= t),
      n = e,
      e = e.return;
  return n.tag === 3 ? n.stateNode : null
}
var bt = !1;
function Xl(e) {
  e.updateQueue = {
      baseState: e.memoizedState,
      firstBaseUpdate: null,
      lastBaseUpdate: null,
      shared: {
          pending: null,
          interleaved: null,
          lanes: 0
      },
      effects: null
  }
}
function J1(e, t) {
  e = e.updateQueue,
  t.updateQueue === e && (t.updateQueue = {
      baseState: e.baseState,
      firstBaseUpdate: e.firstBaseUpdate,
      lastBaseUpdate: e.lastBaseUpdate,
      shared: e.shared,
      effects: e.effects
  })
}
function xt(e, t) {
  return {
      eventTime: e,
      lane: t,
      tag: 0,
      payload: null,
      callback: null,
      next: null
  }
}
function $t(e, t, n) {
  var r = e.updateQueue;
  if (r === null)
      return null;
  if (r = r.shared,
  (B & 2) !== 0) {
      var i = r.pending;
      return i === null ? t.next = t : (t.next = i.next,
      i.next = t),
      r.pending = t,
      Ct(e, n)
  }
  return i = r.interleaved,
  i === null ? (t.next = t,
  Yl(r)) : (t.next = i.next,
  i.next = t),
  r.interleaved = t,
  Ct(e, n)
}
function qi(e, t, n) {
  if (t = t.updateQueue,
  t !== null && (t = t.shared,
  (n & 4194240) !== 0)) {
      var r = t.lanes;
      r &= e.pendingLanes,
      n |= r,
      t.lanes = n,
      jl(e, n)
  }
}
function Ac(e, t) {
  var n = e.updateQueue
    , r = e.alternate;
  if (r !== null && (r = r.updateQueue,
  n === r)) {
      var i = null
        , o = null;
      if (n = n.firstBaseUpdate,
      n !== null) {
          do {
              var a = {
                  eventTime: n.eventTime,
                  lane: n.lane,
                  tag: n.tag,
                  payload: n.payload,
                  callback: n.callback,
                  next: null
              };
              o === null ? i = o = a : o = o.next = a,
              n = n.next
          } while (n !== null);
          o === null ? i = o = t : o = o.next = t
      } else
          i = o = t;
      n = {
          baseState: r.baseState,
          firstBaseUpdate: i,
          lastBaseUpdate: o,
          shared: r.shared,
          effects: r.effects
      },
      e.updateQueue = n;
      return
  }
  e = n.lastBaseUpdate,
  e === null ? n.firstBaseUpdate = t : e.next = t,
  n.lastBaseUpdate = t
}
function Co(e, t, n, r) {
  var i = e.updateQueue;
  bt = !1;
  var o = i.firstBaseUpdate
    , a = i.lastBaseUpdate
    , s = i.shared.pending;
  if (s !== null) {
      i.shared.pending = null;
      var l = s
        , u = l.next;
      l.next = null,
      a === null ? o = u : a.next = u,
      a = l;
      var f = e.alternate;
      f !== null && (f = f.updateQueue,
      s = f.lastBaseUpdate,
      s !== a && (s === null ? f.firstBaseUpdate = u : s.next = u,
      f.lastBaseUpdate = l))
  }
  if (o !== null) {
      var d = i.baseState;
      a = 0,
      f = u = l = null,
      s = o;
      do {
          var m = s.lane
            , p = s.eventTime;
          if ((r & m) === m) {
              f !== null && (f = f.next = {
                  eventTime: p,
                  lane: 0,
                  tag: s.tag,
                  payload: s.payload,
                  callback: s.callback,
                  next: null
              });
              e: {
                  var v = e
                    , x = s;
                  switch (m = t,
                  p = n,
                  x.tag) {
                  case 1:
                      if (v = x.payload,
                      typeof v == "function") {
                          d = v.call(p, d, m);
                          break e
                      }
                      d = v;
                      break e;
                  case 3:
                      v.flags = v.flags & -65537 | 128;
                  case 0:
                      if (v = x.payload,
                      m = typeof v == "function" ? v.call(p, d, m) : v,
                      m == null)
                          break e;
                      d = te({}, d, m);
                      break e;
                  case 2:
                      bt = !0
                  }
              }
              s.callback !== null && s.lane !== 0 && (e.flags |= 64,
              m = i.effects,
              m === null ? i.effects = [s] : m.push(s))
          } else
              p = {
                  eventTime: p,
                  lane: m,
                  tag: s.tag,
                  payload: s.payload,
                  callback: s.callback,
                  next: null
              },
              f === null ? (u = f = p,
              l = d) : f = f.next = p,
              a |= m;
          if (s = s.next,
          s === null) {
              if (s = i.shared.pending,
              s === null)
                  break;
              m = s,
              s = m.next,
              m.next = null,
              i.lastBaseUpdate = m,
              i.shared.pending = null
          }
      } while (1);
      if (f === null && (l = d),
      i.baseState = l,
      i.firstBaseUpdate = u,
      i.lastBaseUpdate = f,
      t = i.shared.interleaved,
      t !== null) {
          i = t;
          do
              a |= i.lane,
              i = i.next;
          while (i !== t)
      } else
          o === null && (i.shared.lanes = 0);
      Pn |= a,
      e.lanes = a,
      e.memoizedState = d
  }
}
function kc(e, t, n) {
  if (e = t.effects,
  t.effects = null,
  e !== null)
      for (t = 0; t < e.length; t++) {
          var r = e[t]
            , i = r.callback;
          if (i !== null) {
              if (r.callback = null,
              r = n,
              typeof i != "function")
                  throw Error(L(191, i));
              i.call(r)
          }
      }
}
var xi = {}
, dt = en(xi)
, ni = en(xi)
, ri = en(xi);
function pn(e) {
  if (e === xi)
      throw Error(L(174));
  return e
}
function ql(e, t) {
  switch (G(ri, t),
  G(ni, e),
  G(dt, xi),
  e = t.nodeType,
  e) {
  case 9:
  case 11:
      t = (t = t.documentElement) ? t.namespaceURI : ws(null, "");
      break;
  default:
      e = e === 8 ? t.parentNode : t,
      t = e.namespaceURI || null,
      e = e.tagName,
      t = ws(t, e)
  }
  K(dt),
  G(dt, t)
}
function or() {
  K(dt),
  K(ni),
  K(ri)
}
function ef(e) {
  pn(ri.current);
  var t = pn(dt.current)
    , n = ws(t, e.type);
  t !== n && (G(ni, e),
  G(dt, n))
}
function Jl(e) {
  ni.current === e && (K(dt),
  K(ni))
}
var q = en(0);
function Po(e) {
  for (var t = e; t !== null; ) {
      if (t.tag === 13) {
          var n = t.memoizedState;
          if (n !== null && (n = n.dehydrated,
          n === null || n.data === "$?" || n.data === "$!"))
              return t
      } else if (t.tag === 19 && t.memoizedProps.revealOrder !== void 0) {
          if ((t.flags & 128) !== 0)
              return t
      } else if (t.child !== null) {
          t.child.return = t,
          t = t.child;
          continue
      }
      if (t === e)
          break;
      for (; t.sibling === null; ) {
          if (t.return === null || t.return === e)
              return null;
          t = t.return
      }
      t.sibling.return = t.return,
      t = t.sibling
  }
  return null
}
var Ha = [];
function eu() {
  for (var e = 0; e < Ha.length; e++)
      Ha[e]._workInProgressVersionPrimary = null;
  Ha.length = 0
}
var Ji = kt.ReactCurrentDispatcher
, Ba = kt.ReactCurrentBatchConfig
, Cn = 0
, ee = null
, ce = null
, me = null
, Ao = !1
, Ir = !1
, ii = 0
, B2 = 0;
function xe() {
  throw Error(L(321))
}
function tu(e, t) {
  if (t === null)
      return !1;
  for (var n = 0; n < t.length && n < e.length; n++)
      if (!ot(e[n], t[n]))
          return !1;
  return !0
}
function nu(e, t, n, r, i, o) {
  if (Cn = o,
  ee = t,
  t.memoizedState = null,
  t.updateQueue = null,
  t.lanes = 0,
  Ji.current = e === null || e.memoizedState === null ? G2 : W2,
  e = n(r, i),
  Ir) {
      o = 0;
      do {
          if (Ir = !1,
          ii = 0,
          25 <= o)
              throw Error(L(301));
          o += 1,
          me = ce = null,
          t.updateQueue = null,
          Ji.current = Q2,
          e = n(r, i)
      } while (Ir)
  }
  if (Ji.current = ko,
  t = ce !== null && ce.next !== null,
  Cn = 0,
  me = ce = ee = null,
  Ao = !1,
  t)
      throw Error(L(300));
  return e
}
function ru() {
  var e = ii !== 0;
  return ii = 0,
  e
}
function lt() {
  var e = {
      memoizedState: null,
      baseState: null,
      baseQueue: null,
      queue: null,
      next: null
  };
  return me === null ? ee.memoizedState = me = e : me = me.next = e,
  me
}
function Xe() {
  if (ce === null) {
      var e = ee.alternate;
      e = e !== null ? e.memoizedState : null
  } else
      e = ce.next;
  var t = me === null ? ee.memoizedState : me.next;
  if (t !== null)
      me = t,
      ce = e;
  else {
      if (e === null)
          throw Error(L(310));
      ce = e,
      e = {
          memoizedState: ce.memoizedState,
          baseState: ce.baseState,
          baseQueue: ce.baseQueue,
          queue: ce.queue,
          next: null
      },
      me === null ? ee.memoizedState = me = e : me = me.next = e
  }
  return me
}
function oi(e, t) {
  return typeof t == "function" ? t(e) : t
}
function $a(e) {
  var t = Xe()
    , n = t.queue;
  if (n === null)
      throw Error(L(311));
  n.lastRenderedReducer = e;
  var r = ce
    , i = r.baseQueue
    , o = n.pending;
  if (o !== null) {
      if (i !== null) {
          var a = i.next;
          i.next = o.next,
          o.next = a
      }
      r.baseQueue = i = o,
      n.pending = null
  }
  if (i !== null) {
      o = i.next,
      r = r.baseState;
      var s = a = null
        , l = null
        , u = o;
      do {
          var f = u.lane;
          if ((Cn & f) === f)
              l !== null && (l = l.next = {
                  lane: 0,
                  action: u.action,
                  hasEagerState: u.hasEagerState,
                  eagerState: u.eagerState,
                  next: null
              }),
              r = u.hasEagerState ? u.eagerState : e(r, u.action);
          else {
              var d = {
                  lane: f,
                  action: u.action,
                  hasEagerState: u.hasEagerState,
                  eagerState: u.eagerState,
                  next: null
              };
              l === null ? (s = l = d,
              a = r) : l = l.next = d,
              ee.lanes |= f,
              Pn |= f
          }
          u = u.next
      } while (u !== null && u !== o);
      l === null ? a = r : l.next = s,
      ot(r, t.memoizedState) || (Re = !0),
      t.memoizedState = r,
      t.baseState = a,
      t.baseQueue = l,
      n.lastRenderedState = r
  }
  if (e = n.interleaved,
  e !== null) {
      i = e;
      do
          o = i.lane,
          ee.lanes |= o,
          Pn |= o,
          i = i.next;
      while (i !== e)
  } else
      i === null && (n.lanes = 0);
  return [t.memoizedState, n.dispatch]
}
function Ua(e) {
  var t = Xe()
    , n = t.queue;
  if (n === null)
      throw Error(L(311));
  n.lastRenderedReducer = e;
  var r = n.dispatch
    , i = n.pending
    , o = t.memoizedState;
  if (i !== null) {
      n.pending = null;
      var a = i = i.next;
      do
          o = e(o, a.action),
          a = a.next;
      while (a !== i);
      ot(o, t.memoizedState) || (Re = !0),
      t.memoizedState = o,
      t.baseQueue === null && (t.baseState = o),
      n.lastRenderedState = o
  }
  return [o, r]
}
function tf() {}
function nf(e, t) {
  var n = ee
    , r = Xe()
    , i = t()
    , o = !ot(r.memoizedState, i);
  if (o && (r.memoizedState = i,
  Re = !0),
  r = r.queue,
  iu(af.bind(null, n, r, e), [e]),
  r.getSnapshot !== t || o || me !== null && me.memoizedState.tag & 1) {
      if (n.flags |= 2048,
      ai(9, of.bind(null, n, r, i, t), void 0, null),
      he === null)
          throw Error(L(349));
      (Cn & 30) !== 0 || rf(n, t, i)
  }
  return i
}
function rf(e, t, n) {
  e.flags |= 16384,
  e = {
      getSnapshot: t,
      value: n
  },
  t = ee.updateQueue,
  t === null ? (t = {
      lastEffect: null,
      stores: null
  },
  ee.updateQueue = t,
  t.stores = [e]) : (n = t.stores,
  n === null ? t.stores = [e] : n.push(e))
}
function of(e, t, n, r) {
  t.value = n,
  t.getSnapshot = r,
  sf(t) && lf(e)
}
function af(e, t, n) {
  return n(function() {
      sf(t) && lf(e)
  })
}
function sf(e) {
  var t = e.getSnapshot;
  e = e.value;
  try {
      var n = t();
      return !ot(e, n)
  } catch {
      return !0
  }
}
function lf(e) {
  var t = Ct(e, 1);
  t !== null && it(t, e, 1, -1)
}
function Tc(e) {
  var t = lt();
  return typeof e == "function" && (e = e()),
  t.memoizedState = t.baseState = e,
  e = {
      pending: null,
      interleaved: null,
      lanes: 0,
      dispatch: null,
      lastRenderedReducer: oi,
      lastRenderedState: e
  },
  t.queue = e,
  e = e.dispatch = Z2.bind(null, ee, e),
  [t.memoizedState, e]
}
function ai(e, t, n, r) {
  return e = {
      tag: e,
      create: t,
      destroy: n,
      deps: r,
      next: null
  },
  t = ee.updateQueue,
  t === null ? (t = {
      lastEffect: null,
      stores: null
  },
  ee.updateQueue = t,
  t.lastEffect = e.next = e) : (n = t.lastEffect,
  n === null ? t.lastEffect = e.next = e : (r = n.next,
  n.next = e,
  e.next = r,
  t.lastEffect = e)),
  e
}
function uf() {
  return Xe().memoizedState
}
function eo(e, t, n, r) {
  var i = lt();
  ee.flags |= e,
  i.memoizedState = ai(1 | t, n, void 0, r === void 0 ? null : r)
}
function qo(e, t, n, r) {
  var i = Xe();
  r = r === void 0 ? null : r;
  var o = void 0;
  if (ce !== null) {
      var a = ce.memoizedState;
      if (o = a.destroy,
      r !== null && tu(r, a.deps)) {
          i.memoizedState = ai(t, n, o, r);
          return
      }
  }
  ee.flags |= e,
  i.memoizedState = ai(1 | t, n, o, r)
}
function Mc(e, t) {
  return eo(8390656, 8, e, t)
}
function iu(e, t) {
  return qo(2048, 8, e, t)
}
function cf(e, t) {
  return qo(4, 2, e, t)
}
function df(e, t) {
  return qo(4, 4, e, t)
}
function ff(e, t) {
  if (typeof t == "function")
      return e = e(),
      t(e),
      function() {
          t(null)
      }
      ;
  if (t != null)
      return e = e(),
      t.current = e,
      function() {
          t.current = null
      }
}
function mf(e, t, n) {
  return n = n != null ? n.concat([e]) : null,
  qo(4, 4, ff.bind(null, t, e), n)
}
function ou() {}
function hf(e, t) {
  var n = Xe();
  t = t === void 0 ? null : t;
  var r = n.memoizedState;
  return r !== null && t !== null && tu(t, r[1]) ? r[0] : (n.memoizedState = [e, t],
  e)
}
function pf(e, t) {
  var n = Xe();
  t = t === void 0 ? null : t;
  var r = n.memoizedState;
  return r !== null && t !== null && tu(t, r[1]) ? r[0] : (e = e(),
  n.memoizedState = [e, t],
  e)
}
function gf(e, t, n) {
  return (Cn & 21) === 0 ? (e.baseState && (e.baseState = !1,
  Re = !0),
  e.memoizedState = n) : (ot(n, t) || (n = w1(),
  ee.lanes |= n,
  Pn |= n,
  e.baseState = !0),
  t)
}
function $2(e, t) {
  var n = Z;
  Z = n !== 0 && 4 > n ? n : 4,
  e(!0);
  var r = Ba.transition;
  Ba.transition = {};
  try {
      e(!1),
      t()
  } finally {
      Z = n,
      Ba.transition = r
  }
}
function yf() {
  return Xe().memoizedState
}
function U2(e, t, n) {
  var r = Zt(e);
  if (n = {
      lane: r,
      action: n,
      hasEagerState: !1,
      eagerState: null,
      next: null
  },
  vf(e))
      xf(t, n);
  else if (n = q1(e, t, n, r),
  n !== null) {
      var i = Ae();
      it(n, e, r, i),
      wf(n, t, r)
  }
}
function Z2(e, t, n) {
  var r = Zt(e)
    , i = {
      lane: r,
      action: n,
      hasEagerState: !1,
      eagerState: null,
      next: null
  };
  if (vf(e))
      xf(t, i);
  else {
      var o = e.alternate;
      if (e.lanes === 0 && (o === null || o.lanes === 0) && (o = t.lastRenderedReducer,
      o !== null))
          try {
              var a = t.lastRenderedState
                , s = o(a, n);
              if (i.hasEagerState = !0,
              i.eagerState = s,
              ot(s, a)) {
                  var l = t.interleaved;
                  l === null ? (i.next = i,
                  Yl(t)) : (i.next = l.next,
                  l.next = i),
                  t.interleaved = i;
                  return
              }
          } catch {} finally {}
      n = q1(e, t, i, r),
      n !== null && (i = Ae(),
      it(n, e, r, i),
      wf(n, t, r))
  }
}
function vf(e) {
  var t = e.alternate;
  return e === ee || t !== null && t === ee
}
function xf(e, t) {
  Ir = Ao = !0;
  var n = e.pending;
  n === null ? t.next = t : (t.next = n.next,
  n.next = t),
  e.pending = t
}
function wf(e, t, n) {
  if ((n & 4194240) !== 0) {
      var r = t.lanes;
      r &= e.pendingLanes,
      n |= r,
      t.lanes = n,
      jl(e, n)
  }
}
var ko = {
  readContext: Ye,
  useCallback: xe,
  useContext: xe,
  useEffect: xe,
  useImperativeHandle: xe,
  useInsertionEffect: xe,
  useLayoutEffect: xe,
  useMemo: xe,
  useReducer: xe,
  useRef: xe,
  useState: xe,
  useDebugValue: xe,
  useDeferredValue: xe,
  useTransition: xe,
  useMutableSource: xe,
  useSyncExternalStore: xe,
  useId: xe,
  unstable_isNewReconciler: !1
}
, G2 = {
  readContext: Ye,
  useCallback: function(e, t) {
      return lt().memoizedState = [e, t === void 0 ? null : t],
      e
  },
  useContext: Ye,
  useEffect: Mc,
  useImperativeHandle: function(e, t, n) {
      return n = n != null ? n.concat([e]) : null,
      eo(4194308, 4, ff.bind(null, t, e), n)
  },
  useLayoutEffect: function(e, t) {
      return eo(4194308, 4, e, t)
  },
  useInsertionEffect: function(e, t) {
      return eo(4, 2, e, t)
  },
  useMemo: function(e, t) {
      var n = lt();
      return t = t === void 0 ? null : t,
      e = e(),
      n.memoizedState = [e, t],
      e
  },
  useReducer: function(e, t, n) {
      var r = lt();
      return t = n !== void 0 ? n(t) : t,
      r.memoizedState = r.baseState = t,
      e = {
          pending: null,
          interleaved: null,
          lanes: 0,
          dispatch: null,
          lastRenderedReducer: e,
          lastRenderedState: t
      },
      r.queue = e,
      e = e.dispatch = U2.bind(null, ee, e),
      [r.memoizedState, e]
  },
  useRef: function(e) {
      var t = lt();
      return e = {
          current: e
      },
      t.memoizedState = e
  },
  useState: Tc,
  useDebugValue: ou,
  useDeferredValue: function(e) {
      return lt().memoizedState = e
  },
  useTransition: function() {
      var e = Tc(!1)
        , t = e[0];
      return e = $2.bind(null, e[1]),
      lt().memoizedState = e,
      [t, e]
  },
  useMutableSource: function() {},
  useSyncExternalStore: function(e, t, n) {
      var r = ee
        , i = lt();
      if (X) {
          if (n === void 0)
              throw Error(L(407));
          n = n()
      } else {
          if (n = t(),
          he === null)
              throw Error(L(349));
          (Cn & 30) !== 0 || rf(r, t, n)
      }
      i.memoizedState = n;
      var o = {
          value: n,
          getSnapshot: t
      };
      return i.queue = o,
      Mc(af.bind(null, r, o, e), [e]),
      r.flags |= 2048,
      ai(9, of.bind(null, r, o, n, t), void 0, null),
      n
  },
  useId: function() {
      var e = lt()
        , t = he.identifierPrefix;
      if (X) {
          var n = yt
            , r = gt;
          n = (r & ~(1 << 32 - rt(r) - 1)).toString(32) + n,
          t = ":" + t + "R" + n,
          n = ii++,
          0 < n && (t += "H" + n.toString(32)),
          t += ":"
      } else
          n = B2++,
          t = ":" + t + "r" + n.toString(32) + ":";
      return e.memoizedState = t
  },
  unstable_isNewReconciler: !1
}
, W2 = {
  readContext: Ye,
  useCallback: hf,
  useContext: Ye,
  useEffect: iu,
  useImperativeHandle: mf,
  useInsertionEffect: cf,
  useLayoutEffect: df,
  useMemo: pf,
  useReducer: $a,
  useRef: uf,
  useState: function() {
      return $a(oi)
  },
  useDebugValue: ou,
  useDeferredValue: function(e) {
      var t = Xe();
      return gf(t, ce.memoizedState, e)
  },
  useTransition: function() {
      var e = $a(oi)[0]
        , t = Xe().memoizedState;
      return [e, t]
  },
  useMutableSource: tf,
  useSyncExternalStore: nf,
  useId: yf,
  unstable_isNewReconciler: !1
}
, Q2 = {
  readContext: Ye,
  useCallback: hf,
  useContext: Ye,
  useEffect: iu,
  useImperativeHandle: mf,
  useInsertionEffect: cf,
  useLayoutEffect: df,
  useMemo: pf,
  useReducer: Ua,
  useRef: uf,
  useState: function() {
      return Ua(oi)
  },
  useDebugValue: ou,
  useDeferredValue: function(e) {
      var t = Xe();
      return ce === null ? t.memoizedState = e : gf(t, ce.memoizedState, e)
  },
  useTransition: function() {
      var e = Ua(oi)[0]
        , t = Xe().memoizedState;
      return [e, t]
  },
  useMutableSource: tf,
  useSyncExternalStore: nf,
  useId: yf,
  unstable_isNewReconciler: !1
};
function et(e, t) {
  if (e && e.defaultProps) {
      t = te({}, t),
      e = e.defaultProps;
      for (var n in e)
          t[n] === void 0 && (t[n] = e[n]);
      return t
  }
  return t
}
function Hs(e, t, n, r) {
  t = e.memoizedState,
  n = n(r, t),
  n = n == null ? t : te({}, t, n),
  e.memoizedState = n,
  e.lanes === 0 && (e.updateQueue.baseState = n)
}
var Jo = {
  isMounted: function(e) {
      return (e = e._reactInternals) ? Tn(e) === e : !1
  },
  enqueueSetState: function(e, t, n) {
      e = e._reactInternals;
      var r = Ae()
        , i = Zt(e)
        , o = xt(r, i);
      o.payload = t,
      n != null && (o.callback = n),
      t = $t(e, o, i),
      t !== null && (it(t, e, i, r),
      qi(t, e, i))
  },
  enqueueReplaceState: function(e, t, n) {
      e = e._reactInternals;
      var r = Ae()
        , i = Zt(e)
        , o = xt(r, i);
      o.tag = 1,
      o.payload = t,
      n != null && (o.callback = n),
      t = $t(e, o, i),
      t !== null && (it(t, e, i, r),
      qi(t, e, i))
  },
  enqueueForceUpdate: function(e, t) {
      e = e._reactInternals;
      var n = Ae()
        , r = Zt(e)
        , i = xt(n, r);
      i.tag = 2,
      t != null && (i.callback = t),
      t = $t(e, i, r),
      t !== null && (it(t, e, r, n),
      qi(t, e, r))
  }
};
function Lc(e, t, n, r, i, o, a) {
  return e = e.stateNode,
  typeof e.shouldComponentUpdate == "function" ? e.shouldComponentUpdate(r, o, a) : t.prototype && t.prototype.isPureReactComponent ? !qr(n, r) || !qr(i, o) : !0
}
function Sf(e, t, n) {
  var r = !1
    , i = Yt
    , o = t.contextType;
  return typeof o == "object" && o !== null ? o = Ye(o) : (i = Oe(t) ? En : Ne.current,
  r = t.contextTypes,
  o = (r = r != null) ? nr(e, i) : Yt),
  t = new t(n,o),
  e.memoizedState = t.state !== null && t.state !== void 0 ? t.state : null,
  t.updater = Jo,
  e.stateNode = t,
  t._reactInternals = e,
  r && (e = e.stateNode,
  e.__reactInternalMemoizedUnmaskedChildContext = i,
  e.__reactInternalMemoizedMaskedChildContext = o),
  t
}
function Rc(e, t, n, r) {
  e = t.state,
  typeof t.componentWillReceiveProps == "function" && t.componentWillReceiveProps(n, r),
  typeof t.UNSAFE_componentWillReceiveProps == "function" && t.UNSAFE_componentWillReceiveProps(n, r),
  t.state !== e && Jo.enqueueReplaceState(t, t.state, null)
}
function Bs(e, t, n, r) {
  var i = e.stateNode;
  i.props = n,
  i.state = e.memoizedState,
  i.refs = {},
  Xl(e);
  var o = t.contextType;
  typeof o == "object" && o !== null ? i.context = Ye(o) : (o = Oe(t) ? En : Ne.current,
  i.context = nr(e, o)),
  i.state = e.memoizedState,
  o = t.getDerivedStateFromProps,
  typeof o == "function" && (Hs(e, t, o, n),
  i.state = e.memoizedState),
  typeof t.getDerivedStateFromProps == "function" || typeof i.getSnapshotBeforeUpdate == "function" || typeof i.UNSAFE_componentWillMount != "function" && typeof i.componentWillMount != "function" || (t = i.state,
  typeof i.componentWillMount == "function" && i.componentWillMount(),
  typeof i.UNSAFE_componentWillMount == "function" && i.UNSAFE_componentWillMount(),
  t !== i.state && Jo.enqueueReplaceState(i, i.state, null),
  Co(e, n, i, r),
  i.state = e.memoizedState),
  typeof i.componentDidMount == "function" && (e.flags |= 4194308)
}
function ar(e, t) {
  try {
      var n = ""
        , r = t;
      do
          n += Ep(r),
          r = r.return;
      while (r);
      var i = n
  } catch (o) {
      i = `
Error generating stack: ` + o.message + `
` + o.stack
  }
  return {
      value: e,
      source: t,
      stack: i,
      digest: null
  }
}
function Za(e, t, n) {
  return {
      value: e,
      source: null,
      stack: n != null ? n : null,
      digest: t != null ? t : null
  }
}
function $s(e, t) {
  try {
      console.error(t.value)
  } catch (n) {
      setTimeout(function() {
          throw n
      })
  }
}
var K2 = typeof WeakMap == "function" ? WeakMap : Map;
function Ef(e, t, n) {
  n = xt(-1, n),
  n.tag = 3,
  n.payload = {
      element: null
  };
  var r = t.value;
  return n.callback = function() {
      Mo || (Mo = !0,
      Js = r),
      $s(e, t)
  }
  ,
  n
}
function Nf(e, t, n) {
  n = xt(-1, n),
  n.tag = 3;
  var r = e.type.getDerivedStateFromError;
  if (typeof r == "function") {
      var i = t.value;
      n.payload = function() {
          return r(i)
      }
      ,
      n.callback = function() {
          $s(e, t)
      }
  }
  var o = e.stateNode;
  return o !== null && typeof o.componentDidCatch == "function" && (n.callback = function() {
      $s(e, t),
      typeof r != "function" && (Ut === null ? Ut = new Set([this]) : Ut.add(this));
      var a = t.stack;
      this.componentDidCatch(t.value, {
          componentStack: a !== null ? a : ""
      })
  }
  ),
  n
}
function bc(e, t, n) {
  var r = e.pingCache;
  if (r === null) {
      r = e.pingCache = new K2;
      var i = new Set;
      r.set(t, i)
  } else
      i = r.get(t),
      i === void 0 && (i = new Set,
      r.set(t, i));
  i.has(n) || (i.add(n),
  e = ug.bind(null, e, t, n),
  t.then(e, e))
}
function Oc(e) {
  do {
      var t;
      if ((t = e.tag === 13) && (t = e.memoizedState,
      t = t !== null ? t.dehydrated !== null : !0),
      t)
          return e;
      e = e.return
  } while (e !== null);
  return null
}
function Vc(e, t, n, r, i) {
  return (e.mode & 1) === 0 ? (e === t ? e.flags |= 65536 : (e.flags |= 128,
  n.flags |= 131072,
  n.flags &= -52805,
  n.tag === 1 && (n.alternate === null ? n.tag = 17 : (t = xt(-1, 1),
  t.tag = 2,
  $t(n, t, 1))),
  n.lanes |= 1),
  e) : (e.flags |= 65536,
  e.lanes = i,
  e)
}
var Y2 = kt.ReactCurrentOwner
, Re = !1;
function Pe(e, t, n, r) {
  t.child = e === null ? X1(t, null, n, r) : ir(t, e.child, n, r)
}
function Dc(e, t, n, r, i) {
  n = n.render;
  var o = t.ref;
  return Jn(t, i),
  r = nu(e, t, n, r, o, i),
  n = ru(),
  e !== null && !Re ? (t.updateQueue = e.updateQueue,
  t.flags &= -2053,
  e.lanes &= ~i,
  Pt(e, t, i)) : (X && n && Ul(t),
  t.flags |= 1,
  Pe(e, t, r, i),
  t.child)
}
function jc(e, t, n, r, i) {
  if (e === null) {
      var o = n.type;
      return typeof o == "function" && !mu(o) && o.defaultProps === void 0 && n.compare === null && n.defaultProps === void 0 ? (t.tag = 15,
      t.type = o,
      Cf(e, t, o, r, i)) : (e = io(n.type, null, r, t, t.mode, i),
      e.ref = t.ref,
      e.return = t,
      t.child = e)
  }
  if (o = e.child,
  (e.lanes & i) === 0) {
      var a = o.memoizedProps;
      if (n = n.compare,
      n = n !== null ? n : qr,
      n(a, r) && e.ref === t.ref)
          return Pt(e, t, i)
  }
  return t.flags |= 1,
  e = Gt(o, r),
  e.ref = t.ref,
  e.return = t,
  t.child = e
}
function Cf(e, t, n, r, i) {
  if (e !== null) {
      var o = e.memoizedProps;
      if (qr(o, r) && e.ref === t.ref)
          if (Re = !1,
          t.pendingProps = r = o,
          (e.lanes & i) !== 0)
              (e.flags & 131072) !== 0 && (Re = !0);
          else
              return t.lanes = e.lanes,
              Pt(e, t, i)
  }
  return Us(e, t, n, r, i)
}
function Pf(e, t, n) {
  var r = t.pendingProps
    , i = r.children
    , o = e !== null ? e.memoizedState : null;
  if (r.mode === "hidden")
      if ((t.mode & 1) === 0)
          t.memoizedState = {
              baseLanes: 0,
              cachePool: null,
              transitions: null
          },
          G(Un, Ie),
          Ie |= n;
      else {
          if ((n & 1073741824) === 0)
              return e = o !== null ? o.baseLanes | n : n,
              t.lanes = t.childLanes = 1073741824,
              t.memoizedState = {
                  baseLanes: e,
                  cachePool: null,
                  transitions: null
              },
              t.updateQueue = null,
              G(Un, Ie),
              Ie |= e,
              null;
          t.memoizedState = {
              baseLanes: 0,
              cachePool: null,
              transitions: null
          },
          r = o !== null ? o.baseLanes : n,
          G(Un, Ie),
          Ie |= r
      }
  else
      o !== null ? (r = o.baseLanes | n,
      t.memoizedState = null) : r = n,
      G(Un, Ie),
      Ie |= r;
  return Pe(e, t, i, n),
  t.child
}
function Af(e, t) {
  var n = t.ref;
  (e === null && n !== null || e !== null && e.ref !== n) && (t.flags |= 512,
  t.flags |= 2097152)
}
function Us(e, t, n, r, i) {
  var o = Oe(n) ? En : Ne.current;
  return o = nr(t, o),
  Jn(t, i),
  n = nu(e, t, n, r, o, i),
  r = ru(),
  e !== null && !Re ? (t.updateQueue = e.updateQueue,
  t.flags &= -2053,
  e.lanes &= ~i,
  Pt(e, t, i)) : (X && r && Ul(t),
  t.flags |= 1,
  Pe(e, t, n, i),
  t.child)
}
function Ic(e, t, n, r, i) {
  if (Oe(n)) {
      var o = !0;
      xo(t)
  } else
      o = !1;
  if (Jn(t, i),
  t.stateNode === null)
      to(e, t),
      Sf(t, n, r),
      Bs(t, n, r, i),
      r = !0;
  else if (e === null) {
      var a = t.stateNode
        , s = t.memoizedProps;
      a.props = s;
      var l = a.context
        , u = n.contextType;
      typeof u == "object" && u !== null ? u = Ye(u) : (u = Oe(n) ? En : Ne.current,
      u = nr(t, u));
      var f = n.getDerivedStateFromProps
        , d = typeof f == "function" || typeof a.getSnapshotBeforeUpdate == "function";
      d || typeof a.UNSAFE_componentWillReceiveProps != "function" && typeof a.componentWillReceiveProps != "function" || (s !== r || l !== u) && Rc(t, a, r, u),
      bt = !1;
      var m = t.memoizedState;
      a.state = m,
      Co(t, r, a, i),
      l = t.memoizedState,
      s !== r || m !== l || be.current || bt ? (typeof f == "function" && (Hs(t, n, f, r),
      l = t.memoizedState),
      (s = bt || Lc(t, n, s, r, m, l, u)) ? (d || typeof a.UNSAFE_componentWillMount != "function" && typeof a.componentWillMount != "function" || (typeof a.componentWillMount == "function" && a.componentWillMount(),
      typeof a.UNSAFE_componentWillMount == "function" && a.UNSAFE_componentWillMount()),
      typeof a.componentDidMount == "function" && (t.flags |= 4194308)) : (typeof a.componentDidMount == "function" && (t.flags |= 4194308),
      t.memoizedProps = r,
      t.memoizedState = l),
      a.props = r,
      a.state = l,
      a.context = u,
      r = s) : (typeof a.componentDidMount == "function" && (t.flags |= 4194308),
      r = !1)
  } else {
      a = t.stateNode,
      J1(e, t),
      s = t.memoizedProps,
      u = t.type === t.elementType ? s : et(t.type, s),
      a.props = u,
      d = t.pendingProps,
      m = a.context,
      l = n.contextType,
      typeof l == "object" && l !== null ? l = Ye(l) : (l = Oe(n) ? En : Ne.current,
      l = nr(t, l));
      var p = n.getDerivedStateFromProps;
      (f = typeof p == "function" || typeof a.getSnapshotBeforeUpdate == "function") || typeof a.UNSAFE_componentWillReceiveProps != "function" && typeof a.componentWillReceiveProps != "function" || (s !== d || m !== l) && Rc(t, a, r, l),
      bt = !1,
      m = t.memoizedState,
      a.state = m,
      Co(t, r, a, i);
      var v = t.memoizedState;
      s !== d || m !== v || be.current || bt ? (typeof p == "function" && (Hs(t, n, p, r),
      v = t.memoizedState),
      (u = bt || Lc(t, n, u, r, m, v, l) || !1) ? (f || typeof a.UNSAFE_componentWillUpdate != "function" && typeof a.componentWillUpdate != "function" || (typeof a.componentWillUpdate == "function" && a.componentWillUpdate(r, v, l),
      typeof a.UNSAFE_componentWillUpdate == "function" && a.UNSAFE_componentWillUpdate(r, v, l)),
      typeof a.componentDidUpdate == "function" && (t.flags |= 4),
      typeof a.getSnapshotBeforeUpdate == "function" && (t.flags |= 1024)) : (typeof a.componentDidUpdate != "function" || s === e.memoizedProps && m === e.memoizedState || (t.flags |= 4),
      typeof a.getSnapshotBeforeUpdate != "function" || s === e.memoizedProps && m === e.memoizedState || (t.flags |= 1024),
      t.memoizedProps = r,
      t.memoizedState = v),
      a.props = r,
      a.state = v,
      a.context = l,
      r = u) : (typeof a.componentDidUpdate != "function" || s === e.memoizedProps && m === e.memoizedState || (t.flags |= 4),
      typeof a.getSnapshotBeforeUpdate != "function" || s === e.memoizedProps && m === e.memoizedState || (t.flags |= 1024),
      r = !1)
  }
  return Zs(e, t, n, r, o, i)
}
function Zs(e, t, n, r, i, o) {
  Af(e, t);
  var a = (t.flags & 128) !== 0;
  if (!r && !a)
      return i && Ec(t, n, !1),
      Pt(e, t, o);
  r = t.stateNode,
  Y2.current = t;
  var s = a && typeof n.getDerivedStateFromError != "function" ? null : r.render();
  return t.flags |= 1,
  e !== null && a ? (t.child = ir(t, e.child, null, o),
  t.child = ir(t, null, s, o)) : Pe(e, t, s, o),
  t.memoizedState = r.state,
  i && Ec(t, n, !0),
  t.child
}
function kf(e) {
  var t = e.stateNode;
  t.pendingContext ? Sc(e, t.pendingContext, t.pendingContext !== t.context) : t.context && Sc(e, t.context, !1),
  ql(e, t.containerInfo)
}
function Fc(e, t, n, r, i) {
  return rr(),
  Gl(i),
  t.flags |= 256,
  Pe(e, t, n, r),
  t.child
}
var Gs = {
  dehydrated: null,
  treeContext: null,
  retryLane: 0
};
function Ws(e) {
  return {
      baseLanes: e,
      cachePool: null,
      transitions: null
  }
}
function Tf(e, t, n) {
  var r = t.pendingProps, i = q.current, o = !1, a = (t.flags & 128) !== 0, s;
  if ((s = a) || (s = e !== null && e.memoizedState === null ? !1 : (i & 2) !== 0),
  s ? (o = !0,
  t.flags &= -129) : (e === null || e.memoizedState !== null) && (i |= 1),
  G(q, i & 1),
  e === null)
      return _s(t),
      e = t.memoizedState,
      e !== null && (e = e.dehydrated,
      e !== null) ? ((t.mode & 1) === 0 ? t.lanes = 1 : e.data === "$!" ? t.lanes = 8 : t.lanes = 1073741824,
      null) : (a = r.children,
      e = r.fallback,
      o ? (r = t.mode,
      o = t.child,
      a = {
          mode: "hidden",
          children: a
      },
      (r & 1) === 0 && o !== null ? (o.childLanes = 0,
      o.pendingProps = a) : o = na(a, r, 0, null),
      e = vn(e, r, n, null),
      o.return = t,
      e.return = t,
      o.sibling = e,
      t.child = o,
      t.child.memoizedState = Ws(n),
      t.memoizedState = Gs,
      e) : au(t, a));
  if (i = e.memoizedState,
  i !== null && (s = i.dehydrated,
  s !== null))
      return X2(e, t, a, r, s, i, n);
  if (o) {
      o = r.fallback,
      a = t.mode,
      i = e.child,
      s = i.sibling;
      var l = {
          mode: "hidden",
          children: r.children
      };
      return (a & 1) === 0 && t.child !== i ? (r = t.child,
      r.childLanes = 0,
      r.pendingProps = l,
      t.deletions = null) : (r = Gt(i, l),
      r.subtreeFlags = i.subtreeFlags & 14680064),
      s !== null ? o = Gt(s, o) : (o = vn(o, a, n, null),
      o.flags |= 2),
      o.return = t,
      r.return = t,
      r.sibling = o,
      t.child = r,
      r = o,
      o = t.child,
      a = e.child.memoizedState,
      a = a === null ? Ws(n) : {
          baseLanes: a.baseLanes | n,
          cachePool: null,
          transitions: a.transitions
      },
      o.memoizedState = a,
      o.childLanes = e.childLanes & ~n,
      t.memoizedState = Gs,
      r
  }
  return o = e.child,
  e = o.sibling,
  r = Gt(o, {
      mode: "visible",
      children: r.children
  }),
  (t.mode & 1) === 0 && (r.lanes = n),
  r.return = t,
  r.sibling = null,
  e !== null && (n = t.deletions,
  n === null ? (t.deletions = [e],
  t.flags |= 16) : n.push(e)),
  t.child = r,
  t.memoizedState = null,
  r
}
function au(e, t) {
  return t = na({
      mode: "visible",
      children: t
  }, e.mode, 0, null),
  t.return = e,
  e.child = t
}
function _i(e, t, n, r) {
  return r !== null && Gl(r),
  ir(t, e.child, null, n),
  e = au(t, t.pendingProps.children),
  e.flags |= 2,
  t.memoizedState = null,
  e
}
function X2(e, t, n, r, i, o, a) {
  if (n)
      return t.flags & 256 ? (t.flags &= -257,
      r = Za(Error(L(422))),
      _i(e, t, a, r)) : t.memoizedState !== null ? (t.child = e.child,
      t.flags |= 128,
      null) : (o = r.fallback,
      i = t.mode,
      r = na({
          mode: "visible",
          children: r.children
      }, i, 0, null),
      o = vn(o, i, a, null),
      o.flags |= 2,
      r.return = t,
      o.return = t,
      r.sibling = o,
      t.child = r,
      (t.mode & 1) !== 0 && ir(t, e.child, null, a),
      t.child.memoizedState = Ws(a),
      t.memoizedState = Gs,
      o);
  if ((t.mode & 1) === 0)
      return _i(e, t, a, null);
  if (i.data === "$!") {
      if (r = i.nextSibling && i.nextSibling.dataset,
      r)
          var s = r.dgst;
      return r = s,
      o = Error(L(419)),
      r = Za(o, r, void 0),
      _i(e, t, a, r)
  }
  if (s = (a & e.childLanes) !== 0,
  Re || s) {
      if (r = he,
      r !== null) {
          switch (a & -a) {
          case 4:
              i = 2;
              break;
          case 16:
              i = 8;
              break;
          case 64:
          case 128:
          case 256:
          case 512:
          case 1024:
          case 2048:
          case 4096:
          case 8192:
          case 16384:
          case 32768:
          case 65536:
          case 131072:
          case 262144:
          case 524288:
          case 1048576:
          case 2097152:
          case 4194304:
          case 8388608:
          case 16777216:
          case 33554432:
          case 67108864:
              i = 32;
              break;
          case 536870912:
              i = 268435456;
              break;
          default:
              i = 0
          }
          i = (i & (r.suspendedLanes | a)) !== 0 ? 0 : i,
          i !== 0 && i !== o.retryLane && (o.retryLane = i,
          Ct(e, i),
          it(r, e, i, -1))
      }
      return fu(),
      r = Za(Error(L(421))),
      _i(e, t, a, r)
  }
  return i.data === "$?" ? (t.flags |= 128,
  t.child = e.child,
  t = cg.bind(null, e),
  i._reactRetry = t,
  null) : (e = o.treeContext,
  Fe = Bt(i.nextSibling),
  _e = t,
  X = !0,
  nt = null,
  e !== null && (Ge[We++] = gt,
  Ge[We++] = yt,
  Ge[We++] = Nn,
  gt = e.id,
  yt = e.overflow,
  Nn = t),
  t = au(t, r.children),
  t.flags |= 4096,
  t)
}
function _c(e, t, n) {
  e.lanes |= t;
  var r = e.alternate;
  r !== null && (r.lanes |= t),
  zs(e.return, t, n)
}
function Ga(e, t, n, r, i) {
  var o = e.memoizedState;
  o === null ? e.memoizedState = {
      isBackwards: t,
      rendering: null,
      renderingStartTime: 0,
      last: r,
      tail: n,
      tailMode: i
  } : (o.isBackwards = t,
  o.rendering = null,
  o.renderingStartTime = 0,
  o.last = r,
  o.tail = n,
  o.tailMode = i)
}
function Mf(e, t, n) {
  var r = t.pendingProps
    , i = r.revealOrder
    , o = r.tail;
  if (Pe(e, t, r.children, n),
  r = q.current,
  (r & 2) !== 0)
      r = r & 1 | 2,
      t.flags |= 128;
  else {
      if (e !== null && (e.flags & 128) !== 0)
          e: for (e = t.child; e !== null; ) {
              if (e.tag === 13)
                  e.memoizedState !== null && _c(e, n, t);
              else if (e.tag === 19)
                  _c(e, n, t);
              else if (e.child !== null) {
                  e.child.return = e,
                  e = e.child;
                  continue
              }
              if (e === t)
                  break e;
              for (; e.sibling === null; ) {
                  if (e.return === null || e.return === t)
                      break e;
                  e = e.return
              }
              e.sibling.return = e.return,
              e = e.sibling
          }
      r &= 1
  }
  if (G(q, r),
  (t.mode & 1) === 0)
      t.memoizedState = null;
  else
      switch (i) {
      case "forwards":
          for (n = t.child,
          i = null; n !== null; )
              e = n.alternate,
              e !== null && Po(e) === null && (i = n),
              n = n.sibling;
          n = i,
          n === null ? (i = t.child,
          t.child = null) : (i = n.sibling,
          n.sibling = null),
          Ga(t, !1, i, n, o);
          break;
      case "backwards":
          for (n = null,
          i = t.child,
          t.child = null; i !== null; ) {
              if (e = i.alternate,
              e !== null && Po(e) === null) {
                  t.child = i;
                  break
              }
              e = i.sibling,
              i.sibling = n,
              n = i,
              i = e
          }
          Ga(t, !0, n, null, o);
          break;
      case "together":
          Ga(t, !1, null, null, void 0);
          break;
      default:
          t.memoizedState = null
      }
  return t.child
}
function to(e, t) {
  (t.mode & 1) === 0 && e !== null && (e.alternate = null,
  t.alternate = null,
  t.flags |= 2)
}
function Pt(e, t, n) {
  if (e !== null && (t.dependencies = e.dependencies),
  Pn |= t.lanes,
  (n & t.childLanes) === 0)
      return null;
  if (e !== null && t.child !== e.child)
      throw Error(L(153));
  if (t.child !== null) {
      for (e = t.child,
      n = Gt(e, e.pendingProps),
      t.child = n,
      n.return = t; e.sibling !== null; )
          e = e.sibling,
          n = n.sibling = Gt(e, e.pendingProps),
          n.return = t;
      n.sibling = null
  }
  return t.child
}
function q2(e, t, n) {
  switch (t.tag) {
  case 3:
      kf(t),
      rr();
      break;
  case 5:
      ef(t);
      break;
  case 1:
      Oe(t.type) && xo(t);
      break;
  case 4:
      ql(t, t.stateNode.containerInfo);
      break;
  case 10:
      var r = t.type._context
        , i = t.memoizedProps.value;
      G(Eo, r._currentValue),
      r._currentValue = i;
      break;
  case 13:
      if (r = t.memoizedState,
      r !== null)
          return r.dehydrated !== null ? (G(q, q.current & 1),
          t.flags |= 128,
          null) : (n & t.child.childLanes) !== 0 ? Tf(e, t, n) : (G(q, q.current & 1),
          e = Pt(e, t, n),
          e !== null ? e.sibling : null);
      G(q, q.current & 1);
      break;
  case 19:
      if (r = (n & t.childLanes) !== 0,
      (e.flags & 128) !== 0) {
          if (r)
              return Mf(e, t, n);
          t.flags |= 128
      }
      if (i = t.memoizedState,
      i !== null && (i.rendering = null,
      i.tail = null,
      i.lastEffect = null),
      G(q, q.current),
      r)
          break;
      return null;
  case 22:
  case 23:
      return t.lanes = 0,
      Pf(e, t, n)
  }
  return Pt(e, t, n)
}
var Lf, Qs, Rf, bf;
Lf = function(e, t) {
  for (var n = t.child; n !== null; ) {
      if (n.tag === 5 || n.tag === 6)
          e.appendChild(n.stateNode);
      else if (n.tag !== 4 && n.child !== null) {
          n.child.return = n,
          n = n.child;
          continue
      }
      if (n === t)
          break;
      for (; n.sibling === null; ) {
          if (n.return === null || n.return === t)
              return;
          n = n.return
      }
      n.sibling.return = n.return,
      n = n.sibling
  }
}
;
Qs = function() {}
;
Rf = function(e, t, n, r) {
  var i = e.memoizedProps;
  if (i !== r) {
      e = t.stateNode,
      pn(dt.current);
      var o = null;
      switch (n) {
      case "input":
          i = gs(e, i),
          r = gs(e, r),
          o = [];
          break;
      case "select":
          i = te({}, i, {
              value: void 0
          }),
          r = te({}, r, {
              value: void 0
          }),
          o = [];
          break;
      case "textarea":
          i = xs(e, i),
          r = xs(e, r),
          o = [];
          break;
      default:
          typeof i.onClick != "function" && typeof r.onClick == "function" && (e.onclick = yo)
      }
      Ss(n, r);
      var a;
      n = null;
      for (u in i)
          if (!r.hasOwnProperty(u) && i.hasOwnProperty(u) && i[u] != null)
              if (u === "style") {
                  var s = i[u];
                  for (a in s)
                      s.hasOwnProperty(a) && (n || (n = {}),
                      n[a] = "")
              } else
                  u !== "dangerouslySetInnerHTML" && u !== "children" && u !== "suppressContentEditableWarning" && u !== "suppressHydrationWarning" && u !== "autoFocus" && (Zr.hasOwnProperty(u) ? o || (o = []) : (o = o || []).push(u, null));
      for (u in r) {
          var l = r[u];
          if (s = i != null ? i[u] : void 0,
          r.hasOwnProperty(u) && l !== s && (l != null || s != null))
              if (u === "style")
                  if (s) {
                      for (a in s)
                          !s.hasOwnProperty(a) || l && l.hasOwnProperty(a) || (n || (n = {}),
                          n[a] = "");
                      for (a in l)
                          l.hasOwnProperty(a) && s[a] !== l[a] && (n || (n = {}),
                          n[a] = l[a])
                  } else
                      n || (o || (o = []),
                      o.push(u, n)),
                      n = l;
              else
                  u === "dangerouslySetInnerHTML" ? (l = l ? l.__html : void 0,
                  s = s ? s.__html : void 0,
                  l != null && s !== l && (o = o || []).push(u, l)) : u === "children" ? typeof l != "string" && typeof l != "number" || (o = o || []).push(u, "" + l) : u !== "suppressContentEditableWarning" && u !== "suppressHydrationWarning" && (Zr.hasOwnProperty(u) ? (l != null && u === "onScroll" && Q("scroll", e),
                  o || s === l || (o = [])) : (o = o || []).push(u, l))
      }
      n && (o = o || []).push("style", n);
      var u = o;
      (t.updateQueue = u) && (t.flags |= 4)
  }
}
;
bf = function(e, t, n, r) {
  n !== r && (t.flags |= 4)
}
;
function Nr(e, t) {
  if (!X)
      switch (e.tailMode) {
      case "hidden":
          t = e.tail;
          for (var n = null; t !== null; )
              t.alternate !== null && (n = t),
              t = t.sibling;
          n === null ? e.tail = null : n.sibling = null;
          break;
      case "collapsed":
          n = e.tail;
          for (var r = null; n !== null; )
              n.alternate !== null && (r = n),
              n = n.sibling;
          r === null ? t || e.tail === null ? e.tail = null : e.tail.sibling = null : r.sibling = null
      }
}
function we(e) {
  var t = e.alternate !== null && e.alternate.child === e.child
    , n = 0
    , r = 0;
  if (t)
      for (var i = e.child; i !== null; )
          n |= i.lanes | i.childLanes,
          r |= i.subtreeFlags & 14680064,
          r |= i.flags & 14680064,
          i.return = e,
          i = i.sibling;
  else
      for (i = e.child; i !== null; )
          n |= i.lanes | i.childLanes,
          r |= i.subtreeFlags,
          r |= i.flags,
          i.return = e,
          i = i.sibling;
  return e.subtreeFlags |= r,
  e.childLanes = n,
  t
}
function J2(e, t, n) {
  var r = t.pendingProps;
  switch (Zl(t),
  t.tag) {
  case 2:
  case 16:
  case 15:
  case 0:
  case 11:
  case 7:
  case 8:
  case 12:
  case 9:
  case 14:
      return we(t),
      null;
  case 1:
      return Oe(t.type) && vo(),
      we(t),
      null;
  case 3:
      return r = t.stateNode,
      or(),
      K(be),
      K(Ne),
      eu(),
      r.pendingContext && (r.context = r.pendingContext,
      r.pendingContext = null),
      (e === null || e.child === null) && (Ii(t) ? t.flags |= 4 : e === null || e.memoizedState.isDehydrated && (t.flags & 256) === 0 || (t.flags |= 1024,
      nt !== null && (nl(nt),
      nt = null))),
      Qs(e, t),
      we(t),
      null;
  case 5:
      Jl(t);
      var i = pn(ri.current);
      if (n = t.type,
      e !== null && t.stateNode != null)
          Rf(e, t, n, r, i),
          e.ref !== t.ref && (t.flags |= 512,
          t.flags |= 2097152);
      else {
          if (!r) {
              if (t.stateNode === null)
                  throw Error(L(166));
              return we(t),
              null
          }
          if (e = pn(dt.current),
          Ii(t)) {
              r = t.stateNode,
              n = t.type;
              var o = t.memoizedProps;
              switch (r[ut] = t,
              r[ti] = o,
              e = (t.mode & 1) !== 0,
              n) {
              case "dialog":
                  Q("cancel", r),
                  Q("close", r);
                  break;
              case "iframe":
              case "object":
              case "embed":
                  Q("load", r);
                  break;
              case "video":
              case "audio":
                  for (i = 0; i < Lr.length; i++)
                      Q(Lr[i], r);
                  break;
              case "source":
                  Q("error", r);
                  break;
              case "img":
              case "image":
              case "link":
                  Q("error", r),
                  Q("load", r);
                  break;
              case "details":
                  Q("toggle", r);
                  break;
              case "input":
                  Qu(r, o),
                  Q("invalid", r);
                  break;
              case "select":
                  r._wrapperState = {
                      wasMultiple: !!o.multiple
                  },
                  Q("invalid", r);
                  break;
              case "textarea":
                  Yu(r, o),
                  Q("invalid", r)
              }
              Ss(n, o),
              i = null;
              for (var a in o)
                  if (o.hasOwnProperty(a)) {
                      var s = o[a];
                      a === "children" ? typeof s == "string" ? r.textContent !== s && (o.suppressHydrationWarning !== !0 && ji(r.textContent, s, e),
                      i = ["children", s]) : typeof s == "number" && r.textContent !== "" + s && (o.suppressHydrationWarning !== !0 && ji(r.textContent, s, e),
                      i = ["children", "" + s]) : Zr.hasOwnProperty(a) && s != null && a === "onScroll" && Q("scroll", r)
                  }
              switch (n) {
              case "input":
                  Ti(r),
                  Ku(r, o, !0);
                  break;
              case "textarea":
                  Ti(r),
                  Xu(r);
                  break;
              case "select":
              case "option":
                  break;
              default:
                  typeof o.onClick == "function" && (r.onclick = yo)
              }
              r = i,
              t.updateQueue = r,
              r !== null && (t.flags |= 4)
          } else {
              a = i.nodeType === 9 ? i : i.ownerDocument,
              e === "http://www.w3.org/1999/xhtml" && (e = o1(n)),
              e === "http://www.w3.org/1999/xhtml" ? n === "script" ? (e = a.createElement("div"),
              e.innerHTML = "<script><\/script>",
              e = e.removeChild(e.firstChild)) : typeof r.is == "string" ? e = a.createElement(n, {
                  is: r.is
              }) : (e = a.createElement(n),
              n === "select" && (a = e,
              r.multiple ? a.multiple = !0 : r.size && (a.size = r.size))) : e = a.createElementNS(e, n),
              e[ut] = t,
              e[ti] = r,
              Lf(e, t, !1, !1),
              t.stateNode = e;
              e: {
                  switch (a = Es(n, r),
                  n) {
                  case "dialog":
                      Q("cancel", e),
                      Q("close", e),
                      i = r;
                      break;
                  case "iframe":
                  case "object":
                  case "embed":
                      Q("load", e),
                      i = r;
                      break;
                  case "video":
                  case "audio":
                      for (i = 0; i < Lr.length; i++)
                          Q(Lr[i], e);
                      i = r;
                      break;
                  case "source":
                      Q("error", e),
                      i = r;
                      break;
                  case "img":
                  case "image":
                  case "link":
                      Q("error", e),
                      Q("load", e),
                      i = r;
                      break;
                  case "details":
                      Q("toggle", e),
                      i = r;
                      break;
                  case "input":
                      Qu(e, r),
                      i = gs(e, r),
                      Q("invalid", e);
                      break;
                  case "option":
                      i = r;
                      break;
                  case "select":
                      e._wrapperState = {
                          wasMultiple: !!r.multiple
                      },
                      i = te({}, r, {
                          value: void 0
                      }),
                      Q("invalid", e);
                      break;
                  case "textarea":
                      Yu(e, r),
                      i = xs(e, r),
                      Q("invalid", e);
                      break;
                  default:
                      i = r
                  }
                  Ss(n, i),
                  s = i;
                  for (o in s)
                      if (s.hasOwnProperty(o)) {
                          var l = s[o];
                          o === "style" ? l1(e, l) : o === "dangerouslySetInnerHTML" ? (l = l ? l.__html : void 0,
                          l != null && a1(e, l)) : o === "children" ? typeof l == "string" ? (n !== "textarea" || l !== "") && Gr(e, l) : typeof l == "number" && Gr(e, "" + l) : o !== "suppressContentEditableWarning" && o !== "suppressHydrationWarning" && o !== "autoFocus" && (Zr.hasOwnProperty(o) ? l != null && o === "onScroll" && Q("scroll", e) : l != null && Ll(e, o, l, a))
                      }
                  switch (n) {
                  case "input":
                      Ti(e),
                      Ku(e, r, !1);
                      break;
                  case "textarea":
                      Ti(e),
                      Xu(e);
                      break;
                  case "option":
                      r.value != null && e.setAttribute("value", "" + Kt(r.value));
                      break;
                  case "select":
                      e.multiple = !!r.multiple,
                      o = r.value,
                      o != null ? Kn(e, !!r.multiple, o, !1) : r.defaultValue != null && Kn(e, !!r.multiple, r.defaultValue, !0);
                      break;
                  default:
                      typeof i.onClick == "function" && (e.onclick = yo)
                  }
                  switch (n) {
                  case "button":
                  case "input":
                  case "select":
                  case "textarea":
                      r = !!r.autoFocus;
                      break e;
                  case "img":
                      r = !0;
                      break e;
                  default:
                      r = !1
                  }
              }
              r && (t.flags |= 4)
          }
          t.ref !== null && (t.flags |= 512,
          t.flags |= 2097152)
      }
      return we(t),
      null;
  case 6:
      if (e && t.stateNode != null)
          bf(e, t, e.memoizedProps, r);
      else {
          if (typeof r != "string" && t.stateNode === null)
              throw Error(L(166));
          if (n = pn(ri.current),
          pn(dt.current),
          Ii(t)) {
              if (r = t.stateNode,
              n = t.memoizedProps,
              r[ut] = t,
              (o = r.nodeValue !== n) && (e = _e,
              e !== null))
                  switch (e.tag) {
                  case 3:
                      ji(r.nodeValue, n, (e.mode & 1) !== 0);
                      break;
                  case 5:
                      e.memoizedProps.suppressHydrationWarning !== !0 && ji(r.nodeValue, n, (e.mode & 1) !== 0)
                  }
              o && (t.flags |= 4)
          } else
              r = (n.nodeType === 9 ? n : n.ownerDocument).createTextNode(r),
              r[ut] = t,
              t.stateNode = r
      }
      return we(t),
      null;
  case 13:
      if (K(q),
      r = t.memoizedState,
      e === null || e.memoizedState !== null && e.memoizedState.dehydrated !== null) {
          if (X && Fe !== null && (t.mode & 1) !== 0 && (t.flags & 128) === 0)
              K1(),
              rr(),
              t.flags |= 98560,
              o = !1;
          else if (o = Ii(t),
          r !== null && r.dehydrated !== null) {
              if (e === null) {
                  if (!o)
                      throw Error(L(318));
                  if (o = t.memoizedState,
                  o = o !== null ? o.dehydrated : null,
                  !o)
                      throw Error(L(317));
                  o[ut] = t
              } else
                  rr(),
                  (t.flags & 128) === 0 && (t.memoizedState = null),
                  t.flags |= 4;
              we(t),
              o = !1
          } else
              nt !== null && (nl(nt),
              nt = null),
              o = !0;
          if (!o)
              return t.flags & 65536 ? t : null
      }
      return (t.flags & 128) !== 0 ? (t.lanes = n,
      t) : (r = r !== null,
      r !== (e !== null && e.memoizedState !== null) && r && (t.child.flags |= 8192,
      (t.mode & 1) !== 0 && (e === null || (q.current & 1) !== 0 ? de === 0 && (de = 3) : fu())),
      t.updateQueue !== null && (t.flags |= 4),
      we(t),
      null);
  case 4:
      return or(),
      Qs(e, t),
      e === null && Jr(t.stateNode.containerInfo),
      we(t),
      null;
  case 10:
      return Kl(t.type._context),
      we(t),
      null;
  case 17:
      return Oe(t.type) && vo(),
      we(t),
      null;
  case 19:
      if (K(q),
      o = t.memoizedState,
      o === null)
          return we(t),
          null;
      if (r = (t.flags & 128) !== 0,
      a = o.rendering,
      a === null)
          if (r)
              Nr(o, !1);
          else {
              if (de !== 0 || e !== null && (e.flags & 128) !== 0)
                  for (e = t.child; e !== null; ) {
                      if (a = Po(e),
                      a !== null) {
                          for (t.flags |= 128,
                          Nr(o, !1),
                          r = a.updateQueue,
                          r !== null && (t.updateQueue = r,
                          t.flags |= 4),
                          t.subtreeFlags = 0,
                          r = n,
                          n = t.child; n !== null; )
                              o = n,
                              e = r,
                              o.flags &= 14680066,
                              a = o.alternate,
                              a === null ? (o.childLanes = 0,
                              o.lanes = e,
                              o.child = null,
                              o.subtreeFlags = 0,
                              o.memoizedProps = null,
                              o.memoizedState = null,
                              o.updateQueue = null,
                              o.dependencies = null,
                              o.stateNode = null) : (o.childLanes = a.childLanes,
                              o.lanes = a.lanes,
                              o.child = a.child,
                              o.subtreeFlags = 0,
                              o.deletions = null,
                              o.memoizedProps = a.memoizedProps,
                              o.memoizedState = a.memoizedState,
                              o.updateQueue = a.updateQueue,
                              o.type = a.type,
                              e = a.dependencies,
                              o.dependencies = e === null ? null : {
                                  lanes: e.lanes,
                                  firstContext: e.firstContext
                              }),
                              n = n.sibling;
                          return G(q, q.current & 1 | 2),
                          t.child
                      }
                      e = e.sibling
                  }
              o.tail !== null && ie() > sr && (t.flags |= 128,
              r = !0,
              Nr(o, !1),
              t.lanes = 4194304)
          }
      else {
          if (!r)
              if (e = Po(a),
              e !== null) {
                  if (t.flags |= 128,
                  r = !0,
                  n = e.updateQueue,
                  n !== null && (t.updateQueue = n,
                  t.flags |= 4),
                  Nr(o, !0),
                  o.tail === null && o.tailMode === "hidden" && !a.alternate && !X)
                      return we(t),
                      null
              } else
                  2 * ie() - o.renderingStartTime > sr && n !== 1073741824 && (t.flags |= 128,
                  r = !0,
                  Nr(o, !1),
                  t.lanes = 4194304);
          o.isBackwards ? (a.sibling = t.child,
          t.child = a) : (n = o.last,
          n !== null ? n.sibling = a : t.child = a,
          o.last = a)
      }
      return o.tail !== null ? (t = o.tail,
      o.rendering = t,
      o.tail = t.sibling,
      o.renderingStartTime = ie(),
      t.sibling = null,
      n = q.current,
      G(q, r ? n & 1 | 2 : n & 1),
      t) : (we(t),
      null);
  case 22:
  case 23:
      return du(),
      r = t.memoizedState !== null,
      e !== null && e.memoizedState !== null !== r && (t.flags |= 8192),
      r && (t.mode & 1) !== 0 ? (Ie & 1073741824) !== 0 && (we(t),
      t.subtreeFlags & 6 && (t.flags |= 8192)) : we(t),
      null;
  case 24:
      return null;
  case 25:
      return null
  }
  throw Error(L(156, t.tag))
}
function eg(e, t) {
  switch (Zl(t),
  t.tag) {
  case 1:
      return Oe(t.type) && vo(),
      e = t.flags,
      e & 65536 ? (t.flags = e & -65537 | 128,
      t) : null;
  case 3:
      return or(),
      K(be),
      K(Ne),
      eu(),
      e = t.flags,
      (e & 65536) !== 0 && (e & 128) === 0 ? (t.flags = e & -65537 | 128,
      t) : null;
  case 5:
      return Jl(t),
      null;
  case 13:
      if (K(q),
      e = t.memoizedState,
      e !== null && e.dehydrated !== null) {
          if (t.alternate === null)
              throw Error(L(340));
          rr()
      }
      return e = t.flags,
      e & 65536 ? (t.flags = e & -65537 | 128,
      t) : null;
  case 19:
      return K(q),
      null;
  case 4:
      return or(),
      null;
  case 10:
      return Kl(t.type._context),
      null;
  case 22:
  case 23:
      return du(),
      null;
  case 24:
      return null;
  default:
      return null
  }
}
var zi = !1
, Ee = !1
, tg = typeof WeakSet == "function" ? WeakSet : Set
, V = null;
function $n(e, t) {
  var n = e.ref;
  if (n !== null)
      if (typeof n == "function")
          try {
              n(null)
          } catch (r) {
              ne(e, t, r)
          }
      else
          n.current = null
}
function Ks(e, t, n) {
  try {
      n()
  } catch (r) {
      ne(e, t, r)
  }
}
var zc = !1;
function ng(e, t) {
  if (bs = ho,
  e = j1(),
  $l(e)) {
      if ("selectionStart"in e)
          var n = {
              start: e.selectionStart,
              end: e.selectionEnd
          };
      else
          e: {
              n = (n = e.ownerDocument) && n.defaultView || window;
              var r = n.getSelection && n.getSelection();
              if (r && r.rangeCount !== 0) {
                  n = r.anchorNode;
                  var i = r.anchorOffset
                    , o = r.focusNode;
                  r = r.focusOffset;
                  try {
                      n.nodeType,
                      o.nodeType
                  } catch {
                      n = null;
                      break e
                  }
                  var a = 0
                    , s = -1
                    , l = -1
                    , u = 0
                    , f = 0
                    , d = e
                    , m = null;
                  t: for (; ; ) {
                      for (var p; d !== n || i !== 0 && d.nodeType !== 3 || (s = a + i),
                      d !== o || r !== 0 && d.nodeType !== 3 || (l = a + r),
                      d.nodeType === 3 && (a += d.nodeValue.length),
                      (p = d.firstChild) !== null; )
                          m = d,
                          d = p;
                      for (; ; ) {
                          if (d === e)
                              break t;
                          if (m === n && ++u === i && (s = a),
                          m === o && ++f === r && (l = a),
                          (p = d.nextSibling) !== null)
                              break;
                          d = m,
                          m = d.parentNode
                      }
                      d = p
                  }
                  n = s === -1 || l === -1 ? null : {
                      start: s,
                      end: l
                  }
              } else
                  n = null
          }
      n = n || {
          start: 0,
          end: 0
      }
  } else
      n = null;
  for (Os = {
      focusedElem: e,
      selectionRange: n
  },
  ho = !1,
  V = t; V !== null; )
      if (t = V,
      e = t.child,
      (t.subtreeFlags & 1028) !== 0 && e !== null)
          e.return = t,
          V = e;
      else
          for (; V !== null; ) {
              t = V;
              try {
                  var v = t.alternate;
                  if ((t.flags & 1024) !== 0)
                      switch (t.tag) {
                      case 0:
                      case 11:
                      case 15:
                          break;
                      case 1:
                          if (v !== null) {
                              var x = v.memoizedProps
                                , P = v.memoizedState
                                , y = t.stateNode
                                , h = y.getSnapshotBeforeUpdate(t.elementType === t.type ? x : et(t.type, x), P);
                              y.__reactInternalSnapshotBeforeUpdate = h
                          }
                          break;
                      case 3:
                          var g = t.stateNode.containerInfo;
                          g.nodeType === 1 ? g.textContent = "" : g.nodeType === 9 && g.documentElement && g.removeChild(g.documentElement);
                          break;
                      case 5:
                      case 6:
                      case 4:
                      case 17:
                          break;
                      default:
                          throw Error(L(163))
                      }
              } catch (S) {
                  ne(t, t.return, S)
              }
              if (e = t.sibling,
              e !== null) {
                  e.return = t.return,
                  V = e;
                  break
              }
              V = t.return
          }
  return v = zc,
  zc = !1,
  v
}
function Fr(e, t, n) {
  var r = t.updateQueue;
  if (r = r !== null ? r.lastEffect : null,
  r !== null) {
      var i = r = r.next;
      do {
          if ((i.tag & e) === e) {
              var o = i.destroy;
              i.destroy = void 0,
              o !== void 0 && Ks(t, n, o)
          }
          i = i.next
      } while (i !== r)
  }
}
function ea(e, t) {
  if (t = t.updateQueue,
  t = t !== null ? t.lastEffect : null,
  t !== null) {
      var n = t = t.next;
      do {
          if ((n.tag & e) === e) {
              var r = n.create;
              n.destroy = r()
          }
          n = n.next
      } while (n !== t)
  }
}
function Ys(e) {
  var t = e.ref;
  if (t !== null) {
      var n = e.stateNode;
      switch (e.tag) {
      case 5:
          e = n;
          break;
      default:
          e = n
      }
      typeof t == "function" ? t(e) : t.current = e
  }
}
function Of(e) {
  var t = e.alternate;
  t !== null && (e.alternate = null,
  Of(t)),
  e.child = null,
  e.deletions = null,
  e.sibling = null,
  e.tag === 5 && (t = e.stateNode,
  t !== null && (delete t[ut],
  delete t[ti],
  delete t[js],
  delete t[F2],
  delete t[_2])),
  e.stateNode = null,
  e.return = null,
  e.dependencies = null,
  e.memoizedProps = null,
  e.memoizedState = null,
  e.pendingProps = null,
  e.stateNode = null,
  e.updateQueue = null
}
function Vf(e) {
  return e.tag === 5 || e.tag === 3 || e.tag === 4
}
function Hc(e) {
  e: for (; ; ) {
      for (; e.sibling === null; ) {
          if (e.return === null || Vf(e.return))
              return null;
          e = e.return
      }
      for (e.sibling.return = e.return,
      e = e.sibling; e.tag !== 5 && e.tag !== 6 && e.tag !== 18; ) {
          if (e.flags & 2 || e.child === null || e.tag === 4)
              continue e;
          e.child.return = e,
          e = e.child
      }
      if (!(e.flags & 2))
          return e.stateNode
  }
}
function Xs(e, t, n) {
  var r = e.tag;
  if (r === 5 || r === 6)
      e = e.stateNode,
      t ? n.nodeType === 8 ? n.parentNode.insertBefore(e, t) : n.insertBefore(e, t) : (n.nodeType === 8 ? (t = n.parentNode,
      t.insertBefore(e, n)) : (t = n,
      t.appendChild(e)),
      n = n._reactRootContainer,
      n != null || t.onclick !== null || (t.onclick = yo));
  else if (r !== 4 && (e = e.child,
  e !== null))
      for (Xs(e, t, n),
      e = e.sibling; e !== null; )
          Xs(e, t, n),
          e = e.sibling
}
function qs(e, t, n) {
  var r = e.tag;
  if (r === 5 || r === 6)
      e = e.stateNode,
      t ? n.insertBefore(e, t) : n.appendChild(e);
  else if (r !== 4 && (e = e.child,
  e !== null))
      for (qs(e, t, n),
      e = e.sibling; e !== null; )
          qs(e, t, n),
          e = e.sibling
}
var ge = null
, tt = !1;
function Mt(e, t, n) {
  for (n = n.child; n !== null; )
      Df(e, t, n),
      n = n.sibling
}
function Df(e, t, n) {
  if (ct && typeof ct.onCommitFiberUnmount == "function")
      try {
          ct.onCommitFiberUnmount(Go, n)
      } catch {}
  switch (n.tag) {
  case 5:
      Ee || $n(n, t);
  case 6:
      var r = ge
        , i = tt;
      ge = null,
      Mt(e, t, n),
      ge = r,
      tt = i,
      ge !== null && (tt ? (e = ge,
      n = n.stateNode,
      e.nodeType === 8 ? e.parentNode.removeChild(n) : e.removeChild(n)) : ge.removeChild(n.stateNode));
      break;
  case 18:
      ge !== null && (tt ? (e = ge,
      n = n.stateNode,
      e.nodeType === 8 ? _a(e.parentNode, n) : e.nodeType === 1 && _a(e, n),
      Yr(e)) : _a(ge, n.stateNode));
      break;
  case 4:
      r = ge,
      i = tt,
      ge = n.stateNode.containerInfo,
      tt = !0,
      Mt(e, t, n),
      ge = r,
      tt = i;
      break;
  case 0:
  case 11:
  case 14:
  case 15:
      if (!Ee && (r = n.updateQueue,
      r !== null && (r = r.lastEffect,
      r !== null))) {
          i = r = r.next;
          do {
              var o = i
                , a = o.destroy;
              o = o.tag,
              a !== void 0 && ((o & 2) !== 0 || (o & 4) !== 0) && Ks(n, t, a),
              i = i.next
          } while (i !== r)
      }
      Mt(e, t, n);
      break;
  case 1:
      if (!Ee && ($n(n, t),
      r = n.stateNode,
      typeof r.componentWillUnmount == "function"))
          try {
              r.props = n.memoizedProps,
              r.state = n.memoizedState,
              r.componentWillUnmount()
          } catch (s) {
              ne(n, t, s)
          }
      Mt(e, t, n);
      break;
  case 21:
      Mt(e, t, n);
      break;
  case 22:
      n.mode & 1 ? (Ee = (r = Ee) || n.memoizedState !== null,
      Mt(e, t, n),
      Ee = r) : Mt(e, t, n);
      break;
  default:
      Mt(e, t, n)
  }
}
function Bc(e) {
  var t = e.updateQueue;
  if (t !== null) {
      e.updateQueue = null;
      var n = e.stateNode;
      n === null && (n = e.stateNode = new tg),
      t.forEach(function(r) {
          var i = dg.bind(null, e, r);
          n.has(r) || (n.add(r),
          r.then(i, i))
      })
  }
}
function Je(e, t) {
  var n = t.deletions;
  if (n !== null)
      for (var r = 0; r < n.length; r++) {
          var i = n[r];
          try {
              var o = e
                , a = t
                , s = a;
              e: for (; s !== null; ) {
                  switch (s.tag) {
                  case 5:
                      ge = s.stateNode,
                      tt = !1;
                      break e;
                  case 3:
                      ge = s.stateNode.containerInfo,
                      tt = !0;
                      break e;
                  case 4:
                      ge = s.stateNode.containerInfo,
                      tt = !0;
                      break e
                  }
                  s = s.return
              }
              if (ge === null)
                  throw Error(L(160));
              Df(o, a, i),
              ge = null,
              tt = !1;
              var l = i.alternate;
              l !== null && (l.return = null),
              i.return = null
          } catch (u) {
              ne(i, t, u)
          }
      }
  if (t.subtreeFlags & 12854)
      for (t = t.child; t !== null; )
          jf(t, e),
          t = t.sibling
}
function jf(e, t) {
  var n = e.alternate
    , r = e.flags;
  switch (e.tag) {
  case 0:
  case 11:
  case 14:
  case 15:
      if (Je(t, e),
      st(e),
      r & 4) {
          try {
              Fr(3, e, e.return),
              ea(3, e)
          } catch (x) {
              ne(e, e.return, x)
          }
          try {
              Fr(5, e, e.return)
          } catch (x) {
              ne(e, e.return, x)
          }
      }
      break;
  case 1:
      Je(t, e),
      st(e),
      r & 512 && n !== null && $n(n, n.return);
      break;
  case 5:
      if (Je(t, e),
      st(e),
      r & 512 && n !== null && $n(n, n.return),
      e.flags & 32) {
          var i = e.stateNode;
          try {
              Gr(i, "")
          } catch (x) {
              ne(e, e.return, x)
          }
      }
      if (r & 4 && (i = e.stateNode,
      i != null)) {
          var o = e.memoizedProps
            , a = n !== null ? n.memoizedProps : o
            , s = e.type
            , l = e.updateQueue;
          if (e.updateQueue = null,
          l !== null)
              try {
                  s === "input" && o.type === "radio" && o.name != null && r1(i, o),
                  Es(s, a);
                  var u = Es(s, o);
                  for (a = 0; a < l.length; a += 2) {
                      var f = l[a]
                        , d = l[a + 1];
                      f === "style" ? l1(i, d) : f === "dangerouslySetInnerHTML" ? a1(i, d) : f === "children" ? Gr(i, d) : Ll(i, f, d, u)
                  }
                  switch (s) {
                  case "input":
                      ys(i, o);
                      break;
                  case "textarea":
                      i1(i, o);
                      break;
                  case "select":
                      var m = i._wrapperState.wasMultiple;
                      i._wrapperState.wasMultiple = !!o.multiple;
                      var p = o.value;
                      p != null ? Kn(i, !!o.multiple, p, !1) : m !== !!o.multiple && (o.defaultValue != null ? Kn(i, !!o.multiple, o.defaultValue, !0) : Kn(i, !!o.multiple, o.multiple ? [] : "", !1))
                  }
                  i[ti] = o
              } catch (x) {
                  ne(e, e.return, x)
              }
      }
      break;
  case 6:
      if (Je(t, e),
      st(e),
      r & 4) {
          if (e.stateNode === null)
              throw Error(L(162));
          i = e.stateNode,
          o = e.memoizedProps;
          try {
              i.nodeValue = o
          } catch (x) {
              ne(e, e.return, x)
          }
      }
      break;
  case 3:
      if (Je(t, e),
      st(e),
      r & 4 && n !== null && n.memoizedState.isDehydrated)
          try {
              Yr(t.containerInfo)
          } catch (x) {
              ne(e, e.return, x)
          }
      break;
  case 4:
      Je(t, e),
      st(e);
      break;
  case 13:
      Je(t, e),
      st(e),
      i = e.child,
      i.flags & 8192 && (o = i.memoizedState !== null,
      i.stateNode.isHidden = o,
      !o || i.alternate !== null && i.alternate.memoizedState !== null || (uu = ie())),
      r & 4 && Bc(e);
      break;
  case 22:
      if (f = n !== null && n.memoizedState !== null,
      e.mode & 1 ? (Ee = (u = Ee) || f,
      Je(t, e),
      Ee = u) : Je(t, e),
      st(e),
      r & 8192) {
          if (u = e.memoizedState !== null,
          (e.stateNode.isHidden = u) && !f && (e.mode & 1) !== 0)
              for (V = e,
              f = e.child; f !== null; ) {
                  for (d = V = f; V !== null; ) {
                      switch (m = V,
                      p = m.child,
                      m.tag) {
                      case 0:
                      case 11:
                      case 14:
                      case 15:
                          Fr(4, m, m.return);
                          break;
                      case 1:
                          $n(m, m.return);
                          var v = m.stateNode;
                          if (typeof v.componentWillUnmount == "function") {
                              r = m,
                              n = m.return;
                              try {
                                  t = r,
                                  v.props = t.memoizedProps,
                                  v.state = t.memoizedState,
                                  v.componentWillUnmount()
                              } catch (x) {
                                  ne(r, n, x)
                              }
                          }
                          break;
                      case 5:
                          $n(m, m.return);
                          break;
                      case 22:
                          if (m.memoizedState !== null) {
                              Uc(d);
                              continue
                          }
                      }
                      p !== null ? (p.return = m,
                      V = p) : Uc(d)
                  }
                  f = f.sibling
              }
          e: for (f = null,
          d = e; ; ) {
              if (d.tag === 5) {
                  if (f === null) {
                      f = d;
                      try {
                          i = d.stateNode,
                          u ? (o = i.style,
                          typeof o.setProperty == "function" ? o.setProperty("display", "none", "important") : o.display = "none") : (s = d.stateNode,
                          l = d.memoizedProps.style,
                          a = l != null && l.hasOwnProperty("display") ? l.display : null,
                          s.style.display = s1("display", a))
                      } catch (x) {
                          ne(e, e.return, x)
                      }
                  }
              } else if (d.tag === 6) {
                  if (f === null)
                      try {
                          d.stateNode.nodeValue = u ? "" : d.memoizedProps
                      } catch (x) {
                          ne(e, e.return, x)
                      }
              } else if ((d.tag !== 22 && d.tag !== 23 || d.memoizedState === null || d === e) && d.child !== null) {
                  d.child.return = d,
                  d = d.child;
                  continue
              }
              if (d === e)
                  break e;
              for (; d.sibling === null; ) {
                  if (d.return === null || d.return === e)
                      break e;
                  f === d && (f = null),
                  d = d.return
              }
              f === d && (f = null),
              d.sibling.return = d.return,
              d = d.sibling
          }
      }
      break;
  case 19:
      Je(t, e),
      st(e),
      r & 4 && Bc(e);
      break;
  case 21:
      break;
  default:
      Je(t, e),
      st(e)
  }
}
function st(e) {
  var t = e.flags;
  if (t & 2) {
      try {
          e: {
              for (var n = e.return; n !== null; ) {
                  if (Vf(n)) {
                      var r = n;
                      break e
                  }
                  n = n.return
              }
              throw Error(L(160))
          }
          switch (r.tag) {
          case 5:
              var i = r.stateNode;
              r.flags & 32 && (Gr(i, ""),
              r.flags &= -33);
              var o = Hc(e);
              qs(e, o, i);
              break;
          case 3:
          case 4:
              var a = r.stateNode.containerInfo
                , s = Hc(e);
              Xs(e, s, a);
              break;
          default:
              throw Error(L(161))
          }
      } catch (l) {
          ne(e, e.return, l)
      }
      e.flags &= -3
  }
  t & 4096 && (e.flags &= -4097)
}
function rg(e, t, n) {
  V = e,
  If(e)
}
function If(e, t, n) {
  for (var r = (e.mode & 1) !== 0; V !== null; ) {
      var i = V
        , o = i.child;
      if (i.tag === 22 && r) {
          var a = i.memoizedState !== null || zi;
          if (!a) {
              var s = i.alternate
                , l = s !== null && s.memoizedState !== null || Ee;
              s = zi;
              var u = Ee;
              if (zi = a,
              (Ee = l) && !u)
                  for (V = i; V !== null; )
                      a = V,
                      l = a.child,
                      a.tag === 22 && a.memoizedState !== null ? Zc(i) : l !== null ? (l.return = a,
                      V = l) : Zc(i);
              for (; o !== null; )
                  V = o,
                  If(o),
                  o = o.sibling;
              V = i,
              zi = s,
              Ee = u
          }
          $c(e)
      } else
          (i.subtreeFlags & 8772) !== 0 && o !== null ? (o.return = i,
          V = o) : $c(e)
  }
}
function $c(e) {
  for (; V !== null; ) {
      var t = V;
      if ((t.flags & 8772) !== 0) {
          var n = t.alternate;
          try {
              if ((t.flags & 8772) !== 0)
                  switch (t.tag) {
                  case 0:
                  case 11:
                  case 15:
                      Ee || ea(5, t);
                      break;
                  case 1:
                      var r = t.stateNode;
                      if (t.flags & 4 && !Ee)
                          if (n === null)
                              r.componentDidMount();
                          else {
                              var i = t.elementType === t.type ? n.memoizedProps : et(t.type, n.memoizedProps);
                              r.componentDidUpdate(i, n.memoizedState, r.__reactInternalSnapshotBeforeUpdate)
                          }
                      var o = t.updateQueue;
                      o !== null && kc(t, o, r);
                      break;
                  case 3:
                      var a = t.updateQueue;
                      if (a !== null) {
                          if (n = null,
                          t.child !== null)
                              switch (t.child.tag) {
                              case 5:
                                  n = t.child.stateNode;
                                  break;
                              case 1:
                                  n = t.child.stateNode
                              }
                          kc(t, a, n)
                      }
                      break;
                  case 5:
                      var s = t.stateNode;
                      if (n === null && t.flags & 4) {
                          n = s;
                          var l = t.memoizedProps;
                          switch (t.type) {
                          case "button":
                          case "input":
                          case "select":
                          case "textarea":
                              l.autoFocus && n.focus();
                              break;
                          case "img":
                              l.src && (n.src = l.src)
                          }
                      }
                      break;
                  case 6:
                      break;
                  case 4:
                      break;
                  case 12:
                      break;
                  case 13:
                      if (t.memoizedState === null) {
                          var u = t.alternate;
                          if (u !== null) {
                              var f = u.memoizedState;
                              if (f !== null) {
                                  var d = f.dehydrated;
                                  d !== null && Yr(d)
                              }
                          }
                      }
                      break;
                  case 19:
                  case 17:
                  case 21:
                  case 22:
                  case 23:
                  case 25:
                      break;
                  default:
                      throw Error(L(163))
                  }
              Ee || t.flags & 512 && Ys(t)
          } catch (m) {
              ne(t, t.return, m)
          }
      }
      if (t === e) {
          V = null;
          break
      }
      if (n = t.sibling,
      n !== null) {
          n.return = t.return,
          V = n;
          break
      }
      V = t.return
  }
}
function Uc(e) {
  for (; V !== null; ) {
      var t = V;
      if (t === e) {
          V = null;
          break
      }
      var n = t.sibling;
      if (n !== null) {
          n.return = t.return,
          V = n;
          break
      }
      V = t.return
  }
}
function Zc(e) {
  for (; V !== null; ) {
      var t = V;
      try {
          switch (t.tag) {
          case 0:
          case 11:
          case 15:
              var n = t.return;
              try {
                  ea(4, t)
              } catch (l) {
                  ne(t, n, l)
              }
              break;
          case 1:
              var r = t.stateNode;
              if (typeof r.componentDidMount == "function") {
                  var i = t.return;
                  try {
                      r.componentDidMount()
                  } catch (l) {
                      ne(t, i, l)
                  }
              }
              var o = t.return;
              try {
                  Ys(t)
              } catch (l) {
                  ne(t, o, l)
              }
              break;
          case 5:
              var a = t.return;
              try {
                  Ys(t)
              } catch (l) {
                  ne(t, a, l)
              }
          }
      } catch (l) {
          ne(t, t.return, l)
      }
      if (t === e) {
          V = null;
          break
      }
      var s = t.sibling;
      if (s !== null) {
          s.return = t.return,
          V = s;
          break
      }
      V = t.return
  }
}
var ig = Math.ceil
, To = kt.ReactCurrentDispatcher
, su = kt.ReactCurrentOwner
, Ke = kt.ReactCurrentBatchConfig
, B = 0
, he = null
, le = null
, ye = 0
, Ie = 0
, Un = en(0)
, de = 0
, si = null
, Pn = 0
, ta = 0
, lu = 0
, _r = null
, Le = null
, uu = 0
, sr = 1 / 0
, ht = null
, Mo = !1
, Js = null
, Ut = null
, Hi = !1
, It = null
, Lo = 0
, zr = 0
, el = null
, no = -1
, ro = 0;
function Ae() {
  return (B & 6) !== 0 ? ie() : no !== -1 ? no : no = ie()
}
function Zt(e) {
  return (e.mode & 1) === 0 ? 1 : (B & 2) !== 0 && ye !== 0 ? ye & -ye : H2.transition !== null ? (ro === 0 && (ro = w1()),
  ro) : (e = Z,
  e !== 0 || (e = window.event,
  e = e === void 0 ? 16 : k1(e.type)),
  e)
}
function it(e, t, n, r) {
  if (50 < zr)
      throw zr = 0,
      el = null,
      Error(L(185));
  gi(e, n, r),
  ((B & 2) === 0 || e !== he) && (e === he && ((B & 2) === 0 && (ta |= n),
  de === 4 && Dt(e, ye)),
  Ve(e, r),
  n === 1 && B === 0 && (t.mode & 1) === 0 && (sr = ie() + 500,
  Xo && tn()))
}
function Ve(e, t) {
  var n = e.callbackNode;
  Hp(e, t);
  var r = mo(e, e === he ? ye : 0);
  if (r === 0)
      n !== null && ec(n),
      e.callbackNode = null,
      e.callbackPriority = 0;
  else if (t = r & -r,
  e.callbackPriority !== t) {
      if (n != null && ec(n),
      t === 1)
          e.tag === 0 ? z2(Gc.bind(null, e)) : G1(Gc.bind(null, e)),
          j2(function() {
              (B & 6) === 0 && tn()
          }),
          n = null;
      else {
          switch (S1(r)) {
          case 1:
              n = Dl;
              break;
          case 4:
              n = v1;
              break;
          case 16:
              n = fo;
              break;
          case 536870912:
              n = x1;
              break;
          default:
              n = fo
          }
          n = Zf(n, Ff.bind(null, e))
      }
      e.callbackPriority = t,
      e.callbackNode = n
  }
}
function Ff(e, t) {
  if (no = -1,
  ro = 0,
  (B & 6) !== 0)
      throw Error(L(327));
  var n = e.callbackNode;
  if (er() && e.callbackNode !== n)
      return null;
  var r = mo(e, e === he ? ye : 0);
  if (r === 0)
      return null;
  if ((r & 30) !== 0 || (r & e.expiredLanes) !== 0 || t)
      t = Ro(e, r);
  else {
      t = r;
      var i = B;
      B |= 2;
      var o = zf();
      (he !== e || ye !== t) && (ht = null,
      sr = ie() + 500,
      yn(e, t));
      do
          try {
              sg();
              break
          } catch (s) {
              _f(e, s)
          }
      while (1);
      Ql(),
      To.current = o,
      B = i,
      le !== null ? t = 0 : (he = null,
      ye = 0,
      t = de)
  }
  if (t !== 0) {
      if (t === 2 && (i = ks(e),
      i !== 0 && (r = i,
      t = tl(e, i))),
      t === 1)
          throw n = si,
          yn(e, 0),
          Dt(e, r),
          Ve(e, ie()),
          n;
      if (t === 6)
          Dt(e, r);
      else {
          if (i = e.current.alternate,
          (r & 30) === 0 && !og(i) && (t = Ro(e, r),
          t === 2 && (o = ks(e),
          o !== 0 && (r = o,
          t = tl(e, o))),
          t === 1))
              throw n = si,
              yn(e, 0),
              Dt(e, r),
              Ve(e, ie()),
              n;
          switch (e.finishedWork = i,
          e.finishedLanes = r,
          t) {
          case 0:
          case 1:
              throw Error(L(345));
          case 2:
              un(e, Le, ht);
              break;
          case 3:
              if (Dt(e, r),
              (r & 130023424) === r && (t = uu + 500 - ie(),
              10 < t)) {
                  if (mo(e, 0) !== 0)
                      break;
                  if (i = e.suspendedLanes,
                  (i & r) !== r) {
                      Ae(),
                      e.pingedLanes |= e.suspendedLanes & i;
                      break
                  }
                  e.timeoutHandle = Ds(un.bind(null, e, Le, ht), t);
                  break
              }
              un(e, Le, ht);
              break;
          case 4:
              if (Dt(e, r),
              (r & 4194240) === r)
                  break;
              for (t = e.eventTimes,
              i = -1; 0 < r; ) {
                  var a = 31 - rt(r);
                  o = 1 << a,
                  a = t[a],
                  a > i && (i = a),
                  r &= ~o
              }
              if (r = i,
              r = ie() - r,
              r = (120 > r ? 120 : 480 > r ? 480 : 1080 > r ? 1080 : 1920 > r ? 1920 : 3e3 > r ? 3e3 : 4320 > r ? 4320 : 1960 * ig(r / 1960)) - r,
              10 < r) {
                  e.timeoutHandle = Ds(un.bind(null, e, Le, ht), r);
                  break
              }
              un(e, Le, ht);
              break;
          case 5:
              un(e, Le, ht);
              break;
          default:
              throw Error(L(329))
          }
      }
  }
  return Ve(e, ie()),
  e.callbackNode === n ? Ff.bind(null, e) : null
}
function tl(e, t) {
  var n = _r;
  return e.current.memoizedState.isDehydrated && (yn(e, t).flags |= 256),
  e = Ro(e, t),
  e !== 2 && (t = Le,
  Le = n,
  t !== null && nl(t)),
  e
}
function nl(e) {
  Le === null ? Le = e : Le.push.apply(Le, e)
}
function og(e) {
  for (var t = e; ; ) {
      if (t.flags & 16384) {
          var n = t.updateQueue;
          if (n !== null && (n = n.stores,
          n !== null))
              for (var r = 0; r < n.length; r++) {
                  var i = n[r]
                    , o = i.getSnapshot;
                  i = i.value;
                  try {
                      if (!ot(o(), i))
                          return !1
                  } catch {
                      return !1
                  }
              }
      }
      if (n = t.child,
      t.subtreeFlags & 16384 && n !== null)
          n.return = t,
          t = n;
      else {
          if (t === e)
              break;
          for (; t.sibling === null; ) {
              if (t.return === null || t.return === e)
                  return !0;
              t = t.return
          }
          t.sibling.return = t.return,
          t = t.sibling
      }
  }
  return !0
}
function Dt(e, t) {
  for (t &= ~lu,
  t &= ~ta,
  e.suspendedLanes |= t,
  e.pingedLanes &= ~t,
  e = e.expirationTimes; 0 < t; ) {
      var n = 31 - rt(t)
        , r = 1 << n;
      e[n] = -1,
      t &= ~r
  }
}
function Gc(e) {
  if ((B & 6) !== 0)
      throw Error(L(327));
  er();
  var t = mo(e, 0);
  if ((t & 1) === 0)
      return Ve(e, ie()),
      null;
  var n = Ro(e, t);
  if (e.tag !== 0 && n === 2) {
      var r = ks(e);
      r !== 0 && (t = r,
      n = tl(e, r))
  }
  if (n === 1)
      throw n = si,
      yn(e, 0),
      Dt(e, t),
      Ve(e, ie()),
      n;
  if (n === 6)
      throw Error(L(345));
  return e.finishedWork = e.current.alternate,
  e.finishedLanes = t,
  un(e, Le, ht),
  Ve(e, ie()),
  null
}
function cu(e, t) {
  var n = B;
  B |= 1;
  try {
      return e(t)
  } finally {
      B = n,
      B === 0 && (sr = ie() + 500,
      Xo && tn())
  }
}
function An(e) {
  It !== null && It.tag === 0 && (B & 6) === 0 && er();
  var t = B;
  B |= 1;
  var n = Ke.transition
    , r = Z;
  try {
      if (Ke.transition = null,
      Z = 1,
      e)
          return e()
  } finally {
      Z = r,
      Ke.transition = n,
      B = t,
      (B & 6) === 0 && tn()
  }
}
function du() {
  Ie = Un.current,
  K(Un)
}
function yn(e, t) {
  e.finishedWork = null,
  e.finishedLanes = 0;
  var n = e.timeoutHandle;
  if (n !== -1 && (e.timeoutHandle = -1,
  D2(n)),
  le !== null)
      for (n = le.return; n !== null; ) {
          var r = n;
          switch (Zl(r),
          r.tag) {
          case 1:
              r = r.type.childContextTypes,
              r != null && vo();
              break;
          case 3:
              or(),
              K(be),
              K(Ne),
              eu();
              break;
          case 5:
              Jl(r);
              break;
          case 4:
              or();
              break;
          case 13:
              K(q);
              break;
          case 19:
              K(q);
              break;
          case 10:
              Kl(r.type._context);
              break;
          case 22:
          case 23:
              du()
          }
          n = n.return
      }
  if (he = e,
  le = e = Gt(e.current, null),
  ye = Ie = t,
  de = 0,
  si = null,
  lu = ta = Pn = 0,
  Le = _r = null,
  hn !== null) {
      for (t = 0; t < hn.length; t++)
          if (n = hn[t],
          r = n.interleaved,
          r !== null) {
              n.interleaved = null;
              var i = r.next
                , o = n.pending;
              if (o !== null) {
                  var a = o.next;
                  o.next = i,
                  r.next = a
              }
              n.pending = r
          }
      hn = null
  }
  return e
}
function _f(e, t) {
  do {
      var n = le;
      try {
          if (Ql(),
          Ji.current = ko,
          Ao) {
              for (var r = ee.memoizedState; r !== null; ) {
                  var i = r.queue;
                  i !== null && (i.pending = null),
                  r = r.next
              }
              Ao = !1
          }
          if (Cn = 0,
          me = ce = ee = null,
          Ir = !1,
          ii = 0,
          su.current = null,
          n === null || n.return === null) {
              de = 1,
              si = t,
              le = null;
              break
          }
          e: {
              var o = e
                , a = n.return
                , s = n
                , l = t;
              if (t = ye,
              s.flags |= 32768,
              l !== null && typeof l == "object" && typeof l.then == "function") {
                  var u = l
                    , f = s
                    , d = f.tag;
                  if ((f.mode & 1) === 0 && (d === 0 || d === 11 || d === 15)) {
                      var m = f.alternate;
                      m ? (f.updateQueue = m.updateQueue,
                      f.memoizedState = m.memoizedState,
                      f.lanes = m.lanes) : (f.updateQueue = null,
                      f.memoizedState = null)
                  }
                  var p = Oc(a);
                  if (p !== null) {
                      p.flags &= -257,
                      Vc(p, a, s, o, t),
                      p.mode & 1 && bc(o, u, t),
                      t = p,
                      l = u;
                      var v = t.updateQueue;
                      if (v === null) {
                          var x = new Set;
                          x.add(l),
                          t.updateQueue = x
                      } else
                          v.add(l);
                      break e
                  } else {
                      if ((t & 1) === 0) {
                          bc(o, u, t),
                          fu();
                          break e
                      }
                      l = Error(L(426))
                  }
              } else if (X && s.mode & 1) {
                  var P = Oc(a);
                  if (P !== null) {
                      (P.flags & 65536) === 0 && (P.flags |= 256),
                      Vc(P, a, s, o, t),
                      Gl(ar(l, s));
                      break e
                  }
              }
              o = l = ar(l, s),
              de !== 4 && (de = 2),
              _r === null ? _r = [o] : _r.push(o),
              o = a;
              do {
                  switch (o.tag) {
                  case 3:
                      o.flags |= 65536,
                      t &= -t,
                      o.lanes |= t;
                      var y = Ef(o, l, t);
                      Ac(o, y);
                      break e;
                  case 1:
                      s = l;
                      var h = o.type
                        , g = o.stateNode;
                      if ((o.flags & 128) === 0 && (typeof h.getDerivedStateFromError == "function" || g !== null && typeof g.componentDidCatch == "function" && (Ut === null || !Ut.has(g)))) {
                          o.flags |= 65536,
                          t &= -t,
                          o.lanes |= t;
                          var S = Nf(o, s, t);
                          Ac(o, S);
                          break e
                      }
                  }
                  o = o.return
              } while (o !== null)
          }
          Bf(n)
      } catch (M) {
          t = M,
          le === n && n !== null && (le = n = n.return);
          continue
      }
      break
  } while (1)
}
function zf() {
  var e = To.current;
  return To.current = ko,
  e === null ? ko : e
}
function fu() {
  (de === 0 || de === 3 || de === 2) && (de = 4),
  he === null || (Pn & 268435455) === 0 && (ta & 268435455) === 0 || Dt(he, ye)
}
function Ro(e, t) {
  var n = B;
  B |= 2;
  var r = zf();
  (he !== e || ye !== t) && (ht = null,
  yn(e, t));
  do
      try {
          ag();
          break
      } catch (i) {
          _f(e, i)
      }
  while (1);
  if (Ql(),
  B = n,
  To.current = r,
  le !== null)
      throw Error(L(261));
  return he = null,
  ye = 0,
  de
}
function ag() {
  for (; le !== null; )
      Hf(le)
}
function sg() {
  for (; le !== null && !bp(); )
      Hf(le)
}
function Hf(e) {
  var t = Uf(e.alternate, e, Ie);
  e.memoizedProps = e.pendingProps,
  t === null ? Bf(e) : le = t,
  su.current = null
}
function Bf(e) {
  var t = e;
  do {
      var n = t.alternate;
      if (e = t.return,
      (t.flags & 32768) === 0) {
          if (n = J2(n, t, Ie),
          n !== null) {
              le = n;
              return
          }
      } else {
          if (n = eg(n, t),
          n !== null) {
              n.flags &= 32767,
              le = n;
              return
          }
          if (e !== null)
              e.flags |= 32768,
              e.subtreeFlags = 0,
              e.deletions = null;
          else {
              de = 6,
              le = null;
              return
          }
      }
      if (t = t.sibling,
      t !== null) {
          le = t;
          return
      }
      le = t = e
  } while (t !== null);
  de === 0 && (de = 5)
}
function un(e, t, n) {
  var r = Z
    , i = Ke.transition;
  try {
      Ke.transition = null,
      Z = 1,
      lg(e, t, n, r)
  } finally {
      Ke.transition = i,
      Z = r
  }
  return null
}
function lg(e, t, n, r) {
  do
      er();
  while (It !== null);
  if ((B & 6) !== 0)
      throw Error(L(327));
  n = e.finishedWork;
  var i = e.finishedLanes;
  if (n === null)
      return null;
  if (e.finishedWork = null,
  e.finishedLanes = 0,
  n === e.current)
      throw Error(L(177));
  e.callbackNode = null,
  e.callbackPriority = 0;
  var o = n.lanes | n.childLanes;
  if (Bp(e, o),
  e === he && (le = he = null,
  ye = 0),
  (n.subtreeFlags & 2064) === 0 && (n.flags & 2064) === 0 || Hi || (Hi = !0,
  Zf(fo, function() {
      return er(),
      null
  })),
  o = (n.flags & 15990) !== 0,
  (n.subtreeFlags & 15990) !== 0 || o) {
      o = Ke.transition,
      Ke.transition = null;
      var a = Z;
      Z = 1;
      var s = B;
      B |= 4,
      su.current = null,
      ng(e, n),
      jf(n, e),
      T2(Os),
      ho = !!bs,
      Os = bs = null,
      e.current = n,
      rg(n),
      Op(),
      B = s,
      Z = a,
      Ke.transition = o
  } else
      e.current = n;
  if (Hi && (Hi = !1,
  It = e,
  Lo = i),
  o = e.pendingLanes,
  o === 0 && (Ut = null),
  jp(n.stateNode),
  Ve(e, ie()),
  t !== null)
      for (r = e.onRecoverableError,
      n = 0; n < t.length; n++)
          i = t[n],
          r(i.value, {
              componentStack: i.stack,
              digest: i.digest
          });
  if (Mo)
      throw Mo = !1,
      e = Js,
      Js = null,
      e;
  return (Lo & 1) !== 0 && e.tag !== 0 && er(),
  o = e.pendingLanes,
  (o & 1) !== 0 ? e === el ? zr++ : (zr = 0,
  el = e) : zr = 0,
  tn(),
  null
}
function er() {
  if (It !== null) {
      var e = S1(Lo)
        , t = Ke.transition
        , n = Z;
      try {
          if (Ke.transition = null,
          Z = 16 > e ? 16 : e,
          It === null)
              var r = !1;
          else {
              if (e = It,
              It = null,
              Lo = 0,
              (B & 6) !== 0)
                  throw Error(L(331));
              var i = B;
              for (B |= 4,
              V = e.current; V !== null; ) {
                  var o = V
                    , a = o.child;
                  if ((V.flags & 16) !== 0) {
                      var s = o.deletions;
                      if (s !== null) {
                          for (var l = 0; l < s.length; l++) {
                              var u = s[l];
                              for (V = u; V !== null; ) {
                                  var f = V;
                                  switch (f.tag) {
                                  case 0:
                                  case 11:
                                  case 15:
                                      Fr(8, f, o)
                                  }
                                  var d = f.child;
                                  if (d !== null)
                                      d.return = f,
                                      V = d;
                                  else
                                      for (; V !== null; ) {
                                          f = V;
                                          var m = f.sibling
                                            , p = f.return;
                                          if (Of(f),
                                          f === u) {
                                              V = null;
                                              break
                                          }
                                          if (m !== null) {
                                              m.return = p,
                                              V = m;
                                              break
                                          }
                                          V = p
                                      }
                              }
                          }
                          var v = o.alternate;
                          if (v !== null) {
                              var x = v.child;
                              if (x !== null) {
                                  v.child = null;
                                  do {
                                      var P = x.sibling;
                                      x.sibling = null,
                                      x = P
                                  } while (x !== null)
                              }
                          }
                          V = o
                      }
                  }
                  if ((o.subtreeFlags & 2064) !== 0 && a !== null)
                      a.return = o,
                      V = a;
                  else
                      e: for (; V !== null; ) {
                          if (o = V,
                          (o.flags & 2048) !== 0)
                              switch (o.tag) {
                              case 0:
                              case 11:
                              case 15:
                                  Fr(9, o, o.return)
                              }
                          var y = o.sibling;
                          if (y !== null) {
                              y.return = o.return,
                              V = y;
                              break e
                          }
                          V = o.return
                      }
              }
              var h = e.current;
              for (V = h; V !== null; ) {
                  a = V;
                  var g = a.child;
                  if ((a.subtreeFlags & 2064) !== 0 && g !== null)
                      g.return = a,
                      V = g;
                  else
                      e: for (a = h; V !== null; ) {
                          if (s = V,
                          (s.flags & 2048) !== 0)
                              try {
                                  switch (s.tag) {
                                  case 0:
                                  case 11:
                                  case 15:
                                      ea(9, s)
                                  }
                              } catch (M) {
                                  ne(s, s.return, M)
                              }
                          if (s === a) {
                              V = null;
                              break e
                          }
                          var S = s.sibling;
                          if (S !== null) {
                              S.return = s.return,
                              V = S;
                              break e
                          }
                          V = s.return
                      }
              }
              if (B = i,
              tn(),
              ct && typeof ct.onPostCommitFiberRoot == "function")
                  try {
                      ct.onPostCommitFiberRoot(Go, e)
                  } catch {}
              r = !0
          }
          return r
      } finally {
          Z = n,
          Ke.transition = t
      }
  }
  return !1
}
function Wc(e, t, n) {
  t = ar(n, t),
  t = Ef(e, t, 1),
  e = $t(e, t, 1),
  t = Ae(),
  e !== null && (gi(e, 1, t),
  Ve(e, t))
}
function ne(e, t, n) {
  if (e.tag === 3)
      Wc(e, e, n);
  else
      for (; t !== null; ) {
          if (t.tag === 3) {
              Wc(t, e, n);
              break
          } else if (t.tag === 1) {
              var r = t.stateNode;
              if (typeof t.type.getDerivedStateFromError == "function" || typeof r.componentDidCatch == "function" && (Ut === null || !Ut.has(r))) {
                  e = ar(n, e),
                  e = Nf(t, e, 1),
                  t = $t(t, e, 1),
                  e = Ae(),
                  t !== null && (gi(t, 1, e),
                  Ve(t, e));
                  break
              }
          }
          t = t.return
      }
}
function ug(e, t, n) {
  var r = e.pingCache;
  r !== null && r.delete(t),
  t = Ae(),
  e.pingedLanes |= e.suspendedLanes & n,
  he === e && (ye & n) === n && (de === 4 || de === 3 && (ye & 130023424) === ye && 500 > ie() - uu ? yn(e, 0) : lu |= n),
  Ve(e, t)
}
function $f(e, t) {
  t === 0 && ((e.mode & 1) === 0 ? t = 1 : (t = Ri,
  Ri <<= 1,
  (Ri & 130023424) === 0 && (Ri = 4194304)));
  var n = Ae();
  e = Ct(e, t),
  e !== null && (gi(e, t, n),
  Ve(e, n))
}
function cg(e) {
  var t = e.memoizedState
    , n = 0;
  t !== null && (n = t.retryLane),
  $f(e, n)
}
function dg(e, t) {
  var n = 0;
  switch (e.tag) {
  case 13:
      var r = e.stateNode
        , i = e.memoizedState;
      i !== null && (n = i.retryLane);
      break;
  case 19:
      r = e.stateNode;
      break;
  default:
      throw Error(L(314))
  }
  r !== null && r.delete(t),
  $f(e, n)
}
var Uf;
Uf = function(e, t, n) {
  if (e !== null)
      if (e.memoizedProps !== t.pendingProps || be.current)
          Re = !0;
      else {
          if ((e.lanes & n) === 0 && (t.flags & 128) === 0)
              return Re = !1,
              q2(e, t, n);
          Re = (e.flags & 131072) !== 0
      }
  else
      Re = !1,
      X && (t.flags & 1048576) !== 0 && W1(t, So, t.index);
  switch (t.lanes = 0,
  t.tag) {
  case 2:
      var r = t.type;
      to(e, t),
      e = t.pendingProps;
      var i = nr(t, Ne.current);
      Jn(t, n),
      i = nu(null, t, r, e, i, n);
      var o = ru();
      return t.flags |= 1,
      typeof i == "object" && i !== null && typeof i.render == "function" && i.$$typeof === void 0 ? (t.tag = 1,
      t.memoizedState = null,
      t.updateQueue = null,
      Oe(r) ? (o = !0,
      xo(t)) : o = !1,
      t.memoizedState = i.state !== null && i.state !== void 0 ? i.state : null,
      Xl(t),
      i.updater = Jo,
      t.stateNode = i,
      i._reactInternals = t,
      Bs(t, r, e, n),
      t = Zs(null, t, r, !0, o, n)) : (t.tag = 0,
      X && o && Ul(t),
      Pe(null, t, i, n),
      t = t.child),
      t;
  case 16:
      r = t.elementType;
      e: {
          switch (to(e, t),
          e = t.pendingProps,
          i = r._init,
          r = i(r._payload),
          t.type = r,
          i = t.tag = mg(r),
          e = et(r, e),
          i) {
          case 0:
              t = Us(null, t, r, e, n);
              break e;
          case 1:
              t = Ic(null, t, r, e, n);
              break e;
          case 11:
              t = Dc(null, t, r, e, n);
              break e;
          case 14:
              t = jc(null, t, r, et(r.type, e), n);
              break e
          }
          throw Error(L(306, r, ""))
      }
      return t;
  case 0:
      return r = t.type,
      i = t.pendingProps,
      i = t.elementType === r ? i : et(r, i),
      Us(e, t, r, i, n);
  case 1:
      return r = t.type,
      i = t.pendingProps,
      i = t.elementType === r ? i : et(r, i),
      Ic(e, t, r, i, n);
  case 3:
      e: {
          if (kf(t),
          e === null)
              throw Error(L(387));
          r = t.pendingProps,
          o = t.memoizedState,
          i = o.element,
          J1(e, t),
          Co(t, r, null, n);
          var a = t.memoizedState;
          if (r = a.element,
          o.isDehydrated)
              if (o = {
                  element: r,
                  isDehydrated: !1,
                  cache: a.cache,
                  pendingSuspenseBoundaries: a.pendingSuspenseBoundaries,
                  transitions: a.transitions
              },
              t.updateQueue.baseState = o,
              t.memoizedState = o,
              t.flags & 256) {
                  i = ar(Error(L(423)), t),
                  t = Fc(e, t, r, n, i);
                  break e
              } else if (r !== i) {
                  i = ar(Error(L(424)), t),
                  t = Fc(e, t, r, n, i);
                  break e
              } else
                  for (Fe = Bt(t.stateNode.containerInfo.firstChild),
                  _e = t,
                  X = !0,
                  nt = null,
                  n = X1(t, null, r, n),
                  t.child = n; n; )
                      n.flags = n.flags & -3 | 4096,
                      n = n.sibling;
          else {
              if (rr(),
              r === i) {
                  t = Pt(e, t, n);
                  break e
              }
              Pe(e, t, r, n)
          }
          t = t.child
      }
      return t;
  case 5:
      return ef(t),
      e === null && _s(t),
      r = t.type,
      i = t.pendingProps,
      o = e !== null ? e.memoizedProps : null,
      a = i.children,
      Vs(r, i) ? a = null : o !== null && Vs(r, o) && (t.flags |= 32),
      Af(e, t),
      Pe(e, t, a, n),
      t.child;
  case 6:
      return e === null && _s(t),
      null;
  case 13:
      return Tf(e, t, n);
  case 4:
      return ql(t, t.stateNode.containerInfo),
      r = t.pendingProps,
      e === null ? t.child = ir(t, null, r, n) : Pe(e, t, r, n),
      t.child;
  case 11:
      return r = t.type,
      i = t.pendingProps,
      i = t.elementType === r ? i : et(r, i),
      Dc(e, t, r, i, n);
  case 7:
      return Pe(e, t, t.pendingProps, n),
      t.child;
  case 8:
      return Pe(e, t, t.pendingProps.children, n),
      t.child;
  case 12:
      return Pe(e, t, t.pendingProps.children, n),
      t.child;
  case 10:
      e: {
          if (r = t.type._context,
          i = t.pendingProps,
          o = t.memoizedProps,
          a = i.value,
          G(Eo, r._currentValue),
          r._currentValue = a,
          o !== null)
              if (ot(o.value, a)) {
                  if (o.children === i.children && !be.current) {
                      t = Pt(e, t, n);
                      break e
                  }
              } else
                  for (o = t.child,
                  o !== null && (o.return = t); o !== null; ) {
                      var s = o.dependencies;
                      if (s !== null) {
                          a = o.child;
                          for (var l = s.firstContext; l !== null; ) {
                              if (l.context === r) {
                                  if (o.tag === 1) {
                                      l = xt(-1, n & -n),
                                      l.tag = 2;
                                      var u = o.updateQueue;
                                      if (u !== null) {
                                          u = u.shared;
                                          var f = u.pending;
                                          f === null ? l.next = l : (l.next = f.next,
                                          f.next = l),
                                          u.pending = l
                                      }
                                  }
                                  o.lanes |= n,
                                  l = o.alternate,
                                  l !== null && (l.lanes |= n),
                                  zs(o.return, n, t),
                                  s.lanes |= n;
                                  break
                              }
                              l = l.next
                          }
                      } else if (o.tag === 10)
                          a = o.type === t.type ? null : o.child;
                      else if (o.tag === 18) {
                          if (a = o.return,
                          a === null)
                              throw Error(L(341));
                          a.lanes |= n,
                          s = a.alternate,
                          s !== null && (s.lanes |= n),
                          zs(a, n, t),
                          a = o.sibling
                      } else
                          a = o.child;
                      if (a !== null)
                          a.return = o;
                      else
                          for (a = o; a !== null; ) {
                              if (a === t) {
                                  a = null;
                                  break
                              }
                              if (o = a.sibling,
                              o !== null) {
                                  o.return = a.return,
                                  a = o;
                                  break
                              }
                              a = a.return
                          }
                      o = a
                  }
          Pe(e, t, i.children, n),
          t = t.child
      }
      return t;
  case 9:
      return i = t.type,
      r = t.pendingProps.children,
      Jn(t, n),
      i = Ye(i),
      r = r(i),
      t.flags |= 1,
      Pe(e, t, r, n),
      t.child;
  case 14:
      return r = t.type,
      i = et(r, t.pendingProps),
      i = et(r.type, i),
      jc(e, t, r, i, n);
  case 15:
      return Cf(e, t, t.type, t.pendingProps, n);
  case 17:
      return r = t.type,
      i = t.pendingProps,
      i = t.elementType === r ? i : et(r, i),
      to(e, t),
      t.tag = 1,
      Oe(r) ? (e = !0,
      xo(t)) : e = !1,
      Jn(t, n),
      Sf(t, r, i),
      Bs(t, r, i, n),
      Zs(null, t, r, !0, e, n);
  case 19:
      return Mf(e, t, n);
  case 22:
      return Pf(e, t, n)
  }
  throw Error(L(156, t.tag))
}
;
function Zf(e, t) {
  return y1(e, t)
}
function fg(e, t, n, r) {
  this.tag = e,
  this.key = n,
  this.sibling = this.child = this.return = this.stateNode = this.type = this.elementType = null,
  this.index = 0,
  this.ref = null,
  this.pendingProps = t,
  this.dependencies = this.memoizedState = this.updateQueue = this.memoizedProps = null,
  this.mode = r,
  this.subtreeFlags = this.flags = 0,
  this.deletions = null,
  this.childLanes = this.lanes = 0,
  this.alternate = null
}
function Qe(e, t, n, r) {
  return new fg(e,t,n,r)
}
function mu(e) {
  return e = e.prototype,
  !(!e || !e.isReactComponent)
}
function mg(e) {
  if (typeof e == "function")
      return mu(e) ? 1 : 0;
  if (e != null) {
      if (e = e.$$typeof,
      e === bl)
          return 11;
      if (e === Ol)
          return 14
  }
  return 2
}
function Gt(e, t) {
  var n = e.alternate;
  return n === null ? (n = Qe(e.tag, t, e.key, e.mode),
  n.elementType = e.elementType,
  n.type = e.type,
  n.stateNode = e.stateNode,
  n.alternate = e,
  e.alternate = n) : (n.pendingProps = t,
  n.type = e.type,
  n.flags = 0,
  n.subtreeFlags = 0,
  n.deletions = null),
  n.flags = e.flags & 14680064,
  n.childLanes = e.childLanes,
  n.lanes = e.lanes,
  n.child = e.child,
  n.memoizedProps = e.memoizedProps,
  n.memoizedState = e.memoizedState,
  n.updateQueue = e.updateQueue,
  t = e.dependencies,
  n.dependencies = t === null ? null : {
      lanes: t.lanes,
      firstContext: t.firstContext
  },
  n.sibling = e.sibling,
  n.index = e.index,
  n.ref = e.ref,
  n
}
function io(e, t, n, r, i, o) {
  var a = 2;
  if (r = e,
  typeof e == "function")
      mu(e) && (a = 1);
  else if (typeof e == "string")
      a = 5;
  else
      e: switch (e) {
      case Vn:
          return vn(n.children, i, o, t);
      case Rl:
          a = 8,
          i |= 8;
          break;
      case fs:
          return e = Qe(12, n, t, i | 2),
          e.elementType = fs,
          e.lanes = o,
          e;
      case ms:
          return e = Qe(13, n, t, i),
          e.elementType = ms,
          e.lanes = o,
          e;
      case hs:
          return e = Qe(19, n, t, i),
          e.elementType = hs,
          e.lanes = o,
          e;
      case e1:
          return na(n, i, o, t);
      default:
          if (typeof e == "object" && e !== null)
              switch (e.$$typeof) {
              case qd:
                  a = 10;
                  break e;
              case Jd:
                  a = 9;
                  break e;
              case bl:
                  a = 11;
                  break e;
              case Ol:
                  a = 14;
                  break e;
              case Rt:
                  a = 16,
                  r = null;
                  break e
              }
          throw Error(L(130, e == null ? e : typeof e, ""))
      }
  return t = Qe(a, n, t, i),
  t.elementType = e,
  t.type = r,
  t.lanes = o,
  t
}
function vn(e, t, n, r) {
  return e = Qe(7, e, r, t),
  e.lanes = n,
  e
}
function na(e, t, n, r) {
  return e = Qe(22, e, r, t),
  e.elementType = e1,
  e.lanes = n,
  e.stateNode = {
      isHidden: !1
  },
  e
}
function Wa(e, t, n) {
  return e = Qe(6, e, null, t),
  e.lanes = n,
  e
}
function Qa(e, t, n) {
  return t = Qe(4, e.children !== null ? e.children : [], e.key, t),
  t.lanes = n,
  t.stateNode = {
      containerInfo: e.containerInfo,
      pendingChildren: null,
      implementation: e.implementation
  },
  t
}
function hg(e, t, n, r, i) {
  this.tag = t,
  this.containerInfo = e,
  this.finishedWork = this.pingCache = this.current = this.pendingChildren = null,
  this.timeoutHandle = -1,
  this.callbackNode = this.pendingContext = this.context = null,
  this.callbackPriority = 0,
  this.eventTimes = Ta(0),
  this.expirationTimes = Ta(-1),
  this.entangledLanes = this.finishedLanes = this.mutableReadLanes = this.expiredLanes = this.pingedLanes = this.suspendedLanes = this.pendingLanes = 0,
  this.entanglements = Ta(0),
  this.identifierPrefix = r,
  this.onRecoverableError = i,
  this.mutableSourceEagerHydrationData = null
}
function hu(e, t, n, r, i, o, a, s, l) {
  return e = new hg(e,t,n,s,l),
  t === 1 ? (t = 1,
  o === !0 && (t |= 8)) : t = 0,
  o = Qe(3, null, null, t),
  e.current = o,
  o.stateNode = e,
  o.memoizedState = {
      element: r,
      isDehydrated: n,
      cache: null,
      transitions: null,
      pendingSuspenseBoundaries: null
  },
  Xl(o),
  e
}
function pg(e, t, n) {
  var r = 3 < arguments.length && arguments[3] !== void 0 ? arguments[3] : null;
  return {
      $$typeof: On,
      key: r == null ? null : "" + r,
      children: e,
      containerInfo: t,
      implementation: n
  }
}
function Gf(e) {
  if (!e)
      return Yt;
  e = e._reactInternals;
  e: {
      if (Tn(e) !== e || e.tag !== 1)
          throw Error(L(170));
      var t = e;
      do {
          switch (t.tag) {
          case 3:
              t = t.stateNode.context;
              break e;
          case 1:
              if (Oe(t.type)) {
                  t = t.stateNode.__reactInternalMemoizedMergedChildContext;
                  break e
              }
          }
          t = t.return
      } while (t !== null);
      throw Error(L(171))
  }
  if (e.tag === 1) {
      var n = e.type;
      if (Oe(n))
          return Z1(e, n, t)
  }
  return t
}
function Wf(e, t, n, r, i, o, a, s, l) {
  return e = hu(n, r, !0, e, i, o, a, s, l),
  e.context = Gf(null),
  n = e.current,
  r = Ae(),
  i = Zt(n),
  o = xt(r, i),
  o.callback = t != null ? t : null,
  $t(n, o, i),
  e.current.lanes = i,
  gi(e, i, r),
  Ve(e, r),
  e
}
function ra(e, t, n, r) {
  var i = t.current
    , o = Ae()
    , a = Zt(i);
  return n = Gf(n),
  t.context === null ? t.context = n : t.pendingContext = n,
  t = xt(o, a),
  t.payload = {
      element: e
  },
  r = r === void 0 ? null : r,
  r !== null && (t.callback = r),
  e = $t(i, t, a),
  e !== null && (it(e, i, a, o),
  qi(e, i, a)),
  a
}
function bo(e) {
  if (e = e.current,
  !e.child)
      return null;
  switch (e.child.tag) {
  case 5:
      return e.child.stateNode;
  default:
      return e.child.stateNode
  }
}
function Qc(e, t) {
  if (e = e.memoizedState,
  e !== null && e.dehydrated !== null) {
      var n = e.retryLane;
      e.retryLane = n !== 0 && n < t ? n : t
  }
}
function pu(e, t) {
  Qc(e, t),
  (e = e.alternate) && Qc(e, t)
}
function gg() {
  return null
}
var Qf = typeof reportError == "function" ? reportError : function(e) {
  console.error(e)
}
;
function gu(e) {
  this._internalRoot = e
}
ia.prototype.render = gu.prototype.render = function(e) {
  var t = this._internalRoot;
  if (t === null)
      throw Error(L(409));
  ra(e, t, null, null)
}
;
ia.prototype.unmount = gu.prototype.unmount = function() {
  var e = this._internalRoot;
  if (e !== null) {
      this._internalRoot = null;
      var t = e.containerInfo;
      An(function() {
          ra(null, e, null, null)
      }),
      t[Nt] = null
  }
}
;
function ia(e) {
  this._internalRoot = e
}
ia.prototype.unstable_scheduleHydration = function(e) {
  if (e) {
      var t = C1();
      e = {
          blockedOn: null,
          target: e,
          priority: t
      };
      for (var n = 0; n < Vt.length && t !== 0 && t < Vt[n].priority; n++)
          ;
      Vt.splice(n, 0, e),
      n === 0 && A1(e)
  }
}
;
function yu(e) {
  return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11)
}
function oa(e) {
  return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11 && (e.nodeType !== 8 || e.nodeValue !== " react-mount-point-unstable "))
}
function Kc() {}
function yg(e, t, n, r, i) {
  if (i) {
      if (typeof r == "function") {
          var o = r;
          r = function() {
              var u = bo(a);
              o.call(u)
          }
      }
      var a = Wf(t, r, e, 0, null, !1, !1, "", Kc);
      return e._reactRootContainer = a,
      e[Nt] = a.current,
      Jr(e.nodeType === 8 ? e.parentNode : e),
      An(),
      a
  }
  for (; i = e.lastChild; )
      e.removeChild(i);
  if (typeof r == "function") {
      var s = r;
      r = function() {
          var u = bo(l);
          s.call(u)
      }
  }
  var l = hu(e, 0, !1, null, null, !1, !1, "", Kc);
  return e._reactRootContainer = l,
  e[Nt] = l.current,
  Jr(e.nodeType === 8 ? e.parentNode : e),
  An(function() {
      ra(t, l, n, r)
  }),
  l
}
function aa(e, t, n, r, i) {
  var o = n._reactRootContainer;
  if (o) {
      var a = o;
      if (typeof i == "function") {
          var s = i;
          i = function() {
              var l = bo(a);
              s.call(l)
          }
      }
      ra(t, a, e, i)
  } else
      a = yg(n, t, e, i, r);
  return bo(a)
}
E1 = function(e) {
  switch (e.tag) {
  case 3:
      var t = e.stateNode;
      if (t.current.memoizedState.isDehydrated) {
          var n = Mr(t.pendingLanes);
          n !== 0 && (jl(t, n | 1),
          Ve(t, ie()),
          (B & 6) === 0 && (sr = ie() + 500,
          tn()))
      }
      break;
  case 13:
      An(function() {
          var r = Ct(e, 1);
          if (r !== null) {
              var i = Ae();
              it(r, e, 1, i)
          }
      }),
      pu(e, 1)
  }
}
;
Il = function(e) {
  if (e.tag === 13) {
      var t = Ct(e, 134217728);
      if (t !== null) {
          var n = Ae();
          it(t, e, 134217728, n)
      }
      pu(e, 134217728)
  }
}
;
N1 = function(e) {
  if (e.tag === 13) {
      var t = Zt(e)
        , n = Ct(e, t);
      if (n !== null) {
          var r = Ae();
          it(n, e, t, r)
      }
      pu(e, t)
  }
}
;
C1 = function() {
  return Z
}
;
P1 = function(e, t) {
  var n = Z;
  try {
      return Z = e,
      t()
  } finally {
      Z = n
  }
}
;
Cs = function(e, t, n) {
  switch (t) {
  case "input":
      if (ys(e, n),
      t = n.name,
      n.type === "radio" && t != null) {
          for (n = e; n.parentNode; )
              n = n.parentNode;
          for (n = n.querySelectorAll("input[name=" + JSON.stringify("" + t) + '][type="radio"]'),
          t = 0; t < n.length; t++) {
              var r = n[t];
              if (r !== e && r.form === e.form) {
                  var i = Yo(r);
                  if (!i)
                      throw Error(L(90));
                  n1(r),
                  ys(r, i)
              }
          }
      }
      break;
  case "textarea":
      i1(e, n);
      break;
  case "select":
      t = n.value,
      t != null && Kn(e, !!n.multiple, t, !1)
  }
}
;
d1 = cu;
f1 = An;
var vg = {
  usingClientEntryPoint: !1,
  Events: [vi, Fn, Yo, u1, c1, cu]
}
, Cr = {
  findFiberByHostInstance: mn,
  bundleType: 0,
  version: "18.3.1",
  rendererPackageName: "react-dom"
}
, xg = {
  bundleType: Cr.bundleType,
  version: Cr.version,
  rendererPackageName: Cr.rendererPackageName,
  rendererConfig: Cr.rendererConfig,
  overrideHookState: null,
  overrideHookStateDeletePath: null,
  overrideHookStateRenamePath: null,
  overrideProps: null,
  overridePropsDeletePath: null,
  overridePropsRenamePath: null,
  setErrorHandler: null,
  setSuspenseHandler: null,
  scheduleUpdate: null,
  currentDispatcherRef: kt.ReactCurrentDispatcher,
  findHostInstanceByFiber: function(e) {
      return e = p1(e),
      e === null ? null : e.stateNode
  },
  findFiberByHostInstance: Cr.findFiberByHostInstance || gg,
  findHostInstancesForRefresh: null,
  scheduleRefresh: null,
  scheduleRoot: null,
  setRefreshHandler: null,
  getCurrentFiber: null,
  reconcilerVersion: "18.3.1-next-f1338f8080-20240426"
};
if (typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ < "u") {
  var Bi = __REACT_DEVTOOLS_GLOBAL_HOOK__;
  if (!Bi.isDisabled && Bi.supportsFiber)
      try {
          Go = Bi.inject(xg),
          ct = Bi
      } catch {}
}
Be.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = vg;
Be.createPortal = function(e, t) {
  var n = 2 < arguments.length && arguments[2] !== void 0 ? arguments[2] : null;
  if (!yu(t))
      throw Error(L(200));
  return pg(e, t, null, n)
}
;
Be.createRoot = function(e, t) {
  if (!yu(e))
      throw Error(L(299));
  var n = !1
    , r = ""
    , i = Qf;
  return t != null && (t.unstable_strictMode === !0 && (n = !0),
  t.identifierPrefix !== void 0 && (r = t.identifierPrefix),
  t.onRecoverableError !== void 0 && (i = t.onRecoverableError)),
  t = hu(e, 1, !1, null, null, n, !1, r, i),
  e[Nt] = t.current,
  Jr(e.nodeType === 8 ? e.parentNode : e),
  new gu(t)
}
;
Be.findDOMNode = function(e) {
  if (e == null)
      return null;
  if (e.nodeType === 1)
      return e;
  var t = e._reactInternals;
  if (t === void 0)
      throw typeof e.render == "function" ? Error(L(188)) : (e = Object.keys(e).join(","),
      Error(L(268, e)));
  return e = p1(t),
  e = e === null ? null : e.stateNode,
  e
}
;
Be.flushSync = function(e) {
  return An(e)
}
;
Be.hydrate = function(e, t, n) {
  if (!oa(t))
      throw Error(L(200));
  return aa(null, e, t, !0, n)
}
;
Be.hydrateRoot = function(e, t, n) {
  if (!yu(e))
      throw Error(L(405));
  var r = n != null && n.hydratedSources || null
    , i = !1
    , o = ""
    , a = Qf;
  if (n != null && (n.unstable_strictMode === !0 && (i = !0),
  n.identifierPrefix !== void 0 && (o = n.identifierPrefix),
  n.onRecoverableError !== void 0 && (a = n.onRecoverableError)),
  t = Wf(t, null, e, 1, n != null ? n : null, i, !1, o, a),
  e[Nt] = t.current,
  Jr(e),
  r)
      for (e = 0; e < r.length; e++)
          n = r[e],
          i = n._getVersion,
          i = i(n._source),
          t.mutableSourceEagerHydrationData == null ? t.mutableSourceEagerHydrationData = [n, i] : t.mutableSourceEagerHydrationData.push(n, i);
  return new ia(t)
}
;
Be.render = function(e, t, n) {
  if (!oa(t))
      throw Error(L(200));
  return aa(null, e, t, !1, n)
}
;
Be.unmountComponentAtNode = function(e) {
  if (!oa(e))
      throw Error(L(40));
  return e._reactRootContainer ? (An(function() {
      aa(null, null, e, !1, function() {
          e._reactRootContainer = null,
          e[Nt] = null
      })
  }),
  !0) : !1
}
;
Be.unstable_batchedUpdates = cu;
Be.unstable_renderSubtreeIntoContainer = function(e, t, n, r) {
  if (!oa(n))
      throw Error(L(200));
  if (e == null || e._reactInternals === void 0)
      throw Error(L(38));
  return aa(e, t, n, !1, r)
}
;
Be.version = "18.3.1-next-f1338f8080-20240426";
(function(e) {
  function t() {
      if (!(typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ > "u" || typeof __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE != "function"))
          try {
              __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE(t)
          } catch (n) {
              console.error(n)
          }
  }
  t(),
  e.exports = Be
}
)(Zo);
const wg = El(Zo.exports)
, Sg = zd({
  __proto__: null,
  default: wg
}, [Zo.exports]);
/**
* @remix-run/router v1.19.1
*
* Copyright (c) Remix Software Inc.
*
* This source code is licensed under the MIT license found in the
* LICENSE.md file in the root directory of this source tree.
*
* @license MIT
*/
function li() {
  return li = Object.assign ? Object.assign.bind() : function(e) {
      for (var t = 1; t < arguments.length; t++) {
          var n = arguments[t];
          for (var r in n)
              Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r])
      }
      return e
  }
  ,
  li.apply(this, arguments)
}
var Ft;
(function(e) {
  e.Pop = "POP",
  e.Push = "PUSH",
  e.Replace = "REPLACE"
}
)(Ft || (Ft = {}));
const Yc = "popstate";
function Eg(e) {
  e === void 0 && (e = {});
  function t(r, i) {
      let {pathname: o, search: a, hash: s} = r.location;
      return rl("", {
          pathname: o,
          search: a,
          hash: s
      }, i.state && i.state.usr || null, i.state && i.state.key || "default")
  }
  function n(r, i) {
      return typeof i == "string" ? i : Yf(i)
  }
  return Cg(t, n, null, e)
}
function fe(e, t) {
  if (e === !1 || e === null || typeof e > "u")
      throw new Error(t)
}
function Kf(e, t) {
  if (!e) {
      typeof console < "u" && console.warn(t);
      try {
          throw new Error(t)
      } catch {}
  }
}
function Ng() {
  return Math.random().toString(36).substr(2, 8)
}
function Xc(e, t) {
  return {
      usr: e.state,
      key: e.key,
      idx: t
  }
}
function rl(e, t, n, r) {
  return n === void 0 && (n = null),
  li({
      pathname: typeof e == "string" ? e : e.pathname,
      search: "",
      hash: ""
  }, typeof t == "string" ? hr(t) : t, {
      state: n,
      key: t && t.key || r || Ng()
  })
}
function Yf(e) {
  let {pathname: t="/", search: n="", hash: r=""} = e;
  return n && n !== "?" && (t += n.charAt(0) === "?" ? n : "?" + n),
  r && r !== "#" && (t += r.charAt(0) === "#" ? r : "#" + r),
  t
}
function hr(e) {
  let t = {};
  if (e) {
      let n = e.indexOf("#");
      n >= 0 && (t.hash = e.substr(n),
      e = e.substr(0, n));
      let r = e.indexOf("?");
      r >= 0 && (t.search = e.substr(r),
      e = e.substr(0, r)),
      e && (t.pathname = e)
  }
  return t
}
function Cg(e, t, n, r) {
  r === void 0 && (r = {});
  let {window: i=document.defaultView, v5Compat: o=!1} = r
    , a = i.history
    , s = Ft.Pop
    , l = null
    , u = f();
  u == null && (u = 0,
  a.replaceState(li({}, a.state, {
      idx: u
  }), ""));
  function f() {
      return (a.state || {
          idx: null
      }).idx
  }
  function d() {
      s = Ft.Pop;
      let P = f()
        , y = P == null ? null : P - u;
      u = P,
      l && l({
          action: s,
          location: x.location,
          delta: y
      })
  }
  function m(P, y) {
      s = Ft.Push;
      let h = rl(x.location, P, y);
      n && n(h, P),
      u = f() + 1;
      let g = Xc(h, u)
        , S = x.createHref(h);
      try {
          a.pushState(g, "", S)
      } catch (M) {
          if (M instanceof DOMException && M.name === "DataCloneError")
              throw M;
          i.location.assign(S)
      }
      o && l && l({
          action: s,
          location: x.location,
          delta: 1
      })
  }
  function p(P, y) {
      s = Ft.Replace;
      let h = rl(x.location, P, y);
      n && n(h, P),
      u = f();
      let g = Xc(h, u)
        , S = x.createHref(h);
      a.replaceState(g, "", S),
      o && l && l({
          action: s,
          location: x.location,
          delta: 0
      })
  }
  function v(P) {
      let y = i.location.origin !== "null" ? i.location.origin : i.location.href
        , h = typeof P == "string" ? P : Yf(P);
      return h = h.replace(/ $/, "%20"),
      fe(y, "No window.location.(origin|href) available to create URL for href: " + h),
      new URL(h,y)
  }
  let x = {
      get action() {
          return s
      },
      get location() {
          return e(i, a)
      },
      listen(P) {
          if (l)
              throw new Error("A history only accepts one active listener");
          return i.addEventListener(Yc, d),
          l = P,
          () => {
              i.removeEventListener(Yc, d),
              l = null
          }
      },
      createHref(P) {
          return t(i, P)
      },
      createURL: v,
      encodeLocation(P) {
          let y = v(P);
          return {
              pathname: y.pathname,
              search: y.search,
              hash: y.hash
          }
      },
      push: m,
      replace: p,
      go(P) {
          return a.go(P)
      }
  };
  return x
}
var qc;
(function(e) {
  e.data = "data",
  e.deferred = "deferred",
  e.redirect = "redirect",
  e.error = "error"
}
)(qc || (qc = {}));
function Pg(e, t, n) {
  return n === void 0 && (n = "/"),
  Ag(e, t, n, !1)
}
function Ag(e, t, n, r) {
  let i = typeof t == "string" ? hr(t) : t
    , o = Jf(i.pathname || "/", n);
  if (o == null)
      return null;
  let a = Xf(e);
  kg(a);
  let s = null;
  for (let l = 0; s == null && l < a.length; ++l) {
      let u = Fg(o);
      s = jg(a[l], u, r)
  }
  return s
}
function Xf(e, t, n, r) {
  t === void 0 && (t = []),
  n === void 0 && (n = []),
  r === void 0 && (r = "");
  let i = (o, a, s) => {
      let l = {
          relativePath: s === void 0 ? o.path || "" : s,
          caseSensitive: o.caseSensitive === !0,
          childrenIndex: a,
          route: o
      };
      l.relativePath.startsWith("/") && (fe(l.relativePath.startsWith(r), 'Absolute route path "' + l.relativePath + '" nested under path ' + ('"' + r + '" is not valid. An absolute child route path ') + "must start with the combined path of all its parent routes."),
      l.relativePath = l.relativePath.slice(r.length));
      let u = xn([r, l.relativePath])
        , f = n.concat(l);
      o.children && o.children.length > 0 && (fe(o.index !== !0, "Index routes must not have child routes. Please remove " + ('all child routes from route path "' + u + '".')),
      Xf(o.children, t, f, u)),
      !(o.path == null && !o.index) && t.push({
          path: u,
          score: Vg(u, o.index),
          routesMeta: f
      })
  }
  ;
  return e.forEach( (o, a) => {
      var s;
      if (o.path === "" || !((s = o.path) != null && s.includes("?")))
          i(o, a);
      else
          for (let l of qf(o.path))
              i(o, a, l)
  }
  ),
  t
}
function qf(e) {
  let t = e.split("/");
  if (t.length === 0)
      return [];
  let[n,...r] = t
    , i = n.endsWith("?")
    , o = n.replace(/\?$/, "");
  if (r.length === 0)
      return i ? [o, ""] : [o];
  let a = qf(r.join("/"))
    , s = [];
  return s.push(...a.map(l => l === "" ? o : [o, l].join("/"))),
  i && s.push(...a),
  s.map(l => e.startsWith("/") && l === "" ? "/" : l)
}
function kg(e) {
  e.sort( (t, n) => t.score !== n.score ? n.score - t.score : Dg(t.routesMeta.map(r => r.childrenIndex), n.routesMeta.map(r => r.childrenIndex)))
}
const Tg = /^:[\w-]+$/
, Mg = 3
, Lg = 2
, Rg = 1
, bg = 10
, Og = -2
, Jc = e => e === "*";
function Vg(e, t) {
  let n = e.split("/")
    , r = n.length;
  return n.some(Jc) && (r += Og),
  t && (r += Lg),
  n.filter(i => !Jc(i)).reduce( (i, o) => i + (Tg.test(o) ? Mg : o === "" ? Rg : bg), r)
}
function Dg(e, t) {
  return e.length === t.length && e.slice(0, -1).every( (r, i) => r === t[i]) ? e[e.length - 1] - t[t.length - 1] : 0
}
function jg(e, t, n) {
  n === void 0 && (n = !1);
  let {routesMeta: r} = e
    , i = {}
    , o = "/"
    , a = [];
  for (let s = 0; s < r.length; ++s) {
      let l = r[s]
        , u = s === r.length - 1
        , f = o === "/" ? t : t.slice(o.length) || "/"
        , d = e0({
          path: l.relativePath,
          caseSensitive: l.caseSensitive,
          end: u
      }, f)
        , m = l.route;
      if (!d && u && n && !r[r.length - 1].route.index && (d = e0({
          path: l.relativePath,
          caseSensitive: l.caseSensitive,
          end: !1
      }, f)),
      !d)
          return null;
      Object.assign(i, d.params),
      a.push({
          params: i,
          pathname: xn([o, d.pathname]),
          pathnameBase: Ug(xn([o, d.pathnameBase])),
          route: m
      }),
      d.pathnameBase !== "/" && (o = xn([o, d.pathnameBase]))
  }
  return a
}
function e0(e, t) {
  typeof e == "string" && (e = {
      path: e,
      caseSensitive: !1,
      end: !0
  });
  let[n,r] = Ig(e.path, e.caseSensitive, e.end)
    , i = t.match(n);
  if (!i)
      return null;
  let o = i[0]
    , a = o.replace(/(.)\/+$/, "$1")
    , s = i.slice(1);
  return {
      params: r.reduce( (u, f, d) => {
          let {paramName: m, isOptional: p} = f;
          if (m === "*") {
              let x = s[d] || "";
              a = o.slice(0, o.length - x.length).replace(/(.)\/+$/, "$1")
          }
          const v = s[d];
          return p && !v ? u[m] = void 0 : u[m] = (v || "").replace(/%2F/g, "/"),
          u
      }
      , {}),
      pathname: o,
      pathnameBase: a,
      pattern: e
  }
}
function Ig(e, t, n) {
  t === void 0 && (t = !1),
  n === void 0 && (n = !0),
  Kf(e === "*" || !e.endsWith("*") || e.endsWith("/*"), 'Route path "' + e + '" will be treated as if it were ' + ('"' + e.replace(/\*$/, "/*") + '" because the `*` character must ') + "always follow a `/` in the pattern. To get rid of this warning, " + ('please change the route path to "' + e.replace(/\*$/, "/*") + '".'));
  let r = []
    , i = "^" + e.replace(/\/*\*?$/, "").replace(/^\/*/, "/").replace(/[\\.*+^${}|()[\]]/g, "\\$&").replace(/\/:([\w-]+)(\?)?/g, (a, s, l) => (r.push({
      paramName: s,
      isOptional: l != null
  }),
  l ? "/?([^\\/]+)?" : "/([^\\/]+)"));
  return e.endsWith("*") ? (r.push({
      paramName: "*"
  }),
  i += e === "*" || e === "/*" ? "(.*)$" : "(?:\\/(.+)|\\/*)$") : n ? i += "\\/*$" : e !== "" && e !== "/" && (i += "(?:(?=\\/|$))"),
  [new RegExp(i,t ? void 0 : "i"), r]
}
function Fg(e) {
  try {
      return e.split("/").map(t => decodeURIComponent(t).replace(/\//g, "%2F")).join("/")
  } catch (t) {
      return Kf(!1, 'The URL path "' + e + '" could not be decoded because it is is a malformed URL segment. This is probably due to a bad percent ' + ("encoding (" + t + ").")),
      e
  }
}
function Jf(e, t) {
  if (t === "/")
      return e;
  if (!e.toLowerCase().startsWith(t.toLowerCase()))
      return null;
  let n = t.endsWith("/") ? t.length - 1 : t.length
    , r = e.charAt(n);
  return r && r !== "/" ? null : e.slice(n) || "/"
}
function _g(e, t) {
  t === void 0 && (t = "/");
  let {pathname: n, search: r="", hash: i=""} = typeof e == "string" ? hr(e) : e;
  return {
      pathname: n ? n.startsWith("/") ? n : zg(n, t) : t,
      search: Zg(r),
      hash: Gg(i)
  }
}
function zg(e, t) {
  let n = t.replace(/\/+$/, "").split("/");
  return e.split("/").forEach(i => {
      i === ".." ? n.length > 1 && n.pop() : i !== "." && n.push(i)
  }
  ),
  n.length > 1 ? n.join("/") : "/"
}
function Ka(e, t, n, r) {
  return "Cannot include a '" + e + "' character in a manually specified " + ("`to." + t + "` field [" + JSON.stringify(r) + "].  Please separate it out to the ") + ("`to." + n + "` field. Alternatively you may provide the full path as ") + 'a string in <Link to="..."> and the router will parse it for you.'
}
function Hg(e) {
  return e.filter( (t, n) => n === 0 || t.route.path && t.route.path.length > 0)
}
function Bg(e, t) {
  let n = Hg(e);
  return t ? n.map( (r, i) => i === n.length - 1 ? r.pathname : r.pathnameBase) : n.map(r => r.pathnameBase)
}
function $g(e, t, n, r) {
  r === void 0 && (r = !1);
  let i;
  typeof e == "string" ? i = hr(e) : (i = li({}, e),
  fe(!i.pathname || !i.pathname.includes("?"), Ka("?", "pathname", "search", i)),
  fe(!i.pathname || !i.pathname.includes("#"), Ka("#", "pathname", "hash", i)),
  fe(!i.search || !i.search.includes("#"), Ka("#", "search", "hash", i)));
  let o = e === "" || i.pathname === "", a = o ? "/" : i.pathname, s;
  if (a == null)
      s = n;
  else {
      let d = t.length - 1;
      if (!r && a.startsWith("..")) {
          let m = a.split("/");
          for (; m[0] === ".."; )
              m.shift(),
              d -= 1;
          i.pathname = m.join("/")
      }
      s = d >= 0 ? t[d] : "/"
  }
  let l = _g(i, s)
    , u = a && a !== "/" && a.endsWith("/")
    , f = (o || a === ".") && n.endsWith("/");
  return !l.pathname.endsWith("/") && (u || f) && (l.pathname += "/"),
  l
}
const xn = e => e.join("/").replace(/\/\/+/g, "/")
, Ug = e => e.replace(/\/+$/, "").replace(/^\/*/, "/")
, Zg = e => !e || e === "?" ? "" : e.startsWith("?") ? e : "?" + e
, Gg = e => !e || e === "#" ? "" : e.startsWith("#") ? e : "#" + e;
function Wg(e) {
  return e != null && typeof e.status == "number" && typeof e.statusText == "string" && typeof e.internal == "boolean" && "data"in e
}
const Qg = ["post", "put", "patch", "delete"];
[...Qg];
var sa = {
  exports: {}
}
, la = {};
/**
* @license React
* react-jsx-runtime.production.min.js
*
* Copyright (c) Facebook, Inc. and its affiliates.
*
* This source code is licensed under the MIT license found in the
* LICENSE file in the root directory of this source tree.
*/
var Kg = E.exports
, Yg = Symbol.for("react.element")
, Xg = Symbol.for("react.fragment")
, qg = Object.prototype.hasOwnProperty
, Jg = Kg.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner
, e4 = {
  key: !0,
  ref: !0,
  __self: !0,
  __source: !0
};
function em(e, t, n) {
  var r, i = {}, o = null, a = null;
  n !== void 0 && (o = "" + n),
  t.key !== void 0 && (o = "" + t.key),
  t.ref !== void 0 && (a = t.ref);
  for (r in t)
      qg.call(t, r) && !e4.hasOwnProperty(r) && (i[r] = t[r]);
  if (e && e.defaultProps)
      for (r in t = e.defaultProps,
      t)
          i[r] === void 0 && (i[r] = t[r]);
  return {
      $$typeof: Yg,
      type: e,
      key: o,
      ref: a,
      props: i,
      _owner: Jg.current
  }
}
la.Fragment = Xg;
la.jsx = em;
la.jsxs = em;
(function(e) {
  e.exports = la
}
)(sa);
const ui = sa.exports.Fragment
, c = sa.exports.jsx
, w = sa.exports.jsxs;
/**
* React Router v6.26.1
*
* Copyright (c) Remix Software Inc.
*
* This source code is licensed under the MIT license found in the
* LICENSE.md file in the root directory of this source tree.
*
* @license MIT
*/
function ci() {
  return ci = Object.assign ? Object.assign.bind() : function(e) {
      for (var t = 1; t < arguments.length; t++) {
          var n = arguments[t];
          for (var r in n)
              Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r])
      }
      return e
  }
  ,
  ci.apply(this, arguments)
}
const vu = E.exports.createContext(null)
, t4 = E.exports.createContext(null)
, ua = E.exports.createContext(null)
, ca = E.exports.createContext(null)
, pr = E.exports.createContext({
  outlet: null,
  matches: [],
  isDataRoute: !1
})
, tm = E.exports.createContext(null);
function da() {
  return E.exports.useContext(ca) != null
}
function xu() {
  return da() || fe(!1),
  E.exports.useContext(ca).location
}
function nm(e) {
  E.exports.useContext(ua).static || E.exports.useLayoutEffect(e)
}
function rm() {
  let {isDataRoute: e} = E.exports.useContext(pr);
  return e ? h4() : n4()
}
function n4() {
  da() || fe(!1);
  let e = E.exports.useContext(vu)
    , {basename: t, future: n, navigator: r} = E.exports.useContext(ua)
    , {matches: i} = E.exports.useContext(pr)
    , {pathname: o} = xu()
    , a = JSON.stringify(Bg(i, n.v7_relativeSplatPath))
    , s = E.exports.useRef(!1);
  return nm( () => {
      s.current = !0
  }
  ),
  E.exports.useCallback(function(u, f) {
      if (f === void 0 && (f = {}),
      !s.current)
          return;
      if (typeof u == "number") {
          r.go(u);
          return
      }
      let d = $g(u, JSON.parse(a), o, f.relative === "path");
      e == null && t !== "/" && (d.pathname = d.pathname === "/" ? t : xn([t, d.pathname])),
      (f.replace ? r.replace : r.push)(d, f.state, f)
  }, [t, r, a, o, e])
}
function r4(e, t) {
  return i4(e, t)
}
function i4(e, t, n, r) {
  da() || fe(!1);
  let {navigator: i} = E.exports.useContext(ua)
    , {matches: o} = E.exports.useContext(pr)
    , a = o[o.length - 1]
    , s = a ? a.params : {};
  a && a.pathname;
  let l = a ? a.pathnameBase : "/";
  a && a.route;
  let u = xu(), f;
  if (t) {
      var d;
      let P = typeof t == "string" ? hr(t) : t;
      l === "/" || ((d = P.pathname) == null ? void 0 : d.startsWith(l)) || fe(!1),
      f = P
  } else
      f = u;
  let m = f.pathname || "/"
    , p = m;
  if (l !== "/") {
      let P = l.replace(/^\//, "").split("/");
      p = "/" + m.replace(/^\//, "").split("/").slice(P.length).join("/")
  }
  let v = Pg(e, {
      pathname: p
  })
    , x = u4(v && v.map(P => Object.assign({}, P, {
      params: Object.assign({}, s, P.params),
      pathname: xn([l, i.encodeLocation ? i.encodeLocation(P.pathname).pathname : P.pathname]),
      pathnameBase: P.pathnameBase === "/" ? l : xn([l, i.encodeLocation ? i.encodeLocation(P.pathnameBase).pathname : P.pathnameBase])
  })), o, n, r);
  return t && x ? c(ca.Provider, {
      value: {
          location: ci({
              pathname: "/",
              search: "",
              hash: "",
              state: null,
              key: "default"
          }, f),
          navigationType: Ft.Pop
      },
      children: x
  }) : x
}
function o4() {
  let e = m4()
    , t = Wg(e) ? e.status + " " + e.statusText : e instanceof Error ? e.message : JSON.stringify(e)
    , n = e instanceof Error ? e.stack : null;
  return w(ui, {
      children: [c("h2", {
          children: "Unexpected Application Error!"
      }), c("h3", {
          style: {
              fontStyle: "italic"
          },
          children: t
      }), n ? c("pre", {
          style: {
              padding: "0.5rem",
              backgroundColor: "rgba(200,200,200, 0.5)"
          },
          children: n
      }) : null, null]
  })
}
const a4 = c(o4, {});
class s4 extends E.exports.Component {
  constructor(t) {
      super(t),
      this.state = {
          location: t.location,
          revalidation: t.revalidation,
          error: t.error
      }
  }
  static getDerivedStateFromError(t) {
      return {
          error: t
      }
  }
  static getDerivedStateFromProps(t, n) {
      return n.location !== t.location || n.revalidation !== "idle" && t.revalidation === "idle" ? {
          error: t.error,
          location: t.location,
          revalidation: t.revalidation
      } : {
          error: t.error !== void 0 ? t.error : n.error,
          location: n.location,
          revalidation: t.revalidation || n.revalidation
      }
  }
  componentDidCatch(t, n) {
      console.error("React Router caught the following error during render", t, n)
  }
  render() {
      return this.state.error !== void 0 ? c(pr.Provider, {
          value: this.props.routeContext,
          children: c(tm.Provider, {
              value: this.state.error,
              children: this.props.component
          })
      }) : this.props.children
  }
}
function l4(e) {
  let {routeContext: t, match: n, children: r} = e
    , i = E.exports.useContext(vu);
  return i && i.static && i.staticContext && (n.route.errorElement || n.route.ErrorBoundary) && (i.staticContext._deepestRenderedBoundaryId = n.route.id),
  c(pr.Provider, {
      value: t,
      children: r
  })
}
function u4(e, t, n, r) {
  var i;
  if (t === void 0 && (t = []),
  n === void 0 && (n = null),
  r === void 0 && (r = null),
  e == null) {
      var o;
      if (!n)
          return null;
      if (n.errors)
          e = n.matches;
      else if ((o = r) != null && o.v7_partialHydration && t.length === 0 && !n.initialized && n.matches.length > 0)
          e = n.matches;
      else
          return null
  }
  let a = e
    , s = (i = n) == null ? void 0 : i.errors;
  if (s != null) {
      let f = a.findIndex(d => d.route.id && (s == null ? void 0 : s[d.route.id]) !== void 0);
      f >= 0 || fe(!1),
      a = a.slice(0, Math.min(a.length, f + 1))
  }
  let l = !1
    , u = -1;
  if (n && r && r.v7_partialHydration)
      for (let f = 0; f < a.length; f++) {
          let d = a[f];
          if ((d.route.HydrateFallback || d.route.hydrateFallbackElement) && (u = f),
          d.route.id) {
              let {loaderData: m, errors: p} = n
                , v = d.route.loader && m[d.route.id] === void 0 && (!p || p[d.route.id] === void 0);
              if (d.route.lazy || v) {
                  l = !0,
                  u >= 0 ? a = a.slice(0, u + 1) : a = [a[0]];
                  break
              }
          }
      }
  return a.reduceRight( (f, d, m) => {
      let p, v = !1, x = null, P = null;
      n && (p = s && d.route.id ? s[d.route.id] : void 0,
      x = d.route.errorElement || a4,
      l && (u < 0 && m === 0 ? (p4("route-fallback", !1),
      v = !0,
      P = null) : u === m && (v = !0,
      P = d.route.hydrateFallbackElement || null)));
      let y = t.concat(a.slice(0, m + 1))
        , h = () => {
          let g;
          return p ? g = x : v ? g = P : d.route.Component ? g = E.exports.createElement(d.route.Component, null) : d.route.element ? g = d.route.element : g = f,
          c(l4, {
              match: d,
              routeContext: {
                  outlet: f,
                  matches: y,
                  isDataRoute: n != null
              },
              children: g
          })
      }
      ;
      return n && (d.route.ErrorBoundary || d.route.errorElement || m === 0) ? c(s4, {
          location: n.location,
          revalidation: n.revalidation,
          component: x,
          error: p,
          children: h(),
          routeContext: {
              outlet: null,
              matches: y,
              isDataRoute: !0
          }
      }) : h()
  }
  , null)
}
var im = function(e) {
  return e.UseBlocker = "useBlocker",
  e.UseRevalidator = "useRevalidator",
  e.UseNavigateStable = "useNavigate",
  e
}(im || {})
, Oo = function(e) {
  return e.UseBlocker = "useBlocker",
  e.UseLoaderData = "useLoaderData",
  e.UseActionData = "useActionData",
  e.UseRouteError = "useRouteError",
  e.UseNavigation = "useNavigation",
  e.UseRouteLoaderData = "useRouteLoaderData",
  e.UseMatches = "useMatches",
  e.UseRevalidator = "useRevalidator",
  e.UseNavigateStable = "useNavigate",
  e.UseRouteId = "useRouteId",
  e
}(Oo || {});
function c4(e) {
  let t = E.exports.useContext(vu);
  return t || fe(!1),
  t
}
function d4(e) {
  let t = E.exports.useContext(t4);
  return t || fe(!1),
  t
}
function f4(e) {
  let t = E.exports.useContext(pr);
  return t || fe(!1),
  t
}
function om(e) {
  let t = f4()
    , n = t.matches[t.matches.length - 1];
  return n.route.id || fe(!1),
  n.route.id
}
function m4() {
  var e;
  let t = E.exports.useContext(tm)
    , n = d4(Oo.UseRouteError)
    , r = om(Oo.UseRouteError);
  return t !== void 0 ? t : (e = n.errors) == null ? void 0 : e[r]
}
function h4() {
  let {router: e} = c4(im.UseNavigateStable)
    , t = om(Oo.UseNavigateStable)
    , n = E.exports.useRef(!1);
  return nm( () => {
      n.current = !0
  }
  ),
  E.exports.useCallback(function(i, o) {
      o === void 0 && (o = {}),
      n.current && (typeof i == "number" ? e.navigate(i) : e.navigate(i, ci({
          fromRouteId: t
      }, o)))
  }, [e, t])
}
const t0 = {};
function p4(e, t, n) {
  !t && !t0[e] && (t0[e] = !0)
}
const g4 = "startTransition";
kl[g4];
function mt(e) {
  fe(!1)
}
function y4(e) {
  let {basename: t="/", children: n=null, location: r, navigationType: i=Ft.Pop, navigator: o, static: a=!1, future: s} = e;
  da() && fe(!1);
  let l = t.replace(/^\/*/, "/")
    , u = E.exports.useMemo( () => ({
      basename: l,
      navigator: o,
      static: a,
      future: ci({
          v7_relativeSplatPath: !1
      }, s)
  }), [l, s, o, a]);
  typeof r == "string" && (r = hr(r));
  let {pathname: f="/", search: d="", hash: m="", state: p=null, key: v="default"} = r
    , x = E.exports.useMemo( () => {
      let P = Jf(f, l);
      return P == null ? null : {
          location: {
              pathname: P,
              search: d,
              hash: m,
              state: p,
              key: v
          },
          navigationType: i
      }
  }
  , [l, f, d, m, p, v, i]);
  return x == null ? null : c(ua.Provider, {
      value: u,
      children: c(ca.Provider, {
          children: n,
          value: x
      })
  })
}
function v4(e) {
  let {children: t, location: n} = e;
  return r4(il(t), n)
}
new Promise( () => {}
);
function il(e, t) {
  t === void 0 && (t = []);
  let n = [];
  return E.exports.Children.forEach(e, (r, i) => {
      if (!E.exports.isValidElement(r))
          return;
      let o = [...t, i];
      if (r.type === E.exports.Fragment) {
          n.push.apply(n, il(r.props.children, o));
          return
      }
      r.type !== mt && fe(!1),
      !r.props.index || !r.props.children || fe(!1);
      let a = {
          id: r.props.id || o.join("-"),
          caseSensitive: r.props.caseSensitive,
          element: r.props.element,
          Component: r.props.Component,
          index: r.props.index,
          path: r.props.path,
          loader: r.props.loader,
          action: r.props.action,
          errorElement: r.props.errorElement,
          ErrorBoundary: r.props.ErrorBoundary,
          hasErrorBoundary: r.props.ErrorBoundary != null || r.props.errorElement != null,
          shouldRevalidate: r.props.shouldRevalidate,
          handle: r.props.handle,
          lazy: r.props.lazy
      };
      r.props.children && (a.children = il(r.props.children, o)),
      n.push(a)
  }
  ),
  n
}
/**
* React Router DOM v6.26.1
*
* Copyright (c) Remix Software Inc.
*
* This source code is licensed under the MIT license found in the
* LICENSE.md file in the root directory of this source tree.
*
* @license MIT
*/
const x4 = "6";
try {
  window.__reactRouterVersion = x4
} catch {}
const w4 = "startTransition"
, n0 = kl[w4]
, S4 = "flushSync";
Sg[S4];
const E4 = "useId";
kl[E4];
function N4(e) {
  let {basename: t, children: n, future: r, window: i} = e
    , o = E.exports.useRef();
  o.current == null && (o.current = Eg({
      window: i,
      v5Compat: !0
  }));
  let a = o.current
    , [s,l] = E.exports.useState({
      action: a.action,
      location: a.location
  })
    , {v7_startTransition: u} = r || {}
    , f = E.exports.useCallback(d => {
      u && n0 ? n0( () => l(d)) : l(d)
  }
  , [l, u]);
  return E.exports.useLayoutEffect( () => a.listen(f), [a, f]),
  c(y4, {
      basename: t,
      children: n,
      location: s.location,
      navigationType: s.action,
      navigator: a,
      future: r
  })
}
var r0;
(function(e) {
  e.UseScrollRestoration = "useScrollRestoration",
  e.UseSubmit = "useSubmit",
  e.UseSubmitFetcher = "useSubmitFetcher",
  e.UseFetcher = "useFetcher",
  e.useViewTransitionState = "useViewTransitionState"
}
)(r0 || (r0 = {}));
var i0;
(function(e) {
  e.UseFetcher = "useFetcher",
  e.UseFetchers = "useFetchers",
  e.UseScrollRestoration = "useScrollRestoration"
}
)(i0 || (i0 = {}));
const oo = () => !window.invokeNative
, C4 = () => {}
;
async function z(e, t, n) {
  const r = {
      method: "post",
      body: JSON.stringify(t)
  };
  if (oo() && n)
      return n;
  const i = window.GetParentResourceName ? window.GetParentResourceName() : "nui-frame-app";
  return await (await fetch(`https://${i}/${e}`, r)).json()
}
const o0 = e => {
  let t;
  const n = new Set
    , r = (f, d) => {
      const m = typeof f == "function" ? f(t) : f;
      if (!Object.is(m, t)) {
          const p = t;
          t = (d != null ? d : typeof m != "object" || m === null) ? m : Object.assign({}, t, m),
          n.forEach(v => v(t, p))
      }
  }
    , i = () => t
    , l = {
      setState: r,
      getState: i,
      getInitialState: () => u,
      subscribe: f => (n.add(f),
      () => n.delete(f)),
      destroy: () => {
          n.clear()
      }
  }
    , u = t = e(r, i, l);
  return l
}
, P4 = e => e ? o0(e) : o0;
var am = {
  exports: {}
}
, sm = {}
, lm = {
  exports: {}
}
, um = {};
/**
* @license React
* use-sync-external-store-shim.production.min.js
*
* Copyright (c) Facebook, Inc. and its affiliates.
*
* This source code is licensed under the MIT license found in the
* LICENSE file in the root directory of this source tree.
*/
var lr = E.exports;
function A4(e, t) {
  return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var k4 = typeof Object.is == "function" ? Object.is : A4
, T4 = lr.useState
, M4 = lr.useEffect
, L4 = lr.useLayoutEffect
, R4 = lr.useDebugValue;
function b4(e, t) {
  var n = t()
    , r = T4({
      inst: {
          value: n,
          getSnapshot: t
      }
  })
    , i = r[0].inst
    , o = r[1];
  return L4(function() {
      i.value = n,
      i.getSnapshot = t,
      Ya(i) && o({
          inst: i
      })
  }, [e, n, t]),
  M4(function() {
      return Ya(i) && o({
          inst: i
      }),
      e(function() {
          Ya(i) && o({
              inst: i
          })
      })
  }, [e]),
  R4(n),
  n
}
function Ya(e) {
  var t = e.getSnapshot;
  e = e.value;
  try {
      var n = t();
      return !k4(e, n)
  } catch {
      return !0
  }
}
function O4(e, t) {
  return t()
}
var V4 = typeof window > "u" || typeof window.document > "u" || typeof window.document.createElement > "u" ? O4 : b4;
um.useSyncExternalStore = lr.useSyncExternalStore !== void 0 ? lr.useSyncExternalStore : V4;
(function(e) {
  e.exports = um
}
)(lm);
/**
* @license React
* use-sync-external-store-shim/with-selector.production.min.js
*
* Copyright (c) Facebook, Inc. and its affiliates.
*
* This source code is licensed under the MIT license found in the
* LICENSE file in the root directory of this source tree.
*/
var fa = E.exports
, D4 = lm.exports;
function j4(e, t) {
  return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var I4 = typeof Object.is == "function" ? Object.is : j4
, F4 = D4.useSyncExternalStore
, _4 = fa.useRef
, z4 = fa.useEffect
, H4 = fa.useMemo
, B4 = fa.useDebugValue;
sm.useSyncExternalStoreWithSelector = function(e, t, n, r, i) {
  var o = _4(null);
  if (o.current === null) {
      var a = {
          hasValue: !1,
          value: null
      };
      o.current = a
  } else
      a = o.current;
  o = H4(function() {
      function l(p) {
          if (!u) {
              if (u = !0,
              f = p,
              p = r(p),
              i !== void 0 && a.hasValue) {
                  var v = a.value;
                  if (i(v, p))
                      return d = v
              }
              return d = p
          }
          if (v = d,
          I4(f, p))
              return v;
          var x = r(p);
          return i !== void 0 && i(v, x) ? v : (f = p,
          d = x)
      }
      var u = !1, f, d, m = n === void 0 ? null : n;
      return [function() {
          return l(t())
      }
      , m === null ? void 0 : function() {
          return l(m())
      }
      ]
  }, [t, n, r, i]);
  var s = F4(e, o[0], o[1]);
  return z4(function() {
      a.hasValue = !0,
      a.value = s
  }, [s]),
  B4(s),
  s
}
;
(function(e) {
  e.exports = sm
}
)(am);
const $4 = El(am.exports)
, {useDebugValue: U4} = T
, {useSyncExternalStoreWithSelector: Z4} = $4;
const G4 = e => e;
function W4(e, t=G4, n) {
  const r = Z4(e.subscribe, e.getState, e.getServerState || e.getInitialState, t, n);
  return U4(r),
  r
}
const a0 = e => {
  const t = typeof e == "function" ? P4(e) : e
    , n = (r, i) => W4(t, r, i);
  return Object.assign(n, t),
  n
}
, Q4 = e => e ? a0(e) : a0;
var cm = e => Q4(e);
const oe = cm(e => ({
  radio: 1,
  setRadio: t => e({
      radio: t
  }),
  preset: {
      male: "",
      female: ""
  },
  setPreset: t => e({
      preset: t
  }),
  openedModal: !1,
  setOpenedModal: t => e({
      openedModal: t
  }),
  openedPermissionsModal: !1,
  setOpenedPermissionsModal: t => e({
      openedPermissionsModal: t
  }),
  openedPartnerModal: !1,
  setOpenedPartnerModal: t => e({
      openedPartnerModal: t
  }),
  partners: [],
  setPartners: t => e({
      partners: t
  }),
  openedEditGoal: !1,
  setOpenedEditGoal: t => e({
      openedEditGoal: t
  }),
  goals: {
      prize: "",
      my: [],
      faction: [],
      members: []
  },
  setGoals: t => e({
      goals: t
  }),
  openedNewGoal: !1,
  setOpenedNewGoal: t => e({
      openedNewGoal: t
  }),
  typeNewGoal: "",
  setTypeNewGoal: t => e({
      typeNewGoal: t
  }),
  contractModal: !1,
  setOpenedContractModal: t => e({
      contractModal: t
  }),
  user_id: 0,
  setUserId: t => e({
      user_id: t
  }),
  setCanWarn: t => e({
      canWarn: t
  }),
  canWarn: !1,
  avatar: "",
  setAvatar: t => e({
      avatar: t
  }),
  setWarnings: t => e({
      warnings: t
  }),
  warnings: [],
  orgBalance: 0,
  setOrgBalance: t => e({
      orgBalance: t
  }),
  playerBalance: 0,
  setPlayerBalance: t => e({
      playerBalance: t
  }),
  name: "fivecommunity",
  setName: t => e({
      name: t
  }),
  setWarningModalVisible: t => e({
      warningModalVisible: t
  }),
  warningModalVisible: !1,
  logo: "",
  setLogo: t => e({
      logo: t
  }),
  leader: "",
  members: 0,
  membersOnline: 0,
  goalReward: 0,
  setGoalReward: t => e({
      goalReward: t
  }),
  setMembers: t => e({
      members: t
  }),
  setMembersOnline: t => e({
      membersOnline: t
  }),
  setleader: t => e({
      leader: t
  }),
  orgName: "",
  setOrgName: t => e({
      orgName: t
  }),
  permissionsModalVisible: !1,
  setPermissionsModalVisible: t => e({
      permissionsModalVisible: t
  }),
  roleEdit: "",
  setRoleEdit: t => e({
      roleEdit: t
  }),
  setPermissions: t => e({
      permissions: t
  }),
  permissions: {
      name: !1,
      promote: !1,
      demote: !1,
      dismiss: !1,
      withdraw: !1,
      deposit: !1,
      message: !1,
      alerts: !1,
      invite: !1,
      leader: !1,
      chat: !1
  },
  roles: [],
  setRoles: t => e({
      roles: t
  }),
  discord: "",
  setDiscord: t => e({
      discord: t
  }),
  serverIcon: "",
  setServerIcon: t => e({
      serverIcon: t
  }),
  nextPayment: !1,
  setNextPayment: t => e({
      nextPayment: t
  }),
  salary: 0,
  setSalary: t => e({
      salary: t
  }),
  store: "",
  setStore: t => e({
      store: t
  }),
  nextPaymentMax: 0,
  setNextPaymentMax: t => e({
      nextPaymentMax: t
  }),
  setGoalModalVisible: t => e({
      goalModalVisible: t
  }),
  goalModalVisible: !1,
  setConfigModalVisible: t => e({
      configModalVisible: t
  }),
  configModalVisible: !1,
  update: t => e({
      ...t
  }),
  max: 0,
  setMax: t => e({
      max: t
  }),
  current: 0,
  setCurrent: t => e({
      current: t
  }),
  title: "",
  setTitle: t => e({
      title: t
  }),
  description: "",
  setDescription: t => e({
      description: t
  }),
  index: null,
  setIndex: t => e({
      index: t
  }),
  painelType: "legal",
  setPainelType: t => e({
      painelType: t
  })
}))
, ol = cm(e => ({
  modal: {
      time: 0,
      title: "",
      description: "",
      placeholder: "",
      save: t => {}
  },
  setModal: t => e({
      modal: t
  })
}));
var dm = {
  color: void 0,
  size: void 0,
  className: void 0,
  style: void 0,
  attr: void 0
}
, s0 = T.createContext && T.createContext(dm)
, K4 = ["attr", "size", "title"];
function Y4(e, t) {
  if (e == null)
      return {};
  var n = X4(e, t), r, i;
  if (Object.getOwnPropertySymbols) {
      var o = Object.getOwnPropertySymbols(e);
      for (i = 0; i < o.length; i++)
          r = o[i],
          !(t.indexOf(r) >= 0) && (!Object.prototype.propertyIsEnumerable.call(e, r) || (n[r] = e[r]))
  }
  return n
}
function X4(e, t) {
  if (e == null)
      return {};
  var n = {};
  for (var r in e)
      if (Object.prototype.hasOwnProperty.call(e, r)) {
          if (t.indexOf(r) >= 0)
              continue;
          n[r] = e[r]
      }
  return n
}
function l0(e, t) {
  var n = Object.keys(e);
  if (Object.getOwnPropertySymbols) {
      var r = Object.getOwnPropertySymbols(e);
      t && (r = r.filter(function(i) {
          return Object.getOwnPropertyDescriptor(e, i).enumerable
      })),
      n.push.apply(n, r)
  }
  return n
}
function Vo(e) {
  for (var t = 1; t < arguments.length; t++) {
      var n = arguments[t] != null ? arguments[t] : {};
      t % 2 ? l0(Object(n), !0).forEach(function(r) {
          q4(e, r, n[r])
      }) : Object.getOwnPropertyDescriptors ? Object.defineProperties(e, Object.getOwnPropertyDescriptors(n)) : l0(Object(n)).forEach(function(r) {
          Object.defineProperty(e, r, Object.getOwnPropertyDescriptor(n, r))
      })
  }
  return e
}
function q4(e, t, n) {
  return t = J4(t),
  t in e ? Object.defineProperty(e, t, {
      value: n,
      enumerable: !0,
      configurable: !0,
      writable: !0
  }) : e[t] = n,
  e
}
function J4(e) {
  var t = ey(e, "string");
  return typeof t == "symbol" ? t : t + ""
}
function ey(e, t) {
  if (typeof e != "object" || !e)
      return e;
  var n = e[Symbol.toPrimitive];
  if (n !== void 0) {
      var r = n.call(e, t || "default");
      if (typeof r != "object")
          return r;
      throw new TypeError("@@toPrimitive must return a primitive value.")
  }
  return (t === "string" ? String : Number)(e)
}
function fm(e) {
  return e && e.map( (t, n) => T.createElement(t.tag, Vo({
      key: n
  }, t.attr), fm(t.child)))
}
function $(e) {
  return t => c(ty, {
      attr: Vo({}, e.attr),
      ...t,
      children: fm(e.child)
  })
}
function ty(e) {
  var t = n => {
      var {attr: r, size: i, title: o} = e, a = Y4(e, K4), s = i || n.size || "1em", l;
      return n.className && (l = n.className),
      e.className && (l = (l ? l + " " : "") + e.className),
      w("svg", {
          stroke: "currentColor",
          fill: "currentColor",
          strokeWidth: "0",
          ...n.attr,
          ...r,
          ...a,
          className: l,
          style: Vo(Vo({
              color: e.color || n.color
          }, n.style), e.style),
          height: s,
          width: s,
          xmlns: "http://www.w3.org/2000/svg",
          children: [o && c("title", {
              children: o
          }), e.children]
      })
  }
  ;
  return s0 !== void 0 ? c(s0.Consumer, {
      children: n => t(n)
  }) : t(dm)
}
function di(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M4 22C4 17.5817 7.58172 14 12 14C16.4183 14 20 17.5817 20 22H18C18 18.6863 15.3137 16 12 16C8.68629 16 6 18.6863 6 22H4ZM12 13C8.685 13 6 10.315 6 7C6 3.685 8.685 1 12 1C15.315 1 18 3.685 18 7C18 10.315 15.315 13 12 13ZM12 11C14.21 11 16 9.21 16 7C16 4.79 14.21 3 12 3C9.79 3 8 4.79 8 7C8 9.21 9.79 11 12 11Z"
          },
          child: []
      }]
  })(e)
}
function gr(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 512 512"
      },
      child: [{
          tag: "path",
          attr: {
              fill: "none",
              strokeLinecap: "round",
              strokeLinejoin: "round",
              strokeWidth: "32",
              d: "M368 368 144 144m224 0L144 368"
          },
          child: []
      }]
  })(e)
}
function mm(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 512 512"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M456.69 421.39 362.6 327.3a173.81 173.81 0 0 0 34.84-104.58C397.44 126.38 319.06 48 222.72 48S48 126.38 48 222.72s78.38 174.72 174.72 174.72A173.81 173.81 0 0 0 327.3 362.6l94.09 94.09a25 25 0 0 0 35.3-35.3zM97.92 222.72a124.8 124.8 0 1 1 124.8 124.8 124.95 124.95 0 0 1-124.8-124.8z"
          },
          child: []
      }]
  })(e)
}
function hm(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 512 512"
      },
      child: [{
          tag: "rect",
          attr: {
              width: "416",
              height: "288",
              x: "48",
              y: "144",
              fill: "none",
              strokeLinejoin: "round",
              strokeWidth: "32",
              rx: "48",
              ry: "48"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              fill: "none",
              strokeLinejoin: "round",
              strokeWidth: "32",
              d: "M411.36 144v-30A50 50 0 0 0 352 64.9L88.64 109.85A50 50 0 0 0 48 159v49"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M368 320a32 32 0 1 1 32-32 32 32 0 0 1-32 32z"
          },
          child: []
      }]
  })(e)
}
function ny(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          strokeWidth: "2",
          strokeLinecap: "round",
          strokeLinejoin: "round"
      },
      child: [{
          tag: "rect",
          attr: {
              x: "3",
              y: "3",
              width: "18",
              height: "18",
              rx: "2",
              ry: "2"
          },
          child: []
      }, {
          tag: "line",
          attr: {
              x1: "8",
              y1: "12",
              x2: "16",
              y2: "12"
          },
          child: []
      }]
  })(e)
}
function ry(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          strokeWidth: "2",
          strokeLinecap: "round",
          strokeLinejoin: "round"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"
          },
          child: []
      }, {
          tag: "circle",
          attr: {
              cx: "12",
              cy: "7",
              r: "4"
          },
          child: []
      }]
  })(e)
}
function iy(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          strokeWidth: "2",
          strokeLinecap: "round",
          strokeLinejoin: "round"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M17 7 7 17"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M17 17H7V7"
          },
          child: []
      }]
  })(e)
}
function oy(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          strokeWidth: "2",
          strokeLinecap: "round",
          strokeLinejoin: "round"
      },
      child: [{
          tag: "rect",
          attr: {
              width: "18",
              height: "18",
              x: "3",
              y: "3",
              rx: "2"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M12 8v8"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "m8 12 4 4 4-4"
          },
          child: []
      }]
  })(e)
}
function ay(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          strokeWidth: "2",
          strokeLinecap: "round",
          strokeLinejoin: "round"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M7 7h10v10"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M7 17 17 7"
          },
          child: []
      }]
  })(e)
}
function sy(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          strokeWidth: "2",
          strokeLinecap: "round",
          strokeLinejoin: "round"
      },
      child: [{
          tag: "rect",
          attr: {
              width: "18",
              height: "18",
              x: "3",
              y: "3",
              rx: "2"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "m16 12-4-4-4 4"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M12 16V8"
          },
          child: []
      }]
  })(e)
}
function ly(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          strokeWidth: "2",
          strokeLinecap: "round",
          strokeLinejoin: "round"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M5 12h14"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M12 5v14"
          },
          child: []
      }]
  })(e)
}
function pm(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          strokeWidth: "2",
          strokeLinecap: "round",
          strokeLinejoin: "round"
      },
      child: [{
          tag: "path",
          attr: {
              d: "m3 3 3 9-3 9 19-9Z"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M6 12h16"
          },
          child: []
      }]
  })(e)
}
function uy(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 256 256",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M253.88,108.11l-25.53-51a20,20,0,0,0-26.83-9L178.34,59.7,131.7,44.58a12.14,12.14,0,0,0-7.4,0L77.66,59.7,54.48,48.11a20,20,0,0,0-26.83,9L2.12,108.11a20,20,0,0,0,9,26.83l26.67,13.34,51.18,37.41A12.15,12.15,0,0,0,93,187.62l62,16a12.27,12.27,0,0,0,3,.38,12,12,0,0,0,8.48-3.52l52.62-52.62,25.83-12.92a20,20,0,0,0,8.95-26.83Zm-58.12,29.15-27.52-26a12,12,0,0,0-16.76.26c-9.66,9.74-25.06,16.81-40.81,9.55l38.19-37h22.72l25.81,51.63ZM47.32,71.37,60.59,78l-22,43.9-13.27-6.63Zm107,107.3L101.23,165l-42-30.66L85.17,82.5,128,68.61l1.69.55L90,107.68l-.13.12a20,20,0,0,0,3.4,31c20.95,13.39,46,12.07,66.33-2.73l19.2,18.15Zm63-56.77-22-43.9,13.27-6.63,21.95,43.9ZM118.55,219a12,12,0,0,1-14.62,8.62l-26.6-6.87a12,12,0,0,1-4.08-1.93L48.92,201a12,12,0,0,1,14.16-19.37l22.47,16.42,24.38,6.29A12,12,0,0,1,118.55,219Z"
          },
          child: []
      }]
  })(e)
}
function cy(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 256 256",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M232,60H212V48a12,12,0,0,0-12-12H56A12,12,0,0,0,44,48V60H24A20,20,0,0,0,4,80V96a44.05,44.05,0,0,0,44,44h.77A84.18,84.18,0,0,0,116,195.15V212H96a12,12,0,0,0,0,24h64a12,12,0,0,0,0-24H140V195.11c30.94-4.51,56.53-26.2,67-55.11h1a44.05,44.05,0,0,0,44-44V80A20,20,0,0,0,232,60ZM28,96V84H44v28c0,1.21,0,2.41.09,3.61A20,20,0,0,1,28,96Zm160,15.1c0,33.33-26.71,60.65-59.54,60.9A60,60,0,0,1,68,112V60H188ZM228,96a20,20,0,0,1-16.12,19.62c.08-1.5.12-3,.12-4.52V84h16Z"
          },
          child: []
      }]
  })(e)
}
function Xa(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 256 256",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M213.66,101.66l-80,80a8,8,0,0,1-11.32,0l-80-80A8,8,0,0,1,48,88H208a8,8,0,0,1,5.66,13.66Z"
          },
          child: []
      }]
  })(e)
}
function gm(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 256 256",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M234.29,114.85l-45,38.83L203,211.75a16.4,16.4,0,0,1-24.5,17.82L128,198.49,77.47,229.57A16.4,16.4,0,0,1,53,211.75l13.76-58.07-45-38.83A16.46,16.46,0,0,1,31.08,86l59-4.76,22.76-55.08a16.36,16.36,0,0,1,30.27,0l22.75,55.08,59,4.76a16.46,16.46,0,0,1,9.37,28.86Z"
          },
          child: []
      }]
  })(e)
}
function dy(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 256 256",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M254.3,107.91,228.78,56.85a16,16,0,0,0-21.47-7.15L182.44,62.13,130.05,48.27a8.14,8.14,0,0,0-4.1,0L73.56,62.13,48.69,49.7a16,16,0,0,0-21.47,7.15L1.7,107.9a16,16,0,0,0,7.15,21.47l27,13.51,55.49,39.63a8.06,8.06,0,0,0,2.71,1.25l64,16a8,8,0,0,0,7.6-2.1l55.07-55.08,26.42-13.21a16,16,0,0,0,7.15-21.46Zm-54.89,33.37L165,113.72a8,8,0,0,0-10.68.61C136.51,132.27,116.66,130,104,122L147.24,80h31.81l27.21,54.41ZM41.53,64,62,74.22,36.43,125.27,16,115.06Zm116,119.13L99.42,168.61l-49.2-35.14,28-56L128,64.28l9.8,2.59-45,43.68-.08.09a16,16,0,0,0,2.72,24.81c20.56,13.13,45.37,11,64.91-5L188,152.66Zm62-57.87-25.52-51L214.47,64,240,115.06Zm-87.75,92.67a8,8,0,0,1-7.75,6.06,8.13,8.13,0,0,1-1.95-.24L80.41,213.33a7.89,7.89,0,0,1-2.71-1.25L51.35,193.26a8,8,0,0,1,9.3-13l25.11,17.94L126,208.24A8,8,0,0,1,131.82,217.94Z"
          },
          child: []
      }]
  })(e)
}
function fy(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 256 256",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M227.31,73.37,182.63,28.68a16,16,0,0,0-22.63,0L36.69,152A15.86,15.86,0,0,0,32,163.31V208a16,16,0,0,0,16,16H92.69A15.86,15.86,0,0,0,104,219.31L227.31,96a16,16,0,0,0,0-22.63ZM92.69,208H48V163.31l88-88L180.69,120ZM192,108.68,147.31,64l24-24L216,84.68Z"
          },
          child: []
      }]
  })(e)
}
function ym(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 256 256",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M239.18,97.26A16.38,16.38,0,0,0,224.92,86l-59-4.76L143.14,26.15a16.36,16.36,0,0,0-30.27,0L90.11,81.23,31.08,86a16.46,16.46,0,0,0-9.37,28.86l45,38.83L53,211.75a16.38,16.38,0,0,0,24.5,17.82L128,198.49l50.53,31.08A16.4,16.4,0,0,0,203,211.75l-13.76-58.07,45-38.83A16.43,16.43,0,0,0,239.18,97.26Zm-15.34,5.47-48.7,42a8,8,0,0,0-2.56,7.91l14.88,62.8a.37.37,0,0,1-.17.48c-.18.14-.23.11-.38,0l-54.72-33.65a8,8,0,0,0-8.38,0L69.09,215.94c-.15.09-.19.12-.38,0a.37.37,0,0,1-.17-.48l14.88-62.8a8,8,0,0,0-2.56-7.91l-48.7-42c-.12-.1-.23-.19-.13-.5s.18-.27.33-.29l63.92-5.16A8,8,0,0,0,103,91.86l24.62-59.61c.08-.17.11-.25.35-.25s.27.08.35.25L153,91.86a8,8,0,0,0,6.75,4.92l63.92,5.16c.15,0,.24,0,.33.29S224,102.63,223.84,102.73Z"
          },
          child: []
      }]
  })(e)
}
function al(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 256 256",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M216,48H176V40a24,24,0,0,0-24-24H104A24,24,0,0,0,80,40v8H40a8,8,0,0,0,0,16h8V208a16,16,0,0,0,16,16H192a16,16,0,0,0,16-16V64h8a8,8,0,0,0,0-16ZM96,40a8,8,0,0,1,8-8h48a8,8,0,0,1,8,8v8H96Zm96,168H64V64H192ZM112,104v64a8,8,0,0,1-16,0V104a8,8,0,0,1,16,0Zm48,0v64a8,8,0,0,1-16,0V104a8,8,0,0,1,16,0Z"
          },
          child: []
      }]
  })(e)
}
function u0(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 256 256",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M232,64H208V48a8,8,0,0,0-8-8H56a8,8,0,0,0-8,8V64H24A16,16,0,0,0,8,80V96a40,40,0,0,0,40,40h3.65A80.13,80.13,0,0,0,120,191.61V216H96a8,8,0,0,0,0,16h64a8,8,0,0,0,0-16H136V191.58c31.94-3.23,58.44-25.64,68.08-55.58H208a40,40,0,0,0,40-40V80A16,16,0,0,0,232,64ZM48,120A24,24,0,0,1,24,96V80H48v32q0,4,.39,8Zm144-8.9c0,35.52-29,64.64-64,64.9a64,64,0,0,1-64-64V56H192ZM232,96a24,24,0,0,1-24,24h-.5a81.81,81.81,0,0,0,.5-8.9V80h24Z"
          },
          child: []
      }]
  })(e)
}
function my(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 256 256",
          fill: "currentColor"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M230.92,212c-15.23-26.33-38.7-45.21-66.09-54.16a72,72,0,1,0-73.66,0C63.78,166.78,40.31,185.66,25.08,212a8,8,0,1,0,13.85,8c18.84-32.56,52.14-52,89.07-52s70.23,19.44,89.07,52a8,8,0,1,0,13.85-8ZM72,96a56,56,0,1,1,56,56A56.06,56.06,0,0,1,72,96Z"
          },
          child: []
      }]
  })(e)
}
function vm(e) {
  var t, n, r = "";
  if (typeof e == "string" || typeof e == "number")
      r += e;
  else if (typeof e == "object")
      if (Array.isArray(e)) {
          var i = e.length;
          for (t = 0; t < i; t++)
              e[t] && (n = vm(e[t])) && (r && (r += " "),
              r += n)
      } else
          for (n in e)
              e[n] && (r && (r += " "),
              r += n);
  return r
}
function wi() {
  for (var e, t, n = 0, r = "", i = arguments.length; n < i; n++)
      (e = arguments[n]) && (t = vm(e)) && (r && (r += " "),
      r += t);
  return r
}
function hy() {
  const e = E.exports.useRef(null)
    , {permissions: t, setOpenedContractModal: n} = oe();
  function r() {
      var i, o;
      !((i = e.current) != null && i.value) || !t.invite || (z("ContractMember", {
          id: Number((o = e.current) == null ? void 0 : o.value)
      }),
      e.current && (e.current.value = ""),
      n(!1))
  }
  return c("div", {
      className: "w-screen z-10 h-screen bg-black/75 absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2",
      children: w("div", {
          className: "absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 p-6 flex flex-col gap-3 rounded-md border border-primary bg-primary-gradient",
          children: [w("div", {
              className: "flex justify-between gap-5",
              children: [w("div", {
                  children: [c("h3", {
                      className: "text-primary text-[1.125rem] font-semibold",
                      children: "CONTRATAR"
                  }), c("p", {
                      className: "text-white text-[.625rem] font-normal",
                      children: "Digite o ID da pessoa que deseja convidar."
                  })]
              }), c(gr, {
                  size: 20,
                  className: "text-white/30 cursor-pointer",
                  onClick: () => n(!1)
              })]
          }), c("input", {
              ref: e,
              type: "number",
              placeholder: "id",
              className: "bg-white/[.04] border border-white/[.04] h-10 rounded-[.25rem] px-4 text-white text-[.8125rem] font-normal uppercase outline-none"
          }), c("button", {
              onClick: r,
              className: "w-[21.375rem] text-white text-[.8125rem] font-normal h-10 border border-white/[.15] rounded-[.1875rem] bg-primary",
              children: "CONVIDAR"
          })]
      })
  })
}
const xm = E.exports.createContext({
  transformPagePoint: e => e,
  isStatic: !1,
  reducedMotion: "never"
})
, ma = E.exports.createContext({})
, ha = E.exports.createContext(null)
, pa = typeof document < "u"
, wu = pa ? E.exports.useLayoutEffect : E.exports.useEffect
, wm = E.exports.createContext({
  strict: !1
})
, Su = e => e.replace(/([a-z])([A-Z])/g, "$1-$2").toLowerCase()
, py = "framerAppearId"
, Sm = "data-" + Su(py);
function gy(e, t, n, r) {
  const {visualElement: i} = E.exports.useContext(ma)
    , o = E.exports.useContext(wm)
    , a = E.exports.useContext(ha)
    , s = E.exports.useContext(xm).reducedMotion
    , l = E.exports.useRef();
  r = r || o.renderer,
  !l.current && r && (l.current = r(e, {
      visualState: t,
      parent: i,
      props: n,
      presenceContext: a,
      blockInitialAnimation: a ? a.initial === !1 : !1,
      reducedMotionConfig: s
  }));
  const u = l.current;
  E.exports.useInsertionEffect( () => {
      u && u.update(n, a)
  }
  );
  const f = E.exports.useRef(Boolean(n[Sm] && !window.HandoffComplete));
  return wu( () => {
      !u || (u.render(),
      f.current && u.animationState && u.animationState.animateChanges())
  }
  ),
  E.exports.useEffect( () => {
      !u || (u.updateFeatures(),
      !f.current && u.animationState && u.animationState.animateChanges(),
      f.current && (f.current = !1,
      window.HandoffComplete = !0))
  }
  ),
  u
}
function Zn(e) {
  return e && typeof e == "object" && Object.prototype.hasOwnProperty.call(e, "current")
}
function yy(e, t, n) {
  return E.exports.useCallback(r => {
      r && e.mount && e.mount(r),
      t && (r ? t.mount(r) : t.unmount()),
      n && (typeof n == "function" ? n(r) : Zn(n) && (n.current = r))
  }
  , [t])
}
function fi(e) {
  return typeof e == "string" || Array.isArray(e)
}
function ga(e) {
  return e !== null && typeof e == "object" && typeof e.start == "function"
}
const Eu = ["animate", "whileInView", "whileFocus", "whileHover", "whileTap", "whileDrag", "exit"]
, Nu = ["initial", ...Eu];
function ya(e) {
  return ga(e.animate) || Nu.some(t => fi(e[t]))
}
function Em(e) {
  return Boolean(ya(e) || e.variants)
}
function vy(e, t) {
  if (ya(e)) {
      const {initial: n, animate: r} = e;
      return {
          initial: n === !1 || fi(n) ? n : void 0,
          animate: fi(r) ? r : void 0
      }
  }
  return e.inherit !== !1 ? t : {}
}
function xy(e) {
  const {initial: t, animate: n} = vy(e, E.exports.useContext(ma));
  return E.exports.useMemo( () => ({
      initial: t,
      animate: n
  }), [c0(t), c0(n)])
}
function c0(e) {
  return Array.isArray(e) ? e.join(" ") : e
}
const d0 = {
  animation: ["animate", "variants", "whileHover", "whileTap", "exit", "whileInView", "whileFocus", "whileDrag"],
  exit: ["exit"],
  drag: ["drag", "dragControls"],
  focus: ["whileFocus"],
  hover: ["whileHover", "onHoverStart", "onHoverEnd"],
  tap: ["whileTap", "onTap", "onTapStart", "onTapCancel"],
  pan: ["onPan", "onPanStart", "onPanSessionStart", "onPanEnd"],
  inView: ["whileInView", "onViewportEnter", "onViewportLeave"],
  layout: ["layout", "layoutId"]
}
, mi = {};
for (const e in d0)
  mi[e] = {
      isEnabled: t => d0[e].some(n => !!t[n])
  };
function wy(e) {
  for (const t in e)
      mi[t] = {
          ...mi[t],
          ...e[t]
      }
}
const Cu = E.exports.createContext({})
, Nm = E.exports.createContext({})
, Sy = Symbol.for("motionComponentSymbol");
function Ey({preloadedFeatures: e, createVisualElement: t, useRender: n, useVisualState: r, Component: i}) {
  e && wy(e);
  function o(s, l) {
      let u;
      const f = {
          ...E.exports.useContext(xm),
          ...s,
          layoutId: Ny(s)
      }
        , {isStatic: d} = f
        , m = xy(s)
        , p = r(s, d);
      if (!d && pa) {
          m.visualElement = gy(i, p, f, t);
          const v = E.exports.useContext(Nm)
            , x = E.exports.useContext(wm).strict;
          m.visualElement && (u = m.visualElement.loadFeatures(f, x, e, v))
      }
      return w(ma.Provider, {
          value: m,
          children: [u && m.visualElement ? c(u, {
              visualElement: m.visualElement,
              ...f
          }) : null, n(i, s, yy(p, m.visualElement, l), p, d, m.visualElement)]
      })
  }
  const a = E.exports.forwardRef(o);
  return a[Sy] = i,
  a
}
function Ny({layoutId: e}) {
  const t = E.exports.useContext(Cu).id;
  return t && e !== void 0 ? t + "-" + e : e
}
function Cy(e) {
  function t(r, i={}) {
      return Ey(e(r, i))
  }
  if (typeof Proxy > "u")
      return t;
  const n = new Map;
  return new Proxy(t,{
      get: (r, i) => (n.has(i) || n.set(i, t(i)),
      n.get(i))
  })
}
const Py = ["animate", "circle", "defs", "desc", "ellipse", "g", "image", "line", "filter", "marker", "mask", "metadata", "path", "pattern", "polygon", "polyline", "rect", "stop", "switch", "symbol", "svg", "text", "tspan", "use", "view"];
function Pu(e) {
  return typeof e != "string" || e.includes("-") ? !1 : !!(Py.indexOf(e) > -1 || /[A-Z]/.test(e))
}
const Do = {};
function Ay(e) {
  Object.assign(Do, e)
}
const Si = ["transformPerspective", "x", "y", "z", "translateX", "translateY", "translateZ", "scale", "scaleX", "scaleY", "rotate", "rotateX", "rotateY", "rotateZ", "skew", "skewX", "skewY"]
, Mn = new Set(Si);
function Cm(e, {layout: t, layoutId: n}) {
  return Mn.has(e) || e.startsWith("origin") || (t || n !== void 0) && (!!Do[e] || e === "opacity")
}
const De = e => Boolean(e && e.getVelocity)
, ky = {
  x: "translateX",
  y: "translateY",
  z: "translateZ",
  transformPerspective: "perspective"
}
, Ty = Si.length;
function My(e, {enableHardwareAcceleration: t=!0, allowTransformNone: n=!0}, r, i) {
  let o = "";
  for (let a = 0; a < Ty; a++) {
      const s = Si[a];
      if (e[s] !== void 0) {
          const l = ky[s] || s;
          o += `${l}(${e[s]}) `
      }
  }
  return t && !e.z && (o += "translateZ(0)"),
  o = o.trim(),
  i ? o = i(e, r ? "" : o) : n && r && (o = "none"),
  o
}
const Pm = e => t => typeof t == "string" && t.startsWith(e)
, Am = Pm("--")
, sl = Pm("var(--")
, Ly = /var\s*\(\s*--[\w-]+(\s*,\s*(?:(?:[^)(]|\((?:[^)(]+|\([^)(]*\))*\))*)+)?\s*\)/g
, Ry = (e, t) => t && typeof e == "number" ? t.transform(e) : e
, Xt = (e, t, n) => Math.min(Math.max(n, e), t)
, Ln = {
  test: e => typeof e == "number",
  parse: parseFloat,
  transform: e => e
}
, Hr = {
  ...Ln,
  transform: e => Xt(0, 1, e)
}
, $i = {
  ...Ln,
  default: 1
}
, Br = e => Math.round(e * 1e5) / 1e5
, va = /(-)?([\d]*\.?[\d])+/g
, km = /(#[0-9a-f]{3,8}|(rgb|hsl)a?\((-?[\d\.]+%?[,\s]+){2}(-?[\d\.]+%?)\s*[\,\/]?\s*[\d\.]*%?\))/gi
, by = /^(#[0-9a-f]{3,8}|(rgb|hsl)a?\((-?[\d\.]+%?[,\s]+){2}(-?[\d\.]+%?)\s*[\,\/]?\s*[\d\.]*%?\))$/i;
function Ei(e) {
  return typeof e == "string"
}
const Ni = e => ({
  test: t => Ei(t) && t.endsWith(e) && t.split(" ").length === 1,
  parse: parseFloat,
  transform: t => `${t}${e}`
})
, Lt = Ni("deg")
, ft = Ni("%")
, j = Ni("px")
, Oy = Ni("vh")
, Vy = Ni("vw")
, f0 = {
  ...ft,
  parse: e => ft.parse(e) / 100,
  transform: e => ft.transform(e * 100)
}
, m0 = {
  ...Ln,
  transform: Math.round
}
, Tm = {
  borderWidth: j,
  borderTopWidth: j,
  borderRightWidth: j,
  borderBottomWidth: j,
  borderLeftWidth: j,
  borderRadius: j,
  radius: j,
  borderTopLeftRadius: j,
  borderTopRightRadius: j,
  borderBottomRightRadius: j,
  borderBottomLeftRadius: j,
  width: j,
  maxWidth: j,
  height: j,
  maxHeight: j,
  size: j,
  top: j,
  right: j,
  bottom: j,
  left: j,
  padding: j,
  paddingTop: j,
  paddingRight: j,
  paddingBottom: j,
  paddingLeft: j,
  margin: j,
  marginTop: j,
  marginRight: j,
  marginBottom: j,
  marginLeft: j,
  rotate: Lt,
  rotateX: Lt,
  rotateY: Lt,
  rotateZ: Lt,
  scale: $i,
  scaleX: $i,
  scaleY: $i,
  scaleZ: $i,
  skew: Lt,
  skewX: Lt,
  skewY: Lt,
  distance: j,
  translateX: j,
  translateY: j,
  translateZ: j,
  x: j,
  y: j,
  z: j,
  perspective: j,
  transformPerspective: j,
  opacity: Hr,
  originX: f0,
  originY: f0,
  originZ: j,
  zIndex: m0,
  fillOpacity: Hr,
  strokeOpacity: Hr,
  numOctaves: m0
};
function Au(e, t, n, r) {
  const {style: i, vars: o, transform: a, transformOrigin: s} = e;
  let l = !1
    , u = !1
    , f = !0;
  for (const d in t) {
      const m = t[d];
      if (Am(d)) {
          o[d] = m;
          continue
      }
      const p = Tm[d]
        , v = Ry(m, p);
      if (Mn.has(d)) {
          if (l = !0,
          a[d] = v,
          !f)
              continue;
          m !== (p.default || 0) && (f = !1)
      } else
          d.startsWith("origin") ? (u = !0,
          s[d] = v) : i[d] = v
  }
  if (t.transform || (l || r ? i.transform = My(e.transform, n, f, r) : i.transform && (i.transform = "none")),
  u) {
      const {originX: d="50%", originY: m="50%", originZ: p=0} = s;
      i.transformOrigin = `${d} ${m} ${p}`
  }
}
const ku = () => ({
  style: {},
  transform: {},
  transformOrigin: {},
  vars: {}
});
function Mm(e, t, n) {
  for (const r in t)
      !De(t[r]) && !Cm(r, n) && (e[r] = t[r])
}
function Dy({transformTemplate: e}, t, n) {
  return E.exports.useMemo( () => {
      const r = ku();
      return Au(r, t, {
          enableHardwareAcceleration: !n
      }, e),
      Object.assign({}, r.vars, r.style)
  }
  , [t])
}
function jy(e, t, n) {
  const r = e.style || {}
    , i = {};
  return Mm(i, r, e),
  Object.assign(i, Dy(e, t, n)),
  e.transformValues ? e.transformValues(i) : i
}
function Iy(e, t, n) {
  const r = {}
    , i = jy(e, t, n);
  return e.drag && e.dragListener !== !1 && (r.draggable = !1,
  i.userSelect = i.WebkitUserSelect = i.WebkitTouchCallout = "none",
  i.touchAction = e.drag === !0 ? "none" : `pan-${e.drag === "x" ? "y" : "x"}`),
  e.tabIndex === void 0 && (e.onTap || e.onTapStart || e.whileTap) && (r.tabIndex = 0),
  r.style = i,
  r
}
const Fy = new Set(["animate", "exit", "variants", "initial", "style", "values", "variants", "transition", "transformTemplate", "transformValues", "custom", "inherit", "onBeforeLayoutMeasure", "onAnimationStart", "onAnimationComplete", "onUpdate", "onDragStart", "onDrag", "onDragEnd", "onMeasureDragConstraints", "onDirectionLock", "onDragTransitionEnd", "_dragX", "_dragY", "onHoverStart", "onHoverEnd", "onViewportEnter", "onViewportLeave", "globalTapTarget", "ignoreStrict", "viewport"]);
function jo(e) {
  return e.startsWith("while") || e.startsWith("drag") && e !== "draggable" || e.startsWith("layout") || e.startsWith("onTap") || e.startsWith("onPan") || e.startsWith("onLayout") || Fy.has(e)
}
let Lm = e => !jo(e);
function _y(e) {
  !e || (Lm = t => t.startsWith("on") ? !jo(t) : e(t))
}
try {
  _y(require("@emotion/is-prop-valid").default)
} catch {}
function zy(e, t, n) {
  const r = {};
  for (const i in e)
      i === "values" && typeof e.values == "object" || (Lm(i) || n === !0 && jo(i) || !t && !jo(i) || e.draggable && i.startsWith("onDrag")) && (r[i] = e[i]);
  return r
}
function h0(e, t, n) {
  return typeof e == "string" ? e : j.transform(t + n * e)
}
function Hy(e, t, n) {
  const r = h0(t, e.x, e.width)
    , i = h0(n, e.y, e.height);
  return `${r} ${i}`
}
const By = {
  offset: "stroke-dashoffset",
  array: "stroke-dasharray"
}
, $y = {
  offset: "strokeDashoffset",
  array: "strokeDasharray"
};
function Uy(e, t, n=1, r=0, i=!0) {
  e.pathLength = 1;
  const o = i ? By : $y;
  e[o.offset] = j.transform(-r);
  const a = j.transform(t)
    , s = j.transform(n);
  e[o.array] = `${a} ${s}`
}
function Tu(e, {attrX: t, attrY: n, attrScale: r, originX: i, originY: o, pathLength: a, pathSpacing: s=1, pathOffset: l=0, ...u}, f, d, m) {
  if (Au(e, u, f, m),
  d) {
      e.style.viewBox && (e.attrs.viewBox = e.style.viewBox);
      return
  }
  e.attrs = e.style,
  e.style = {};
  const {attrs: p, style: v, dimensions: x} = e;
  p.transform && (x && (v.transform = p.transform),
  delete p.transform),
  x && (i !== void 0 || o !== void 0 || v.transform) && (v.transformOrigin = Hy(x, i !== void 0 ? i : .5, o !== void 0 ? o : .5)),
  t !== void 0 && (p.x = t),
  n !== void 0 && (p.y = n),
  r !== void 0 && (p.scale = r),
  a !== void 0 && Uy(p, a, s, l, !1)
}
const Rm = () => ({
  ...ku(),
  attrs: {}
})
, Mu = e => typeof e == "string" && e.toLowerCase() === "svg";
function Zy(e, t, n, r) {
  const i = E.exports.useMemo( () => {
      const o = Rm();
      return Tu(o, t, {
          enableHardwareAcceleration: !1
      }, Mu(r), e.transformTemplate),
      {
          ...o.attrs,
          style: {
              ...o.style
          }
      }
  }
  , [t]);
  if (e.style) {
      const o = {};
      Mm(o, e.style, e),
      i.style = {
          ...o,
          ...i.style
      }
  }
  return i
}
function Gy(e=!1) {
  return (n, r, i, {latestValues: o}, a) => {
      const l = (Pu(n) ? Zy : Iy)(r, o, a, n)
        , f = {
          ...zy(r, typeof n == "string", e),
          ...l,
          ref: i
      }
        , {children: d} = r
        , m = E.exports.useMemo( () => De(d) ? d.get() : d, [d]);
      return E.exports.createElement(n, {
          ...f,
          children: m
      })
  }
}
function bm(e, {style: t, vars: n}, r, i) {
  Object.assign(e.style, t, i && i.getProjectionStyles(r));
  for (const o in n)
      e.style.setProperty(o, n[o])
}
const Om = new Set(["baseFrequency", "diffuseConstant", "kernelMatrix", "kernelUnitLength", "keySplines", "keyTimes", "limitingConeAngle", "markerHeight", "markerWidth", "numOctaves", "targetX", "targetY", "surfaceScale", "specularConstant", "specularExponent", "stdDeviation", "tableValues", "viewBox", "gradientTransform", "pathLength", "startOffset", "textLength", "lengthAdjust"]);
function Vm(e, t, n, r) {
  bm(e, t, void 0, r);
  for (const i in t.attrs)
      e.setAttribute(Om.has(i) ? i : Su(i), t.attrs[i])
}
function Lu(e, t) {
  const {style: n} = e
    , r = {};
  for (const i in n)
      (De(n[i]) || t.style && De(t.style[i]) || Cm(i, e)) && (r[i] = n[i]);
  return r
}
function Dm(e, t) {
  const n = Lu(e, t);
  for (const r in e)
      if (De(e[r]) || De(t[r])) {
          const i = Si.indexOf(r) !== -1 ? "attr" + r.charAt(0).toUpperCase() + r.substring(1) : r;
          n[i] = e[r]
      }
  return n
}
function Ru(e, t, n, r={}, i={}) {
  return typeof t == "function" && (t = t(n !== void 0 ? n : e.custom, r, i)),
  typeof t == "string" && (t = e.variants && e.variants[t]),
  typeof t == "function" && (t = t(n !== void 0 ? n : e.custom, r, i)),
  t
}
function jm(e) {
  const t = E.exports.useRef(null);
  return t.current === null && (t.current = e()),
  t.current
}
const Io = e => Array.isArray(e)
, Wy = e => Boolean(e && typeof e == "object" && e.mix && e.toValue)
, Qy = e => Io(e) ? e[e.length - 1] || 0 : e;
function ao(e) {
  const t = De(e) ? e.get() : e;
  return Wy(t) ? t.toValue() : t
}
function Ky({scrapeMotionValuesFromProps: e, createRenderState: t, onMount: n}, r, i, o) {
  const a = {
      latestValues: Yy(r, i, o, e),
      renderState: t()
  };
  return n && (a.mount = s => n(r, s, a)),
  a
}
const Im = e => (t, n) => {
  const r = E.exports.useContext(ma)
    , i = E.exports.useContext(ha)
    , o = () => Ky(e, t, r, i);
  return n ? o() : jm(o)
}
;
function Yy(e, t, n, r) {
  const i = {}
    , o = r(e, {});
  for (const m in o)
      i[m] = ao(o[m]);
  let {initial: a, animate: s} = e;
  const l = ya(e)
    , u = Em(e);
  t && u && !l && e.inherit !== !1 && (a === void 0 && (a = t.initial),
  s === void 0 && (s = t.animate));
  let f = n ? n.initial === !1 : !1;
  f = f || a === !1;
  const d = f ? s : a;
  return d && typeof d != "boolean" && !ga(d) && (Array.isArray(d) ? d : [d]).forEach(p => {
      const v = Ru(e, p);
      if (!v)
          return;
      const {transitionEnd: x, transition: P, ...y} = v;
      for (const h in y) {
          let g = y[h];
          if (Array.isArray(g)) {
              const S = f ? g.length - 1 : 0;
              g = g[S]
          }
          g !== null && (i[h] = g)
      }
      for (const h in x)
          i[h] = x[h]
  }
  ),
  i
}
const re = e => e;
class p0 {
  constructor() {
      this.order = [],
      this.scheduled = new Set
  }
  add(t) {
      if (!this.scheduled.has(t))
          return this.scheduled.add(t),
          this.order.push(t),
          !0
  }
  remove(t) {
      const n = this.order.indexOf(t);
      n !== -1 && (this.order.splice(n, 1),
      this.scheduled.delete(t))
  }
  clear() {
      this.order.length = 0,
      this.scheduled.clear()
  }
}
function Xy(e) {
  let t = new p0
    , n = new p0
    , r = 0
    , i = !1
    , o = !1;
  const a = new WeakSet
    , s = {
      schedule: (l, u=!1, f=!1) => {
          const d = f && i
            , m = d ? t : n;
          return u && a.add(l),
          m.add(l) && d && i && (r = t.order.length),
          l
      }
      ,
      cancel: l => {
          n.remove(l),
          a.delete(l)
      }
      ,
      process: l => {
          if (i) {
              o = !0;
              return
          }
          if (i = !0,
          [t,n] = [n, t],
          n.clear(),
          r = t.order.length,
          r)
              for (let u = 0; u < r; u++) {
                  const f = t.order[u];
                  f(l),
                  a.has(f) && (s.schedule(f),
                  e())
              }
          i = !1,
          o && (o = !1,
          s.process(l))
      }
  };
  return s
}
const Ui = ["prepare", "read", "update", "preRender", "render", "postRender"]
, qy = 40;
function Jy(e, t) {
  let n = !1
    , r = !0;
  const i = {
      delta: 0,
      timestamp: 0,
      isProcessing: !1
  }
    , o = Ui.reduce( (d, m) => (d[m] = Xy( () => n = !0),
  d), {})
    , a = d => o[d].process(i)
    , s = () => {
      const d = performance.now();
      n = !1,
      i.delta = r ? 1e3 / 60 : Math.max(Math.min(d - i.timestamp, qy), 1),
      i.timestamp = d,
      i.isProcessing = !0,
      Ui.forEach(a),
      i.isProcessing = !1,
      n && t && (r = !1,
      e(s))
  }
    , l = () => {
      n = !0,
      r = !0,
      i.isProcessing || e(s)
  }
  ;
  return {
      schedule: Ui.reduce( (d, m) => {
          const p = o[m];
          return d[m] = (v, x=!1, P=!1) => (n || l(),
          p.schedule(v, x, P)),
          d
      }
      , {}),
      cancel: d => Ui.forEach(m => o[m].cancel(d)),
      state: i,
      steps: o
  }
}
const {schedule: W, cancel: At, state: Se, steps: qa} = Jy(typeof requestAnimationFrame < "u" ? requestAnimationFrame : re, !0)
, ev = {
  useVisualState: Im({
      scrapeMotionValuesFromProps: Dm,
      createRenderState: Rm,
      onMount: (e, t, {renderState: n, latestValues: r}) => {
          W.read( () => {
              try {
                  n.dimensions = typeof t.getBBox == "function" ? t.getBBox() : t.getBoundingClientRect()
              } catch {
                  n.dimensions = {
                      x: 0,
                      y: 0,
                      width: 0,
                      height: 0
                  }
              }
          }
          ),
          W.render( () => {
              Tu(n, r, {
                  enableHardwareAcceleration: !1
              }, Mu(t.tagName), e.transformTemplate),
              Vm(t, n)
          }
          )
      }
  })
}
, tv = {
  useVisualState: Im({
      scrapeMotionValuesFromProps: Lu,
      createRenderState: ku
  })
};
function nv(e, {forwardMotionProps: t=!1}, n, r) {
  return {
      ...Pu(e) ? ev : tv,
      preloadedFeatures: n,
      useRender: Gy(t),
      createVisualElement: r,
      Component: e
  }
}
function vt(e, t, n, r={
  passive: !0
}) {
  return e.addEventListener(t, n, r),
  () => e.removeEventListener(t, n)
}
const Fm = e => e.pointerType === "mouse" ? typeof e.button != "number" || e.button <= 0 : e.isPrimary !== !1;
function xa(e, t="page") {
  return {
      point: {
          x: e[t + "X"],
          y: e[t + "Y"]
      }
  }
}
const rv = e => t => Fm(t) && e(t, xa(t));
function wt(e, t, n, r) {
  return vt(e, t, rv(n), r)
}
const iv = (e, t) => n => t(e(n))
, Wt = (...e) => e.reduce(iv);
function _m(e) {
  let t = null;
  return () => {
      const n = () => {
          t = null
      }
      ;
      return t === null ? (t = e,
      n) : !1
  }
}
const g0 = _m("dragHorizontal")
, y0 = _m("dragVertical");
function zm(e) {
  let t = !1;
  if (e === "y")
      t = y0();
  else if (e === "x")
      t = g0();
  else {
      const n = g0()
        , r = y0();
      n && r ? t = () => {
          n(),
          r()
      }
      : (n && n(),
      r && r())
  }
  return t
}
function Hm() {
  const e = zm(!0);
  return e ? (e(),
  !1) : !0
}
class nn {
  constructor(t) {
      this.isMounted = !1,
      this.node = t
  }
  update() {}
}
function v0(e, t) {
  const n = "pointer" + (t ? "enter" : "leave")
    , r = "onHover" + (t ? "Start" : "End")
    , i = (o, a) => {
      if (o.pointerType === "touch" || Hm())
          return;
      const s = e.getProps();
      e.animationState && s.whileHover && e.animationState.setActive("whileHover", t),
      s[r] && W.update( () => s[r](o, a))
  }
  ;
  return wt(e.current, n, i, {
      passive: !e.getProps()[r]
  })
}
class ov extends nn {
  mount() {
      this.unmount = Wt(v0(this.node, !0), v0(this.node, !1))
  }
  unmount() {}
}
class av extends nn {
  constructor() {
      super(...arguments),
      this.isActive = !1
  }
  onFocus() {
      let t = !1;
      try {
          t = this.node.current.matches(":focus-visible")
      } catch {
          t = !0
      }
      !t || !this.node.animationState || (this.node.animationState.setActive("whileFocus", !0),
      this.isActive = !0)
  }
  onBlur() {
      !this.isActive || !this.node.animationState || (this.node.animationState.setActive("whileFocus", !1),
      this.isActive = !1)
  }
  mount() {
      this.unmount = Wt(vt(this.node.current, "focus", () => this.onFocus()), vt(this.node.current, "blur", () => this.onBlur()))
  }
  unmount() {}
}
const Bm = (e, t) => t ? e === t ? !0 : Bm(e, t.parentElement) : !1;
function Ja(e, t) {
  if (!t)
      return;
  const n = new PointerEvent("pointer" + e);
  t(n, xa(n))
}
class sv extends nn {
  constructor() {
      super(...arguments),
      this.removeStartListeners = re,
      this.removeEndListeners = re,
      this.removeAccessibleListeners = re,
      this.startPointerPress = (t, n) => {
          if (this.isPressing)
              return;
          this.removeEndListeners();
          const r = this.node.getProps()
            , o = wt(window, "pointerup", (s, l) => {
              if (!this.checkPressEnd())
                  return;
              const {onTap: u, onTapCancel: f, globalTapTarget: d} = this.node.getProps();
              W.update( () => {
                  !d && !Bm(this.node.current, s.target) ? f && f(s, l) : u && u(s, l)
              }
              )
          }
          , {
              passive: !(r.onTap || r.onPointerUp)
          })
            , a = wt(window, "pointercancel", (s, l) => this.cancelPress(s, l), {
              passive: !(r.onTapCancel || r.onPointerCancel)
          });
          this.removeEndListeners = Wt(o, a),
          this.startPress(t, n)
      }
      ,
      this.startAccessiblePress = () => {
          const t = o => {
              if (o.key !== "Enter" || this.isPressing)
                  return;
              const a = s => {
                  s.key !== "Enter" || !this.checkPressEnd() || Ja("up", (l, u) => {
                      const {onTap: f} = this.node.getProps();
                      f && W.update( () => f(l, u))
                  }
                  )
              }
              ;
              this.removeEndListeners(),
              this.removeEndListeners = vt(this.node.current, "keyup", a),
              Ja("down", (s, l) => {
                  this.startPress(s, l)
              }
              )
          }
            , n = vt(this.node.current, "keydown", t)
            , r = () => {
              !this.isPressing || Ja("cancel", (o, a) => this.cancelPress(o, a))
          }
            , i = vt(this.node.current, "blur", r);
          this.removeAccessibleListeners = Wt(n, i)
      }
  }
  startPress(t, n) {
      this.isPressing = !0;
      const {onTapStart: r, whileTap: i} = this.node.getProps();
      i && this.node.animationState && this.node.animationState.setActive("whileTap", !0),
      r && W.update( () => r(t, n))
  }
  checkPressEnd() {
      return this.removeEndListeners(),
      this.isPressing = !1,
      this.node.getProps().whileTap && this.node.animationState && this.node.animationState.setActive("whileTap", !1),
      !Hm()
  }
  cancelPress(t, n) {
      if (!this.checkPressEnd())
          return;
      const {onTapCancel: r} = this.node.getProps();
      r && W.update( () => r(t, n))
  }
  mount() {
      const t = this.node.getProps()
        , n = wt(t.globalTapTarget ? window : this.node.current, "pointerdown", this.startPointerPress, {
          passive: !(t.onTapStart || t.onPointerStart)
      })
        , r = vt(this.node.current, "focus", this.startAccessiblePress);
      this.removeStartListeners = Wt(n, r)
  }
  unmount() {
      this.removeStartListeners(),
      this.removeEndListeners(),
      this.removeAccessibleListeners()
  }
}
const ll = new WeakMap
, es = new WeakMap
, lv = e => {
  const t = ll.get(e.target);
  t && t(e)
}
, uv = e => {
  e.forEach(lv)
}
;
function cv({root: e, ...t}) {
  const n = e || document;
  es.has(n) || es.set(n, {});
  const r = es.get(n)
    , i = JSON.stringify(t);
  return r[i] || (r[i] = new IntersectionObserver(uv,{
      root: e,
      ...t
  })),
  r[i]
}
function dv(e, t, n) {
  const r = cv(t);
  return ll.set(e, n),
  r.observe(e),
  () => {
      ll.delete(e),
      r.unobserve(e)
  }
}
const fv = {
  some: 0,
  all: 1
};
class mv extends nn {
  constructor() {
      super(...arguments),
      this.hasEnteredView = !1,
      this.isInView = !1
  }
  startObserver() {
      this.unmount();
      const {viewport: t={}} = this.node.getProps()
        , {root: n, margin: r, amount: i="some", once: o} = t
        , a = {
          root: n ? n.current : void 0,
          rootMargin: r,
          threshold: typeof i == "number" ? i : fv[i]
      }
        , s = l => {
          const {isIntersecting: u} = l;
          if (this.isInView === u || (this.isInView = u,
          o && !u && this.hasEnteredView))
              return;
          u && (this.hasEnteredView = !0),
          this.node.animationState && this.node.animationState.setActive("whileInView", u);
          const {onViewportEnter: f, onViewportLeave: d} = this.node.getProps()
            , m = u ? f : d;
          m && m(l)
      }
      ;
      return dv(this.node.current, a, s)
  }
  mount() {
      this.startObserver()
  }
  update() {
      if (typeof IntersectionObserver > "u")
          return;
      const {props: t, prevProps: n} = this.node;
      ["amount", "margin", "root"].some(hv(t, n)) && this.startObserver()
  }
  unmount() {}
}
function hv({viewport: e={}}, {viewport: t={}}={}) {
  return n => e[n] !== t[n]
}
const pv = {
  inView: {
      Feature: mv
  },
  tap: {
      Feature: sv
  },
  focus: {
      Feature: av
  },
  hover: {
      Feature: ov
  }
};
function $m(e, t) {
  if (!Array.isArray(t))
      return !1;
  const n = t.length;
  if (n !== e.length)
      return !1;
  for (let r = 0; r < n; r++)
      if (t[r] !== e[r])
          return !1;
  return !0
}
function gv(e) {
  const t = {};
  return e.values.forEach( (n, r) => t[r] = n.get()),
  t
}
function yv(e) {
  const t = {};
  return e.values.forEach( (n, r) => t[r] = n.getVelocity()),
  t
}
function wa(e, t, n) {
  const r = e.getProps();
  return Ru(r, t, n !== void 0 ? n : r.custom, gv(e), yv(e))
}
let bu = re
, Sa = re;
const Qt = e => e * 1e3
, St = e => e / 1e3
, x0 = {
  current: !1
}
, Um = e => Array.isArray(e) && typeof e[0] == "number";
function Zm(e) {
  return Boolean(!e || typeof e == "string" && Gm[e] || Um(e) || Array.isArray(e) && e.every(Zm))
}
const Rr = ([e,t,n,r]) => `cubic-bezier(${e}, ${t}, ${n}, ${r})`
, Gm = {
  linear: "linear",
  ease: "ease",
  easeIn: "ease-in",
  easeOut: "ease-out",
  easeInOut: "ease-in-out",
  circIn: Rr([0, .65, .55, 1]),
  circOut: Rr([.55, 0, 1, .45]),
  backIn: Rr([.31, .01, .66, -.59]),
  backOut: Rr([.33, 1.53, .69, .99])
};
function Wm(e) {
  if (!!e)
      return Um(e) ? Rr(e) : Array.isArray(e) ? e.map(Wm) : Gm[e]
}
function vv(e, t, n, {delay: r=0, duration: i, repeat: o=0, repeatType: a="loop", ease: s, times: l}={}) {
  const u = {
      [t]: n
  };
  l && (u.offset = l);
  const f = Wm(s);
  return Array.isArray(f) && (u.easing = f),
  e.animate(u, {
      delay: r,
      duration: i,
      easing: Array.isArray(f) ? "linear" : f,
      fill: "both",
      iterations: o + 1,
      direction: a === "reverse" ? "alternate" : "normal"
  })
}
function xv(e, {repeat: t, repeatType: n="loop"}) {
  const r = t && n !== "loop" && t % 2 === 1 ? 0 : e.length - 1;
  return e[r]
}
const Qm = (e, t, n) => (((1 - 3 * n + 3 * t) * e + (3 * n - 6 * t)) * e + 3 * t) * e
, wv = 1e-7
, Sv = 12;
function Ev(e, t, n, r, i) {
  let o, a, s = 0;
  do
      a = t + (n - t) / 2,
      o = Qm(a, r, i) - e,
      o > 0 ? n = a : t = a;
  while (Math.abs(o) > wv && ++s < Sv);
  return a
}
function Ci(e, t, n, r) {
  if (e === t && n === r)
      return re;
  const i = o => Ev(o, 0, 1, e, n);
  return o => o === 0 || o === 1 ? o : Qm(i(o), t, r)
}
const Nv = Ci(.42, 0, 1, 1)
, Cv = Ci(0, 0, .58, 1)
, Km = Ci(.42, 0, .58, 1)
, Pv = e => Array.isArray(e) && typeof e[0] != "number"
, Ym = e => t => t <= .5 ? e(2 * t) / 2 : (2 - e(2 * (1 - t))) / 2
, Xm = e => t => 1 - e(1 - t)
, Ou = e => 1 - Math.sin(Math.acos(e))
, qm = Xm(Ou)
, Av = Ym(Ou)
, Jm = Ci(.33, 1.53, .69, .99)
, Vu = Xm(Jm)
, kv = Ym(Vu)
, Tv = e => (e *= 2) < 1 ? .5 * Vu(e) : .5 * (2 - Math.pow(2, -10 * (e - 1)))
, Mv = {
  linear: re,
  easeIn: Nv,
  easeInOut: Km,
  easeOut: Cv,
  circIn: Ou,
  circInOut: Av,
  circOut: qm,
  backIn: Vu,
  backInOut: kv,
  backOut: Jm,
  anticipate: Tv
}
, w0 = e => {
  if (Array.isArray(e)) {
      Sa(e.length === 4);
      const [t,n,r,i] = e;
      return Ci(t, n, r, i)
  } else if (typeof e == "string")
      return Mv[e];
  return e
}
, Du = (e, t) => n => Boolean(Ei(n) && by.test(n) && n.startsWith(e) || t && Object.prototype.hasOwnProperty.call(n, t))
, eh = (e, t, n) => r => {
  if (!Ei(r))
      return r;
  const [i,o,a,s] = r.match(va);
  return {
      [e]: parseFloat(i),
      [t]: parseFloat(o),
      [n]: parseFloat(a),
      alpha: s !== void 0 ? parseFloat(s) : 1
  }
}
, Lv = e => Xt(0, 255, e)
, ts = {
  ...Ln,
  transform: e => Math.round(Lv(e))
}
, gn = {
  test: Du("rgb", "red"),
  parse: eh("red", "green", "blue"),
  transform: ({red: e, green: t, blue: n, alpha: r=1}) => "rgba(" + ts.transform(e) + ", " + ts.transform(t) + ", " + ts.transform(n) + ", " + Br(Hr.transform(r)) + ")"
};
function Rv(e) {
  let t = ""
    , n = ""
    , r = ""
    , i = "";
  return e.length > 5 ? (t = e.substring(1, 3),
  n = e.substring(3, 5),
  r = e.substring(5, 7),
  i = e.substring(7, 9)) : (t = e.substring(1, 2),
  n = e.substring(2, 3),
  r = e.substring(3, 4),
  i = e.substring(4, 5),
  t += t,
  n += n,
  r += r,
  i += i),
  {
      red: parseInt(t, 16),
      green: parseInt(n, 16),
      blue: parseInt(r, 16),
      alpha: i ? parseInt(i, 16) / 255 : 1
  }
}
const ul = {
  test: Du("#"),
  parse: Rv,
  transform: gn.transform
}
, Gn = {
  test: Du("hsl", "hue"),
  parse: eh("hue", "saturation", "lightness"),
  transform: ({hue: e, saturation: t, lightness: n, alpha: r=1}) => "hsla(" + Math.round(e) + ", " + ft.transform(Br(t)) + ", " + ft.transform(Br(n)) + ", " + Br(Hr.transform(r)) + ")"
}
, Ce = {
  test: e => gn.test(e) || ul.test(e) || Gn.test(e),
  parse: e => gn.test(e) ? gn.parse(e) : Gn.test(e) ? Gn.parse(e) : ul.parse(e),
  transform: e => Ei(e) ? e : e.hasOwnProperty("red") ? gn.transform(e) : Gn.transform(e)
}
, J = (e, t, n) => -n * e + n * t + e;
function ns(e, t, n) {
  return n < 0 && (n += 1),
  n > 1 && (n -= 1),
  n < 1 / 6 ? e + (t - e) * 6 * n : n < 1 / 2 ? t : n < 2 / 3 ? e + (t - e) * (2 / 3 - n) * 6 : e
}
function bv({hue: e, saturation: t, lightness: n, alpha: r}) {
  e /= 360,
  t /= 100,
  n /= 100;
  let i = 0
    , o = 0
    , a = 0;
  if (!t)
      i = o = a = n;
  else {
      const s = n < .5 ? n * (1 + t) : n + t - n * t
        , l = 2 * n - s;
      i = ns(l, s, e + 1 / 3),
      o = ns(l, s, e),
      a = ns(l, s, e - 1 / 3)
  }
  return {
      red: Math.round(i * 255),
      green: Math.round(o * 255),
      blue: Math.round(a * 255),
      alpha: r
  }
}
const rs = (e, t, n) => {
  const r = e * e;
  return Math.sqrt(Math.max(0, n * (t * t - r) + r))
}
, Ov = [ul, gn, Gn]
, Vv = e => Ov.find(t => t.test(e));
function S0(e) {
  const t = Vv(e);
  let n = t.parse(e);
  return t === Gn && (n = bv(n)),
  n
}
const th = (e, t) => {
  const n = S0(e)
    , r = S0(t)
    , i = {
      ...n
  };
  return o => (i.red = rs(n.red, r.red, o),
  i.green = rs(n.green, r.green, o),
  i.blue = rs(n.blue, r.blue, o),
  i.alpha = J(n.alpha, r.alpha, o),
  gn.transform(i))
}
;
function Dv(e) {
  var t, n;
  return isNaN(e) && Ei(e) && (((t = e.match(va)) === null || t === void 0 ? void 0 : t.length) || 0) + (((n = e.match(km)) === null || n === void 0 ? void 0 : n.length) || 0) > 0
}
const nh = {
  regex: Ly,
  countKey: "Vars",
  token: "${v}",
  parse: re
}
, rh = {
  regex: km,
  countKey: "Colors",
  token: "${c}",
  parse: Ce.parse
}
, ih = {
  regex: va,
  countKey: "Numbers",
  token: "${n}",
  parse: Ln.parse
};
function is(e, {regex: t, countKey: n, token: r, parse: i}) {
  const o = e.tokenised.match(t);
  !o || (e["num" + n] = o.length,
  e.tokenised = e.tokenised.replace(t, r),
  e.values.push(...o.map(i)))
}
function Fo(e) {
  const t = e.toString()
    , n = {
      value: t,
      tokenised: t,
      values: [],
      numVars: 0,
      numColors: 0,
      numNumbers: 0
  };
  return n.value.includes("var(--") && is(n, nh),
  is(n, rh),
  is(n, ih),
  n
}
function oh(e) {
  return Fo(e).values
}
function ah(e) {
  const {values: t, numColors: n, numVars: r, tokenised: i} = Fo(e)
    , o = t.length;
  return a => {
      let s = i;
      for (let l = 0; l < o; l++)
          l < r ? s = s.replace(nh.token, a[l]) : l < r + n ? s = s.replace(rh.token, Ce.transform(a[l])) : s = s.replace(ih.token, Br(a[l]));
      return s
  }
}
const jv = e => typeof e == "number" ? 0 : e;
function Iv(e) {
  const t = oh(e);
  return ah(e)(t.map(jv))
}
const qt = {
  test: Dv,
  parse: oh,
  createTransformer: ah,
  getAnimatableNone: Iv
}
, sh = (e, t) => n => `${n > 0 ? t : e}`;
function lh(e, t) {
  return typeof e == "number" ? n => J(e, t, n) : Ce.test(e) ? th(e, t) : e.startsWith("var(") ? sh(e, t) : ch(e, t)
}
const uh = (e, t) => {
  const n = [...e]
    , r = n.length
    , i = e.map( (o, a) => lh(o, t[a]));
  return o => {
      for (let a = 0; a < r; a++)
          n[a] = i[a](o);
      return n
  }
}
, Fv = (e, t) => {
  const n = {
      ...e,
      ...t
  }
    , r = {};
  for (const i in n)
      e[i] !== void 0 && t[i] !== void 0 && (r[i] = lh(e[i], t[i]));
  return i => {
      for (const o in r)
          n[o] = r[o](i);
      return n
  }
}
, ch = (e, t) => {
  const n = qt.createTransformer(t)
    , r = Fo(e)
    , i = Fo(t);
  return r.numVars === i.numVars && r.numColors === i.numColors && r.numNumbers >= i.numNumbers ? Wt(uh(r.values, i.values), n) : (bu(!0),
  sh(e, t))
}
, hi = (e, t, n) => {
  const r = t - e;
  return r === 0 ? 1 : (n - e) / r
}
, E0 = (e, t) => n => J(e, t, n);
function _v(e) {
  return typeof e == "number" ? E0 : typeof e == "string" ? Ce.test(e) ? th : ch : Array.isArray(e) ? uh : typeof e == "object" ? Fv : E0
}
function zv(e, t, n) {
  const r = []
    , i = n || _v(e[0])
    , o = e.length - 1;
  for (let a = 0; a < o; a++) {
      let s = i(e[a], e[a + 1]);
      if (t) {
          const l = Array.isArray(t) ? t[a] || re : t;
          s = Wt(l, s)
      }
      r.push(s)
  }
  return r
}
function dh(e, t, {clamp: n=!0, ease: r, mixer: i}={}) {
  const o = e.length;
  if (Sa(o === t.length),
  o === 1)
      return () => t[0];
  e[0] > e[o - 1] && (e = [...e].reverse(),
  t = [...t].reverse());
  const a = zv(t, r, i)
    , s = a.length
    , l = u => {
      let f = 0;
      if (s > 1)
          for (; f < e.length - 2 && !(u < e[f + 1]); f++)
              ;
      const d = hi(e[f], e[f + 1], u);
      return a[f](d)
  }
  ;
  return n ? u => l(Xt(e[0], e[o - 1], u)) : l
}
function Hv(e, t) {
  const n = e[e.length - 1];
  for (let r = 1; r <= t; r++) {
      const i = hi(0, t, r);
      e.push(J(n, 1, i))
  }
}
function Bv(e) {
  const t = [0];
  return Hv(t, e.length - 1),
  t
}
function $v(e, t) {
  return e.map(n => n * t)
}
function Uv(e, t) {
  return e.map( () => t || Km).splice(0, e.length - 1)
}
function _o({duration: e=300, keyframes: t, times: n, ease: r="easeInOut"}) {
  const i = Pv(r) ? r.map(w0) : w0(r)
    , o = {
      done: !1,
      value: t[0]
  }
    , a = $v(n && n.length === t.length ? n : Bv(t), e)
    , s = dh(a, t, {
      ease: Array.isArray(i) ? i : Uv(t, i)
  });
  return {
      calculatedDuration: e,
      next: l => (o.value = s(l),
      o.done = l >= e,
      o)
  }
}
function fh(e, t) {
  return t ? e * (1e3 / t) : 0
}
const Zv = 5;
function mh(e, t, n) {
  const r = Math.max(t - Zv, 0);
  return fh(n - e(r), t - r)
}
const os = .001
, Gv = .01
, N0 = 10
, Wv = .05
, Qv = 1;
function Kv({duration: e=800, bounce: t=.25, velocity: n=0, mass: r=1}) {
  let i, o;
  bu(e <= Qt(N0));
  let a = 1 - t;
  a = Xt(Wv, Qv, a),
  e = Xt(Gv, N0, St(e)),
  a < 1 ? (i = u => {
      const f = u * a
        , d = f * e
        , m = f - n
        , p = cl(u, a)
        , v = Math.exp(-d);
      return os - m / p * v
  }
  ,
  o = u => {
      const d = u * a * e
        , m = d * n + n
        , p = Math.pow(a, 2) * Math.pow(u, 2) * e
        , v = Math.exp(-d)
        , x = cl(Math.pow(u, 2), a);
      return (-i(u) + os > 0 ? -1 : 1) * ((m - p) * v) / x
  }
  ) : (i = u => {
      const f = Math.exp(-u * e)
        , d = (u - n) * e + 1;
      return -os + f * d
  }
  ,
  o = u => {
      const f = Math.exp(-u * e)
        , d = (n - u) * (e * e);
      return f * d
  }
  );
  const s = 5 / e
    , l = Xv(i, o, s);
  if (e = Qt(e),
  isNaN(l))
      return {
          stiffness: 100,
          damping: 10,
          duration: e
      };
  {
      const u = Math.pow(l, 2) * r;
      return {
          stiffness: u,
          damping: a * 2 * Math.sqrt(r * u),
          duration: e
      }
  }
}
const Yv = 12;
function Xv(e, t, n) {
  let r = n;
  for (let i = 1; i < Yv; i++)
      r = r - e(r) / t(r);
  return r
}
function cl(e, t) {
  return e * Math.sqrt(1 - t * t)
}
const qv = ["duration", "bounce"]
, Jv = ["stiffness", "damping", "mass"];
function C0(e, t) {
  return t.some(n => e[n] !== void 0)
}
function e8(e) {
  let t = {
      velocity: 0,
      stiffness: 100,
      damping: 10,
      mass: 1,
      isResolvedFromDuration: !1,
      ...e
  };
  if (!C0(e, Jv) && C0(e, qv)) {
      const n = Kv(e);
      t = {
          ...t,
          ...n,
          mass: 1
      },
      t.isResolvedFromDuration = !0
  }
  return t
}
function hh({keyframes: e, restDelta: t, restSpeed: n, ...r}) {
  const i = e[0]
    , o = e[e.length - 1]
    , a = {
      done: !1,
      value: i
  }
    , {stiffness: s, damping: l, mass: u, duration: f, velocity: d, isResolvedFromDuration: m} = e8({
      ...r,
      velocity: -St(r.velocity || 0)
  })
    , p = d || 0
    , v = l / (2 * Math.sqrt(s * u))
    , x = o - i
    , P = St(Math.sqrt(s / u))
    , y = Math.abs(x) < 5;
  n || (n = y ? .01 : 2),
  t || (t = y ? .005 : .5);
  let h;
  if (v < 1) {
      const g = cl(P, v);
      h = S => {
          const M = Math.exp(-v * P * S);
          return o - M * ((p + v * P * x) / g * Math.sin(g * S) + x * Math.cos(g * S))
      }
  } else if (v === 1)
      h = g => o - Math.exp(-P * g) * (x + (p + P * x) * g);
  else {
      const g = P * Math.sqrt(v * v - 1);
      h = S => {
          const M = Math.exp(-v * P * S)
            , A = Math.min(g * S, 300);
          return o - M * ((p + v * P * x) * Math.sinh(A) + g * x * Math.cosh(A)) / g
      }
  }
  return {
      calculatedDuration: m && f || null,
      next: g => {
          const S = h(g);
          if (m)
              a.done = g >= f;
          else {
              let M = p;
              g !== 0 && (v < 1 ? M = mh(h, g, S) : M = 0);
              const A = Math.abs(M) <= n
                , C = Math.abs(o - S) <= t;
              a.done = A && C
          }
          return a.value = a.done ? o : S,
          a
      }
  }
}
function P0({keyframes: e, velocity: t=0, power: n=.8, timeConstant: r=325, bounceDamping: i=10, bounceStiffness: o=500, modifyTarget: a, min: s, max: l, restDelta: u=.5, restSpeed: f}) {
  const d = e[0]
    , m = {
      done: !1,
      value: d
  }
    , p = N => s !== void 0 && N < s || l !== void 0 && N > l
    , v = N => s === void 0 ? l : l === void 0 || Math.abs(s - N) < Math.abs(l - N) ? s : l;
  let x = n * t;
  const P = d + x
    , y = a === void 0 ? P : a(P);
  y !== P && (x = y - d);
  const h = N => -x * Math.exp(-N / r)
    , g = N => y + h(N)
    , S = N => {
      const R = h(N)
        , O = g(N);
      m.done = Math.abs(R) <= u,
      m.value = m.done ? y : O
  }
  ;
  let M, A;
  const C = N => {
      !p(m.value) || (M = N,
      A = hh({
          keyframes: [m.value, v(m.value)],
          velocity: mh(g, N, m.value),
          damping: i,
          stiffness: o,
          restDelta: u,
          restSpeed: f
      }))
  }
  ;
  return C(0),
  {
      calculatedDuration: null,
      next: N => {
          let R = !1;
          return !A && M === void 0 && (R = !0,
          S(N),
          C(N)),
          M !== void 0 && N > M ? A.next(N - M) : (!R && S(N),
          m)
      }
  }
}
const t8 = e => {
  const t = ({timestamp: n}) => e(n);
  return {
      start: () => W.update(t, !0),
      stop: () => At(t),
      now: () => Se.isProcessing ? Se.timestamp : performance.now()
  }
}
, A0 = 2e4;
function k0(e) {
  let t = 0;
  const n = 50;
  let r = e.next(t);
  for (; !r.done && t < A0; )
      t += n,
      r = e.next(t);
  return t >= A0 ? 1 / 0 : t
}
const n8 = {
  decay: P0,
  inertia: P0,
  tween: _o,
  keyframes: _o,
  spring: hh
};
function zo({autoplay: e=!0, delay: t=0, driver: n=t8, keyframes: r, type: i="keyframes", repeat: o=0, repeatDelay: a=0, repeatType: s="loop", onPlay: l, onStop: u, onComplete: f, onUpdate: d, ...m}) {
  let p = 1, v = !1, x, P;
  const y = () => {
      P = new Promise(F => {
          x = F
      }
      )
  }
  ;
  y();
  let h;
  const g = n8[i] || _o;
  let S;
  g !== _o && typeof r[0] != "number" && (S = dh([0, 100], r, {
      clamp: !1
  }),
  r = [0, 100]);
  const M = g({
      ...m,
      keyframes: r
  });
  let A;
  s === "mirror" && (A = g({
      ...m,
      keyframes: [...r].reverse(),
      velocity: -(m.velocity || 0)
  }));
  let C = "idle"
    , N = null
    , R = null
    , O = null;
  M.calculatedDuration === null && o && (M.calculatedDuration = k0(M));
  const {calculatedDuration: U} = M;
  let ue = 1 / 0
    , pe = 1 / 0;
  U !== null && (ue = U + a,
  pe = ue * (o + 1) - a);
  let ae = 0;
  const qe = F => {
      if (R === null)
          return;
      p > 0 && (R = Math.min(R, F)),
      p < 0 && (R = Math.min(F - pe / p, R)),
      N !== null ? ae = N : ae = Math.round(F - R) * p;
      const Y = ae - t * (p >= 0 ? 1 : -1)
        , rn = p >= 0 ? Y < 0 : Y > pe;
      ae = Math.max(Y, 0),
      C === "finished" && N === null && (ae = pe);
      let at = ae
        , Rn = M;
      if (o) {
          const Ea = Math.min(ae, pe) / ue;
          let Pi = Math.floor(Ea)
            , an = Ea % 1;
          !an && Ea >= 1 && (an = 1),
          an === 1 && Pi--,
          Pi = Math.min(Pi, o + 1),
          Boolean(Pi % 2) && (s === "reverse" ? (an = 1 - an,
          a && (an -= a / ue)) : s === "mirror" && (Rn = A)),
          at = Xt(0, 1, an) * ue
      }
      const je = rn ? {
          done: !1,
          value: r[0]
      } : Rn.next(at);
      S && (je.value = S(je.value));
      let {done: on} = je;
      !rn && U !== null && (on = p >= 0 ? ae >= pe : ae <= 0);
      const tp = N === null && (C === "finished" || C === "running" && on);
      return d && d(je.value),
      tp && b(),
      je
  }
    , D = () => {
      h && h.stop(),
      h = void 0
  }
    , Me = () => {
      C = "idle",
      D(),
      x(),
      y(),
      R = O = null
  }
    , b = () => {
      C = "finished",
      f && f(),
      D(),
      x()
  }
    , I = () => {
      if (v)
          return;
      h || (h = n(qe));
      const F = h.now();
      l && l(),
      N !== null ? R = F - N : (!R || C === "finished") && (R = F),
      C === "finished" && y(),
      O = R,
      N = null,
      C = "running",
      h.start()
  }
  ;
  e && I();
  const _ = {
      then(F, Y) {
          return P.then(F, Y)
      },
      get time() {
          return St(ae)
      },
      set time(F) {
          F = Qt(F),
          ae = F,
          N !== null || !h || p === 0 ? N = F : R = h.now() - F / p
      },
      get duration() {
          const F = M.calculatedDuration === null ? k0(M) : M.calculatedDuration;
          return St(F)
      },
      get speed() {
          return p
      },
      set speed(F) {
          F === p || !h || (p = F,
          _.time = St(ae))
      },
      get state() {
          return C
      },
      play: I,
      pause: () => {
          C = "paused",
          N = ae
      }
      ,
      stop: () => {
          v = !0,
          C !== "idle" && (C = "idle",
          u && u(),
          Me())
      }
      ,
      cancel: () => {
          O !== null && qe(O),
          Me()
      }
      ,
      complete: () => {
          C = "finished"
      }
      ,
      sample: F => (R = 0,
      qe(F))
  };
  return _
}
function r8(e) {
  let t;
  return () => (t === void 0 && (t = e()),
  t)
}
const i8 = r8( () => Object.hasOwnProperty.call(Element.prototype, "animate"))
, o8 = new Set(["opacity", "clipPath", "filter", "transform", "backgroundColor"])
, Zi = 10
, a8 = 2e4
, s8 = (e, t) => t.type === "spring" || e === "backgroundColor" || !Zm(t.ease);
function l8(e, t, {onUpdate: n, onComplete: r, ...i}) {
  if (!(i8() && o8.has(t) && !i.repeatDelay && i.repeatType !== "mirror" && i.damping !== 0 && i.type !== "inertia"))
      return !1;
  let a = !1, s, l, u = !1;
  const f = () => {
      l = new Promise(g => {
          s = g
      }
      )
  }
  ;
  f();
  let {keyframes: d, duration: m=300, ease: p, times: v} = i;
  if (s8(t, i)) {
      const g = zo({
          ...i,
          repeat: 0,
          delay: 0
      });
      let S = {
          done: !1,
          value: d[0]
      };
      const M = [];
      let A = 0;
      for (; !S.done && A < a8; )
          S = g.sample(A),
          M.push(S.value),
          A += Zi;
      v = void 0,
      d = M,
      m = A - Zi,
      p = "linear"
  }
  const x = vv(e.owner.current, t, d, {
      ...i,
      duration: m,
      ease: p,
      times: v
  })
    , P = () => {
      u = !1,
      x.cancel()
  }
    , y = () => {
      u = !0,
      W.update(P),
      s(),
      f()
  }
  ;
  return x.onfinish = () => {
      u || (e.set(xv(d, i)),
      r && r(),
      y())
  }
  ,
  {
      then(g, S) {
          return l.then(g, S)
      },
      attachTimeline(g) {
          return x.timeline = g,
          x.onfinish = null,
          re
      },
      get time() {
          return St(x.currentTime || 0)
      },
      set time(g) {
          x.currentTime = Qt(g)
      },
      get speed() {
          return x.playbackRate
      },
      set speed(g) {
          x.playbackRate = g
      },
      get duration() {
          return St(m)
      },
      play: () => {
          a || (x.play(),
          At(P))
      }
      ,
      pause: () => x.pause(),
      stop: () => {
          if (a = !0,
          x.playState === "idle")
              return;
          const {currentTime: g} = x;
          if (g) {
              const S = zo({
                  ...i,
                  autoplay: !1
              });
              e.setWithVelocity(S.sample(g - Zi).value, S.sample(g).value, Zi)
          }
          y()
      }
      ,
      complete: () => {
          u || x.finish()
      }
      ,
      cancel: y
  }
}
function u8({keyframes: e, delay: t, onUpdate: n, onComplete: r}) {
  const i = () => (n && n(e[e.length - 1]),
  r && r(),
  {
      time: 0,
      speed: 1,
      duration: 0,
      play: re,
      pause: re,
      stop: re,
      then: o => (o(),
      Promise.resolve()),
      cancel: re,
      complete: re
  });
  return t ? zo({
      keyframes: [0, 1],
      duration: 0,
      delay: t,
      onComplete: i
  }) : i()
}
const c8 = {
  type: "spring",
  stiffness: 500,
  damping: 25,
  restSpeed: 10
}
, d8 = e => ({
  type: "spring",
  stiffness: 550,
  damping: e === 0 ? 2 * Math.sqrt(550) : 30,
  restSpeed: 10
})
, f8 = {
  type: "keyframes",
  duration: .8
}
, m8 = {
  type: "keyframes",
  ease: [.25, .1, .35, 1],
  duration: .3
}
, h8 = (e, {keyframes: t}) => t.length > 2 ? f8 : Mn.has(e) ? e.startsWith("scale") ? d8(t[1]) : c8 : m8
, dl = (e, t) => e === "zIndex" ? !1 : !!(typeof t == "number" || Array.isArray(t) || typeof t == "string" && (qt.test(t) || t === "0") && !t.startsWith("url("))
, p8 = new Set(["brightness", "contrast", "saturate", "opacity"]);
function g8(e) {
  const [t,n] = e.slice(0, -1).split("(");
  if (t === "drop-shadow")
      return e;
  const [r] = n.match(va) || [];
  if (!r)
      return e;
  const i = n.replace(r, "");
  let o = p8.has(t) ? 1 : 0;
  return r !== n && (o *= 100),
  t + "(" + o + i + ")"
}
const y8 = /([a-z-]*)\(.*?\)/g
, fl = {
  ...qt,
  getAnimatableNone: e => {
      const t = e.match(y8);
      return t ? t.map(g8).join(" ") : e
  }
}
, v8 = {
  ...Tm,
  color: Ce,
  backgroundColor: Ce,
  outlineColor: Ce,
  fill: Ce,
  stroke: Ce,
  borderColor: Ce,
  borderTopColor: Ce,
  borderRightColor: Ce,
  borderBottomColor: Ce,
  borderLeftColor: Ce,
  filter: fl,
  WebkitFilter: fl
}
, ju = e => v8[e];
function ph(e, t) {
  let n = ju(e);
  return n !== fl && (n = qt),
  n.getAnimatableNone ? n.getAnimatableNone(t) : void 0
}
const gh = e => /^0[^.\s]+$/.test(e);
function x8(e) {
  if (typeof e == "number")
      return e === 0;
  if (e !== null)
      return e === "none" || e === "0" || gh(e)
}
function w8(e, t, n, r) {
  const i = dl(t, n);
  let o;
  Array.isArray(n) ? o = [...n] : o = [null, n];
  const a = r.from !== void 0 ? r.from : e.get();
  let s;
  const l = [];
  for (let u = 0; u < o.length; u++)
      o[u] === null && (o[u] = u === 0 ? a : o[u - 1]),
      x8(o[u]) && l.push(u),
      typeof o[u] == "string" && o[u] !== "none" && o[u] !== "0" && (s = o[u]);
  if (i && l.length && s)
      for (let u = 0; u < l.length; u++) {
          const f = l[u];
          o[f] = ph(t, s)
      }
  return o
}
function S8({when: e, delay: t, delayChildren: n, staggerChildren: r, staggerDirection: i, repeat: o, repeatType: a, repeatDelay: s, from: l, elapsed: u, ...f}) {
  return !!Object.keys(f).length
}
function Iu(e, t) {
  return e[t] || e.default || e
}
const E8 = {
  skipAnimations: !1
}
, Fu = (e, t, n, r={}) => i => {
  const o = Iu(r, e) || {}
    , a = o.delay || r.delay || 0;
  let {elapsed: s=0} = r;
  s = s - Qt(a);
  const l = w8(t, e, n, o)
    , u = l[0]
    , f = l[l.length - 1]
    , d = dl(e, u)
    , m = dl(e, f);
  bu(d === m);
  let p = {
      keyframes: l,
      velocity: t.getVelocity(),
      ease: "easeOut",
      ...o,
      delay: -s,
      onUpdate: v => {
          t.set(v),
          o.onUpdate && o.onUpdate(v)
      }
      ,
      onComplete: () => {
          i(),
          o.onComplete && o.onComplete()
      }
  };
  if (S8(o) || (p = {
      ...p,
      ...h8(e, p)
  }),
  p.duration && (p.duration = Qt(p.duration)),
  p.repeatDelay && (p.repeatDelay = Qt(p.repeatDelay)),
  !d || !m || x0.current || o.type === !1 || E8.skipAnimations)
      return u8(x0.current ? {
          ...p,
          delay: 0
      } : p);
  if (!r.isHandoff && t.owner && t.owner.current instanceof HTMLElement && !t.owner.getProps().onUpdate) {
      const v = l8(t, e, p);
      if (v)
          return v
  }
  return zo(p)
}
;
function Ho(e) {
  return Boolean(De(e) && e.add)
}
const yh = e => /^\-?\d*\.?\d+$/.test(e);
function _u(e, t) {
  e.indexOf(t) === -1 && e.push(t)
}
function zu(e, t) {
  const n = e.indexOf(t);
  n > -1 && e.splice(n, 1)
}
class Hu {
  constructor() {
      this.subscriptions = []
  }
  add(t) {
      return _u(this.subscriptions, t),
      () => zu(this.subscriptions, t)
  }
  notify(t, n, r) {
      const i = this.subscriptions.length;
      if (!!i)
          if (i === 1)
              this.subscriptions[0](t, n, r);
          else
              for (let o = 0; o < i; o++) {
                  const a = this.subscriptions[o];
                  a && a(t, n, r)
              }
  }
  getSize() {
      return this.subscriptions.length
  }
  clear() {
      this.subscriptions.length = 0
  }
}
const N8 = e => !isNaN(parseFloat(e));
class C8 {
  constructor(t, n={}) {
      this.version = "10.18.0",
      this.timeDelta = 0,
      this.lastUpdated = 0,
      this.canTrackVelocity = !1,
      this.events = {},
      this.updateAndNotify = (r, i=!0) => {
          this.prev = this.current,
          this.current = r;
          const {delta: o, timestamp: a} = Se;
          this.lastUpdated !== a && (this.timeDelta = o,
          this.lastUpdated = a,
          W.postRender(this.scheduleVelocityCheck)),
          this.prev !== this.current && this.events.change && this.events.change.notify(this.current),
          this.events.velocityChange && this.events.velocityChange.notify(this.getVelocity()),
          i && this.events.renderRequest && this.events.renderRequest.notify(this.current)
      }
      ,
      this.scheduleVelocityCheck = () => W.postRender(this.velocityCheck),
      this.velocityCheck = ({timestamp: r}) => {
          r !== this.lastUpdated && (this.prev = this.current,
          this.events.velocityChange && this.events.velocityChange.notify(this.getVelocity()))
      }
      ,
      this.hasAnimated = !1,
      this.prev = this.current = t,
      this.canTrackVelocity = N8(this.current),
      this.owner = n.owner
  }
  onChange(t) {
      return this.on("change", t)
  }
  on(t, n) {
      this.events[t] || (this.events[t] = new Hu);
      const r = this.events[t].add(n);
      return t === "change" ? () => {
          r(),
          W.read( () => {
              this.events.change.getSize() || this.stop()
          }
          )
      }
      : r
  }
  clearListeners() {
      for (const t in this.events)
          this.events[t].clear()
  }
  attach(t, n) {
      this.passiveEffect = t,
      this.stopPassiveEffect = n
  }
  set(t, n=!0) {
      !n || !this.passiveEffect ? this.updateAndNotify(t, n) : this.passiveEffect(t, this.updateAndNotify)
  }
  setWithVelocity(t, n, r) {
      this.set(n),
      this.prev = t,
      this.timeDelta = r
  }
  jump(t) {
      this.updateAndNotify(t),
      this.prev = t,
      this.stop(),
      this.stopPassiveEffect && this.stopPassiveEffect()
  }
  get() {
      return this.current
  }
  getPrevious() {
      return this.prev
  }
  getVelocity() {
      return this.canTrackVelocity ? fh(parseFloat(this.current) - parseFloat(this.prev), this.timeDelta) : 0
  }
  start(t) {
      return this.stop(),
      new Promise(n => {
          this.hasAnimated = !0,
          this.animation = t(n),
          this.events.animationStart && this.events.animationStart.notify()
      }
      ).then( () => {
          this.events.animationComplete && this.events.animationComplete.notify(),
          this.clearAnimation()
      }
      )
  }
  stop() {
      this.animation && (this.animation.stop(),
      this.events.animationCancel && this.events.animationCancel.notify()),
      this.clearAnimation()
  }
  isAnimating() {
      return !!this.animation
  }
  clearAnimation() {
      delete this.animation
  }
  destroy() {
      this.clearListeners(),
      this.stop(),
      this.stopPassiveEffect && this.stopPassiveEffect()
  }
}
function ur(e, t) {
  return new C8(e,t)
}
const vh = e => t => t.test(e)
, P8 = {
  test: e => e === "auto",
  parse: e => e
}
, xh = [Ln, j, ft, Lt, Vy, Oy, P8]
, Pr = e => xh.find(vh(e))
, A8 = [...xh, Ce, qt]
, k8 = e => A8.find(vh(e));
function T8(e, t, n) {
  e.hasValue(t) ? e.getValue(t).set(n) : e.addValue(t, ur(n))
}
function M8(e, t) {
  const n = wa(e, t);
  let {transitionEnd: r={}, transition: i={}, ...o} = n ? e.makeTargetAnimatable(n, !1) : {};
  o = {
      ...o,
      ...r
  };
  for (const a in o) {
      const s = Qy(o[a]);
      T8(e, a, s)
  }
}
function L8(e, t, n) {
  var r, i;
  const o = Object.keys(t).filter(s => !e.hasValue(s))
    , a = o.length;
  if (!!a)
      for (let s = 0; s < a; s++) {
          const l = o[s]
            , u = t[l];
          let f = null;
          Array.isArray(u) && (f = u[0]),
          f === null && (f = (i = (r = n[l]) !== null && r !== void 0 ? r : e.readValue(l)) !== null && i !== void 0 ? i : t[l]),
          f != null && (typeof f == "string" && (yh(f) || gh(f)) ? f = parseFloat(f) : !k8(f) && qt.test(u) && (f = ph(l, u)),
          e.addValue(l, ur(f, {
              owner: e
          })),
          n[l] === void 0 && (n[l] = f),
          f !== null && e.setBaseTarget(l, f))
      }
}
function R8(e, t) {
  return t ? (t[e] || t.default || t).from : void 0
}
function b8(e, t, n) {
  const r = {};
  for (const i in e) {
      const o = R8(i, t);
      if (o !== void 0)
          r[i] = o;
      else {
          const a = n.getValue(i);
          a && (r[i] = a.get())
      }
  }
  return r
}
function O8({protectedKeys: e, needsAnimating: t}, n) {
  const r = e.hasOwnProperty(n) && t[n] !== !0;
  return t[n] = !1,
  r
}
function V8(e, t) {
  const n = e.get();
  if (Array.isArray(t)) {
      for (let r = 0; r < t.length; r++)
          if (t[r] !== n)
              return !0
  } else
      return n !== t
}
function wh(e, t, {delay: n=0, transitionOverride: r, type: i}={}) {
  let {transition: o=e.getDefaultTransition(), transitionEnd: a, ...s} = e.makeTargetAnimatable(t);
  const l = e.getValue("willChange");
  r && (o = r);
  const u = []
    , f = i && e.animationState && e.animationState.getState()[i];
  for (const d in s) {
      const m = e.getValue(d)
        , p = s[d];
      if (!m || p === void 0 || f && O8(f, d))
          continue;
      const v = {
          delay: n,
          elapsed: 0,
          ...Iu(o || {}, d)
      };
      if (window.HandoffAppearAnimations) {
          const y = e.getProps()[Sm];
          if (y) {
              const h = window.HandoffAppearAnimations(y, d, m, W);
              h !== null && (v.elapsed = h,
              v.isHandoff = !0)
          }
      }
      let x = !v.isHandoff && !V8(m, p);
      if (v.type === "spring" && (m.getVelocity() || v.velocity) && (x = !1),
      m.animation && (x = !1),
      x)
          continue;
      m.start(Fu(d, m, p, e.shouldReduceMotion && Mn.has(d) ? {
          type: !1
      } : v));
      const P = m.animation;
      Ho(l) && (l.add(d),
      P.then( () => l.remove(d))),
      u.push(P)
  }
  return a && Promise.all(u).then( () => {
      a && M8(e, a)
  }
  ),
  u
}
function ml(e, t, n={}) {
  const r = wa(e, t, n.custom);
  let {transition: i=e.getDefaultTransition() || {}} = r || {};
  n.transitionOverride && (i = n.transitionOverride);
  const o = r ? () => Promise.all(wh(e, r, n)) : () => Promise.resolve()
    , a = e.variantChildren && e.variantChildren.size ? (l=0) => {
      const {delayChildren: u=0, staggerChildren: f, staggerDirection: d} = i;
      return D8(e, t, u + l, f, d, n)
  }
  : () => Promise.resolve()
    , {when: s} = i;
  if (s) {
      const [l,u] = s === "beforeChildren" ? [o, a] : [a, o];
      return l().then( () => u())
  } else
      return Promise.all([o(), a(n.delay)])
}
function D8(e, t, n=0, r=0, i=1, o) {
  const a = []
    , s = (e.variantChildren.size - 1) * r
    , l = i === 1 ? (u=0) => u * r : (u=0) => s - u * r;
  return Array.from(e.variantChildren).sort(j8).forEach( (u, f) => {
      u.notify("AnimationStart", t),
      a.push(ml(u, t, {
          ...o,
          delay: n + l(f)
      }).then( () => u.notify("AnimationComplete", t)))
  }
  ),
  Promise.all(a)
}
function j8(e, t) {
  return e.sortNodePosition(t)
}
function I8(e, t, n={}) {
  e.notify("AnimationStart", t);
  let r;
  if (Array.isArray(t)) {
      const i = t.map(o => ml(e, o, n));
      r = Promise.all(i)
  } else if (typeof t == "string")
      r = ml(e, t, n);
  else {
      const i = typeof t == "function" ? wa(e, t, n.custom) : t;
      r = Promise.all(wh(e, i, n))
  }
  return r.then( () => e.notify("AnimationComplete", t))
}
const F8 = [...Eu].reverse()
, _8 = Eu.length;
function z8(e) {
  return t => Promise.all(t.map( ({animation: n, options: r}) => I8(e, n, r)))
}
function H8(e) {
  let t = z8(e);
  const n = $8();
  let r = !0;
  const i = (l, u) => {
      const f = wa(e, u);
      if (f) {
          const {transition: d, transitionEnd: m, ...p} = f;
          l = {
              ...l,
              ...p,
              ...m
          }
      }
      return l
  }
  ;
  function o(l) {
      t = l(e)
  }
  function a(l, u) {
      const f = e.getProps()
        , d = e.getVariantContext(!0) || {}
        , m = []
        , p = new Set;
      let v = {}
        , x = 1 / 0;
      for (let y = 0; y < _8; y++) {
          const h = F8[y]
            , g = n[h]
            , S = f[h] !== void 0 ? f[h] : d[h]
            , M = fi(S)
            , A = h === u ? g.isActive : null;
          A === !1 && (x = y);
          let C = S === d[h] && S !== f[h] && M;
          if (C && r && e.manuallyAnimateOnMount && (C = !1),
          g.protectedKeys = {
              ...v
          },
          !g.isActive && A === null || !S && !g.prevProp || ga(S) || typeof S == "boolean")
              continue;
          let R = B8(g.prevProp, S) || h === u && g.isActive && !C && M || y > x && M
            , O = !1;
          const U = Array.isArray(S) ? S : [S];
          let ue = U.reduce(i, {});
          A === !1 && (ue = {});
          const {prevResolvedValues: pe={}} = g
            , ae = {
              ...pe,
              ...ue
          }
            , qe = D => {
              R = !0,
              p.has(D) && (O = !0,
              p.delete(D)),
              g.needsAnimating[D] = !0
          }
          ;
          for (const D in ae) {
              const Me = ue[D]
                , b = pe[D];
              if (v.hasOwnProperty(D))
                  continue;
              let I = !1;
              Io(Me) && Io(b) ? I = !$m(Me, b) : I = Me !== b,
              I ? Me !== void 0 ? qe(D) : p.add(D) : Me !== void 0 && p.has(D) ? qe(D) : g.protectedKeys[D] = !0
          }
          g.prevProp = S,
          g.prevResolvedValues = ue,
          g.isActive && (v = {
              ...v,
              ...ue
          }),
          r && e.blockInitialAnimation && (R = !1),
          R && (!C || O) && m.push(...U.map(D => ({
              animation: D,
              options: {
                  type: h,
                  ...l
              }
          })))
      }
      if (p.size) {
          const y = {};
          p.forEach(h => {
              const g = e.getBaseTarget(h);
              g !== void 0 && (y[h] = g)
          }
          ),
          m.push({
              animation: y
          })
      }
      let P = Boolean(m.length);
      return r && (f.initial === !1 || f.initial === f.animate) && !e.manuallyAnimateOnMount && (P = !1),
      r = !1,
      P ? t(m) : Promise.resolve()
  }
  function s(l, u, f) {
      var d;
      if (n[l].isActive === u)
          return Promise.resolve();
      (d = e.variantChildren) === null || d === void 0 || d.forEach(p => {
          var v;
          return (v = p.animationState) === null || v === void 0 ? void 0 : v.setActive(l, u)
      }
      ),
      n[l].isActive = u;
      const m = a(f, l);
      for (const p in n)
          n[p].protectedKeys = {};
      return m
  }
  return {
      animateChanges: a,
      setActive: s,
      setAnimateFunction: o,
      getState: () => n
  }
}
function B8(e, t) {
  return typeof t == "string" ? t !== e : Array.isArray(t) ? !$m(t, e) : !1
}
function sn(e=!1) {
  return {
      isActive: e,
      protectedKeys: {},
      needsAnimating: {},
      prevResolvedValues: {}
  }
}
function $8() {
  return {
      animate: sn(!0),
      whileInView: sn(),
      whileHover: sn(),
      whileTap: sn(),
      whileDrag: sn(),
      whileFocus: sn(),
      exit: sn()
  }
}
class U8 extends nn {
  constructor(t) {
      super(t),
      t.animationState || (t.animationState = H8(t))
  }
  updateAnimationControlsSubscription() {
      const {animate: t} = this.node.getProps();
      this.unmount(),
      ga(t) && (this.unmount = t.subscribe(this.node))
  }
  mount() {
      this.updateAnimationControlsSubscription()
  }
  update() {
      const {animate: t} = this.node.getProps()
        , {animate: n} = this.node.prevProps || {};
      t !== n && this.updateAnimationControlsSubscription()
  }
  unmount() {}
}
let Z8 = 0;
class G8 extends nn {
  constructor() {
      super(...arguments),
      this.id = Z8++
  }
  update() {
      if (!this.node.presenceContext)
          return;
      const {isPresent: t, onExitComplete: n, custom: r} = this.node.presenceContext
        , {isPresent: i} = this.node.prevPresenceContext || {};
      if (!this.node.animationState || t === i)
          return;
      const o = this.node.animationState.setActive("exit", !t, {
          custom: r != null ? r : this.node.getProps().custom
      });
      n && !t && o.then( () => n(this.id))
  }
  mount() {
      const {register: t} = this.node.presenceContext || {};
      t && (this.unmount = t(this.id))
  }
  unmount() {}
}
const W8 = {
  animation: {
      Feature: U8
  },
  exit: {
      Feature: G8
  }
}
, T0 = (e, t) => Math.abs(e - t);
function Q8(e, t) {
  const n = T0(e.x, t.x)
    , r = T0(e.y, t.y);
  return Math.sqrt(n ** 2 + r ** 2)
}
class Sh {
  constructor(t, n, {transformPagePoint: r, contextWindow: i, dragSnapToOrigin: o=!1}={}) {
      if (this.startEvent = null,
      this.lastMoveEvent = null,
      this.lastMoveEventInfo = null,
      this.handlers = {},
      this.contextWindow = window,
      this.updatePoint = () => {
          if (!(this.lastMoveEvent && this.lastMoveEventInfo))
              return;
          const d = ss(this.lastMoveEventInfo, this.history)
            , m = this.startEvent !== null
            , p = Q8(d.offset, {
              x: 0,
              y: 0
          }) >= 3;
          if (!m && !p)
              return;
          const {point: v} = d
            , {timestamp: x} = Se;
          this.history.push({
              ...v,
              timestamp: x
          });
          const {onStart: P, onMove: y} = this.handlers;
          m || (P && P(this.lastMoveEvent, d),
          this.startEvent = this.lastMoveEvent),
          y && y(this.lastMoveEvent, d)
      }
      ,
      this.handlePointerMove = (d, m) => {
          this.lastMoveEvent = d,
          this.lastMoveEventInfo = as(m, this.transformPagePoint),
          W.update(this.updatePoint, !0)
      }
      ,
      this.handlePointerUp = (d, m) => {
          this.end();
          const {onEnd: p, onSessionEnd: v, resumeAnimation: x} = this.handlers;
          if (this.dragSnapToOrigin && x && x(),
          !(this.lastMoveEvent && this.lastMoveEventInfo))
              return;
          const P = ss(d.type === "pointercancel" ? this.lastMoveEventInfo : as(m, this.transformPagePoint), this.history);
          this.startEvent && p && p(d, P),
          v && v(d, P)
      }
      ,
      !Fm(t))
          return;
      this.dragSnapToOrigin = o,
      this.handlers = n,
      this.transformPagePoint = r,
      this.contextWindow = i || window;
      const a = xa(t)
        , s = as(a, this.transformPagePoint)
        , {point: l} = s
        , {timestamp: u} = Se;
      this.history = [{
          ...l,
          timestamp: u
      }];
      const {onSessionStart: f} = n;
      f && f(t, ss(s, this.history)),
      this.removeListeners = Wt(wt(this.contextWindow, "pointermove", this.handlePointerMove), wt(this.contextWindow, "pointerup", this.handlePointerUp), wt(this.contextWindow, "pointercancel", this.handlePointerUp))
  }
  updateHandlers(t) {
      this.handlers = t
  }
  end() {
      this.removeListeners && this.removeListeners(),
      At(this.updatePoint)
  }
}
function as(e, t) {
  return t ? {
      point: t(e.point)
  } : e
}
function M0(e, t) {
  return {
      x: e.x - t.x,
      y: e.y - t.y
  }
}
function ss({point: e}, t) {
  return {
      point: e,
      delta: M0(e, Eh(t)),
      offset: M0(e, K8(t)),
      velocity: Y8(t, .1)
  }
}
function K8(e) {
  return e[0]
}
function Eh(e) {
  return e[e.length - 1]
}
function Y8(e, t) {
  if (e.length < 2)
      return {
          x: 0,
          y: 0
      };
  let n = e.length - 1
    , r = null;
  const i = Eh(e);
  for (; n >= 0 && (r = e[n],
  !(i.timestamp - r.timestamp > Qt(t))); )
      n--;
  if (!r)
      return {
          x: 0,
          y: 0
      };
  const o = St(i.timestamp - r.timestamp);
  if (o === 0)
      return {
          x: 0,
          y: 0
      };
  const a = {
      x: (i.x - r.x) / o,
      y: (i.y - r.y) / o
  };
  return a.x === 1 / 0 && (a.x = 0),
  a.y === 1 / 0 && (a.y = 0),
  a
}
function He(e) {
  return e.max - e.min
}
function hl(e, t=0, n=.01) {
  return Math.abs(e - t) <= n
}
function L0(e, t, n, r=.5) {
  e.origin = r,
  e.originPoint = J(t.min, t.max, e.origin),
  e.scale = He(n) / He(t),
  (hl(e.scale, 1, 1e-4) || isNaN(e.scale)) && (e.scale = 1),
  e.translate = J(n.min, n.max, e.origin) - e.originPoint,
  (hl(e.translate) || isNaN(e.translate)) && (e.translate = 0)
}
function $r(e, t, n, r) {
  L0(e.x, t.x, n.x, r ? r.originX : void 0),
  L0(e.y, t.y, n.y, r ? r.originY : void 0)
}
function R0(e, t, n) {
  e.min = n.min + t.min,
  e.max = e.min + He(t)
}
function X8(e, t, n) {
  R0(e.x, t.x, n.x),
  R0(e.y, t.y, n.y)
}
function b0(e, t, n) {
  e.min = t.min - n.min,
  e.max = e.min + He(t)
}
function Ur(e, t, n) {
  b0(e.x, t.x, n.x),
  b0(e.y, t.y, n.y)
}
function q8(e, {min: t, max: n}, r) {
  return t !== void 0 && e < t ? e = r ? J(t, e, r.min) : Math.max(e, t) : n !== void 0 && e > n && (e = r ? J(n, e, r.max) : Math.min(e, n)),
  e
}
function O0(e, t, n) {
  return {
      min: t !== void 0 ? e.min + t : void 0,
      max: n !== void 0 ? e.max + n - (e.max - e.min) : void 0
  }
}
function J8(e, {top: t, left: n, bottom: r, right: i}) {
  return {
      x: O0(e.x, n, i),
      y: O0(e.y, t, r)
  }
}
function V0(e, t) {
  let n = t.min - e.min
    , r = t.max - e.max;
  return t.max - t.min < e.max - e.min && ([n,r] = [r, n]),
  {
      min: n,
      max: r
  }
}
function e6(e, t) {
  return {
      x: V0(e.x, t.x),
      y: V0(e.y, t.y)
  }
}
function t6(e, t) {
  let n = .5;
  const r = He(e)
    , i = He(t);
  return i > r ? n = hi(t.min, t.max - r, e.min) : r > i && (n = hi(e.min, e.max - i, t.min)),
  Xt(0, 1, n)
}
function n6(e, t) {
  const n = {};
  return t.min !== void 0 && (n.min = t.min - e.min),
  t.max !== void 0 && (n.max = t.max - e.min),
  n
}
const pl = .35;
function r6(e=pl) {
  return e === !1 ? e = 0 : e === !0 && (e = pl),
  {
      x: D0(e, "left", "right"),
      y: D0(e, "top", "bottom")
  }
}
function D0(e, t, n) {
  return {
      min: j0(e, t),
      max: j0(e, n)
  }
}
function j0(e, t) {
  return typeof e == "number" ? e : e[t] || 0
}
const I0 = () => ({
  translate: 0,
  scale: 1,
  origin: 0,
  originPoint: 0
})
, Wn = () => ({
  x: I0(),
  y: I0()
})
, F0 = () => ({
  min: 0,
  max: 0
})
, se = () => ({
  x: F0(),
  y: F0()
});
function Ze(e) {
  return [e("x"), e("y")]
}
function Nh({top: e, left: t, right: n, bottom: r}) {
  return {
      x: {
          min: t,
          max: n
      },
      y: {
          min: e,
          max: r
      }
  }
}
function i6({x: e, y: t}) {
  return {
      top: t.min,
      right: e.max,
      bottom: t.max,
      left: e.min
  }
}
function o6(e, t) {
  if (!t)
      return e;
  const n = t({
      x: e.left,
      y: e.top
  })
    , r = t({
      x: e.right,
      y: e.bottom
  });
  return {
      top: n.y,
      left: n.x,
      bottom: r.y,
      right: r.x
  }
}
function ls(e) {
  return e === void 0 || e === 1
}
function gl({scale: e, scaleX: t, scaleY: n}) {
  return !ls(e) || !ls(t) || !ls(n)
}
function cn(e) {
  return gl(e) || Ch(e) || e.z || e.rotate || e.rotateX || e.rotateY
}
function Ch(e) {
  return _0(e.x) || _0(e.y)
}
function _0(e) {
  return e && e !== "0%"
}
function Bo(e, t, n) {
  const r = e - n
    , i = t * r;
  return n + i
}
function z0(e, t, n, r, i) {
  return i !== void 0 && (e = Bo(e, i, r)),
  Bo(e, n, r) + t
}
function yl(e, t=0, n=1, r, i) {
  e.min = z0(e.min, t, n, r, i),
  e.max = z0(e.max, t, n, r, i)
}
function Ph(e, {x: t, y: n}) {
  yl(e.x, t.translate, t.scale, t.originPoint),
  yl(e.y, n.translate, n.scale, n.originPoint)
}
function a6(e, t, n, r=!1) {
  const i = n.length;
  if (!i)
      return;
  t.x = t.y = 1;
  let o, a;
  for (let s = 0; s < i; s++) {
      o = n[s],
      a = o.projectionDelta;
      const l = o.instance;
      l && l.style && l.style.display === "contents" || (r && o.options.layoutScroll && o.scroll && o !== o.root && Qn(e, {
          x: -o.scroll.offset.x,
          y: -o.scroll.offset.y
      }),
      a && (t.x *= a.x.scale,
      t.y *= a.y.scale,
      Ph(e, a)),
      r && cn(o.latestValues) && Qn(e, o.latestValues))
  }
  t.x = H0(t.x),
  t.y = H0(t.y)
}
function H0(e) {
  return Number.isInteger(e) || e > 1.0000000000001 || e < .999999999999 ? e : 1
}
function Ot(e, t) {
  e.min = e.min + t,
  e.max = e.max + t
}
function B0(e, t, [n,r,i]) {
  const o = t[i] !== void 0 ? t[i] : .5
    , a = J(e.min, e.max, o);
  yl(e, t[n], t[r], a, t.scale)
}
const s6 = ["x", "scaleX", "originX"]
, l6 = ["y", "scaleY", "originY"];
function Qn(e, t) {
  B0(e.x, t, s6),
  B0(e.y, t, l6)
}
function Ah(e, t) {
  return Nh(o6(e.getBoundingClientRect(), t))
}
function u6(e, t, n) {
  const r = Ah(e, n)
    , {scroll: i} = t;
  return i && (Ot(r.x, i.offset.x),
  Ot(r.y, i.offset.y)),
  r
}
const kh = ({current: e}) => e ? e.ownerDocument.defaultView : null
, c6 = new WeakMap;
class d6 {
  constructor(t) {
      this.openGlobalLock = null,
      this.isDragging = !1,
      this.currentDirection = null,
      this.originPoint = {
          x: 0,
          y: 0
      },
      this.constraints = !1,
      this.hasMutatedConstraints = !1,
      this.elastic = se(),
      this.visualElement = t
  }
  start(t, {snapToCursor: n=!1}={}) {
      const {presenceContext: r} = this.visualElement;
      if (r && r.isPresent === !1)
          return;
      const i = f => {
          const {dragSnapToOrigin: d} = this.getProps();
          d ? this.pauseAnimation() : this.stopAnimation(),
          n && this.snapToCursor(xa(f, "page").point)
      }
        , o = (f, d) => {
          const {drag: m, dragPropagation: p, onDragStart: v} = this.getProps();
          if (m && !p && (this.openGlobalLock && this.openGlobalLock(),
          this.openGlobalLock = zm(m),
          !this.openGlobalLock))
              return;
          this.isDragging = !0,
          this.currentDirection = null,
          this.resolveConstraints(),
          this.visualElement.projection && (this.visualElement.projection.isAnimationBlocked = !0,
          this.visualElement.projection.target = void 0),
          Ze(P => {
              let y = this.getAxisMotionValue(P).get() || 0;
              if (ft.test(y)) {
                  const {projection: h} = this.visualElement;
                  if (h && h.layout) {
                      const g = h.layout.layoutBox[P];
                      g && (y = He(g) * (parseFloat(y) / 100))
                  }
              }
              this.originPoint[P] = y
          }
          ),
          v && W.update( () => v(f, d), !1, !0);
          const {animationState: x} = this.visualElement;
          x && x.setActive("whileDrag", !0)
      }
        , a = (f, d) => {
          const {dragPropagation: m, dragDirectionLock: p, onDirectionLock: v, onDrag: x} = this.getProps();
          if (!m && !this.openGlobalLock)
              return;
          const {offset: P} = d;
          if (p && this.currentDirection === null) {
              this.currentDirection = f6(P),
              this.currentDirection !== null && v && v(this.currentDirection);
              return
          }
          this.updateAxis("x", d.point, P),
          this.updateAxis("y", d.point, P),
          this.visualElement.render(),
          x && x(f, d)
      }
        , s = (f, d) => this.stop(f, d)
        , l = () => Ze(f => {
          var d;
          return this.getAnimationState(f) === "paused" && ((d = this.getAxisMotionValue(f).animation) === null || d === void 0 ? void 0 : d.play())
      }
      )
        , {dragSnapToOrigin: u} = this.getProps();
      this.panSession = new Sh(t,{
          onSessionStart: i,
          onStart: o,
          onMove: a,
          onSessionEnd: s,
          resumeAnimation: l
      },{
          transformPagePoint: this.visualElement.getTransformPagePoint(),
          dragSnapToOrigin: u,
          contextWindow: kh(this.visualElement)
      })
  }
  stop(t, n) {
      const r = this.isDragging;
      if (this.cancel(),
      !r)
          return;
      const {velocity: i} = n;
      this.startAnimation(i);
      const {onDragEnd: o} = this.getProps();
      o && W.update( () => o(t, n))
  }
  cancel() {
      this.isDragging = !1;
      const {projection: t, animationState: n} = this.visualElement;
      t && (t.isAnimationBlocked = !1),
      this.panSession && this.panSession.end(),
      this.panSession = void 0;
      const {dragPropagation: r} = this.getProps();
      !r && this.openGlobalLock && (this.openGlobalLock(),
      this.openGlobalLock = null),
      n && n.setActive("whileDrag", !1)
  }
  updateAxis(t, n, r) {
      const {drag: i} = this.getProps();
      if (!r || !Gi(t, i, this.currentDirection))
          return;
      const o = this.getAxisMotionValue(t);
      let a = this.originPoint[t] + r[t];
      this.constraints && this.constraints[t] && (a = q8(a, this.constraints[t], this.elastic[t])),
      o.set(a)
  }
  resolveConstraints() {
      var t;
      const {dragConstraints: n, dragElastic: r} = this.getProps()
        , i = this.visualElement.projection && !this.visualElement.projection.layout ? this.visualElement.projection.measure(!1) : (t = this.visualElement.projection) === null || t === void 0 ? void 0 : t.layout
        , o = this.constraints;
      n && Zn(n) ? this.constraints || (this.constraints = this.resolveRefConstraints()) : n && i ? this.constraints = J8(i.layoutBox, n) : this.constraints = !1,
      this.elastic = r6(r),
      o !== this.constraints && i && this.constraints && !this.hasMutatedConstraints && Ze(a => {
          this.getAxisMotionValue(a) && (this.constraints[a] = n6(i.layoutBox[a], this.constraints[a]))
      }
      )
  }
  resolveRefConstraints() {
      const {dragConstraints: t, onMeasureDragConstraints: n} = this.getProps();
      if (!t || !Zn(t))
          return !1;
      const r = t.current
        , {projection: i} = this.visualElement;
      if (!i || !i.layout)
          return !1;
      const o = u6(r, i.root, this.visualElement.getTransformPagePoint());
      let a = e6(i.layout.layoutBox, o);
      if (n) {
          const s = n(i6(a));
          this.hasMutatedConstraints = !!s,
          s && (a = Nh(s))
      }
      return a
  }
  startAnimation(t) {
      const {drag: n, dragMomentum: r, dragElastic: i, dragTransition: o, dragSnapToOrigin: a, onDragTransitionEnd: s} = this.getProps()
        , l = this.constraints || {}
        , u = Ze(f => {
          if (!Gi(f, n, this.currentDirection))
              return;
          let d = l && l[f] || {};
          a && (d = {
              min: 0,
              max: 0
          });
          const m = i ? 200 : 1e6
            , p = i ? 40 : 1e7
            , v = {
              type: "inertia",
              velocity: r ? t[f] : 0,
              bounceStiffness: m,
              bounceDamping: p,
              timeConstant: 750,
              restDelta: 1,
              restSpeed: 10,
              ...o,
              ...d
          };
          return this.startAxisValueAnimation(f, v)
      }
      );
      return Promise.all(u).then(s)
  }
  startAxisValueAnimation(t, n) {
      const r = this.getAxisMotionValue(t);
      return r.start(Fu(t, r, 0, n))
  }
  stopAnimation() {
      Ze(t => this.getAxisMotionValue(t).stop())
  }
  pauseAnimation() {
      Ze(t => {
          var n;
          return (n = this.getAxisMotionValue(t).animation) === null || n === void 0 ? void 0 : n.pause()
      }
      )
  }
  getAnimationState(t) {
      var n;
      return (n = this.getAxisMotionValue(t).animation) === null || n === void 0 ? void 0 : n.state
  }
  getAxisMotionValue(t) {
      const n = "_drag" + t.toUpperCase()
        , r = this.visualElement.getProps()
        , i = r[n];
      return i || this.visualElement.getValue(t, (r.initial ? r.initial[t] : void 0) || 0)
  }
  snapToCursor(t) {
      Ze(n => {
          const {drag: r} = this.getProps();
          if (!Gi(n, r, this.currentDirection))
              return;
          const {projection: i} = this.visualElement
            , o = this.getAxisMotionValue(n);
          if (i && i.layout) {
              const {min: a, max: s} = i.layout.layoutBox[n];
              o.set(t[n] - J(a, s, .5))
          }
      }
      )
  }
  scalePositionWithinConstraints() {
      if (!this.visualElement.current)
          return;
      const {drag: t, dragConstraints: n} = this.getProps()
        , {projection: r} = this.visualElement;
      if (!Zn(n) || !r || !this.constraints)
          return;
      this.stopAnimation();
      const i = {
          x: 0,
          y: 0
      };
      Ze(a => {
          const s = this.getAxisMotionValue(a);
          if (s) {
              const l = s.get();
              i[a] = t6({
                  min: l,
                  max: l
              }, this.constraints[a])
          }
      }
      );
      const {transformTemplate: o} = this.visualElement.getProps();
      this.visualElement.current.style.transform = o ? o({}, "") : "none",
      r.root && r.root.updateScroll(),
      r.updateLayout(),
      this.resolveConstraints(),
      Ze(a => {
          if (!Gi(a, t, null))
              return;
          const s = this.getAxisMotionValue(a)
            , {min: l, max: u} = this.constraints[a];
          s.set(J(l, u, i[a]))
      }
      )
  }
  addListeners() {
      if (!this.visualElement.current)
          return;
      c6.set(this.visualElement, this);
      const t = this.visualElement.current
        , n = wt(t, "pointerdown", l => {
          const {drag: u, dragListener: f=!0} = this.getProps();
          u && f && this.start(l)
      }
      )
        , r = () => {
          const {dragConstraints: l} = this.getProps();
          Zn(l) && (this.constraints = this.resolveRefConstraints())
      }
        , {projection: i} = this.visualElement
        , o = i.addEventListener("measure", r);
      i && !i.layout && (i.root && i.root.updateScroll(),
      i.updateLayout()),
      r();
      const a = vt(window, "resize", () => this.scalePositionWithinConstraints())
        , s = i.addEventListener("didUpdate", ({delta: l, hasLayoutChanged: u}) => {
          this.isDragging && u && (Ze(f => {
              const d = this.getAxisMotionValue(f);
              !d || (this.originPoint[f] += l[f].translate,
              d.set(d.get() + l[f].translate))
          }
          ),
          this.visualElement.render())
      }
      );
      return () => {
          a(),
          n(),
          o(),
          s && s()
      }
  }
  getProps() {
      const t = this.visualElement.getProps()
        , {drag: n=!1, dragDirectionLock: r=!1, dragPropagation: i=!1, dragConstraints: o=!1, dragElastic: a=pl, dragMomentum: s=!0} = t;
      return {
          ...t,
          drag: n,
          dragDirectionLock: r,
          dragPropagation: i,
          dragConstraints: o,
          dragElastic: a,
          dragMomentum: s
      }
  }
}
function Gi(e, t, n) {
  return (t === !0 || t === e) && (n === null || n === e)
}
function f6(e, t=10) {
  let n = null;
  return Math.abs(e.y) > t ? n = "y" : Math.abs(e.x) > t && (n = "x"),
  n
}
class m6 extends nn {
  constructor(t) {
      super(t),
      this.removeGroupControls = re,
      this.removeListeners = re,
      this.controls = new d6(t)
  }
  mount() {
      const {dragControls: t} = this.node.getProps();
      t && (this.removeGroupControls = t.subscribe(this.controls)),
      this.removeListeners = this.controls.addListeners() || re
  }
  unmount() {
      this.removeGroupControls(),
      this.removeListeners()
  }
}
const $0 = e => (t, n) => {
  e && W.update( () => e(t, n))
}
;
class h6 extends nn {
  constructor() {
      super(...arguments),
      this.removePointerDownListener = re
  }
  onPointerDown(t) {
      this.session = new Sh(t,this.createPanHandlers(),{
          transformPagePoint: this.node.getTransformPagePoint(),
          contextWindow: kh(this.node)
      })
  }
  createPanHandlers() {
      const {onPanSessionStart: t, onPanStart: n, onPan: r, onPanEnd: i} = this.node.getProps();
      return {
          onSessionStart: $0(t),
          onStart: $0(n),
          onMove: r,
          onEnd: (o, a) => {
              delete this.session,
              i && W.update( () => i(o, a))
          }
      }
  }
  mount() {
      this.removePointerDownListener = wt(this.node.current, "pointerdown", t => this.onPointerDown(t))
  }
  update() {
      this.session && this.session.updateHandlers(this.createPanHandlers())
  }
  unmount() {
      this.removePointerDownListener(),
      this.session && this.session.end()
  }
}
function p6() {
  const e = E.exports.useContext(ha);
  if (e === null)
      return [!0, null];
  const {isPresent: t, onExitComplete: n, register: r} = e
    , i = E.exports.useId();
  return E.exports.useEffect( () => r(i), []),
  !t && n ? [!1, () => n && n(i)] : [!0]
}
const so = {
  hasAnimatedSinceResize: !0,
  hasEverUpdated: !1
};
function U0(e, t) {
  return t.max === t.min ? 0 : e / (t.max - t.min) * 100
}
const Ar = {
  correct: (e, t) => {
      if (!t.target)
          return e;
      if (typeof e == "string")
          if (j.test(e))
              e = parseFloat(e);
          else
              return e;
      const n = U0(e, t.target.x)
        , r = U0(e, t.target.y);
      return `${n}% ${r}%`
  }
}
, g6 = {
  correct: (e, {treeScale: t, projectionDelta: n}) => {
      const r = e
        , i = qt.parse(e);
      if (i.length > 5)
          return r;
      const o = qt.createTransformer(e)
        , a = typeof i[0] != "number" ? 1 : 0
        , s = n.x.scale * t.x
        , l = n.y.scale * t.y;
      i[0 + a] /= s,
      i[1 + a] /= l;
      const u = J(s, l, .5);
      return typeof i[2 + a] == "number" && (i[2 + a] /= u),
      typeof i[3 + a] == "number" && (i[3 + a] /= u),
      o(i)
  }
};
class y6 extends T.Component {
  componentDidMount() {
      const {visualElement: t, layoutGroup: n, switchLayoutGroup: r, layoutId: i} = this.props
        , {projection: o} = t;
      Ay(v6),
      o && (n.group && n.group.add(o),
      r && r.register && i && r.register(o),
      o.root.didUpdate(),
      o.addEventListener("animationComplete", () => {
          this.safeToRemove()
      }
      ),
      o.setOptions({
          ...o.options,
          onExitComplete: () => this.safeToRemove()
      })),
      so.hasEverUpdated = !0
  }
  getSnapshotBeforeUpdate(t) {
      const {layoutDependency: n, visualElement: r, drag: i, isPresent: o} = this.props
        , a = r.projection;
      return a && (a.isPresent = o,
      i || t.layoutDependency !== n || n === void 0 ? a.willUpdate() : this.safeToRemove(),
      t.isPresent !== o && (o ? a.promote() : a.relegate() || W.postRender( () => {
          const s = a.getStack();
          (!s || !s.members.length) && this.safeToRemove()
      }
      ))),
      null
  }
  componentDidUpdate() {
      const {projection: t} = this.props.visualElement;
      t && (t.root.didUpdate(),
      queueMicrotask( () => {
          !t.currentAnimation && t.isLead() && this.safeToRemove()
      }
      ))
  }
  componentWillUnmount() {
      const {visualElement: t, layoutGroup: n, switchLayoutGroup: r} = this.props
        , {projection: i} = t;
      i && (i.scheduleCheckAfterUnmount(),
      n && n.group && n.group.remove(i),
      r && r.deregister && r.deregister(i))
  }
  safeToRemove() {
      const {safeToRemove: t} = this.props;
      t && t()
  }
  render() {
      return null
  }
}
function Th(e) {
  const [t,n] = p6()
    , r = E.exports.useContext(Cu);
  return c(y6, {
      ...e,
      layoutGroup: r,
      switchLayoutGroup: E.exports.useContext(Nm),
      isPresent: t,
      safeToRemove: n
  })
}
const v6 = {
  borderRadius: {
      ...Ar,
      applyTo: ["borderTopLeftRadius", "borderTopRightRadius", "borderBottomLeftRadius", "borderBottomRightRadius"]
  },
  borderTopLeftRadius: Ar,
  borderTopRightRadius: Ar,
  borderBottomLeftRadius: Ar,
  borderBottomRightRadius: Ar,
  boxShadow: g6
}
, Mh = ["TopLeft", "TopRight", "BottomLeft", "BottomRight"]
, x6 = Mh.length
, Z0 = e => typeof e == "string" ? parseFloat(e) : e
, G0 = e => typeof e == "number" || j.test(e);
function w6(e, t, n, r, i, o) {
  i ? (e.opacity = J(0, n.opacity !== void 0 ? n.opacity : 1, S6(r)),
  e.opacityExit = J(t.opacity !== void 0 ? t.opacity : 1, 0, E6(r))) : o && (e.opacity = J(t.opacity !== void 0 ? t.opacity : 1, n.opacity !== void 0 ? n.opacity : 1, r));
  for (let a = 0; a < x6; a++) {
      const s = `border${Mh[a]}Radius`;
      let l = W0(t, s)
        , u = W0(n, s);
      if (l === void 0 && u === void 0)
          continue;
      l || (l = 0),
      u || (u = 0),
      l === 0 || u === 0 || G0(l) === G0(u) ? (e[s] = Math.max(J(Z0(l), Z0(u), r), 0),
      (ft.test(u) || ft.test(l)) && (e[s] += "%")) : e[s] = u
  }
  (t.rotate || n.rotate) && (e.rotate = J(t.rotate || 0, n.rotate || 0, r))
}
function W0(e, t) {
  return e[t] !== void 0 ? e[t] : e.borderRadius
}
const S6 = Lh(0, .5, qm)
, E6 = Lh(.5, .95, re);
function Lh(e, t, n) {
  return r => r < e ? 0 : r > t ? 1 : n(hi(e, t, r))
}
function Q0(e, t) {
  e.min = t.min,
  e.max = t.max
}
function Ue(e, t) {
  Q0(e.x, t.x),
  Q0(e.y, t.y)
}
function K0(e, t, n, r, i) {
  return e -= t,
  e = Bo(e, 1 / n, r),
  i !== void 0 && (e = Bo(e, 1 / i, r)),
  e
}
function N6(e, t=0, n=1, r=.5, i, o=e, a=e) {
  if (ft.test(t) && (t = parseFloat(t),
  t = J(a.min, a.max, t / 100) - a.min),
  typeof t != "number")
      return;
  let s = J(o.min, o.max, r);
  e === o && (s -= t),
  e.min = K0(e.min, t, n, s, i),
  e.max = K0(e.max, t, n, s, i)
}
function Y0(e, t, [n,r,i], o, a) {
  N6(e, t[n], t[r], t[i], t.scale, o, a)
}
const C6 = ["x", "scaleX", "originX"]
, P6 = ["y", "scaleY", "originY"];
function X0(e, t, n, r) {
  Y0(e.x, t, C6, n ? n.x : void 0, r ? r.x : void 0),
  Y0(e.y, t, P6, n ? n.y : void 0, r ? r.y : void 0)
}
function q0(e) {
  return e.translate === 0 && e.scale === 1
}
function Rh(e) {
  return q0(e.x) && q0(e.y)
}
function A6(e, t) {
  return e.x.min === t.x.min && e.x.max === t.x.max && e.y.min === t.y.min && e.y.max === t.y.max
}
function bh(e, t) {
  return Math.round(e.x.min) === Math.round(t.x.min) && Math.round(e.x.max) === Math.round(t.x.max) && Math.round(e.y.min) === Math.round(t.y.min) && Math.round(e.y.max) === Math.round(t.y.max)
}
function J0(e) {
  return He(e.x) / He(e.y)
}
class k6 {
  constructor() {
      this.members = []
  }
  add(t) {
      _u(this.members, t),
      t.scheduleRender()
  }
  remove(t) {
      if (zu(this.members, t),
      t === this.prevLead && (this.prevLead = void 0),
      t === this.lead) {
          const n = this.members[this.members.length - 1];
          n && this.promote(n)
      }
  }
  relegate(t) {
      const n = this.members.findIndex(i => t === i);
      if (n === 0)
          return !1;
      let r;
      for (let i = n; i >= 0; i--) {
          const o = this.members[i];
          if (o.isPresent !== !1) {
              r = o;
              break
          }
      }
      return r ? (this.promote(r),
      !0) : !1
  }
  promote(t, n) {
      const r = this.lead;
      if (t !== r && (this.prevLead = r,
      this.lead = t,
      t.show(),
      r)) {
          r.instance && r.scheduleRender(),
          t.scheduleRender(),
          t.resumeFrom = r,
          n && (t.resumeFrom.preserveOpacity = !0),
          r.snapshot && (t.snapshot = r.snapshot,
          t.snapshot.latestValues = r.animationValues || r.latestValues),
          t.root && t.root.isUpdating && (t.isLayoutDirty = !0);
          const {crossfade: i} = t.options;
          i === !1 && r.hide()
      }
  }
  exitAnimationComplete() {
      this.members.forEach(t => {
          const {options: n, resumingFrom: r} = t;
          n.onExitComplete && n.onExitComplete(),
          r && r.options.onExitComplete && r.options.onExitComplete()
      }
      )
  }
  scheduleRender() {
      this.members.forEach(t => {
          t.instance && t.scheduleRender(!1)
      }
      )
  }
  removeLeadSnapshot() {
      this.lead && this.lead.snapshot && (this.lead.snapshot = void 0)
  }
}
function ed(e, t, n) {
  let r = "";
  const i = e.x.translate / t.x
    , o = e.y.translate / t.y;
  if ((i || o) && (r = `translate3d(${i}px, ${o}px, 0) `),
  (t.x !== 1 || t.y !== 1) && (r += `scale(${1 / t.x}, ${1 / t.y}) `),
  n) {
      const {rotate: l, rotateX: u, rotateY: f} = n;
      l && (r += `rotate(${l}deg) `),
      u && (r += `rotateX(${u}deg) `),
      f && (r += `rotateY(${f}deg) `)
  }
  const a = e.x.scale * t.x
    , s = e.y.scale * t.y;
  return (a !== 1 || s !== 1) && (r += `scale(${a}, ${s})`),
  r || "none"
}
const T6 = (e, t) => e.depth - t.depth;
class M6 {
  constructor() {
      this.children = [],
      this.isDirty = !1
  }
  add(t) {
      _u(this.children, t),
      this.isDirty = !0
  }
  remove(t) {
      zu(this.children, t),
      this.isDirty = !0
  }
  forEach(t) {
      this.isDirty && this.children.sort(T6),
      this.isDirty = !1,
      this.children.forEach(t)
  }
}
function L6(e, t) {
  const n = performance.now()
    , r = ({timestamp: i}) => {
      const o = i - n;
      o >= t && (At(r),
      e(o - t))
  }
  ;
  return W.read(r, !0),
  () => At(r)
}
function R6(e) {
  window.MotionDebug && window.MotionDebug.record(e)
}
function b6(e) {
  return e instanceof SVGElement && e.tagName !== "svg"
}
function O6(e, t, n) {
  const r = De(e) ? e : ur(e);
  return r.start(Fu("", r, t, n)),
  r.animation
}
const td = ["", "X", "Y", "Z"]
, V6 = {
  visibility: "hidden"
}
, nd = 1e3;
let D6 = 0;
const dn = {
  type: "projectionFrame",
  totalNodes: 0,
  resolvedTargetDeltas: 0,
  recalculatedProjection: 0
};
function Oh({attachResizeListener: e, defaultParent: t, measureScroll: n, checkIsScrollRoot: r, resetTransform: i}) {
  return class {
      constructor(a={}, s=t == null ? void 0 : t()) {
          this.id = D6++,
          this.animationId = 0,
          this.children = new Set,
          this.options = {},
          this.isTreeAnimating = !1,
          this.isAnimationBlocked = !1,
          this.isLayoutDirty = !1,
          this.isProjectionDirty = !1,
          this.isSharedProjectionDirty = !1,
          this.isTransformDirty = !1,
          this.updateManuallyBlocked = !1,
          this.updateBlockedByResize = !1,
          this.isUpdating = !1,
          this.isSVG = !1,
          this.needsReset = !1,
          this.shouldResetTransform = !1,
          this.treeScale = {
              x: 1,
              y: 1
          },
          this.eventHandlers = new Map,
          this.hasTreeAnimated = !1,
          this.updateScheduled = !1,
          this.projectionUpdateScheduled = !1,
          this.checkUpdateFailed = () => {
              this.isUpdating && (this.isUpdating = !1,
              this.clearAllSnapshots())
          }
          ,
          this.updateProjection = () => {
              this.projectionUpdateScheduled = !1,
              dn.totalNodes = dn.resolvedTargetDeltas = dn.recalculatedProjection = 0,
              this.nodes.forEach(F6),
              this.nodes.forEach($6),
              this.nodes.forEach(U6),
              this.nodes.forEach(_6),
              R6(dn)
          }
          ,
          this.hasProjected = !1,
          this.isVisible = !0,
          this.animationProgress = 0,
          this.sharedNodes = new Map,
          this.latestValues = a,
          this.root = s ? s.root || s : this,
          this.path = s ? [...s.path, s] : [],
          this.parent = s,
          this.depth = s ? s.depth + 1 : 0;
          for (let l = 0; l < this.path.length; l++)
              this.path[l].shouldResetTransform = !0;
          this.root === this && (this.nodes = new M6)
      }
      addEventListener(a, s) {
          return this.eventHandlers.has(a) || this.eventHandlers.set(a, new Hu),
          this.eventHandlers.get(a).add(s)
      }
      notifyListeners(a, ...s) {
          const l = this.eventHandlers.get(a);
          l && l.notify(...s)
      }
      hasListeners(a) {
          return this.eventHandlers.has(a)
      }
      mount(a, s=this.root.hasTreeAnimated) {
          if (this.instance)
              return;
          this.isSVG = b6(a),
          this.instance = a;
          const {layoutId: l, layout: u, visualElement: f} = this.options;
          if (f && !f.current && f.mount(a),
          this.root.nodes.add(this),
          this.parent && this.parent.children.add(this),
          s && (u || l) && (this.isLayoutDirty = !0),
          e) {
              let d;
              const m = () => this.root.updateBlockedByResize = !1;
              e(a, () => {
                  this.root.updateBlockedByResize = !0,
                  d && d(),
                  d = L6(m, 250),
                  so.hasAnimatedSinceResize && (so.hasAnimatedSinceResize = !1,
                  this.nodes.forEach(id))
              }
              )
          }
          l && this.root.registerSharedNode(l, this),
          this.options.animate !== !1 && f && (l || u) && this.addEventListener("didUpdate", ({delta: d, hasLayoutChanged: m, hasRelativeTargetChanged: p, layout: v}) => {
              if (this.isTreeAnimationBlocked()) {
                  this.target = void 0,
                  this.relativeTarget = void 0;
                  return
              }
              const x = this.options.transition || f.getDefaultTransition() || K6
                , {onLayoutAnimationStart: P, onLayoutAnimationComplete: y} = f.getProps()
                , h = !this.targetLayout || !bh(this.targetLayout, v) || p
                , g = !m && p;
              if (this.options.layoutRoot || this.resumeFrom && this.resumeFrom.instance || g || m && (h || !this.currentAnimation)) {
                  this.resumeFrom && (this.resumingFrom = this.resumeFrom,
                  this.resumingFrom.resumingFrom = void 0),
                  this.setAnimationOrigin(d, g);
                  const S = {
                      ...Iu(x, "layout"),
                      onPlay: P,
                      onComplete: y
                  };
                  (f.shouldReduceMotion || this.options.layoutRoot) && (S.delay = 0,
                  S.type = !1),
                  this.startAnimation(S)
              } else
                  m || id(this),
                  this.isLead() && this.options.onExitComplete && this.options.onExitComplete();
              this.targetLayout = v
          }
          )
      }
      unmount() {
          this.options.layoutId && this.willUpdate(),
          this.root.nodes.remove(this);
          const a = this.getStack();
          a && a.remove(this),
          this.parent && this.parent.children.delete(this),
          this.instance = void 0,
          At(this.updateProjection)
      }
      blockUpdate() {
          this.updateManuallyBlocked = !0
      }
      unblockUpdate() {
          this.updateManuallyBlocked = !1
      }
      isUpdateBlocked() {
          return this.updateManuallyBlocked || this.updateBlockedByResize
      }
      isTreeAnimationBlocked() {
          return this.isAnimationBlocked || this.parent && this.parent.isTreeAnimationBlocked() || !1
      }
      startUpdate() {
          this.isUpdateBlocked() || (this.isUpdating = !0,
          this.nodes && this.nodes.forEach(Z6),
          this.animationId++)
      }
      getTransformTemplate() {
          const {visualElement: a} = this.options;
          return a && a.getProps().transformTemplate
      }
      willUpdate(a=!0) {
          if (this.root.hasTreeAnimated = !0,
          this.root.isUpdateBlocked()) {
              this.options.onExitComplete && this.options.onExitComplete();
              return
          }
          if (!this.root.isUpdating && this.root.startUpdate(),
          this.isLayoutDirty)
              return;
          this.isLayoutDirty = !0;
          for (let f = 0; f < this.path.length; f++) {
              const d = this.path[f];
              d.shouldResetTransform = !0,
              d.updateScroll("snapshot"),
              d.options.layoutRoot && d.willUpdate(!1)
          }
          const {layoutId: s, layout: l} = this.options;
          if (s === void 0 && !l)
              return;
          const u = this.getTransformTemplate();
          this.prevTransformTemplateValue = u ? u(this.latestValues, "") : void 0,
          this.updateSnapshot(),
          a && this.notifyListeners("willUpdate")
      }
      update() {
          if (this.updateScheduled = !1,
          this.isUpdateBlocked()) {
              this.unblockUpdate(),
              this.clearAllSnapshots(),
              this.nodes.forEach(rd);
              return
          }
          this.isUpdating || this.nodes.forEach(H6),
          this.isUpdating = !1,
          this.nodes.forEach(B6),
          this.nodes.forEach(j6),
          this.nodes.forEach(I6),
          this.clearAllSnapshots();
          const s = performance.now();
          Se.delta = Xt(0, 1e3 / 60, s - Se.timestamp),
          Se.timestamp = s,
          Se.isProcessing = !0,
          qa.update.process(Se),
          qa.preRender.process(Se),
          qa.render.process(Se),
          Se.isProcessing = !1
      }
      didUpdate() {
          this.updateScheduled || (this.updateScheduled = !0,
          queueMicrotask( () => this.update()))
      }
      clearAllSnapshots() {
          this.nodes.forEach(z6),
          this.sharedNodes.forEach(G6)
      }
      scheduleUpdateProjection() {
          this.projectionUpdateScheduled || (this.projectionUpdateScheduled = !0,
          W.preRender(this.updateProjection, !1, !0))
      }
      scheduleCheckAfterUnmount() {
          W.postRender( () => {
              this.isLayoutDirty ? this.root.didUpdate() : this.root.checkUpdateFailed()
          }
          )
      }
      updateSnapshot() {
          this.snapshot || !this.instance || (this.snapshot = this.measure())
      }
      updateLayout() {
          if (!this.instance || (this.updateScroll(),
          !(this.options.alwaysMeasureLayout && this.isLead()) && !this.isLayoutDirty))
              return;
          if (this.resumeFrom && !this.resumeFrom.instance)
              for (let l = 0; l < this.path.length; l++)
                  this.path[l].updateScroll();
          const a = this.layout;
          this.layout = this.measure(!1),
          this.layoutCorrected = se(),
          this.isLayoutDirty = !1,
          this.projectionDelta = void 0,
          this.notifyListeners("measure", this.layout.layoutBox);
          const {visualElement: s} = this.options;
          s && s.notify("LayoutMeasure", this.layout.layoutBox, a ? a.layoutBox : void 0)
      }
      updateScroll(a="measure") {
          let s = Boolean(this.options.layoutScroll && this.instance);
          this.scroll && this.scroll.animationId === this.root.animationId && this.scroll.phase === a && (s = !1),
          s && (this.scroll = {
              animationId: this.root.animationId,
              phase: a,
              isRoot: r(this.instance),
              offset: n(this.instance)
          })
      }
      resetTransform() {
          if (!i)
              return;
          const a = this.isLayoutDirty || this.shouldResetTransform
            , s = this.projectionDelta && !Rh(this.projectionDelta)
            , l = this.getTransformTemplate()
            , u = l ? l(this.latestValues, "") : void 0
            , f = u !== this.prevTransformTemplateValue;
          a && (s || cn(this.latestValues) || f) && (i(this.instance, u),
          this.shouldResetTransform = !1,
          this.scheduleRender())
      }
      measure(a=!0) {
          const s = this.measurePageBox();
          let l = this.removeElementScroll(s);
          return a && (l = this.removeTransform(l)),
          Y6(l),
          {
              animationId: this.root.animationId,
              measuredBox: s,
              layoutBox: l,
              latestValues: {},
              source: this.id
          }
      }
      measurePageBox() {
          const {visualElement: a} = this.options;
          if (!a)
              return se();
          const s = a.measureViewportBox()
            , {scroll: l} = this.root;
          return l && (Ot(s.x, l.offset.x),
          Ot(s.y, l.offset.y)),
          s
      }
      removeElementScroll(a) {
          const s = se();
          Ue(s, a);
          for (let l = 0; l < this.path.length; l++) {
              const u = this.path[l]
                , {scroll: f, options: d} = u;
              if (u !== this.root && f && d.layoutScroll) {
                  if (f.isRoot) {
                      Ue(s, a);
                      const {scroll: m} = this.root;
                      m && (Ot(s.x, -m.offset.x),
                      Ot(s.y, -m.offset.y))
                  }
                  Ot(s.x, f.offset.x),
                  Ot(s.y, f.offset.y)
              }
          }
          return s
      }
      applyTransform(a, s=!1) {
          const l = se();
          Ue(l, a);
          for (let u = 0; u < this.path.length; u++) {
              const f = this.path[u];
              !s && f.options.layoutScroll && f.scroll && f !== f.root && Qn(l, {
                  x: -f.scroll.offset.x,
                  y: -f.scroll.offset.y
              }),
              cn(f.latestValues) && Qn(l, f.latestValues)
          }
          return cn(this.latestValues) && Qn(l, this.latestValues),
          l
      }
      removeTransform(a) {
          const s = se();
          Ue(s, a);
          for (let l = 0; l < this.path.length; l++) {
              const u = this.path[l];
              if (!u.instance || !cn(u.latestValues))
                  continue;
              gl(u.latestValues) && u.updateSnapshot();
              const f = se()
                , d = u.measurePageBox();
              Ue(f, d),
              X0(s, u.latestValues, u.snapshot ? u.snapshot.layoutBox : void 0, f)
          }
          return cn(this.latestValues) && X0(s, this.latestValues),
          s
      }
      setTargetDelta(a) {
          this.targetDelta = a,
          this.root.scheduleUpdateProjection(),
          this.isProjectionDirty = !0
      }
      setOptions(a) {
          this.options = {
              ...this.options,
              ...a,
              crossfade: a.crossfade !== void 0 ? a.crossfade : !0
          }
      }
      clearMeasurements() {
          this.scroll = void 0,
          this.layout = void 0,
          this.snapshot = void 0,
          this.prevTransformTemplateValue = void 0,
          this.targetDelta = void 0,
          this.target = void 0,
          this.isLayoutDirty = !1
      }
      forceRelativeParentToResolveTarget() {
          !this.relativeParent || this.relativeParent.resolvedRelativeTargetAt !== Se.timestamp && this.relativeParent.resolveTargetDelta(!0)
      }
      resolveTargetDelta(a=!1) {
          var s;
          const l = this.getLead();
          this.isProjectionDirty || (this.isProjectionDirty = l.isProjectionDirty),
          this.isTransformDirty || (this.isTransformDirty = l.isTransformDirty),
          this.isSharedProjectionDirty || (this.isSharedProjectionDirty = l.isSharedProjectionDirty);
          const u = Boolean(this.resumingFrom) || this !== l;
          if (!(a || u && this.isSharedProjectionDirty || this.isProjectionDirty || ((s = this.parent) === null || s === void 0 ? void 0 : s.isProjectionDirty) || this.attemptToResolveRelativeTarget))
              return;
          const {layout: d, layoutId: m} = this.options;
          if (!(!this.layout || !(d || m))) {
              if (this.resolvedRelativeTargetAt = Se.timestamp,
              !this.targetDelta && !this.relativeTarget) {
                  const p = this.getClosestProjectingParent();
                  p && p.layout && this.animationProgress !== 1 ? (this.relativeParent = p,
                  this.forceRelativeParentToResolveTarget(),
                  this.relativeTarget = se(),
                  this.relativeTargetOrigin = se(),
                  Ur(this.relativeTargetOrigin, this.layout.layoutBox, p.layout.layoutBox),
                  Ue(this.relativeTarget, this.relativeTargetOrigin)) : this.relativeParent = this.relativeTarget = void 0
              }
              if (!(!this.relativeTarget && !this.targetDelta)) {
                  if (this.target || (this.target = se(),
                  this.targetWithTransforms = se()),
                  this.relativeTarget && this.relativeTargetOrigin && this.relativeParent && this.relativeParent.target ? (this.forceRelativeParentToResolveTarget(),
                  X8(this.target, this.relativeTarget, this.relativeParent.target)) : this.targetDelta ? (Boolean(this.resumingFrom) ? this.target = this.applyTransform(this.layout.layoutBox) : Ue(this.target, this.layout.layoutBox),
                  Ph(this.target, this.targetDelta)) : Ue(this.target, this.layout.layoutBox),
                  this.attemptToResolveRelativeTarget) {
                      this.attemptToResolveRelativeTarget = !1;
                      const p = this.getClosestProjectingParent();
                      p && Boolean(p.resumingFrom) === Boolean(this.resumingFrom) && !p.options.layoutScroll && p.target && this.animationProgress !== 1 ? (this.relativeParent = p,
                      this.forceRelativeParentToResolveTarget(),
                      this.relativeTarget = se(),
                      this.relativeTargetOrigin = se(),
                      Ur(this.relativeTargetOrigin, this.target, p.target),
                      Ue(this.relativeTarget, this.relativeTargetOrigin)) : this.relativeParent = this.relativeTarget = void 0
                  }
                  dn.resolvedTargetDeltas++
              }
          }
      }
      getClosestProjectingParent() {
          if (!(!this.parent || gl(this.parent.latestValues) || Ch(this.parent.latestValues)))
              return this.parent.isProjecting() ? this.parent : this.parent.getClosestProjectingParent()
      }
      isProjecting() {
          return Boolean((this.relativeTarget || this.targetDelta || this.options.layoutRoot) && this.layout)
      }
      calcProjection() {
          var a;
          const s = this.getLead()
            , l = Boolean(this.resumingFrom) || this !== s;
          let u = !0;
          if ((this.isProjectionDirty || ((a = this.parent) === null || a === void 0 ? void 0 : a.isProjectionDirty)) && (u = !1),
          l && (this.isSharedProjectionDirty || this.isTransformDirty) && (u = !1),
          this.resolvedRelativeTargetAt === Se.timestamp && (u = !1),
          u)
              return;
          const {layout: f, layoutId: d} = this.options;
          if (this.isTreeAnimating = Boolean(this.parent && this.parent.isTreeAnimating || this.currentAnimation || this.pendingAnimation),
          this.isTreeAnimating || (this.targetDelta = this.relativeTarget = void 0),
          !this.layout || !(f || d))
              return;
          Ue(this.layoutCorrected, this.layout.layoutBox);
          const m = this.treeScale.x
            , p = this.treeScale.y;
          a6(this.layoutCorrected, this.treeScale, this.path, l),
          s.layout && !s.target && (this.treeScale.x !== 1 || this.treeScale.y !== 1) && (s.target = s.layout.layoutBox);
          const {target: v} = s;
          if (!v) {
              this.projectionTransform && (this.projectionDelta = Wn(),
              this.projectionTransform = "none",
              this.scheduleRender());
              return
          }
          this.projectionDelta || (this.projectionDelta = Wn(),
          this.projectionDeltaWithTransform = Wn());
          const x = this.projectionTransform;
          $r(this.projectionDelta, this.layoutCorrected, v, this.latestValues),
          this.projectionTransform = ed(this.projectionDelta, this.treeScale),
          (this.projectionTransform !== x || this.treeScale.x !== m || this.treeScale.y !== p) && (this.hasProjected = !0,
          this.scheduleRender(),
          this.notifyListeners("projectionUpdate", v)),
          dn.recalculatedProjection++
      }
      hide() {
          this.isVisible = !1
      }
      show() {
          this.isVisible = !0
      }
      scheduleRender(a=!0) {
          if (this.options.scheduleRender && this.options.scheduleRender(),
          a) {
              const s = this.getStack();
              s && s.scheduleRender()
          }
          this.resumingFrom && !this.resumingFrom.instance && (this.resumingFrom = void 0)
      }
      setAnimationOrigin(a, s=!1) {
          const l = this.snapshot
            , u = l ? l.latestValues : {}
            , f = {
              ...this.latestValues
          }
            , d = Wn();
          (!this.relativeParent || !this.relativeParent.options.layoutRoot) && (this.relativeTarget = this.relativeTargetOrigin = void 0),
          this.attemptToResolveRelativeTarget = !s;
          const m = se()
            , p = l ? l.source : void 0
            , v = this.layout ? this.layout.source : void 0
            , x = p !== v
            , P = this.getStack()
            , y = !P || P.members.length <= 1
            , h = Boolean(x && !y && this.options.crossfade === !0 && !this.path.some(Q6));
          this.animationProgress = 0;
          let g;
          this.mixTargetDelta = S => {
              const M = S / 1e3;
              od(d.x, a.x, M),
              od(d.y, a.y, M),
              this.setTargetDelta(d),
              this.relativeTarget && this.relativeTargetOrigin && this.layout && this.relativeParent && this.relativeParent.layout && (Ur(m, this.layout.layoutBox, this.relativeParent.layout.layoutBox),
              W6(this.relativeTarget, this.relativeTargetOrigin, m, M),
              g && A6(this.relativeTarget, g) && (this.isProjectionDirty = !1),
              g || (g = se()),
              Ue(g, this.relativeTarget)),
              x && (this.animationValues = f,
              w6(f, u, this.latestValues, M, h, y)),
              this.root.scheduleUpdateProjection(),
              this.scheduleRender(),
              this.animationProgress = M
          }
          ,
          this.mixTargetDelta(this.options.layoutRoot ? 1e3 : 0)
      }
      startAnimation(a) {
          this.notifyListeners("animationStart"),
          this.currentAnimation && this.currentAnimation.stop(),
          this.resumingFrom && this.resumingFrom.currentAnimation && this.resumingFrom.currentAnimation.stop(),
          this.pendingAnimation && (At(this.pendingAnimation),
          this.pendingAnimation = void 0),
          this.pendingAnimation = W.update( () => {
              so.hasAnimatedSinceResize = !0,
              this.currentAnimation = O6(0, nd, {
                  ...a,
                  onUpdate: s => {
                      this.mixTargetDelta(s),
                      a.onUpdate && a.onUpdate(s)
                  }
                  ,
                  onComplete: () => {
                      a.onComplete && a.onComplete(),
                      this.completeAnimation()
                  }
              }),
              this.resumingFrom && (this.resumingFrom.currentAnimation = this.currentAnimation),
              this.pendingAnimation = void 0
          }
          )
      }
      completeAnimation() {
          this.resumingFrom && (this.resumingFrom.currentAnimation = void 0,
          this.resumingFrom.preserveOpacity = void 0);
          const a = this.getStack();
          a && a.exitAnimationComplete(),
          this.resumingFrom = this.currentAnimation = this.animationValues = void 0,
          this.notifyListeners("animationComplete")
      }
      finishAnimation() {
          this.currentAnimation && (this.mixTargetDelta && this.mixTargetDelta(nd),
          this.currentAnimation.stop()),
          this.completeAnimation()
      }
      applyTransformsToTarget() {
          const a = this.getLead();
          let {targetWithTransforms: s, target: l, layout: u, latestValues: f} = a;
          if (!(!s || !l || !u)) {
              if (this !== a && this.layout && u && Vh(this.options.animationType, this.layout.layoutBox, u.layoutBox)) {
                  l = this.target || se();
                  const d = He(this.layout.layoutBox.x);
                  l.x.min = a.target.x.min,
                  l.x.max = l.x.min + d;
                  const m = He(this.layout.layoutBox.y);
                  l.y.min = a.target.y.min,
                  l.y.max = l.y.min + m
              }
              Ue(s, l),
              Qn(s, f),
              $r(this.projectionDeltaWithTransform, this.layoutCorrected, s, f)
          }
      }
      registerSharedNode(a, s) {
          this.sharedNodes.has(a) || this.sharedNodes.set(a, new k6),
          this.sharedNodes.get(a).add(s);
          const u = s.options.initialPromotionConfig;
          s.promote({
              transition: u ? u.transition : void 0,
              preserveFollowOpacity: u && u.shouldPreserveFollowOpacity ? u.shouldPreserveFollowOpacity(s) : void 0
          })
      }
      isLead() {
          const a = this.getStack();
          return a ? a.lead === this : !0
      }
      getLead() {
          var a;
          const {layoutId: s} = this.options;
          return s ? ((a = this.getStack()) === null || a === void 0 ? void 0 : a.lead) || this : this
      }
      getPrevLead() {
          var a;
          const {layoutId: s} = this.options;
          return s ? (a = this.getStack()) === null || a === void 0 ? void 0 : a.prevLead : void 0
      }
      getStack() {
          const {layoutId: a} = this.options;
          if (a)
              return this.root.sharedNodes.get(a)
      }
      promote({needsReset: a, transition: s, preserveFollowOpacity: l}={}) {
          const u = this.getStack();
          u && u.promote(this, l),
          a && (this.projectionDelta = void 0,
          this.needsReset = !0),
          s && this.setOptions({
              transition: s
          })
      }
      relegate() {
          const a = this.getStack();
          return a ? a.relegate(this) : !1
      }
      resetRotation() {
          const {visualElement: a} = this.options;
          if (!a)
              return;
          let s = !1;
          const {latestValues: l} = a;
          if ((l.rotate || l.rotateX || l.rotateY || l.rotateZ) && (s = !0),
          !s)
              return;
          const u = {};
          for (let f = 0; f < td.length; f++) {
              const d = "rotate" + td[f];
              l[d] && (u[d] = l[d],
              a.setStaticValue(d, 0))
          }
          a.render();
          for (const f in u)
              a.setStaticValue(f, u[f]);
          a.scheduleRender()
      }
      getProjectionStyles(a) {
          var s, l;
          if (!this.instance || this.isSVG)
              return;
          if (!this.isVisible)
              return V6;
          const u = {
              visibility: ""
          }
            , f = this.getTransformTemplate();
          if (this.needsReset)
              return this.needsReset = !1,
              u.opacity = "",
              u.pointerEvents = ao(a == null ? void 0 : a.pointerEvents) || "",
              u.transform = f ? f(this.latestValues, "") : "none",
              u;
          const d = this.getLead();
          if (!this.projectionDelta || !this.layout || !d.target) {
              const x = {};
              return this.options.layoutId && (x.opacity = this.latestValues.opacity !== void 0 ? this.latestValues.opacity : 1,
              x.pointerEvents = ao(a == null ? void 0 : a.pointerEvents) || ""),
              this.hasProjected && !cn(this.latestValues) && (x.transform = f ? f({}, "") : "none",
              this.hasProjected = !1),
              x
          }
          const m = d.animationValues || d.latestValues;
          this.applyTransformsToTarget(),
          u.transform = ed(this.projectionDeltaWithTransform, this.treeScale, m),
          f && (u.transform = f(m, u.transform));
          const {x: p, y: v} = this.projectionDelta;
          u.transformOrigin = `${p.origin * 100}% ${v.origin * 100}% 0`,
          d.animationValues ? u.opacity = d === this ? (l = (s = m.opacity) !== null && s !== void 0 ? s : this.latestValues.opacity) !== null && l !== void 0 ? l : 1 : this.preserveOpacity ? this.latestValues.opacity : m.opacityExit : u.opacity = d === this ? m.opacity !== void 0 ? m.opacity : "" : m.opacityExit !== void 0 ? m.opacityExit : 0;
          for (const x in Do) {
              if (m[x] === void 0)
                  continue;
              const {correct: P, applyTo: y} = Do[x]
                , h = u.transform === "none" ? m[x] : P(m[x], d);
              if (y) {
                  const g = y.length;
                  for (let S = 0; S < g; S++)
                      u[y[S]] = h
              } else
                  u[x] = h
          }
          return this.options.layoutId && (u.pointerEvents = d === this ? ao(a == null ? void 0 : a.pointerEvents) || "" : "none"),
          u
      }
      clearSnapshot() {
          this.resumeFrom = this.snapshot = void 0
      }
      resetTree() {
          this.root.nodes.forEach(a => {
              var s;
              return (s = a.currentAnimation) === null || s === void 0 ? void 0 : s.stop()
          }
          ),
          this.root.nodes.forEach(rd),
          this.root.sharedNodes.clear()
      }
  }
}
function j6(e) {
  e.updateLayout()
}
function I6(e) {
  var t;
  const n = ((t = e.resumeFrom) === null || t === void 0 ? void 0 : t.snapshot) || e.snapshot;
  if (e.isLead() && e.layout && n && e.hasListeners("didUpdate")) {
      const {layoutBox: r, measuredBox: i} = e.layout
        , {animationType: o} = e.options
        , a = n.source !== e.layout.source;
      o === "size" ? Ze(d => {
          const m = a ? n.measuredBox[d] : n.layoutBox[d]
            , p = He(m);
          m.min = r[d].min,
          m.max = m.min + p
      }
      ) : Vh(o, n.layoutBox, r) && Ze(d => {
          const m = a ? n.measuredBox[d] : n.layoutBox[d]
            , p = He(r[d]);
          m.max = m.min + p,
          e.relativeTarget && !e.currentAnimation && (e.isProjectionDirty = !0,
          e.relativeTarget[d].max = e.relativeTarget[d].min + p)
      }
      );
      const s = Wn();
      $r(s, r, n.layoutBox);
      const l = Wn();
      a ? $r(l, e.applyTransform(i, !0), n.measuredBox) : $r(l, r, n.layoutBox);
      const u = !Rh(s);
      let f = !1;
      if (!e.resumeFrom) {
          const d = e.getClosestProjectingParent();
          if (d && !d.resumeFrom) {
              const {snapshot: m, layout: p} = d;
              if (m && p) {
                  const v = se();
                  Ur(v, n.layoutBox, m.layoutBox);
                  const x = se();
                  Ur(x, r, p.layoutBox),
                  bh(v, x) || (f = !0),
                  d.options.layoutRoot && (e.relativeTarget = x,
                  e.relativeTargetOrigin = v,
                  e.relativeParent = d)
              }
          }
      }
      e.notifyListeners("didUpdate", {
          layout: r,
          snapshot: n,
          delta: l,
          layoutDelta: s,
          hasLayoutChanged: u,
          hasRelativeTargetChanged: f
      })
  } else if (e.isLead()) {
      const {onExitComplete: r} = e.options;
      r && r()
  }
  e.options.transition = void 0
}
function F6(e) {
  dn.totalNodes++,
  e.parent && (e.isProjecting() || (e.isProjectionDirty = e.parent.isProjectionDirty),
  e.isSharedProjectionDirty || (e.isSharedProjectionDirty = Boolean(e.isProjectionDirty || e.parent.isProjectionDirty || e.parent.isSharedProjectionDirty)),
  e.isTransformDirty || (e.isTransformDirty = e.parent.isTransformDirty))
}
function _6(e) {
  e.isProjectionDirty = e.isSharedProjectionDirty = e.isTransformDirty = !1
}
function z6(e) {
  e.clearSnapshot()
}
function rd(e) {
  e.clearMeasurements()
}
function H6(e) {
  e.isLayoutDirty = !1
}
function B6(e) {
  const {visualElement: t} = e.options;
  t && t.getProps().onBeforeLayoutMeasure && t.notify("BeforeLayoutMeasure"),
  e.resetTransform()
}
function id(e) {
  e.finishAnimation(),
  e.targetDelta = e.relativeTarget = e.target = void 0,
  e.isProjectionDirty = !0
}
function $6(e) {
  e.resolveTargetDelta()
}
function U6(e) {
  e.calcProjection()
}
function Z6(e) {
  e.resetRotation()
}
function G6(e) {
  e.removeLeadSnapshot()
}
function od(e, t, n) {
  e.translate = J(t.translate, 0, n),
  e.scale = J(t.scale, 1, n),
  e.origin = t.origin,
  e.originPoint = t.originPoint
}
function ad(e, t, n, r) {
  e.min = J(t.min, n.min, r),
  e.max = J(t.max, n.max, r)
}
function W6(e, t, n, r) {
  ad(e.x, t.x, n.x, r),
  ad(e.y, t.y, n.y, r)
}
function Q6(e) {
  return e.animationValues && e.animationValues.opacityExit !== void 0
}
const K6 = {
  duration: .45,
  ease: [.4, 0, .1, 1]
}
, sd = e => typeof navigator < "u" && navigator.userAgent.toLowerCase().includes(e)
, ld = sd("applewebkit/") && !sd("chrome/") ? Math.round : re;
function ud(e) {
  e.min = ld(e.min),
  e.max = ld(e.max)
}
function Y6(e) {
  ud(e.x),
  ud(e.y)
}
function Vh(e, t, n) {
  return e === "position" || e === "preserve-aspect" && !hl(J0(t), J0(n), .2)
}
const X6 = Oh({
  attachResizeListener: (e, t) => vt(e, "resize", t),
  measureScroll: () => ({
      x: document.documentElement.scrollLeft || document.body.scrollLeft,
      y: document.documentElement.scrollTop || document.body.scrollTop
  }),
  checkIsScrollRoot: () => !0
})
, us = {
  current: void 0
}
, Dh = Oh({
  measureScroll: e => ({
      x: e.scrollLeft,
      y: e.scrollTop
  }),
  defaultParent: () => {
      if (!us.current) {
          const e = new X6({});
          e.mount(window),
          e.setOptions({
              layoutScroll: !0
          }),
          us.current = e
      }
      return us.current
  }
  ,
  resetTransform: (e, t) => {
      e.style.transform = t !== void 0 ? t : "none"
  }
  ,
  checkIsScrollRoot: e => Boolean(window.getComputedStyle(e).position === "fixed")
})
, q6 = {
  pan: {
      Feature: h6
  },
  drag: {
      Feature: m6,
      ProjectionNode: Dh,
      MeasureLayout: Th
  }
}
, J6 = /var\((--[a-zA-Z0-9-_]+),? ?([a-zA-Z0-9 ()%#.,-]+)?\)/;
function e5(e) {
  const t = J6.exec(e);
  if (!t)
      return [, ];
  const [,n,r] = t;
  return [n, r]
}
function vl(e, t, n=1) {
  const [r,i] = e5(e);
  if (!r)
      return;
  const o = window.getComputedStyle(t).getPropertyValue(r);
  if (o) {
      const a = o.trim();
      return yh(a) ? parseFloat(a) : a
  } else
      return sl(i) ? vl(i, t, n + 1) : i
}
function t5(e, {...t}, n) {
  const r = e.current;
  if (!(r instanceof Element))
      return {
          target: t,
          transitionEnd: n
      };
  n && (n = {
      ...n
  }),
  e.values.forEach(i => {
      const o = i.get();
      if (!sl(o))
          return;
      const a = vl(o, r);
      a && i.set(a)
  }
  );
  for (const i in t) {
      const o = t[i];
      if (!sl(o))
          continue;
      const a = vl(o, r);
      !a || (t[i] = a,
      n || (n = {}),
      n[i] === void 0 && (n[i] = o))
  }
  return {
      target: t,
      transitionEnd: n
  }
}
const n5 = new Set(["width", "height", "top", "left", "right", "bottom", "x", "y", "translateX", "translateY"])
, jh = e => n5.has(e)
, r5 = e => Object.keys(e).some(jh)
, cd = e => e === Ln || e === j
, dd = (e, t) => parseFloat(e.split(", ")[t])
, fd = (e, t) => (n, {transform: r}) => {
  if (r === "none" || !r)
      return 0;
  const i = r.match(/^matrix3d\((.+)\)$/);
  if (i)
      return dd(i[1], t);
  {
      const o = r.match(/^matrix\((.+)\)$/);
      return o ? dd(o[1], e) : 0
  }
}
, i5 = new Set(["x", "y", "z"])
, o5 = Si.filter(e => !i5.has(e));
function a5(e) {
  const t = [];
  return o5.forEach(n => {
      const r = e.getValue(n);
      r !== void 0 && (t.push([n, r.get()]),
      r.set(n.startsWith("scale") ? 1 : 0))
  }
  ),
  t.length && e.render(),
  t
}
const cr = {
  width: ({x: e}, {paddingLeft: t="0", paddingRight: n="0"}) => e.max - e.min - parseFloat(t) - parseFloat(n),
  height: ({y: e}, {paddingTop: t="0", paddingBottom: n="0"}) => e.max - e.min - parseFloat(t) - parseFloat(n),
  top: (e, {top: t}) => parseFloat(t),
  left: (e, {left: t}) => parseFloat(t),
  bottom: ({y: e}, {top: t}) => parseFloat(t) + (e.max - e.min),
  right: ({x: e}, {left: t}) => parseFloat(t) + (e.max - e.min),
  x: fd(4, 13),
  y: fd(5, 14)
};
cr.translateX = cr.x;
cr.translateY = cr.y;
const s5 = (e, t, n) => {
  const r = t.measureViewportBox()
    , i = t.current
    , o = getComputedStyle(i)
    , {display: a} = o
    , s = {};
  a === "none" && t.setStaticValue("display", e.display || "block"),
  n.forEach(u => {
      s[u] = cr[u](r, o)
  }
  ),
  t.render();
  const l = t.measureViewportBox();
  return n.forEach(u => {
      const f = t.getValue(u);
      f && f.jump(s[u]),
      e[u] = cr[u](l, o)
  }
  ),
  e
}
, l5 = (e, t, n={}, r={}) => {
  t = {
      ...t
  },
  r = {
      ...r
  };
  const i = Object.keys(t).filter(jh);
  let o = []
    , a = !1;
  const s = [];
  if (i.forEach(l => {
      const u = e.getValue(l);
      if (!e.hasValue(l))
          return;
      let f = n[l]
        , d = Pr(f);
      const m = t[l];
      let p;
      if (Io(m)) {
          const v = m.length
            , x = m[0] === null ? 1 : 0;
          f = m[x],
          d = Pr(f);
          for (let P = x; P < v && m[P] !== null; P++)
              p ? Sa(Pr(m[P]) === p) : p = Pr(m[P])
      } else
          p = Pr(m);
      if (d !== p)
          if (cd(d) && cd(p)) {
              const v = u.get();
              typeof v == "string" && u.set(parseFloat(v)),
              typeof m == "string" ? t[l] = parseFloat(m) : Array.isArray(m) && p === j && (t[l] = m.map(parseFloat))
          } else
              (d == null ? void 0 : d.transform) && (p == null ? void 0 : p.transform) && (f === 0 || m === 0) ? f === 0 ? u.set(p.transform(f)) : t[l] = d.transform(m) : (a || (o = a5(e),
              a = !0),
              s.push(l),
              r[l] = r[l] !== void 0 ? r[l] : t[l],
              u.jump(m))
  }
  ),
  s.length) {
      const l = s.indexOf("height") >= 0 ? window.pageYOffset : null
        , u = s5(t, e, s);
      return o.length && o.forEach( ([f,d]) => {
          e.getValue(f).set(d)
      }
      ),
      e.render(),
      pa && l !== null && window.scrollTo({
          top: l
      }),
      {
          target: u,
          transitionEnd: r
      }
  } else
      return {
          target: t,
          transitionEnd: r
      }
}
;
function u5(e, t, n, r) {
  return r5(t) ? l5(e, t, n, r) : {
      target: t,
      transitionEnd: r
  }
}
const c5 = (e, t, n, r) => {
  const i = t5(e, t, r);
  return t = i.target,
  r = i.transitionEnd,
  u5(e, t, n, r)
}
, xl = {
  current: null
}
, Ih = {
  current: !1
};
function d5() {
  if (Ih.current = !0,
  !!pa)
      if (window.matchMedia) {
          const e = window.matchMedia("(prefers-reduced-motion)")
            , t = () => xl.current = e.matches;
          e.addListener(t),
          t()
      } else
          xl.current = !1
}
function f5(e, t, n) {
  const {willChange: r} = t;
  for (const i in t) {
      const o = t[i]
        , a = n[i];
      if (De(o))
          e.addValue(i, o),
          Ho(r) && r.add(i);
      else if (De(a))
          e.addValue(i, ur(o, {
              owner: e
          })),
          Ho(r) && r.remove(i);
      else if (a !== o)
          if (e.hasValue(i)) {
              const s = e.getValue(i);
              !s.hasAnimated && s.set(o)
          } else {
              const s = e.getStaticValue(i);
              e.addValue(i, ur(s !== void 0 ? s : o, {
                  owner: e
              }))
          }
  }
  for (const i in n)
      t[i] === void 0 && e.removeValue(i);
  return t
}
const md = new WeakMap
, Fh = Object.keys(mi)
, m5 = Fh.length
, hd = ["AnimationStart", "AnimationComplete", "Update", "BeforeLayoutMeasure", "LayoutMeasure", "LayoutAnimationStart", "LayoutAnimationComplete"]
, h5 = Nu.length;
class p5 {
  constructor({parent: t, props: n, presenceContext: r, reducedMotionConfig: i, visualState: o}, a={}) {
      this.current = null,
      this.children = new Set,
      this.isVariantNode = !1,
      this.isControllingVariants = !1,
      this.shouldReduceMotion = null,
      this.values = new Map,
      this.features = {},
      this.valueSubscriptions = new Map,
      this.prevMotionValues = {},
      this.events = {},
      this.propEventSubscriptions = {},
      this.notifyUpdate = () => this.notify("Update", this.latestValues),
      this.render = () => {
          !this.current || (this.triggerBuild(),
          this.renderInstance(this.current, this.renderState, this.props.style, this.projection))
      }
      ,
      this.scheduleRender = () => W.render(this.render, !1, !0);
      const {latestValues: s, renderState: l} = o;
      this.latestValues = s,
      this.baseTarget = {
          ...s
      },
      this.initialValues = n.initial ? {
          ...s
      } : {},
      this.renderState = l,
      this.parent = t,
      this.props = n,
      this.presenceContext = r,
      this.depth = t ? t.depth + 1 : 0,
      this.reducedMotionConfig = i,
      this.options = a,
      this.isControllingVariants = ya(n),
      this.isVariantNode = Em(n),
      this.isVariantNode && (this.variantChildren = new Set),
      this.manuallyAnimateOnMount = Boolean(t && t.current);
      const {willChange: u, ...f} = this.scrapeMotionValuesFromProps(n, {});
      for (const d in f) {
          const m = f[d];
          s[d] !== void 0 && De(m) && (m.set(s[d], !1),
          Ho(u) && u.add(d))
      }
  }
  scrapeMotionValuesFromProps(t, n) {
      return {}
  }
  mount(t) {
      this.current = t,
      md.set(t, this),
      this.projection && !this.projection.instance && this.projection.mount(t),
      this.parent && this.isVariantNode && !this.isControllingVariants && (this.removeFromVariantTree = this.parent.addVariantChild(this)),
      this.values.forEach( (n, r) => this.bindToMotionValue(r, n)),
      Ih.current || d5(),
      this.shouldReduceMotion = this.reducedMotionConfig === "never" ? !1 : this.reducedMotionConfig === "always" ? !0 : xl.current,
      this.parent && this.parent.children.add(this),
      this.update(this.props, this.presenceContext)
  }
  unmount() {
      md.delete(this.current),
      this.projection && this.projection.unmount(),
      At(this.notifyUpdate),
      At(this.render),
      this.valueSubscriptions.forEach(t => t()),
      this.removeFromVariantTree && this.removeFromVariantTree(),
      this.parent && this.parent.children.delete(this);
      for (const t in this.events)
          this.events[t].clear();
      for (const t in this.features)
          this.features[t].unmount();
      this.current = null
  }
  bindToMotionValue(t, n) {
      const r = Mn.has(t)
        , i = n.on("change", a => {
          this.latestValues[t] = a,
          this.props.onUpdate && W.update(this.notifyUpdate, !1, !0),
          r && this.projection && (this.projection.isTransformDirty = !0)
      }
      )
        , o = n.on("renderRequest", this.scheduleRender);
      this.valueSubscriptions.set(t, () => {
          i(),
          o()
      }
      )
  }
  sortNodePosition(t) {
      return !this.current || !this.sortInstanceNodePosition || this.type !== t.type ? 0 : this.sortInstanceNodePosition(this.current, t.current)
  }
  loadFeatures({children: t, ...n}, r, i, o) {
      let a, s;
      for (let l = 0; l < m5; l++) {
          const u = Fh[l]
            , {isEnabled: f, Feature: d, ProjectionNode: m, MeasureLayout: p} = mi[u];
          m && (a = m),
          f(n) && (!this.features[u] && d && (this.features[u] = new d(this)),
          p && (s = p))
      }
      if ((this.type === "html" || this.type === "svg") && !this.projection && a) {
          this.projection = new a(this.latestValues,this.parent && this.parent.projection);
          const {layoutId: l, layout: u, drag: f, dragConstraints: d, layoutScroll: m, layoutRoot: p} = n;
          this.projection.setOptions({
              layoutId: l,
              layout: u,
              alwaysMeasureLayout: Boolean(f) || d && Zn(d),
              visualElement: this,
              scheduleRender: () => this.scheduleRender(),
              animationType: typeof u == "string" ? u : "both",
              initialPromotionConfig: o,
              layoutScroll: m,
              layoutRoot: p
          })
      }
      return s
  }
  updateFeatures() {
      for (const t in this.features) {
          const n = this.features[t];
          n.isMounted ? n.update() : (n.mount(),
          n.isMounted = !0)
      }
  }
  triggerBuild() {
      this.build(this.renderState, this.latestValues, this.options, this.props)
  }
  measureViewportBox() {
      return this.current ? this.measureInstanceViewportBox(this.current, this.props) : se()
  }
  getStaticValue(t) {
      return this.latestValues[t]
  }
  setStaticValue(t, n) {
      this.latestValues[t] = n
  }
  makeTargetAnimatable(t, n=!0) {
      return this.makeTargetAnimatableFromInstance(t, this.props, n)
  }
  update(t, n) {
      (t.transformTemplate || this.props.transformTemplate) && this.scheduleRender(),
      this.prevProps = this.props,
      this.props = t,
      this.prevPresenceContext = this.presenceContext,
      this.presenceContext = n;
      for (let r = 0; r < hd.length; r++) {
          const i = hd[r];
          this.propEventSubscriptions[i] && (this.propEventSubscriptions[i](),
          delete this.propEventSubscriptions[i]);
          const o = t["on" + i];
          o && (this.propEventSubscriptions[i] = this.on(i, o))
      }
      this.prevMotionValues = f5(this, this.scrapeMotionValuesFromProps(t, this.prevProps), this.prevMotionValues),
      this.handleChildMotionValue && this.handleChildMotionValue()
  }
  getProps() {
      return this.props
  }
  getVariant(t) {
      return this.props.variants ? this.props.variants[t] : void 0
  }
  getDefaultTransition() {
      return this.props.transition
  }
  getTransformPagePoint() {
      return this.props.transformPagePoint
  }
  getClosestVariantNode() {
      return this.isVariantNode ? this : this.parent ? this.parent.getClosestVariantNode() : void 0
  }
  getVariantContext(t=!1) {
      if (t)
          return this.parent ? this.parent.getVariantContext() : void 0;
      if (!this.isControllingVariants) {
          const r = this.parent ? this.parent.getVariantContext() || {} : {};
          return this.props.initial !== void 0 && (r.initial = this.props.initial),
          r
      }
      const n = {};
      for (let r = 0; r < h5; r++) {
          const i = Nu[r]
            , o = this.props[i];
          (fi(o) || o === !1) && (n[i] = o)
      }
      return n
  }
  addVariantChild(t) {
      const n = this.getClosestVariantNode();
      if (n)
          return n.variantChildren && n.variantChildren.add(t),
          () => n.variantChildren.delete(t)
  }
  addValue(t, n) {
      n !== this.values.get(t) && (this.removeValue(t),
      this.bindToMotionValue(t, n)),
      this.values.set(t, n),
      this.latestValues[t] = n.get()
  }
  removeValue(t) {
      this.values.delete(t);
      const n = this.valueSubscriptions.get(t);
      n && (n(),
      this.valueSubscriptions.delete(t)),
      delete this.latestValues[t],
      this.removeValueFromRenderState(t, this.renderState)
  }
  hasValue(t) {
      return this.values.has(t)
  }
  getValue(t, n) {
      if (this.props.values && this.props.values[t])
          return this.props.values[t];
      let r = this.values.get(t);
      return r === void 0 && n !== void 0 && (r = ur(n, {
          owner: this
      }),
      this.addValue(t, r)),
      r
  }
  readValue(t) {
      var n;
      return this.latestValues[t] !== void 0 || !this.current ? this.latestValues[t] : (n = this.getBaseTargetFromProps(this.props, t)) !== null && n !== void 0 ? n : this.readValueFromInstance(this.current, t, this.options)
  }
  setBaseTarget(t, n) {
      this.baseTarget[t] = n
  }
  getBaseTarget(t) {
      var n;
      const {initial: r} = this.props
        , i = typeof r == "string" || typeof r == "object" ? (n = Ru(this.props, r)) === null || n === void 0 ? void 0 : n[t] : void 0;
      if (r && i !== void 0)
          return i;
      const o = this.getBaseTargetFromProps(this.props, t);
      return o !== void 0 && !De(o) ? o : this.initialValues[t] !== void 0 && i === void 0 ? void 0 : this.baseTarget[t]
  }
  on(t, n) {
      return this.events[t] || (this.events[t] = new Hu),
      this.events[t].add(n)
  }
  notify(t, ...n) {
      this.events[t] && this.events[t].notify(...n)
  }
}
class _h extends p5 {
  sortInstanceNodePosition(t, n) {
      return t.compareDocumentPosition(n) & 2 ? 1 : -1
  }
  getBaseTargetFromProps(t, n) {
      return t.style ? t.style[n] : void 0
  }
  removeValueFromRenderState(t, {vars: n, style: r}) {
      delete n[t],
      delete r[t]
  }
  makeTargetAnimatableFromInstance({transition: t, transitionEnd: n, ...r}, {transformValues: i}, o) {
      let a = b8(r, t || {}, this);
      if (i && (n && (n = i(n)),
      r && (r = i(r)),
      a && (a = i(a))),
      o) {
          L8(this, r, a);
          const s = c5(this, r, a, n);
          n = s.transitionEnd,
          r = s.target
      }
      return {
          transition: t,
          transitionEnd: n,
          ...r
      }
  }
}
function g5(e) {
  return window.getComputedStyle(e)
}
class y5 extends _h {
  constructor() {
      super(...arguments),
      this.type = "html"
  }
  readValueFromInstance(t, n) {
      if (Mn.has(n)) {
          const r = ju(n);
          return r && r.default || 0
      } else {
          const r = g5(t)
            , i = (Am(n) ? r.getPropertyValue(n) : r[n]) || 0;
          return typeof i == "string" ? i.trim() : i
      }
  }
  measureInstanceViewportBox(t, {transformPagePoint: n}) {
      return Ah(t, n)
  }
  build(t, n, r, i) {
      Au(t, n, r, i.transformTemplate)
  }
  scrapeMotionValuesFromProps(t, n) {
      return Lu(t, n)
  }
  handleChildMotionValue() {
      this.childSubscription && (this.childSubscription(),
      delete this.childSubscription);
      const {children: t} = this.props;
      De(t) && (this.childSubscription = t.on("change", n => {
          this.current && (this.current.textContent = `${n}`)
      }
      ))
  }
  renderInstance(t, n, r, i) {
      bm(t, n, r, i)
  }
}
class v5 extends _h {
  constructor() {
      super(...arguments),
      this.type = "svg",
      this.isSVGTag = !1
  }
  getBaseTargetFromProps(t, n) {
      return t[n]
  }
  readValueFromInstance(t, n) {
      if (Mn.has(n)) {
          const r = ju(n);
          return r && r.default || 0
      }
      return n = Om.has(n) ? n : Su(n),
      t.getAttribute(n)
  }
  measureInstanceViewportBox() {
      return se()
  }
  scrapeMotionValuesFromProps(t, n) {
      return Dm(t, n)
  }
  build(t, n, r, i) {
      Tu(t, n, r, this.isSVGTag, i.transformTemplate)
  }
  renderInstance(t, n, r, i) {
      Vm(t, n, r, i)
  }
  mount(t) {
      this.isSVGTag = Mu(t.tagName),
      super.mount(t)
  }
}
const x5 = (e, t) => Pu(e) ? new v5(t,{
  enableHardwareAcceleration: !1
}) : new y5(t,{
  enableHardwareAcceleration: !0
})
, w5 = {
  layout: {
      ProjectionNode: Dh,
      MeasureLayout: Th
  }
}
, S5 = {
  ...W8,
  ...pv,
  ...q6,
  ...w5
}
, k = Cy( (e, t) => nv(e, t, S5, x5));
function zh() {
  const e = E.exports.useRef(!1);
  return wu( () => (e.current = !0,
  () => {
      e.current = !1
  }
  ), []),
  e
}
function E5() {
  const e = zh()
    , [t,n] = E.exports.useState(0)
    , r = E.exports.useCallback( () => {
      e.current && n(t + 1)
  }
  , [t]);
  return [E.exports.useCallback( () => W.postRender(r), [r]), t]
}
class N5 extends E.exports.Component {
  getSnapshotBeforeUpdate(t) {
      const n = this.props.childRef.current;
      if (n && t.isPresent && !this.props.isPresent) {
          const r = this.props.sizeRef.current;
          r.height = n.offsetHeight || 0,
          r.width = n.offsetWidth || 0,
          r.top = n.offsetTop,
          r.left = n.offsetLeft
      }
      return null
  }
  componentDidUpdate() {}
  render() {
      return this.props.children
  }
}
function C5({children: e, isPresent: t}) {
  const n = E.exports.useId()
    , r = E.exports.useRef(null)
    , i = E.exports.useRef({
      width: 0,
      height: 0,
      top: 0,
      left: 0
  });
  return E.exports.useInsertionEffect( () => {
      const {width: o, height: a, top: s, left: l} = i.current;
      if (t || !r.current || !o || !a)
          return;
      r.current.dataset.motionPopId = n;
      const u = document.createElement("style");
      return document.head.appendChild(u),
      u.sheet && u.sheet.insertRule(`
        [data-motion-pop-id="${n}"] {
          position: absolute !important;
          width: ${o}px !important;
          height: ${a}px !important;
          top: ${s}px !important;
          left: ${l}px !important;
        }
      `),
      () => {
          document.head.removeChild(u)
      }
  }
  , [t]),
  c(N5, {
      isPresent: t,
      childRef: r,
      sizeRef: i,
      children: E.exports.cloneElement(e, {
          ref: r
      })
  })
}
const cs = ({children: e, initial: t, isPresent: n, onExitComplete: r, custom: i, presenceAffectsLayout: o, mode: a}) => {
  const s = jm(P5)
    , l = E.exports.useId()
    , u = E.exports.useMemo( () => ({
      id: l,
      initial: t,
      isPresent: n,
      custom: i,
      onExitComplete: f => {
          s.set(f, !0);
          for (const d of s.values())
              if (!d)
                  return;
          r && r()
      }
      ,
      register: f => (s.set(f, !1),
      () => s.delete(f))
  }), o ? void 0 : [n]);
  return E.exports.useMemo( () => {
      s.forEach( (f, d) => s.set(d, !1))
  }
  , [n]),
  E.exports.useEffect( () => {
      !n && !s.size && r && r()
  }
  , [n]),
  a === "popLayout" && (e = c(C5, {
      isPresent: n,
      children: e
  })),
  c(ha.Provider, {
      value: u,
      children: e
  })
}
;
function P5() {
  return new Map
}
function A5(e) {
  return E.exports.useEffect( () => () => e(), [])
}
const fn = e => e.key || "";
function k5(e, t) {
  e.forEach(n => {
      const r = fn(n);
      t.set(r, n)
  }
  )
}
function T5(e) {
  const t = [];
  return E.exports.Children.forEach(e, n => {
      E.exports.isValidElement(n) && t.push(n)
  }
  ),
  t
}
const wn = ({children: e, custom: t, initial: n=!0, onExitComplete: r, exitBeforeEnter: i, presenceAffectsLayout: o=!0, mode: a="sync"}) => {
  Sa(!i);
  const s = E.exports.useContext(Cu).forceRender || E5()[0]
    , l = zh()
    , u = T5(e);
  let f = u;
  const d = E.exports.useRef(new Map).current
    , m = E.exports.useRef(f)
    , p = E.exports.useRef(new Map).current
    , v = E.exports.useRef(!0);
  if (wu( () => {
      v.current = !1,
      k5(u, p),
      m.current = f
  }
  ),
  A5( () => {
      v.current = !0,
      p.clear(),
      d.clear()
  }
  ),
  v.current)
      return c(ui, {
          children: f.map(h => c(cs, {
              isPresent: !0,
              initial: n ? void 0 : !1,
              presenceAffectsLayout: o,
              mode: a,
              children: h
          }, fn(h)))
      });
  f = [...f];
  const x = m.current.map(fn)
    , P = u.map(fn)
    , y = x.length;
  for (let h = 0; h < y; h++) {
      const g = x[h];
      P.indexOf(g) === -1 && !d.has(g) && d.set(g, void 0)
  }
  return a === "wait" && d.size && (f = []),
  d.forEach( (h, g) => {
      if (P.indexOf(g) !== -1)
          return;
      const S = p.get(g);
      if (!S)
          return;
      const M = x.indexOf(g);
      let A = h;
      A || (A = c(cs, {
          isPresent: !1,
          onExitComplete: () => {
              d.delete(g);
              const N = Array.from(p.keys()).filter(R => !P.includes(R));
              if (N.forEach(R => p.delete(R)),
              m.current = u.filter(R => {
                  const O = fn(R);
                  return O === g || N.includes(O)
              }
              ),
              !d.size) {
                  if (l.current === !1)
                      return;
                  s(),
                  r && r()
              }
          }
          ,
          custom: t,
          presenceAffectsLayout: o,
          mode: a,
          children: S
      }, fn(S)),
      d.set(g, A)),
      f.splice(M, 0, A)
  }
  ),
  f = f.map(h => {
      const g = h.key;
      return d.has(g) ? h : c(cs, {
          isPresent: !0,
          presenceAffectsLayout: o,
          mode: a,
          children: h
      }, fn(h))
  }
  ),
  c(ui, {
      children: d.size ? f : f.map(h => E.exports.cloneElement(h))
  })
}
;
function pd() {
  const {permissions: e} = oe()
    , [t,n] = E.exports.useState("")
    , [r,i] = E.exports.useState([])
    , {contractModal: o, setOpenedContractModal: a, discord: s, radio: l, preset: u, user_id: f} = oe()
    , [d,m] = E.exports.useState({
      id: "asc",
      status: "asc",
      role: "asc",
      lastLogin: "desc"
  })
    , p = r.filter(C => String(C.name).toLowerCase().includes(t.toLowerCase()) || String(C.id).includes(t.toLowerCase()));
  function v() {
      a(!0)
  }
  function x(C) {
      !C || !e.promote || z("PromoteMember", {
          id: C
      }).then(N => {
          N && i(R => R.map(O => O.id === C ? {
              ...O,
              role_id: N.role_id,
              role: N.role
          } : O))
      }
      )
  }
  function P(C) {
      !C || !e.demote || z("DemoteMember", {
          id: C
      }).then(N => {
          N && i(R => R.map(O => O.id === C ? {
              ...O,
              role_id: N.role_id,
              role: N.role
          } : O))
      }
      )
  }
  function y(C) {
      z("DimissMember", {
          id: C
      }, !0).then( () => {
          i(N => N.filter(R => R.id !== C))
      }
      )
  }
  function h() {
      z("ConnectRadio", {
          radio: l
      }, !0)
  }
  function g() {
      window.invokeNative("openUrl", s)
  }
  function S() {
      z("SetCostume", {
          preset: u
      }, !0)
  }
  function M(C) {
      m(N => ({
          ...N,
          [C]: N[C] === "asc" ? "desc" : "asc"
      }))
  }
  function A(C) {
      const N = d[C]
        , R = r.slice().sort( (O, U) => C === "status" ? O.status === !0 && U.status === !1 ? N === "asc" ? -1 : 1 : O.status === !1 && U.status === !0 ? N === "asc" ? 1 : -1 : 0 : C === "id" ? N === "asc" ? O.id - U.id : U.id - O.id : C === "role" ? N === "asc" ? O.role_id - U.role_id : U.role_id - O.role_id : C === "lastLogin" ? N === "asc" ? U.since - O.since : O.since - U.since : 0);
      i(R),
      M(C)
  }
  return E.exports.useEffect( () => {
      z("GetMembers", {}, [{
          icon: "https://img.artpal.com/636582/12-23-7-19-21-23-13m.jpg",
          name: "IGOR",
          id: 1337,
          role: "MEMBRO",
          lastLogin: "15/10/2024",
          joinedAt: "22/22/22",
          role_id: 3,
          hours: 4960,
          status: !0
      }, {
          icon: "https://img.artpal.com/636582/12-23-7-19-21-23-13m.jpg",
          name: "MIRTIN",
          id: 242,
          role: "GERENTE",
          lastLogin: "15/10/2024",
          joinedAt: "22/22/22",
          role_id: 2,
          hours: 9600,
          status: !1
      }, {
          icon: "https://img.artpal.com/636582/12-23-7-19-21-23-13m.jpg",
          name: "IGOR",
          id: 3,
          role: "L\xCDDER",
          lastLogin: "15/10/2024",
          joinedAt: "22/22/22",
          role_id: 1,
          hours: 9600,
          status: !0
      }, {
          icon: "https://img.artpal.com/636582/12-23-7-19-21-23-13m.jpg",
          name: "IGOR",
          id: 4,
          role: "TESTE",
          lastLogin: "15/10/2024",
          joinedAt: "22/22/22",
          role_id: 3,
          hours: 9600,
          status: !1
      }, {
          icon: "https://img.artpal.com/636582/12-23-7-19-21-23-13m.jpg",
          name: "IGOR",
          id: 5,
          role: "TESTE",
          lastLogin: "15/10/2024",
          joinedAt: "22/22/22",
          role_id: 3,
          hours: 9600,
          status: !0
      }, {
          icon: "https://img.artpal.com/636582/12-23-7-19-21-23-13m.jpg",
          name: "IGOR",
          id: 6,
          role: "TESTE",
          lastLogin: "15/10/2024",
          joinedAt: "22/22/22",
          role_id: 3,
          hours: 9600,
          status: !1
      }, {
          icon: "https://img.artpal.com/636582/12-23-7-19-21-23-13m.jpg",
          name: "IGOR",
          id: 7,
          role: "TESTE",
          lastLogin: "15/10/2024",
          joinedAt: "22/22/22",
          role_id: 3,
          hours: 9600,
          status: !0
      }, {
          icon: "https://img.artpal.com/636582/12-23-7-19-21-23-13m.jpg",
          name: "IGOR",
          id: 8,
          role: "TESTE",
          lastLogin: "15/10/2024",
          joinedAt: "22/22/22",
          role_id: 3,
          hours: 9600,
          status: !1
      }, {
          icon: "https://img.artpal.com/636582/12-23-7-19-21-23-13m.jpg",
          name: "IGOR",
          id: 11,
          role: "TESTE",
          lastLogin: "15/10/2024",
          joinedAt: "22/22/22",
          role_id: 3,
          hours: 9600,
          status: !1
      }, {
          icon: "https://img.artpal.com/636582/12-23-7-19-21-23-13m.jpg",
          name: "IGOR",
          id: 9,
          role: "TESTE",
          lastLogin: "15/10/2024",
          joinedAt: "22/22/22",
          role_id: 3,
          hours: 9600,
          status: !1
      }]).then(i)
  }
  , []),
  w(ui, {
      children: [w(k.div, {
          initial: {
              opacity: 0,
              y: 20
          },
          animate: {
              opacity: 1,
              y: 0
          },
          transition: {
              duration: .5
          },
          className: "w-full pt-[1rem] px-4",
          children: [w(k.div, {
              initial: {
                  opacity: 0,
                  x: -20
              },
              animate: {
                  opacity: 1,
                  x: 0
              },
              transition: {
                  duration: .5,
                  delay: .2
              },
              className: "flex items-center justify-between mb-6",
              children: [w(k.div, {
                  whileHover: {
                      scale: 1.02
                  },
                  className: "bg-radio bg-cover bg-no-repeat w-[19.375rem] h-[7.875rem] flex flex-col justify-center pl-4",
                  children: [c("p", {
                      className: "text-white text-base font-medium",
                      children: "R\xC1DIO"
                  }), c("p", {
                      className: "text-white/60 text-xs font-normal",
                      children: "Entre no r\xE1dio clicando em:"
                  }), c(k.button, {
                      whileTap: {
                          scale: .95
                      },
                      onClick: h,
                      className: "bg-primary w-[10.25rem] py-[.25rem] text-white text-xs rounded-[.1875rem] mt-2",
                      children: "CONECTAR"
                  })]
              }), w(k.div, {
                  whileHover: {
                      scale: 1.02
                  },
                  className: "bg-costume bg-cover bg-no-repeat w-[19.375rem] h-[7.875rem] flex flex-col justify-center pl-4",
                  children: [c("p", {
                      className: "text-white text-base font-medium",
                      children: "TRAJE"
                  }), c("p", {
                      className: "text-white/60 text-xs font-normal",
                      children: "Coloque a roupa clicando em:"
                  }), c(k.button, {
                      whileTap: {
                          scale: .95
                      },
                      onClick: S,
                      className: "bg-primary w-[10.25rem] py-[.25rem] text-white text-xs rounded-[.1875rem] mt-2",
                      children: "SETAR"
                  })]
              }), w(k.div, {
                  whileHover: {
                      scale: 1.02
                  },
                  className: "bg-discord bg-cover bg-no-repeat w-[19.375rem] h-[7.875rem] flex flex-col justify-center pl-4",
                  children: [c("p", {
                      className: "text-white text-base font-medium",
                      children: "DISCORD"
                  }), c("p", {
                      className: "text-white/60 text-xs font-normal",
                      children: "Entre no discord clicando em:"
                  }), c(k.button, {
                      whileTap: {
                          scale: .95
                      },
                      onClick: g,
                      className: "bg-primary w-[10.25rem] py-[.25rem] text-white text-xs rounded-[.1875rem] mt-2",
                      children: "CONECTAR"
                  })]
              })]
          }), w(k.div, {
              initial: {
                  opacity: 0,
                  y: 20
              },
              animate: {
                  opacity: 1,
                  y: 0
              },
              transition: {
                  duration: .5,
                  delay: .4
              },
              className: "flex items-center justify-between",
              children: [w("div", {
                  className: "flex items-center gap-4",
                  children: [w("div", {
                      className: "flex items-center gap-2",
                      children: [c(k.div, {
                          whileHover: {
                              scale: 1.1
                          },
                          className: "w-[2.125rem] h-[2.125rem] bg-primary rounded-[.25rem] flex items-center justify-center",
                          children: c(di, {
                              size: 21,
                              className: "text-white"
                          })
                      }), c("p", {
                          className: "text-white text-xs font-medium",
                          children: "MEMBROS"
                      })]
                  }), w("div", {
                      className: "flex gap-2 px-3 items-center w-60 h-[2.125rem] rounded-[.25rem] bg-white/[.04] border border-white/[.04]",
                      children: [c(mm, {
                          size: 16,
                          className: "text-primary"
                      }), c("input", {
                          onChange: C => n(C.target.value),
                          type: "text",
                          className: "bg-transparent flex-1 h-full outline-none text-white text-xs font-normal",
                          placeholder: "PESQUISAR ID OU NOME..."
                      })]
                  })]
              }), (e.invite || e.leader) && c(k.button, {
                  whileHover: {
                      scale: 1.02
                  },
                  whileTap: {
                      scale: .98
                  },
                  className: "w-[14.125rem] h-[2.125rem] bg-primary border border-white/[.15] rounded-[.25rem] text-white text-[.6875rem] font-semibold",
                  onClick: v,
                  children: "CONTRATAR"
              })]
          }), w(k.div, {
              initial: {
                  opacity: 0,
                  y: 20
              },
              animate: {
                  opacity: 1,
                  y: 0
              },
              transition: {
                  duration: .5,
                  delay: .6
              },
              className: "mt-6 flex flex-col gap-[.64rem]",
              children: [w("div", {
                  className: "flex items-center pl-4",
                  children: [c("p", {
                      className: "text-white text-[.625rem] font-normal w-[9.9375rem]",
                      children: "Nome"
                  }), w("p", {
                      className: "text-white text-[.625rem] font-normal flex items-center gap-[.38rem] w-[8.3125rem]",
                      children: ["ID", c(k.div, {
                          whileHover: {
                              scale: 1.2
                          },
                          children: c(Xa, {
                              size: 8,
                              color: "white",
                              className: "cursor-pointer",
                              onClick: () => A("id")
                          })
                      })]
                  }), w("p", {
                      className: "text-white text-[.625rem] font-normal flex items-center gap-[.38rem] w-[11.3125rem]",
                      children: ["Cargo", c(k.div, {
                          whileHover: {
                              scale: 1.2
                          },
                          children: c(Xa, {
                              size: 8,
                              color: "white",
                              className: "cursor-pointer",
                              onClick: () => A("role")
                          })
                      })]
                  }), c("p", {
                      className: "text-white text-[.625rem] font-normal flex items-center gap-[.38rem] w-[12rem]",
                      children: "Login"
                  }), w("p", {
                      className: "text-white text-[.625rem] font-normal flex items-center gap-[.38rem]",
                      children: ["Status", c(k.div, {
                          whileHover: {
                              scale: 1.2
                          },
                          children: c(Xa, {
                              size: 8,
                              color: "white",
                              className: "cursor-pointer",
                              onClick: () => A("status")
                          })
                      })]
                  })]
              }), c("div", {
                  className: "flex flex-col gap-2 overflow-auto max-h-[14.17525rem]",
                  children: p == null ? void 0 : p.map( (C, N) => w(k.div, {
                      initial: {
                          opacity: 0,
                          x: -20
                      },
                      animate: {
                          opacity: 1,
                          x: 0
                      },
                      transition: {
                          delay: N * .1
                      },
                      whileHover: {
                          scale: 1.01
                      },
                      className: "flex-none flex items-center bg-white/[.04] h-10 rounded-[.25rem] border border-white/[.04] pl-4",
                      children: [c("p", {
                          className: "text-white text-[0.6875rem] font-normal w-[9.9375rem]",
                          children: C.name
                      }), c("p", {
                          className: "text-white text-[0.6875rem] font-normal w-[8.3125rem]",
                          children: C.id
                      }), c("p", {
                          className: "text-white text-[0.6875rem] font-normal w-[11.3125rem]",
                          children: C.role
                      }), c("p", {
                          className: "text-white text-[0.6875rem] font-normal w-[12rem]",
                          children: C.lastLogin
                      }), c("p", {
                          className: wi("text-[0.6875rem] font-normal w-[12.5rem]", {
                              "!text-green-500": C.status,
                              "!text-red-500": !C.status
                          }),
                          children: C.status ? "Online" : "Offline"
                      }), w("div", {
                          className: "flex items-center gap-[.31rem]",
                          children: [c(k.button, {
                              whileHover: {
                                  scale: 1.2
                              },
                              onClick: () => x(C.id),
                              children: c(sy, {
                                  size: 16,
                                  className: `text-primary ${!e.promote && !e.leader && "opacity-0 !cursor-not-allowed"}`
                              })
                          }), c(k.button, {
                              whileHover: {
                                  scale: 1.2
                              },
                              onClick: () => P(C.id),
                              children: c(oy, {
                                  size: 16,
                                  className: `text-primary ${!e.demote && !e.leader && "opacity-0 !cursor-not-allowed"}`
                              })
                          }), c(k.button, {
                              whileHover: {
                                  scale: 1.2
                              },
                              onClick: () => y(C.id),
                              children: c(ny, {
                                  size: 16,
                                  className: `text-primary ${!e.dismiss && C.id !== f && !e.leader && "opacity-0 !cursor-not-allowed"}`
                              })
                          })]
                      })]
                  }, N))
              })]
          })]
      }), o && c(hy, {})]
  })
}
const Sn = (e, t) => {
  const n = E.exports.useRef(C4);
  E.exports.useEffect( () => {
      n.current = t
  }
  , [t]),
  E.exports.useEffect( () => {
      const r = i => {
          const {action: o, data: a} = i.data;
          n.current && o === e && n.current(a)
      }
      ;
      return window.addEventListener("message", r),
      () => window.removeEventListener("message", r)
  }
  , [e])
}
, M5 = E.exports.createContext(null)
, L5 = ({children: e}) => {
  const t = rm()
    , [n,r] = E.exports.useState(oo())
    , {setPainelType: i, setPreset: o, setRadio: a, setWarnings: s, setUserId: l, setAvatar: u, setOrgBalance: f, setWarningModalVisible: d, setConfigModalVisible: m, setGoalModalVisible: p, setServerIcon: v, setName: x, setPlayerBalance: P, setCanWarn: y, setDiscord: h, setLogo: g, setMembers: S, setNextPaymentMax: M, setStore: A, setMembersOnline: C, setleader: N, setOrgName: R, setPermissions: O, setRoles: U, setNextPayment: ue, setSalary: pe, setGoalReward: ae} = oe();
  function qe() {
      z("GetPainelInfos", {}, {
          radio: 1336,
          user_id: 1337,
          preset: {
              male: "aa",
              female: "bbb"
          },
          avatar: "https://i.imgur.com/exJslvp.png",
          orgBalance: 25e3,
          name: "ruan jkz",
          leader: "Mirtin",
          serverIcon: "https://i.imgur.com/exJslvp.png",
          orgName: "Turquia",
          members: 25,
          membersOnline: 10,
          salary: 5e3,
          nextPayment: 4e3,
          nextPaymentMax: 2e3,
          goalReward: 1e3,
          store: "https://discord.gg/fivecommunity",
          playerBalance: 1e5,
          type: "ilegal",
          roles: [{
              prefix: "Membro",
              group: "Membro",
              nivel: 2,
              members: 23
          }, {
              prefix: "L\xEDder",
              group: "L\xEDder",
              nivel: 1,
              members: 23
          }],
          discord: "https://discord.gg/fivecommunity",
          permissions: {
              name: !0,
              promote: !1,
              demote: !1,
              dismiss: !1,
              withdraw: !1,
              deposit: !1,
              message: !0,
              alerts: !0,
              invite: !1,
              chat: !0,
              leader: !0
          },
          logo: "",
          canWarn: !0,
          warnings: [{
              author: "Ruan",
              author_id: 1337,
              message: "Voc\xEA foi promovido!",
              author_avatar: "https://i.imgur.com/exJslvp.png",
              date: "15/03/2024"
          }, {
              author: "Ruan",
              author_id: 1337,
              author_avatar: "https://i.imgur.com/exJslvp.png",
              message: "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
              date: "15/03/2024"
          }, {
              author: "Ruan",
              author_id: 1337,
              author_avatar: "https://i.imgur.com/exJslvp.png",
              message: "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
              date: "15/03/2024"
          }, {
              author: "Ruan",
              author_id: 1337,
              author_avatar: "https://i.imgur.com/exJslvp.png",
              message: "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
              date: "15/03/2024"
          }, {
              author: "Ruan",
              author_id: 1337,
              author_avatar: "https://i.imgur.com/exJslvp.png",
              message: "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
              date: "15/03/2024"
          }]
      }).then(D => {
          a(D.radio),
          u(D.avatar),
          l(D.user_id),
          f(D.orgBalance),
          x(D.name),
          g(D.logo),
          y(D.canWarn),
          P(D.playerBalance),
          O(D.permissions),
          N(D.leader),
          S(D.members),
          C(D.membersOnline),
          s(D.warnings),
          R(D.orgName),
          U(D.roles),
          v(D.serverIcon),
          h(D.discord),
          ue(D.nextPayment),
          pe(D.salary),
          A(D.store),
          M(D.nextPaymentMax),
          ae(D.goalReward),
          o(D.preset),
          i(D.type)
      }
      )
  }
  return E.exports.useEffect( () => {
      oo() && qe()
  }
  , []),
  Sn("open", () => {
      r(!0),
      t("/home"),
      p(!1),
      d(!1),
      m(!1),
      qe()
  }
  ),
  Sn("UpdatePermissions", O),
  Sn("close", () => r(!1)),
  E.exports.useEffect( () => {
      if (!n)
          return;
      const D = Me => {
          if (Me.code === "Escape") {
              if (oo())
                  return r(!1);
              r(!1),
              z("close")
          }
      }
      ;
      return window.addEventListener("keydown", D),
      () => window.removeEventListener("keydown", D)
  }
  , [n]),
  c(M5.Provider, {
      value: {},
      children: n && e
  })
}
, R5 = new Map([["bold", T.createElement(T.Fragment, null, c("path", {
  d: "M128,20A108,108,0,1,0,236,128,108.12,108.12,0,0,0,128,20Zm0,192a84,84,0,1,1,84-84A84.09,84.09,0,0,1,128,212Zm68-84a12,12,0,0,1-12,12H128a12,12,0,0,1-12-12V72a12,12,0,0,1,24,0v44h44A12,12,0,0,1,196,128Z"
}))], ["duotone", T.createElement(T.Fragment, null, c("path", {
  d: "M224,128a96,96,0,1,1-96-96A96,96,0,0,1,224,128Z",
  opacity: "0.2"
}), c("path", {
  d: "M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm64-88a8,8,0,0,1-8,8H128a8,8,0,0,1-8-8V72a8,8,0,0,1,16,0v48h48A8,8,0,0,1,192,128Z"
}))], ["fill", T.createElement(T.Fragment, null, c("path", {
  d: "M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm56,112H128a8,8,0,0,1-8-8V72a8,8,0,0,1,16,0v48h48a8,8,0,0,1,0,16Z"
}))], ["light", T.createElement(T.Fragment, null, c("path", {
  d: "M128,26A102,102,0,1,0,230,128,102.12,102.12,0,0,0,128,26Zm0,192a90,90,0,1,1,90-90A90.1,90.1,0,0,1,128,218Zm62-90a6,6,0,0,1-6,6H128a6,6,0,0,1-6-6V72a6,6,0,0,1,12,0v50h50A6,6,0,0,1,190,128Z"
}))], ["regular", T.createElement(T.Fragment, null, c("path", {
  d: "M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm64-88a8,8,0,0,1-8,8H128a8,8,0,0,1-8-8V72a8,8,0,0,1,16,0v48h48A8,8,0,0,1,192,128Z"
}))], ["thin", T.createElement(T.Fragment, null, c("path", {
  d: "M128,28A100,100,0,1,0,228,128,100.11,100.11,0,0,0,128,28Zm0,192a92,92,0,1,1,92-92A92.1,92.1,0,0,1,128,220Zm60-92a4,4,0,0,1-4,4H128a4,4,0,0,1-4-4V72a4,4,0,0,1,8,0v52h52A4,4,0,0,1,188,128Z"
}))]])
, b5 = new Map([["bold", T.createElement(T.Fragment, null, c("path", {
  d: "M128,76a52,52,0,1,0,52,52A52.06,52.06,0,0,0,128,76Zm0,80a28,28,0,1,1,28-28A28,28,0,0,1,128,156Zm92-27.21v-1.58l14-17.51a12,12,0,0,0,2.23-10.59A111.75,111.75,0,0,0,225,71.89,12,12,0,0,0,215.89,66L193.61,63.5l-1.11-1.11L190,40.1A12,12,0,0,0,184.11,31a111.67,111.67,0,0,0-27.23-11.27A12,12,0,0,0,146.3,22L128.79,36h-1.58L109.7,22a12,12,0,0,0-10.59-2.23A111.75,111.75,0,0,0,71.89,31.05,12,12,0,0,0,66,40.11L63.5,62.39,62.39,63.5,40.1,66A12,12,0,0,0,31,71.89,111.67,111.67,0,0,0,19.77,99.12,12,12,0,0,0,22,109.7l14,17.51v1.58L22,146.3a12,12,0,0,0-2.23,10.59,111.75,111.75,0,0,0,11.29,27.22A12,12,0,0,0,40.11,190l22.28,2.48,1.11,1.11L66,215.9A12,12,0,0,0,71.89,225a111.67,111.67,0,0,0,27.23,11.27A12,12,0,0,0,109.7,234l17.51-14h1.58l17.51,14a12,12,0,0,0,10.59,2.23A111.75,111.75,0,0,0,184.11,225a12,12,0,0,0,5.91-9.06l2.48-22.28,1.11-1.11L215.9,190a12,12,0,0,0,9.06-5.91,111.67,111.67,0,0,0,11.27-27.23A12,12,0,0,0,234,146.3Zm-24.12-4.89a70.1,70.1,0,0,1,0,8.2,12,12,0,0,0,2.61,8.22l12.84,16.05A86.47,86.47,0,0,1,207,166.86l-20.43,2.27a12,12,0,0,0-7.65,4,69,69,0,0,1-5.8,5.8,12,12,0,0,0-4,7.65L166.86,207a86.47,86.47,0,0,1-10.49,4.35l-16.05-12.85a12,12,0,0,0-7.5-2.62c-.24,0-.48,0-.72,0a70.1,70.1,0,0,1-8.2,0,12.06,12.06,0,0,0-8.22,2.6L99.63,211.33A86.47,86.47,0,0,1,89.14,207l-2.27-20.43a12,12,0,0,0-4-7.65,69,69,0,0,1-5.8-5.8,12,12,0,0,0-7.65-4L49,166.86a86.47,86.47,0,0,1-4.35-10.49l12.84-16.05a12,12,0,0,0,2.61-8.22,70.1,70.1,0,0,1,0-8.2,12,12,0,0,0-2.61-8.22L44.67,99.63A86.47,86.47,0,0,1,49,89.14l20.43-2.27a12,12,0,0,0,7.65-4,69,69,0,0,1,5.8-5.8,12,12,0,0,0,4-7.65L89.14,49a86.47,86.47,0,0,1,10.49-4.35l16.05,12.85a12.06,12.06,0,0,0,8.22,2.6,70.1,70.1,0,0,1,8.2,0,12,12,0,0,0,8.22-2.6l16.05-12.85A86.47,86.47,0,0,1,166.86,49l2.27,20.43a12,12,0,0,0,4,7.65,69,69,0,0,1,5.8,5.8,12,12,0,0,0,7.65,4L207,89.14a86.47,86.47,0,0,1,4.35,10.49l-12.84,16.05A12,12,0,0,0,195.88,123.9Z"
}))], ["duotone", T.createElement(T.Fragment, null, c("path", {
  d: "M207.86,123.18l16.78-21a99.14,99.14,0,0,0-10.07-24.29l-26.7-3a81,81,0,0,0-6.81-6.81l-3-26.71a99.43,99.43,0,0,0-24.3-10l-21,16.77a81.59,81.59,0,0,0-9.64,0l-21-16.78A99.14,99.14,0,0,0,77.91,41.43l-3,26.7a81,81,0,0,0-6.81,6.81l-26.71,3a99.43,99.43,0,0,0-10,24.3l16.77,21a81.59,81.59,0,0,0,0,9.64l-16.78,21a99.14,99.14,0,0,0,10.07,24.29l26.7,3a81,81,0,0,0,6.81,6.81l3,26.71a99.43,99.43,0,0,0,24.3,10l21-16.77a81.59,81.59,0,0,0,9.64,0l21,16.78a99.14,99.14,0,0,0,24.29-10.07l3-26.7a81,81,0,0,0,6.81-6.81l26.71-3a99.43,99.43,0,0,0,10-24.3l-16.77-21A81.59,81.59,0,0,0,207.86,123.18ZM128,168a40,40,0,1,1,40-40A40,40,0,0,1,128,168Z",
  opacity: "0.2"
}), c("path", {
  d: "M128,80a48,48,0,1,0,48,48A48.05,48.05,0,0,0,128,80Zm0,80a32,32,0,1,1,32-32A32,32,0,0,1,128,160Zm88-29.84q.06-2.16,0-4.32l14.92-18.64a8,8,0,0,0,1.48-7.06,107.6,107.6,0,0,0-10.88-26.25,8,8,0,0,0-6-3.93l-23.72-2.64q-1.48-1.56-3-3L186,40.54a8,8,0,0,0-3.94-6,107.29,107.29,0,0,0-26.25-10.86,8,8,0,0,0-7.06,1.48L130.16,40Q128,40,125.84,40L107.2,25.11a8,8,0,0,0-7.06-1.48A107.6,107.6,0,0,0,73.89,34.51a8,8,0,0,0-3.93,6L67.32,64.27q-1.56,1.49-3,3L40.54,70a8,8,0,0,0-6,3.94,107.71,107.71,0,0,0-10.87,26.25,8,8,0,0,0,1.49,7.06L40,125.84Q40,128,40,130.16L25.11,148.8a8,8,0,0,0-1.48,7.06,107.6,107.6,0,0,0,10.88,26.25,8,8,0,0,0,6,3.93l23.72,2.64q1.49,1.56,3,3L70,215.46a8,8,0,0,0,3.94,6,107.71,107.71,0,0,0,26.25,10.87,8,8,0,0,0,7.06-1.49L125.84,216q2.16.06,4.32,0l18.64,14.92a8,8,0,0,0,7.06,1.48,107.21,107.21,0,0,0,26.25-10.88,8,8,0,0,0,3.93-6l2.64-23.72q1.56-1.48,3-3L215.46,186a8,8,0,0,0,6-3.94,107.71,107.71,0,0,0,10.87-26.25,8,8,0,0,0-1.49-7.06Zm-16.1-6.5a73.93,73.93,0,0,1,0,8.68,8,8,0,0,0,1.74,5.48l14.19,17.73a91.57,91.57,0,0,1-6.23,15L187,173.11a8,8,0,0,0-5.1,2.64,74.11,74.11,0,0,1-6.14,6.14,8,8,0,0,0-2.64,5.1l-2.51,22.58a91.32,91.32,0,0,1-15,6.23l-17.74-14.19a8,8,0,0,0-5-1.75h-.48a73.93,73.93,0,0,1-8.68,0,8.06,8.06,0,0,0-5.48,1.74L100.45,215.8a91.57,91.57,0,0,1-15-6.23L82.89,187a8,8,0,0,0-2.64-5.1,74.11,74.11,0,0,1-6.14-6.14,8,8,0,0,0-5.1-2.64L46.43,170.6a91.32,91.32,0,0,1-6.23-15l14.19-17.74a8,8,0,0,0,1.74-5.48,73.93,73.93,0,0,1,0-8.68,8,8,0,0,0-1.74-5.48L40.2,100.45a91.57,91.57,0,0,1,6.23-15L69,82.89a8,8,0,0,0,5.1-2.64,74.11,74.11,0,0,1,6.14-6.14A8,8,0,0,0,82.89,69L85.4,46.43a91.32,91.32,0,0,1,15-6.23l17.74,14.19a8,8,0,0,0,5.48,1.74,73.93,73.93,0,0,1,8.68,0,8.06,8.06,0,0,0,5.48-1.74L155.55,40.2a91.57,91.57,0,0,1,15,6.23L173.11,69a8,8,0,0,0,2.64,5.1,74.11,74.11,0,0,1,6.14,6.14,8,8,0,0,0,5.1,2.64l22.58,2.51a91.32,91.32,0,0,1,6.23,15l-14.19,17.74A8,8,0,0,0,199.87,123.66Z"
}))], ["fill", T.createElement(T.Fragment, null, c("path", {
  d: "M216,130.16q.06-2.16,0-4.32l14.92-18.64a8,8,0,0,0,1.48-7.06,107.6,107.6,0,0,0-10.88-26.25,8,8,0,0,0-6-3.93l-23.72-2.64q-1.48-1.56-3-3L186,40.54a8,8,0,0,0-3.94-6,107.29,107.29,0,0,0-26.25-10.86,8,8,0,0,0-7.06,1.48L130.16,40Q128,40,125.84,40L107.2,25.11a8,8,0,0,0-7.06-1.48A107.6,107.6,0,0,0,73.89,34.51a8,8,0,0,0-3.93,6L67.32,64.27q-1.56,1.49-3,3L40.54,70a8,8,0,0,0-6,3.94,107.71,107.71,0,0,0-10.87,26.25,8,8,0,0,0,1.49,7.06L40,125.84Q40,128,40,130.16L25.11,148.8a8,8,0,0,0-1.48,7.06,107.6,107.6,0,0,0,10.88,26.25,8,8,0,0,0,6,3.93l23.72,2.64q1.49,1.56,3,3L70,215.46a8,8,0,0,0,3.94,6,107.71,107.71,0,0,0,26.25,10.87,8,8,0,0,0,7.06-1.49L125.84,216q2.16.06,4.32,0l18.64,14.92a8,8,0,0,0,7.06,1.48,107.21,107.21,0,0,0,26.25-10.88,8,8,0,0,0,3.93-6l2.64-23.72q1.56-1.48,3-3L215.46,186a8,8,0,0,0,6-3.94,107.71,107.71,0,0,0,10.87-26.25,8,8,0,0,0-1.49-7.06ZM128,168a40,40,0,1,1,40-40A40,40,0,0,1,128,168Z"
}))], ["light", T.createElement(T.Fragment, null, c("path", {
  d: "M128,82a46,46,0,1,0,46,46A46.06,46.06,0,0,0,128,82Zm0,80a34,34,0,1,1,34-34A34,34,0,0,1,128,162ZM214,130.84c.06-1.89.06-3.79,0-5.68L229.33,106a6,6,0,0,0,1.11-5.29A105.34,105.34,0,0,0,219.76,74.9a6,6,0,0,0-4.53-3l-24.45-2.71q-1.93-2.07-4-4l-2.72-24.46a6,6,0,0,0-3-4.53,105.65,105.65,0,0,0-25.77-10.66A6,6,0,0,0,150,26.68l-19.2,15.37c-1.89-.06-3.79-.06-5.68,0L106,26.67a6,6,0,0,0-5.29-1.11A105.34,105.34,0,0,0,74.9,36.24a6,6,0,0,0-3,4.53L69.23,65.22q-2.07,1.94-4,4L40.76,72a6,6,0,0,0-4.53,3,105.65,105.65,0,0,0-10.66,25.77A6,6,0,0,0,26.68,106l15.37,19.2c-.06,1.89-.06,3.79,0,5.68L26.67,150.05a6,6,0,0,0-1.11,5.29A105.34,105.34,0,0,0,36.24,181.1a6,6,0,0,0,4.53,3l24.45,2.71q1.94,2.07,4,4L72,215.24a6,6,0,0,0,3,4.53,105.65,105.65,0,0,0,25.77,10.66,6,6,0,0,0,5.29-1.11L125.16,214c1.89.06,3.79.06,5.68,0l19.21,15.38a6,6,0,0,0,3.75,1.31,6.2,6.2,0,0,0,1.54-.2,105.34,105.34,0,0,0,25.76-10.68,6,6,0,0,0,3-4.53l2.71-24.45q2.07-1.93,4-4l24.46-2.72a6,6,0,0,0,4.53-3,105.49,105.49,0,0,0,10.66-25.77,6,6,0,0,0-1.11-5.29Zm-3.1,41.63-23.64,2.63a6,6,0,0,0-3.82,2,75.14,75.14,0,0,1-6.31,6.31,6,6,0,0,0-2,3.82l-2.63,23.63A94.28,94.28,0,0,1,155.14,218l-18.57-14.86a6,6,0,0,0-3.75-1.31h-.36a78.07,78.07,0,0,1-8.92,0,6,6,0,0,0-4.11,1.3L100.87,218a94.13,94.13,0,0,1-17.34-7.17L80.9,187.21a6,6,0,0,0-2-3.82,75.14,75.14,0,0,1-6.31-6.31,6,6,0,0,0-3.82-2l-23.63-2.63A94.28,94.28,0,0,1,38,155.14l14.86-18.57a6,6,0,0,0,1.3-4.11,78.07,78.07,0,0,1,0-8.92,6,6,0,0,0-1.3-4.11L38,100.87a94.13,94.13,0,0,1,7.17-17.34L68.79,80.9a6,6,0,0,0,3.82-2,75.14,75.14,0,0,1,6.31-6.31,6,6,0,0,0,2-3.82l2.63-23.63A94.28,94.28,0,0,1,100.86,38l18.57,14.86a6,6,0,0,0,4.11,1.3,78.07,78.07,0,0,1,8.92,0,6,6,0,0,0,4.11-1.3L155.13,38a94.13,94.13,0,0,1,17.34,7.17l2.63,23.64a6,6,0,0,0,2,3.82,75.14,75.14,0,0,1,6.31,6.31,6,6,0,0,0,3.82,2l23.63,2.63A94.28,94.28,0,0,1,218,100.86l-14.86,18.57a6,6,0,0,0-1.3,4.11,78.07,78.07,0,0,1,0,8.92,6,6,0,0,0,1.3,4.11L218,155.13A94.13,94.13,0,0,1,210.85,172.47Z"
}))], ["regular", T.createElement(T.Fragment, null, c("path", {
  d: "M128,80a48,48,0,1,0,48,48A48.05,48.05,0,0,0,128,80Zm0,80a32,32,0,1,1,32-32A32,32,0,0,1,128,160Zm88-29.84q.06-2.16,0-4.32l14.92-18.64a8,8,0,0,0,1.48-7.06,107.21,107.21,0,0,0-10.88-26.25,8,8,0,0,0-6-3.93l-23.72-2.64q-1.48-1.56-3-3L186,40.54a8,8,0,0,0-3.94-6,107.71,107.71,0,0,0-26.25-10.87,8,8,0,0,0-7.06,1.49L130.16,40Q128,40,125.84,40L107.2,25.11a8,8,0,0,0-7.06-1.48A107.6,107.6,0,0,0,73.89,34.51a8,8,0,0,0-3.93,6L67.32,64.27q-1.56,1.49-3,3L40.54,70a8,8,0,0,0-6,3.94,107.71,107.71,0,0,0-10.87,26.25,8,8,0,0,0,1.49,7.06L40,125.84Q40,128,40,130.16L25.11,148.8a8,8,0,0,0-1.48,7.06,107.21,107.21,0,0,0,10.88,26.25,8,8,0,0,0,6,3.93l23.72,2.64q1.49,1.56,3,3L70,215.46a8,8,0,0,0,3.94,6,107.71,107.71,0,0,0,26.25,10.87,8,8,0,0,0,7.06-1.49L125.84,216q2.16.06,4.32,0l18.64,14.92a8,8,0,0,0,7.06,1.48,107.21,107.21,0,0,0,26.25-10.88,8,8,0,0,0,3.93-6l2.64-23.72q1.56-1.48,3-3L215.46,186a8,8,0,0,0,6-3.94,107.71,107.71,0,0,0,10.87-26.25,8,8,0,0,0-1.49-7.06Zm-16.1-6.5a73.93,73.93,0,0,1,0,8.68,8,8,0,0,0,1.74,5.48l14.19,17.73a91.57,91.57,0,0,1-6.23,15L187,173.11a8,8,0,0,0-5.1,2.64,74.11,74.11,0,0,1-6.14,6.14,8,8,0,0,0-2.64,5.1l-2.51,22.58a91.32,91.32,0,0,1-15,6.23l-17.74-14.19a8,8,0,0,0-5-1.75h-.48a73.93,73.93,0,0,1-8.68,0,8,8,0,0,0-5.48,1.74L100.45,215.8a91.57,91.57,0,0,1-15-6.23L82.89,187a8,8,0,0,0-2.64-5.1,74.11,74.11,0,0,1-6.14-6.14,8,8,0,0,0-5.1-2.64L46.43,170.6a91.32,91.32,0,0,1-6.23-15l14.19-17.74a8,8,0,0,0,1.74-5.48,73.93,73.93,0,0,1,0-8.68,8,8,0,0,0-1.74-5.48L40.2,100.45a91.57,91.57,0,0,1,6.23-15L69,82.89a8,8,0,0,0,5.1-2.64,74.11,74.11,0,0,1,6.14-6.14A8,8,0,0,0,82.89,69L85.4,46.43a91.32,91.32,0,0,1,15-6.23l17.74,14.19a8,8,0,0,0,5.48,1.74,73.93,73.93,0,0,1,8.68,0,8,8,0,0,0,5.48-1.74L155.55,40.2a91.57,91.57,0,0,1,15,6.23L173.11,69a8,8,0,0,0,2.64,5.1,74.11,74.11,0,0,1,6.14,6.14,8,8,0,0,0,5.1,2.64l22.58,2.51a91.32,91.32,0,0,1,6.23,15l-14.19,17.74A8,8,0,0,0,199.87,123.66Z"
}))], ["thin", T.createElement(T.Fragment, null, c("path", {
  d: "M128,84a44,44,0,1,0,44,44A44.05,44.05,0,0,0,128,84Zm0,80a36,36,0,1,1,36-36A36,36,0,0,1,128,164Zm83.93-32.49q.13-3.51,0-7l15.83-19.79a4,4,0,0,0,.75-3.53A103.64,103.64,0,0,0,218,75.9a4,4,0,0,0-3-2l-25.19-2.8c-1.58-1.71-3.24-3.37-4.95-4.95L182.07,41a4,4,0,0,0-2-3A104,104,0,0,0,154.82,27.5a4,4,0,0,0-3.53.74L131.51,44.07q-3.51-.14-7,0L104.7,28.24a4,4,0,0,0-3.53-.75A103.64,103.64,0,0,0,75.9,38a4,4,0,0,0-2,3l-2.8,25.19c-1.71,1.58-3.37,3.24-4.95,4.95L41,73.93a4,4,0,0,0-3,2A104,104,0,0,0,27.5,101.18a4,4,0,0,0,.74,3.53l15.83,19.78q-.14,3.51,0,7L28.24,151.3a4,4,0,0,0-.75,3.53A103.64,103.64,0,0,0,38,180.1a4,4,0,0,0,3,2l25.19,2.8c1.58,1.71,3.24,3.37,4.95,4.95l2.8,25.2a4,4,0,0,0,2,3,104,104,0,0,0,25.28,10.46,4,4,0,0,0,3.53-.74l19.78-15.83q3.51.13,7,0l19.79,15.83a4,4,0,0,0,2.5.88,4,4,0,0,0,1-.13A103.64,103.64,0,0,0,180.1,218a4,4,0,0,0,2-3l2.8-25.19c1.71-1.58,3.37-3.24,4.95-4.95l25.2-2.8a4,4,0,0,0,3-2,104,104,0,0,0,10.46-25.28,4,4,0,0,0-.74-3.53Zm.17,42.83-24.67,2.74a4,4,0,0,0-2.55,1.32,76.2,76.2,0,0,1-6.48,6.48,4,4,0,0,0-1.32,2.55l-2.74,24.66a95.45,95.45,0,0,1-19.64,8.15l-19.38-15.51a4,4,0,0,0-2.5-.87h-.24a73.67,73.67,0,0,1-9.16,0,4,4,0,0,0-2.74.87l-19.37,15.5a95.33,95.33,0,0,1-19.65-8.13l-2.74-24.67a4,4,0,0,0-1.32-2.55,76.2,76.2,0,0,1-6.48-6.48,4,4,0,0,0-2.55-1.32l-24.66-2.74a95.45,95.45,0,0,1-8.15-19.64l15.51-19.38a4,4,0,0,0,.87-2.74,77.76,77.76,0,0,1,0-9.16,4,4,0,0,0-.87-2.74l-15.5-19.37A95.33,95.33,0,0,1,43.9,81.66l24.67-2.74a4,4,0,0,0,2.55-1.32,76.2,76.2,0,0,1,6.48-6.48,4,4,0,0,0,1.32-2.55l2.74-24.66a95.45,95.45,0,0,1,19.64-8.15l19.38,15.51a4,4,0,0,0,2.74.87,73.67,73.67,0,0,1,9.16,0,4,4,0,0,0,2.74-.87l19.37-15.5a95.33,95.33,0,0,1,19.65,8.13l2.74,24.67a4,4,0,0,0,1.32,2.55,76.2,76.2,0,0,1,6.48,6.48,4,4,0,0,0,2.55,1.32l24.66,2.74a95.45,95.45,0,0,1,8.15,19.64l-15.51,19.38a4,4,0,0,0-.87,2.74,77.76,77.76,0,0,1,0,9.16,4,4,0,0,0,.87,2.74l15.5,19.37A95.33,95.33,0,0,1,212.1,174.34Z"
}))]])
, O5 = new Map([["bold", T.createElement(T.Fragment, null, c("path", {
  d: "M128,60a44,44,0,1,0,44,44A44.05,44.05,0,0,0,128,60Zm0,64a20,20,0,1,1,20-20A20,20,0,0,1,128,124Zm0-112a92.1,92.1,0,0,0-92,92c0,77.36,81.64,135.4,85.12,137.83a12,12,0,0,0,13.76,0,259,259,0,0,0,42.18-39C205.15,170.57,220,136.37,220,104A92.1,92.1,0,0,0,128,12Zm31.3,174.71A249.35,249.35,0,0,1,128,216.89a249.35,249.35,0,0,1-31.3-30.18C80,167.37,60,137.31,60,104a68,68,0,0,1,136,0C196,137.31,176,167.37,159.3,186.71Z"
}))], ["duotone", T.createElement(T.Fragment, null, c("path", {
  d: "M128,24a80,80,0,0,0-80,80c0,72,80,128,80,128s80-56,80-128A80,80,0,0,0,128,24Zm0,112a32,32,0,1,1,32-32A32,32,0,0,1,128,136Z",
  opacity: "0.2"
}), c("path", {
  d: "M128,64a40,40,0,1,0,40,40A40,40,0,0,0,128,64Zm0,64a24,24,0,1,1,24-24A24,24,0,0,1,128,128Zm0-112a88.1,88.1,0,0,0-88,88c0,31.4,14.51,64.68,42,96.25a254.19,254.19,0,0,0,41.45,38.3,8,8,0,0,0,9.18,0A254.19,254.19,0,0,0,174,200.25c27.45-31.57,42-64.85,42-96.25A88.1,88.1,0,0,0,128,16Zm0,206c-16.53-13-72-60.75-72-118a72,72,0,0,1,144,0C200,161.23,144.53,209,128,222Z"
}))], ["fill", T.createElement(T.Fragment, null, c("path", {
  d: "M128,16a88.1,88.1,0,0,0-88,88c0,75.3,80,132.17,83.41,134.55a8,8,0,0,0,9.18,0C136,236.17,216,179.3,216,104A88.1,88.1,0,0,0,128,16Zm0,56a32,32,0,1,1-32,32A32,32,0,0,1,128,72Z"
}))], ["light", T.createElement(T.Fragment, null, c("path", {
  d: "M128,66a38,38,0,1,0,38,38A38,38,0,0,0,128,66Zm0,64a26,26,0,1,1,26-26A26,26,0,0,1,128,130Zm0-112a86.1,86.1,0,0,0-86,86c0,30.91,14.34,63.74,41.47,94.94a252.32,252.32,0,0,0,41.09,38,6,6,0,0,0,6.88,0,252.32,252.32,0,0,0,41.09-38c27.13-31.2,41.47-64,41.47-94.94A86.1,86.1,0,0,0,128,18Zm0,206.51C113,212.93,54,163.62,54,104a74,74,0,0,1,148,0C202,163.62,143,212.93,128,224.51Z"
}))], ["regular", T.createElement(T.Fragment, null, c("path", {
  d: "M128,64a40,40,0,1,0,40,40A40,40,0,0,0,128,64Zm0,64a24,24,0,1,1,24-24A24,24,0,0,1,128,128Zm0-112a88.1,88.1,0,0,0-88,88c0,31.4,14.51,64.68,42,96.25a254.19,254.19,0,0,0,41.45,38.3,8,8,0,0,0,9.18,0A254.19,254.19,0,0,0,174,200.25c27.45-31.57,42-64.85,42-96.25A88.1,88.1,0,0,0,128,16Zm0,206c-16.53-13-72-60.75-72-118a72,72,0,0,1,144,0C200,161.23,144.53,209,128,222Z"
}))], ["thin", T.createElement(T.Fragment, null, c("path", {
  d: "M128,68a36,36,0,1,0,36,36A36,36,0,0,0,128,68Zm0,64a28,28,0,1,1,28-28A28,28,0,0,1,128,132Zm0-112a84.09,84.09,0,0,0-84,84c0,30.42,14.17,62.79,41,93.62a250,250,0,0,0,40.73,37.66,4,4,0,0,0,4.58,0A250,250,0,0,0,171,197.62c26.81-30.83,41-63.2,41-93.62A84.09,84.09,0,0,0,128,20Zm37.1,172.23A254.62,254.62,0,0,1,128,227a254.62,254.62,0,0,1-37.1-34.81C73.15,171.8,52,139.9,52,104a76,76,0,0,1,152,0C204,139.9,182.85,171.8,165.1,192.23Z"
}))]])
, V5 = new Map([["bold", T.createElement(T.Fragment, null, c("path", {
  d: "M233.86,110.48,65.8,14.58A20,20,0,0,0,37.15,38.64L67.33,128,37.15,217.36A20,20,0,0,0,56,244a20.1,20.1,0,0,0,9.81-2.58l.09-.06,168-96.07a20,20,0,0,0,0-34.81ZM63.19,215.26,88.61,140H144a12,12,0,0,0,0-24H88.61L63.18,40.72l152.76,87.17Z"
}))], ["duotone", T.createElement(T.Fragment, null, c("path", {
  d: "M227.91,134.86,59.93,231a8,8,0,0,1-11.44-9.67L80,128,48.49,34.72a8,8,0,0,1,11.44-9.67l168,95.85A8,8,0,0,1,227.91,134.86Z",
  opacity: "0.2"
}), c("path", {
  d: "M231.87,114l-168-95.89A16,16,0,0,0,40.92,37.34L71.55,128,40.92,218.67A16,16,0,0,0,56,240a16.15,16.15,0,0,0,7.93-2.1l167.92-96.05a16,16,0,0,0,.05-27.89ZM56,224a.56.56,0,0,0,0-.12L85.74,136H144a8,8,0,0,0,0-16H85.74L56.06,32.16A.46.46,0,0,0,56,32l168,95.83Z"
}))], ["fill", T.createElement(T.Fragment, null, c("path", {
  d: "M240,127.89a16,16,0,0,1-8.18,14L63.9,237.9A16.15,16.15,0,0,1,56,240a16,16,0,0,1-15-21.33l27-79.95A4,4,0,0,1,71.72,136H144a8,8,0,0,0,8-8.53,8.19,8.19,0,0,0-8.26-7.47h-72a4,4,0,0,1-3.79-2.72l-27-79.94A16,16,0,0,1,63.84,18.07l168,95.89A16,16,0,0,1,240,127.89Z"
}))], ["light", T.createElement(T.Fragment, null, c("path", {
  d: "M230.88,115.69l-168-95.88a14,14,0,0,0-20,16.87L73.66,128,42.81,219.33A14,14,0,0,0,56,238a14.15,14.15,0,0,0,6.93-1.83L230.84,140.1a14,14,0,0,0,0-24.41Zm-5.95,14L57,225.73a2,2,0,0,1-2.86-2.42.42.42,0,0,0,0-.1L84.3,134H144a6,6,0,0,0,0-12H84.3L54.17,32.8a.3.3,0,0,0,0-.1,1.87,1.87,0,0,1,.6-2.2A1.85,1.85,0,0,1,57,30.25l168,95.89a1.93,1.93,0,0,1,1,1.74A2,2,0,0,1,224.93,129.66Z"
}))], ["regular", T.createElement(T.Fragment, null, c("path", {
  d: "M231.87,114l-168-95.89A16,16,0,0,0,40.92,37.34L71.55,128,40.92,218.67A16,16,0,0,0,56,240a16.15,16.15,0,0,0,7.93-2.1l167.92-96.05a16,16,0,0,0,.05-27.89ZM56,224a.56.56,0,0,0,0-.12L85.74,136H144a8,8,0,0,0,0-16H85.74L56.06,32.16A.46.46,0,0,0,56,32l168,95.83Z"
}))], ["thin", T.createElement(T.Fragment, null, c("path", {
  d: "M229.89,117.43l-168-95.88A12,12,0,0,0,44.7,36l31.08,92L44.71,220A12,12,0,0,0,56,236a12.13,12.13,0,0,0,5.93-1.57l167.94-96.08a12,12,0,0,0,0-20.92Zm-4,14L58,227.47a4,4,0,0,1-5.72-4.83l0-.07L82.87,132H144a4,4,0,0,0,0-8H82.87L52.26,33.37A3.89,3.89,0,0,1,53.44,29,4.13,4.13,0,0,1,56,28a3.88,3.88,0,0,1,1.93.54l168,95.87a4,4,0,0,1,0,7Z"
}))]])
, D5 = new Map([["bold", T.createElement(T.Fragment, null, c("path", {
  d: "M228,128a12,12,0,0,1-12,12H140v76a12,12,0,0,1-24,0V140H40a12,12,0,0,1,0-24h76V40a12,12,0,0,1,24,0v76h76A12,12,0,0,1,228,128Z"
}))], ["duotone", T.createElement(T.Fragment, null, c("path", {
  d: "M216,56V200a16,16,0,0,1-16,16H56a16,16,0,0,1-16-16V56A16,16,0,0,1,56,40H200A16,16,0,0,1,216,56Z",
  opacity: "0.2"
}), c("path", {
  d: "M224,128a8,8,0,0,1-8,8H136v80a8,8,0,0,1-16,0V136H40a8,8,0,0,1,0-16h80V40a8,8,0,0,1,16,0v80h80A8,8,0,0,1,224,128Z"
}))], ["fill", T.createElement(T.Fragment, null, c("path", {
  d: "M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32ZM184,136H136v48a8,8,0,0,1-16,0V136H72a8,8,0,0,1,0-16h48V72a8,8,0,0,1,16,0v48h48a8,8,0,0,1,0,16Z"
}))], ["light", T.createElement(T.Fragment, null, c("path", {
  d: "M222,128a6,6,0,0,1-6,6H134v82a6,6,0,0,1-12,0V134H40a6,6,0,0,1,0-12h82V40a6,6,0,0,1,12,0v82h82A6,6,0,0,1,222,128Z"
}))], ["regular", T.createElement(T.Fragment, null, c("path", {
  d: "M224,128a8,8,0,0,1-8,8H136v80a8,8,0,0,1-16,0V136H40a8,8,0,0,1,0-16h80V40a8,8,0,0,1,16,0v80h80A8,8,0,0,1,224,128Z"
}))], ["thin", T.createElement(T.Fragment, null, c("path", {
  d: "M220,128a4,4,0,0,1-4,4H132v84a4,4,0,0,1-8,0V132H40a4,4,0,0,1,0-8h84V40a4,4,0,0,1,8,0v84h84A4,4,0,0,1,220,128Z"
}))]])
, j5 = new Map([["bold", T.createElement(T.Fragment, null, c("path", {
  d: "M233.21,56.31A12,12,0,0,0,224,52H66L60.53,21.85A12,12,0,0,0,48.73,12H24a12,12,0,0,0,0,24H38.71L63.62,173a28,28,0,0,0,4.07,10.21A32,32,0,1,0,123,196h34a32,32,0,1,0,31-24H91.17a4,4,0,0,1-3.93-3.28L84.92,156H196.1a28,28,0,0,0,27.55-23l12.16-66.86A12,12,0,0,0,233.21,56.31ZM100,204a8,8,0,1,1-8-8A8,8,0,0,1,100,204Zm88,8a8,8,0,1,1,8-8A8,8,0,0,1,188,212Zm12-83.28A4,4,0,0,1,196.1,132H80.56L70.38,76H209.62Z"
}))], ["duotone", T.createElement(T.Fragment, null, c("path", {
  d: "M224,64l-12.16,66.86A16,16,0,0,1,196.1,144H70.55L56,64Z",
  opacity: "0.2"
}), c("path", {
  d: "M230.14,58.87A8,8,0,0,0,224,56H62.68L56.6,22.57A8,8,0,0,0,48.73,16H24a8,8,0,0,0,0,16h18L67.56,172.29a24,24,0,0,0,5.33,11.27,28,28,0,1,0,44.4,8.44h45.42A27.75,27.75,0,0,0,160,204a28,28,0,1,0,28-28H91.17a8,8,0,0,1-7.87-6.57L80.13,152h116a24,24,0,0,0,23.61-19.71l12.16-66.86A8,8,0,0,0,230.14,58.87ZM104,204a12,12,0,1,1-12-12A12,12,0,0,1,104,204Zm96,0a12,12,0,1,1-12-12A12,12,0,0,1,200,204Zm4-74.57A8,8,0,0,1,196.1,136H77.22L65.59,72H214.41Z"
}))], ["fill", T.createElement(T.Fragment, null, c("path", {
  d: "M230.14,58.87A8,8,0,0,0,224,56H62.68L56.6,22.57A8,8,0,0,0,48.73,16H24a8,8,0,0,0,0,16h18L67.56,172.29a24,24,0,0,0,5.33,11.27,28,28,0,1,0,44.4,8.44h45.42A27.75,27.75,0,0,0,160,204a28,28,0,1,0,28-28H91.17a8,8,0,0,1-7.87-6.57L80.13,152h116a24,24,0,0,0,23.61-19.71l12.16-66.86A8,8,0,0,0,230.14,58.87ZM104,204a12,12,0,1,1-12-12A12,12,0,0,1,104,204Zm96,0a12,12,0,1,1-12-12A12,12,0,0,1,200,204Z"
}))], ["light", T.createElement(T.Fragment, null, c("path", {
  d: "M228.61,60.16A6,6,0,0,0,224,58H61L54.63,22.93A6,6,0,0,0,48.73,18H24a6,6,0,0,0,0,12H43.72L69.53,171.94a21.93,21.93,0,0,0,6.24,11.77A26,26,0,1,0,113.89,190h52.22A26,26,0,1,0,188,178H91.17a10,10,0,0,1-9.84-8.21L77.73,150H196.1a22,22,0,0,0,21.65-18.06L229.9,65.07A6,6,0,0,0,228.61,60.16ZM106,204a14,14,0,1,1-14-14A14,14,0,0,1,106,204Zm96,0a14,14,0,1,1-14-14A14,14,0,0,1,202,204Zm3.94-74.21A10,10,0,0,1,196.1,138H75.55L63.19,70H216.81Z"
}))], ["regular", T.createElement(T.Fragment, null, c("path", {
  d: "M230.14,58.87A8,8,0,0,0,224,56H62.68L56.6,22.57A8,8,0,0,0,48.73,16H24a8,8,0,0,0,0,16h18L67.56,172.29a24,24,0,0,0,5.33,11.27,28,28,0,1,0,44.4,8.44h45.42A27.75,27.75,0,0,0,160,204a28,28,0,1,0,28-28H91.17a8,8,0,0,1-7.87-6.57L80.13,152h116a24,24,0,0,0,23.61-19.71l12.16-66.86A8,8,0,0,0,230.14,58.87ZM104,204a12,12,0,1,1-12-12A12,12,0,0,1,104,204Zm96,0a12,12,0,1,1-12-12A12,12,0,0,1,200,204Zm4-74.57A8,8,0,0,1,196.1,136H77.22L65.59,72H214.41Z"
}))], ["thin", T.createElement(T.Fragment, null, c("path", {
  d: "M227.07,61.44A4,4,0,0,0,224,60H59.34L52.66,23.28A4,4,0,0,0,48.73,20H24a4,4,0,0,0,0,8H45.39l6.69,36.8h0L71.49,171.58A20,20,0,0,0,79,183.85,24,24,0,1,0,109.87,188h60.26A24,24,0,1,0,188,180H91.17a12,12,0,0,1-11.8-9.85l-4-22.15H196.1a20,20,0,0,0,19.68-16.42l12.16-66.86A4,4,0,0,0,227.07,61.44ZM108,204a16,16,0,1,1-16-16A16,16,0,0,1,108,204Zm96,0a16,16,0,1,1-16-16A16,16,0,0,1,204,204Zm3.91-73.85A12,12,0,0,1,196.1,140H73.88L60.79,68H219.21Z"
}))]])
, I5 = new Map([["bold", T.createElement(T.Fragment, null, c("path", {
  d: "M216,48H180V36A28,28,0,0,0,152,8H104A28,28,0,0,0,76,36V48H40a12,12,0,0,0,0,24h4V208a20,20,0,0,0,20,20H192a20,20,0,0,0,20-20V72h4a12,12,0,0,0,0-24ZM100,36a4,4,0,0,1,4-4h48a4,4,0,0,1,4,4V48H100Zm88,168H68V72H188ZM116,104v64a12,12,0,0,1-24,0V104a12,12,0,0,1,24,0Zm48,0v64a12,12,0,0,1-24,0V104a12,12,0,0,1,24,0Z"
}))], ["duotone", T.createElement(T.Fragment, null, c("path", {
  d: "M200,56V208a8,8,0,0,1-8,8H64a8,8,0,0,1-8-8V56Z",
  opacity: "0.2"
}), c("path", {
  d: "M216,48H176V40a24,24,0,0,0-24-24H104A24,24,0,0,0,80,40v8H40a8,8,0,0,0,0,16h8V208a16,16,0,0,0,16,16H192a16,16,0,0,0,16-16V64h8a8,8,0,0,0,0-16ZM96,40a8,8,0,0,1,8-8h48a8,8,0,0,1,8,8v8H96Zm96,168H64V64H192ZM112,104v64a8,8,0,0,1-16,0V104a8,8,0,0,1,16,0Zm48,0v64a8,8,0,0,1-16,0V104a8,8,0,0,1,16,0Z"
}))], ["fill", T.createElement(T.Fragment, null, c("path", {
  d: "M216,48H176V40a24,24,0,0,0-24-24H104A24,24,0,0,0,80,40v8H40a8,8,0,0,0,0,16h8V208a16,16,0,0,0,16,16H192a16,16,0,0,0,16-16V64h8a8,8,0,0,0,0-16ZM112,168a8,8,0,0,1-16,0V104a8,8,0,0,1,16,0Zm48,0a8,8,0,0,1-16,0V104a8,8,0,0,1,16,0Zm0-120H96V40a8,8,0,0,1,8-8h48a8,8,0,0,1,8,8Z"
}))], ["light", T.createElement(T.Fragment, null, c("path", {
  d: "M216,50H174V40a22,22,0,0,0-22-22H104A22,22,0,0,0,82,40V50H40a6,6,0,0,0,0,12H50V208a14,14,0,0,0,14,14H192a14,14,0,0,0,14-14V62h10a6,6,0,0,0,0-12ZM94,40a10,10,0,0,1,10-10h48a10,10,0,0,1,10,10V50H94ZM194,208a2,2,0,0,1-2,2H64a2,2,0,0,1-2-2V62H194ZM110,104v64a6,6,0,0,1-12,0V104a6,6,0,0,1,12,0Zm48,0v64a6,6,0,0,1-12,0V104a6,6,0,0,1,12,0Z"
}))], ["regular", T.createElement(T.Fragment, null, c("path", {
  d: "M216,48H176V40a24,24,0,0,0-24-24H104A24,24,0,0,0,80,40v8H40a8,8,0,0,0,0,16h8V208a16,16,0,0,0,16,16H192a16,16,0,0,0,16-16V64h8a8,8,0,0,0,0-16ZM96,40a8,8,0,0,1,8-8h48a8,8,0,0,1,8,8v8H96Zm96,168H64V64H192ZM112,104v64a8,8,0,0,1-16,0V104a8,8,0,0,1,16,0Zm48,0v64a8,8,0,0,1-16,0V104a8,8,0,0,1,16,0Z"
}))], ["thin", T.createElement(T.Fragment, null, c("path", {
  d: "M216,52H172V40a20,20,0,0,0-20-20H104A20,20,0,0,0,84,40V52H40a4,4,0,0,0,0,8H52V208a12,12,0,0,0,12,12H192a12,12,0,0,0,12-12V60h12a4,4,0,0,0,0-8ZM92,40a12,12,0,0,1,12-12h48a12,12,0,0,1,12,12V52H92ZM196,208a4,4,0,0,1-4,4H64a4,4,0,0,1-4-4V60H196ZM108,104v64a4,4,0,0,1-8,0V104a4,4,0,0,1,8,0Zm48,0v64a4,4,0,0,1-8,0V104a4,4,0,0,1,8,0Z"
}))]])
, F5 = new Map([["bold", T.createElement(T.Fragment, null, c("path", {
  d: "M125.18,156.94a64,64,0,1,0-82.36,0,100.23,100.23,0,0,0-39.49,32,12,12,0,0,0,19.35,14.2,76,76,0,0,1,122.64,0,12,12,0,0,0,19.36-14.2A100.33,100.33,0,0,0,125.18,156.94ZM44,108a40,40,0,1,1,40,40A40,40,0,0,1,44,108Zm206.1,97.67a12,12,0,0,1-16.78-2.57A76.31,76.31,0,0,0,172,172a12,12,0,0,1,0-24,40,40,0,1,0-10.3-78.67,12,12,0,1,1-6.16-23.19,64,64,0,0,1,57.64,110.8,100.23,100.23,0,0,1,39.49,32A12,12,0,0,1,250.1,205.67Z"
}))], ["duotone", T.createElement(T.Fragment, null, c("path", {
  d: "M136,108A52,52,0,1,1,84,56,52,52,0,0,1,136,108Z",
  opacity: "0.2"
}), c("path", {
  d: "M117.25,157.92a60,60,0,1,0-66.5,0A95.83,95.83,0,0,0,3.53,195.63a8,8,0,1,0,13.4,8.74,80,80,0,0,1,134.14,0,8,8,0,0,0,13.4-8.74A95.83,95.83,0,0,0,117.25,157.92ZM40,108a44,44,0,1,1,44,44A44.05,44.05,0,0,1,40,108Zm210.14,98.7a8,8,0,0,1-11.07-2.33A79.83,79.83,0,0,0,172,168a8,8,0,0,1,0-16,44,44,0,1,0-16.34-84.87,8,8,0,1,1-5.94-14.85,60,60,0,0,1,55.53,105.64,95.83,95.83,0,0,1,47.22,37.71A8,8,0,0,1,250.14,206.7Z"
}))], ["fill", T.createElement(T.Fragment, null, c("path", {
  d: "M164.47,195.63a8,8,0,0,1-6.7,12.37H10.23a8,8,0,0,1-6.7-12.37,95.83,95.83,0,0,1,47.22-37.71,60,60,0,1,1,66.5,0A95.83,95.83,0,0,1,164.47,195.63Zm87.91-.15a95.87,95.87,0,0,0-47.13-37.56A60,60,0,0,0,144.7,54.59a4,4,0,0,0-1.33,6A75.83,75.83,0,0,1,147,150.53a4,4,0,0,0,1.07,5.53,112.32,112.32,0,0,1,29.85,30.83,23.92,23.92,0,0,1,3.65,16.47,4,4,0,0,0,3.95,4.64h60.3a8,8,0,0,0,7.73-5.93A8.22,8.22,0,0,0,252.38,195.48Z"
}))], ["light", T.createElement(T.Fragment, null, c("path", {
  d: "M112.6,158.43a58,58,0,1,0-57.2,0A93.83,93.83,0,0,0,5.21,196.72a6,6,0,0,0,10.05,6.56,82,82,0,0,1,137.48,0,6,6,0,0,0,10-6.56A93.83,93.83,0,0,0,112.6,158.43ZM38,108a46,46,0,1,1,46,46A46.06,46.06,0,0,1,38,108Zm211,97a6,6,0,0,1-8.3-1.74A81.8,81.8,0,0,0,172,166a6,6,0,0,1,0-12,46,46,0,1,0-17.08-88.73,6,6,0,1,1-4.46-11.14,58,58,0,0,1,50.14,104.3,93.83,93.83,0,0,1,50.19,38.29A6,6,0,0,1,249,205Z"
}))], ["regular", T.createElement(T.Fragment, null, c("path", {
  d: "M117.25,157.92a60,60,0,1,0-66.5,0A95.83,95.83,0,0,0,3.53,195.63a8,8,0,1,0,13.4,8.74,80,80,0,0,1,134.14,0,8,8,0,0,0,13.4-8.74A95.83,95.83,0,0,0,117.25,157.92ZM40,108a44,44,0,1,1,44,44A44.05,44.05,0,0,1,40,108Zm210.14,98.7a8,8,0,0,1-11.07-2.33A79.83,79.83,0,0,0,172,168a8,8,0,0,1,0-16,44,44,0,1,0-16.34-84.87,8,8,0,1,1-5.94-14.85,60,60,0,0,1,55.53,105.64,95.83,95.83,0,0,1,47.22,37.71A8,8,0,0,1,250.14,206.7Z"
}))], ["thin", T.createElement(T.Fragment, null, c("path", {
  d: "M107.19,159a56,56,0,1,0-46.38,0A91.83,91.83,0,0,0,6.88,197.81a4,4,0,1,0,6.7,4.37,84,84,0,0,1,140.84,0,4,4,0,1,0,6.7-4.37A91.83,91.83,0,0,0,107.19,159ZM36,108a48,48,0,1,1,48,48A48.05,48.05,0,0,1,36,108Zm212,95.35a4,4,0,0,1-5.53-1.17A83.81,83.81,0,0,0,172,164a4,4,0,0,1,0-8,48,48,0,1,0-17.82-92.58,4,4,0,1,1-3-7.43,56,56,0,0,1,44,103,91.83,91.83,0,0,1,53.93,38.86A4,4,0,0,1,248,203.35Z"
}))]])
, _5 = new Map([["bold", T.createElement(T.Fragment, null, c("path", {
  d: "M196,136a16,16,0,1,1-16-16A16,16,0,0,1,196,136Zm40-36v80a32,32,0,0,1-32,32H60a32,32,0,0,1-32-32V60.92A32,32,0,0,1,60,28H192a12,12,0,0,1,0,24H60a8,8,0,0,0-8,8.26v.08A8.32,8.32,0,0,0,60.48,68H204A32,32,0,0,1,236,100Zm-24,0a8,8,0,0,0-8-8H60.48A33.72,33.72,0,0,1,52,90.92V180a8,8,0,0,0,8,8H204a8,8,0,0,0,8-8Z"
}))], ["duotone", T.createElement(T.Fragment, null, c("path", {
  d: "M224,80V192a8,8,0,0,1-8,8H56a16,16,0,0,1-16-16V56A16,16,0,0,0,56,72H216A8,8,0,0,1,224,80Z",
  opacity: "0.2"
}), c("path", {
  d: "M216,64H56a8,8,0,0,1,0-16H192a8,8,0,0,0,0-16H56A24,24,0,0,0,32,56V184a24,24,0,0,0,24,24H216a16,16,0,0,0,16-16V80A16,16,0,0,0,216,64Zm0,128H56a8,8,0,0,1-8-8V78.63A23.84,23.84,0,0,0,56,80H216Zm-48-60a12,12,0,1,1,12,12A12,12,0,0,1,168,132Z"
}))], ["fill", T.createElement(T.Fragment, null, c("path", {
  d: "M216,64H56a8,8,0,0,1,0-16H192a8,8,0,0,0,0-16H56A24,24,0,0,0,32,56V184a24,24,0,0,0,24,24H216a16,16,0,0,0,16-16V80A16,16,0,0,0,216,64Zm-36,80a12,12,0,1,1,12-12A12,12,0,0,1,180,144Z"
}))], ["light", T.createElement(T.Fragment, null, c("path", {
  d: "M216,66H56a10,10,0,0,1,0-20H192a6,6,0,0,0,0-12H56A22,22,0,0,0,34,56V184a22,22,0,0,0,22,22H216a14,14,0,0,0,14-14V80A14,14,0,0,0,216,66Zm2,126a2,2,0,0,1-2,2H56a10,10,0,0,1-10-10V75.59A21.84,21.84,0,0,0,56,78H216a2,2,0,0,1,2,2Zm-28-60a10,10,0,1,1-10-10A10,10,0,0,1,190,132Z"
}))], ["regular", T.createElement(T.Fragment, null, c("path", {
  d: "M216,64H56a8,8,0,0,1,0-16H192a8,8,0,0,0,0-16H56A24,24,0,0,0,32,56V184a24,24,0,0,0,24,24H216a16,16,0,0,0,16-16V80A16,16,0,0,0,216,64Zm0,128H56a8,8,0,0,1-8-8V78.63A23.84,23.84,0,0,0,56,80H216Zm-48-60a12,12,0,1,1,12,12A12,12,0,0,1,168,132Z"
}))], ["thin", T.createElement(T.Fragment, null, c("path", {
  d: "M216,68H56a12,12,0,0,1,0-24H192a4,4,0,0,0,0-8H56A20,20,0,0,0,36,56V184a20,20,0,0,0,20,20H216a12,12,0,0,0,12-12V80A12,12,0,0,0,216,68Zm4,124a4,4,0,0,1-4,4H56a12,12,0,0,1-12-12V72a19.86,19.86,0,0,0,12,4H216a4,4,0,0,1,4,4Zm-32-60a8,8,0,1,1-8-8A8,8,0,0,1,188,132Z"
}))]])
, z5 = E.exports.createContext({
  color: "currentColor",
  size: "1em",
  weight: "regular",
  mirrored: !1
});
var H5 = Object.defineProperty
, $o = Object.getOwnPropertySymbols
, Hh = Object.prototype.hasOwnProperty
, Bh = Object.prototype.propertyIsEnumerable
, gd = (e, t, n) => t in e ? H5(e, t, {
  enumerable: !0,
  configurable: !0,
  writable: !0,
  value: n
}) : e[t] = n
, yd = (e, t) => {
  for (var n in t || (t = {}))
      Hh.call(t, n) && gd(e, n, t[n]);
  if ($o)
      for (var n of $o(t))
          Bh.call(t, n) && gd(e, n, t[n]);
  return e
}
, vd = (e, t) => {
  var n = {};
  for (var r in e)
      Hh.call(e, r) && t.indexOf(r) < 0 && (n[r] = e[r]);
  if (e != null && $o)
      for (var r of $o(e))
          t.indexOf(r) < 0 && Bh.call(e, r) && (n[r] = e[r]);
  return n
}
;
const $h = E.exports.forwardRef( (e, t) => {
  const n = e
    , {alt: r, color: i, size: o, weight: a, mirrored: s, children: l, weights: u} = n
    , f = vd(n, ["alt", "color", "size", "weight", "mirrored", "children", "weights"])
    , d = E.exports.useContext(z5)
    , {color: m="currentColor", size: p, weight: v="regular", mirrored: x=!1} = d
    , P = vd(d, ["color", "size", "weight", "mirrored"]);
  return w("svg", {
      ...yd(yd({
          ref: t,
          xmlns: "http://www.w3.org/2000/svg",
          width: o != null ? o : p,
          height: o != null ? o : p,
          fill: i != null ? i : m,
          viewBox: "0 0 256 256",
          transform: s || x ? "scale(-1, 1)" : void 0
      }, P), f),
      children: [!!r && c("title", {
          children: r
      }), l, u.get(a != null ? a : v)]
  })
}
);
$h.displayName = "IconBase";
const Tt = $h;
var B5 = Object.defineProperty
, $5 = Object.defineProperties
, U5 = Object.getOwnPropertyDescriptors
, xd = Object.getOwnPropertySymbols
, Z5 = Object.prototype.hasOwnProperty
, G5 = Object.prototype.propertyIsEnumerable
, wd = (e, t, n) => t in e ? B5(e, t, {
  enumerable: !0,
  configurable: !0,
  writable: !0,
  value: n
}) : e[t] = n
, W5 = (e, t) => {
  for (var n in t || (t = {}))
      Z5.call(t, n) && wd(e, n, t[n]);
  if (xd)
      for (var n of xd(t))
          G5.call(t, n) && wd(e, n, t[n]);
  return e
}
, Q5 = (e, t) => $5(e, U5(t));
const Uh = E.exports.forwardRef( (e, t) => T.createElement(Tt, Q5(W5({
  ref: t
}, e), {
  weights: R5
})));
Uh.displayName = "Clock";
var K5 = Object.defineProperty
, Y5 = Object.defineProperties
, X5 = Object.getOwnPropertyDescriptors
, Sd = Object.getOwnPropertySymbols
, q5 = Object.prototype.hasOwnProperty
, J5 = Object.prototype.propertyIsEnumerable
, Ed = (e, t, n) => t in e ? K5(e, t, {
  enumerable: !0,
  configurable: !0,
  writable: !0,
  value: n
}) : e[t] = n
, e3 = (e, t) => {
  for (var n in t || (t = {}))
      q5.call(t, n) && Ed(e, n, t[n]);
  if (Sd)
      for (var n of Sd(t))
          J5.call(t, n) && Ed(e, n, t[n]);
  return e
}
, t3 = (e, t) => Y5(e, X5(t));
const Zh = E.exports.forwardRef( (e, t) => T.createElement(Tt, t3(e3({
  ref: t
}, e), {
  weights: b5
})));
Zh.displayName = "Gear";
var n3 = Object.defineProperty
, r3 = Object.defineProperties
, i3 = Object.getOwnPropertyDescriptors
, Nd = Object.getOwnPropertySymbols
, o3 = Object.prototype.hasOwnProperty
, a3 = Object.prototype.propertyIsEnumerable
, Cd = (e, t, n) => t in e ? n3(e, t, {
  enumerable: !0,
  configurable: !0,
  writable: !0,
  value: n
}) : e[t] = n
, s3 = (e, t) => {
  for (var n in t || (t = {}))
      o3.call(t, n) && Cd(e, n, t[n]);
  if (Nd)
      for (var n of Nd(t))
          a3.call(t, n) && Cd(e, n, t[n]);
  return e
}
, l3 = (e, t) => r3(e, i3(t));
const Gh = E.exports.forwardRef( (e, t) => T.createElement(Tt, l3(s3({
  ref: t
}, e), {
  weights: O5
})));
Gh.displayName = "MapPin";
var u3 = Object.defineProperty
, c3 = Object.defineProperties
, d3 = Object.getOwnPropertyDescriptors
, Pd = Object.getOwnPropertySymbols
, f3 = Object.prototype.hasOwnProperty
, m3 = Object.prototype.propertyIsEnumerable
, Ad = (e, t, n) => t in e ? u3(e, t, {
  enumerable: !0,
  configurable: !0,
  writable: !0,
  value: n
}) : e[t] = n
, h3 = (e, t) => {
  for (var n in t || (t = {}))
      f3.call(t, n) && Ad(e, n, t[n]);
  if (Pd)
      for (var n of Pd(t))
          m3.call(t, n) && Ad(e, n, t[n]);
  return e
}
, p3 = (e, t) => c3(e, d3(t));
const Wh = E.exports.forwardRef( (e, t) => c(Tt, {
  ...p3(h3({
      ref: t
  }, e), {
      weights: V5
  })
}));
Wh.displayName = "PaperPlaneRight";
var g3 = Object.defineProperty
, y3 = Object.defineProperties
, v3 = Object.getOwnPropertyDescriptors
, kd = Object.getOwnPropertySymbols
, x3 = Object.prototype.hasOwnProperty
, w3 = Object.prototype.propertyIsEnumerable
, Td = (e, t, n) => t in e ? g3(e, t, {
  enumerable: !0,
  configurable: !0,
  writable: !0,
  value: n
}) : e[t] = n
, S3 = (e, t) => {
  for (var n in t || (t = {}))
      x3.call(t, n) && Td(e, n, t[n]);
  if (kd)
      for (var n of kd(t))
          w3.call(t, n) && Td(e, n, t[n]);
  return e
}
, E3 = (e, t) => y3(e, v3(t));
const Qh = E.exports.forwardRef( (e, t) => T.createElement(Tt, E3(S3({
  ref: t
}, e), {
  weights: D5
})));
Qh.displayName = "Plus";
var N3 = Object.defineProperty
, C3 = Object.defineProperties
, P3 = Object.getOwnPropertyDescriptors
, Md = Object.getOwnPropertySymbols
, A3 = Object.prototype.hasOwnProperty
, k3 = Object.prototype.propertyIsEnumerable
, Ld = (e, t, n) => t in e ? N3(e, t, {
  enumerable: !0,
  configurable: !0,
  writable: !0,
  value: n
}) : e[t] = n
, T3 = (e, t) => {
  for (var n in t || (t = {}))
      A3.call(t, n) && Ld(e, n, t[n]);
  if (Md)
      for (var n of Md(t))
          k3.call(t, n) && Ld(e, n, t[n]);
  return e
}
, M3 = (e, t) => C3(e, P3(t));
const Kh = E.exports.forwardRef( (e, t) => T.createElement(Tt, M3(T3({
  ref: t
}, e), {
  weights: j5
})));
Kh.displayName = "ShoppingCart";
var L3 = Object.defineProperty
, R3 = Object.defineProperties
, b3 = Object.getOwnPropertyDescriptors
, Rd = Object.getOwnPropertySymbols
, O3 = Object.prototype.hasOwnProperty
, V3 = Object.prototype.propertyIsEnumerable
, bd = (e, t, n) => t in e ? L3(e, t, {
  enumerable: !0,
  configurable: !0,
  writable: !0,
  value: n
}) : e[t] = n
, D3 = (e, t) => {
  for (var n in t || (t = {}))
      O3.call(t, n) && bd(e, n, t[n]);
  if (Rd)
      for (var n of Rd(t))
          V3.call(t, n) && bd(e, n, t[n]);
  return e
}
, j3 = (e, t) => R3(e, b3(t));
const Yh = E.exports.forwardRef( (e, t) => T.createElement(Tt, j3(D3({
  ref: t
}, e), {
  weights: I5
})));
Yh.displayName = "Trash";
var I3 = Object.defineProperty
, F3 = Object.defineProperties
, _3 = Object.getOwnPropertyDescriptors
, Od = Object.getOwnPropertySymbols
, z3 = Object.prototype.hasOwnProperty
, H3 = Object.prototype.propertyIsEnumerable
, Vd = (e, t, n) => t in e ? I3(e, t, {
  enumerable: !0,
  configurable: !0,
  writable: !0,
  value: n
}) : e[t] = n
, B3 = (e, t) => {
  for (var n in t || (t = {}))
      z3.call(t, n) && Vd(e, n, t[n]);
  if (Od)
      for (var n of Od(t))
          H3.call(t, n) && Vd(e, n, t[n]);
  return e
}
, $3 = (e, t) => F3(e, _3(t));
const Xh = E.exports.forwardRef( (e, t) => T.createElement(Tt, $3(B3({
  ref: t
}, e), {
  weights: F5
})));
Xh.displayName = "Users";
var U3 = Object.defineProperty
, Z3 = Object.defineProperties
, G3 = Object.getOwnPropertyDescriptors
, Dd = Object.getOwnPropertySymbols
, W3 = Object.prototype.hasOwnProperty
, Q3 = Object.prototype.propertyIsEnumerable
, jd = (e, t, n) => t in e ? U3(e, t, {
  enumerable: !0,
  configurable: !0,
  writable: !0,
  value: n
}) : e[t] = n
, K3 = (e, t) => {
  for (var n in t || (t = {}))
      W3.call(t, n) && jd(e, n, t[n]);
  if (Dd)
      for (var n of Dd(t))
          Q3.call(t, n) && jd(e, n, t[n]);
  return e
}
, Y3 = (e, t) => Z3(e, G3(t));
const wl = E.exports.forwardRef( (e, t) => T.createElement(Tt, Y3(K3({
  ref: t
}, e), {
  weights: _5
})));
wl.displayName = "Wallet";
const X3 = "" + new URL("card.84e9d77f.png",import.meta.url).href
, q3 = "" + new URL("myCard.f9944c3f.png",import.meta.url).href;
function J3() {
  const [e,t] = E.exports.useState(0)
    , n = E.exports.useRef(null)
    , [r,i] = E.exports.useState([])
    , {orgBalance: o, name: a, playerBalance: s, logo: l, setPlayerBalance: u, setOrgBalance: f, permissions: d} = oe();
  function m() {
      !d.withdraw || e <= 0 || (z("Withdraw", {
          value: e
      }),
      n.current && (n.current.value = ""))
  }
  function p() {
      !d.deposit || e <= 0 || (z("Deposit", {
          value: e
      }),
      n.current && (n.current.value = ""))
  }
  return Sn("UpdateExtracts", i),
  Sn("UpdateBalance", f),
  Sn("UpdatePlayerBalance", u),
  E.exports.useEffect( () => {
      z("GetExtracts", {}, [{
          id: 25111,
          name: "Ruan JKZ",
          type: "SAQUE",
          value: 5e3,
          date: "15/10/2024"
      }, {
          id: 25,
          name: "Ruan JKZ",
          type: "DEP\xD3SITO",
          value: 5e3,
          date: "15/10/2024"
      }, {
          id: 25,
          name: "Ruan JKZ",
          type: "SAQUE",
          value: 5e3,
          date: "15/10/2024"
      }, {
          id: 25,
          name: "Ruan JKZ",
          type: "SAQUE",
          value: 5e3,
          date: "15/10/2024"
      }]).then(i)
  }
  , []),
  w(k.div, {
      initial: {
          opacity: 0,
          y: 20
      },
      animate: {
          opacity: 1,
          y: 0
      },
      transition: {
          duration: .5
      },
      className: "flex flex-col p-4",
      children: [w(k.div, {
          initial: {
              opacity: 0,
              x: -20
          },
          animate: {
              opacity: 1,
              x: 0
          },
          transition: {
              delay: .2
          },
          className: "flex items-center gap-3",
          children: [c("div", {
              className: "w-[2.125rem] h-[2.125rem] rounded bg-primary grid place-items-center",
              children: c(wl, {
                  className: "text-white"
              })
          }), c("p", {
              className: "text-xs text-white font-semibold",
              children: "COFRE"
          })]
      }), w(k.div, {
          initial: {
              opacity: 0,
              scale: .95
          },
          animate: {
              opacity: 1,
              scale: 1
          },
          transition: {
              delay: .3
          },
          className: "flex items-center mt-5 justify-between",
          children: [c("div", {
              className: "w-[40.125rem] h-[10rem] relative !bg-cover bg-no-repeat bg-left",
              style: {
                  backgroundImage: `url('${X3}')`
              },
              children: w(k.p, {
                  initial: {
                      opacity: 0
                  },
                  animate: {
                      opacity: 1
                  },
                  transition: {
                      delay: .5
                  },
                  className: "text-2xl text-white font-normal absolute left-4 top-24",
                  children: ["$ ", o == null ? void 0 : o.toLocaleString("pt-br")]
              })
          }), w("div", {
              className: "w-[18.75rem] h-[10rem] relative rounded bg-center !bg-cover bg-no-repeat",
              style: {
                  backgroundImage: `url('${q3}')`
              },
              children: [w(k.p, {
                  initial: {
                      opacity: 0
                  },
                  animate: {
                      opacity: 1
                  },
                  transition: {
                      delay: .5
                  },
                  className: "text-2xl text-white font-semibold absolute left-4 top-8",
                  children: ["$ ", s == null ? void 0 : s.toLocaleString("pt-br")]
              }), w(k.div, {
                  initial: {
                      opacity: 0
                  },
                  animate: {
                      opacity: 1
                  },
                  transition: {
                      delay: .6
                  },
                  className: "absolute bottom-3 left-3",
                  children: [c("p", {
                      className: "text-white/50 text-[0.625rem] font-semibold",
                      children: "CARD"
                  }), c("p", {
                      className: "text-white font-semibold text-[0.6875rem] uppercase",
                      children: a
                  })]
              })]
          })]
      }), w(k.div, {
          initial: {
              opacity: 0,
              y: 20
          },
          animate: {
              opacity: 1,
              y: 0
          },
          transition: {
              delay: .4
          },
          className: "flex items-center mt-4 gap-4",
          children: [c("input", {
              min: 0,
              onChange: v => t(Number(v.target.value)),
              ref: n,
              className: "w-[40.125rem] h-[2.125rem] text-center outline-none text-white placeholder:text-white/50 text-xs bg-white/[.04] border border-white/[.04] rounded",
              placeholder: "VALOR",
              type: "number"
          }), c(k.button, {
              whileHover: {
                  scale: 1.05
              },
              whileTap: {
                  scale: .95
              },
              onClick: m,
              className: `bg-white/5 w-[8.9375rem] h-[2.062rem] rounded text-xs text-primary font-medium ${!d.withdraw && "pointer-events-none cursor-not-allowed opacity-20"}`,
              children: "SACAR"
          }), c(k.button, {
              whileHover: {
                  scale: 1.05
              },
              whileTap: {
                  scale: .95
              },
              onClick: p,
              className: `w-[8.9375rem] h-[2.062rem] bg-primary rounded text-xs text-white font-medium ${!d.deposit && "pointer-events-none cursor-not-allowed opacity-20"}`,
              children: "DEPOSITAR"
          })]
      }), w(k.div, {
          initial: {
              opacity: 0,
              y: 20
          },
          animate: {
              opacity: 1,
              y: 0
          },
          transition: {
              delay: .5
          },
          className: "mt-5",
          children: [c("div", {
              className: "flex items-center justify-between",
              children: w("div", {
                  className: "flex items-center gap-3",
                  children: [c("div", {
                      className: "w-[2.125rem] h-[2.125rem] bg-primary flex items-center justify-center rounded",
                      children: c(wl, {
                          className: "text-white",
                          size: 16
                      })
                  }), c("p", {
                      className: "text-xs text-white font-semibold",
                      children: "EXTRATO"
                  })]
              })
          }), w("div", {
              className: "flex items-center mt-4",
              children: [c("p", {
                  className: "text-white font-medium text-[.625rem] w-[2.1875rem]",
                  children: "#"
              }), c("p", {
                  className: "text-white font-medium text-[.625rem] w-[14.375rem]",
                  children: "NOME"
              }), c("p", {
                  className: "text-white font-medium text-[.625rem] w-[14rem]",
                  children: "TIPO"
              }), c("p", {
                  className: "text-white font-medium text-[.625rem] w-[14.5625rem]",
                  children: "VALOR"
              }), c("p", {
                  className: "text-white font-medium text-[.625rem]",
                  children: "DATA"
              })]
          }), c("div", {
              className: "flex items-center flex-col gap-2 mt-2 h-[6.75rem] overflow-auto",
              children: r == null ? void 0 : r.slice().reverse().map( (v, x) => {
                  var P;
                  return w(k.div, {
                      initial: {
                          opacity: 0,
                          x: -20
                      },
                      animate: {
                          opacity: 1,
                          x: 0
                      },
                      transition: {
                          delay: .1 * x
                      },
                      className: "w-[59.875rem] h-[2.5rem] flex-none bg-white/[.04] border border-white/[.04] flex items-center rounded pl-[.31rem]",
                      children: [c("div", {
                          className: "w-[1.875rem] h-[1.875rem] flex items-center justify-center rounded mr-[.22rem] bg-primary",
                          children: v.type === "SAQUE" ? c(iy, {
                              size: 18,
                              className: "text-white"
                          }) : c(ay, {
                              size: 18,
                              className: "text-white"
                          })
                      }), c("p", {
                          className: "text-white font-semibold text-xs w-[14rem]",
                          children: v.name
                      }), c("p", {
                          className: "primary font-semibold text-xs w-[14rem]",
                          children: v.type
                      }), w("p", {
                          className: "text-white/50 font-semibold text-xs w-[14.5625rem]",
                          children: ["$ ", (P = v.value) == null ? void 0 : P.toLocaleString("pt-br")]
                      }), c("p", {
                          className: "text-white/50 font-semibold text-xs",
                          children: v.date
                      })]
                  }, x)
              }
              )
          })]
      })]
  })
}
function ex() {
  const {orgName: e, goalReward: t, setGoalReward: n, setGoalModalVisible: r} = oe()
    , [i,o] = E.exports.useState([])
    , [a,s] = E.exports.useState(t);
  function l() {
      z("SaveGoalsConfig", {
          org: e,
          goals: i,
          reward: a
      }),
      n(a),
      r(!1)
  }
  return E.exports.useEffect( () => {
      z("GetGoalsConfig", {
          org: e
      }, [{
          item: "Molas",
          amount: 5,
          name: "celular"
      }, {
          item: "Gatilhos",
          amount: 5,
          name: "celular"
      }, {
          item: "Placa de metal",
          amount: 5,
          name: "celular"
      }]).then(o)
  }
  , []),
  c("div", {
      className: "w-screen animate-fade  h-screen flex items-center bg-black/70 justify-center absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2",
      children: w("div", {
          className: "absolute flex flex-col gap-4 top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-[23.75rem] min-h-[14.6875rem] primary-gradient border border-primary rounded p-5",
          children: [w("div", {
              className: "flex items-center gap-3",
              children: [c(Zh, {
                  className: "primary",
                  size: 20
              }), c("span", {
                  className: "text-xs text-white font-semibold",
                  children: "Configura\xE7\xE3o de metas"
              })]
          }), c("hr", {
              className: "border-none w-full h-[0.0625rem] bg-white/10 mt-2.5"
          }), w("div", {
              className: "mt-3 flex flex-col gap-5",
              children: [i.map( (u, f) => w("div", {
                  className: "flex items-center gap-3",
                  children: [c("span", {
                      className: "text-xs text-white font-semibold w-1/2",
                      children: u.item
                  }), c("input", {
                      type: "number",
                      className: "w-full h-[2rem] bg-foreground border text-xs bg-transparent outline-none border-white/20 rounded p-2 text-white",
                      value: u.amount,
                      onChange: d => {
                          o(i.map( (m, p) => p === f ? {
                              ...m,
                              amount: parseInt(d.target.value)
                          } : m))
                      }
                  })]
              }, f)), c("hr", {
                  className: "w-full h-[.01rem] bg-white/30 border-none"
              }), w("div", {
                  className: "flex items-center gap-3",
                  children: [c("span", {
                      className: "text-xs text-white font-semibold w-1/2",
                      children: "Recompensa"
                  }), c("input", {
                      type: "number",
                      className: "w-full h-[2rem] bg-foreground border text-xs bg-transparent outline-none border-white/20 rounded p-2 text-white",
                      onChange: u => s(Number(u.target.value)),
                      value: a
                  })]
              })]
          }), w("div", {
              className: "flex items-center gap-3 self-center w-full mt-6",
              children: [c("button", {
                  onClick: () => r(!1),
                  className: "p-2 w-1/2 rounded bg-primary opacity-60 hover:opacity-100 text-sm text-white font-semibold",
                  children: "CANCELAR"
              }), c("button", {
                  onClick: l,
                  className: "p-2 rounded w-1/2 bg-primary opacity-60 hover:opacity-100 text-sm text-white font-semibold",
                  children: "CONFIRMAR"
              })]
          })]
      })
  })
}
function tx() {
  var a, s, l, u, f;
  const [e,t] = E.exports.useState("")
    , [n,r] = E.exports.useState([])
    , {goalModalVisible: i} = oe()
    , o = n.filter(d => String(d.name).toLowerCase().includes(e.toLowerCase()) || String(d.id).includes(e.toLowerCase()) || String(d.date).includes(e.toLowerCase()));
  return E.exports.useEffect( () => {
      z("GetFarms", {}, [{
          name: "IGOR",
          id: 1,
          date: "16/01/2003",
          role: "GERENTE",
          amount: 325,
          status: !0,
          item: "celular"
      }, {
          name: "IGOR",
          id: 1,
          date: "15/01/2003",
          role: "GERENTE",
          amount: 35,
          status: !1,
          item: "celular"
      }, {
          name: "pedro",
          id: 1,
          date: "15/01/2003",
          role: "GERENTE",
          amount: 35,
          status: !0,
          item: "celular"
      }, {
          name: "IGOR",
          id: 1,
          date: "15/01/2003",
          role: "GERENTE",
          amount: 35,
          status: !1,
          item: "celular"
      }, {
          name: "IGOR",
          id: 1,
          date: "15/01/2003",
          role: "GERENTE",
          amount: 35,
          status: !0,
          item: "celular"
      }, {
          name: "IGOR",
          id: 1,
          date: "15/01/2003",
          role: "GERENTE",
          amount: 35,
          status: !1,
          item: "celular"
      }, {
          name: "IGOR",
          id: 1,
          date: "15/01/2003",
          role: "GERENTE",
          amount: 35,
          status: !0,
          item: "celular"
      }, {
          name: "IGOR",
          id: 1,
          date: "15/01/2003",
          role: "GERENTE",
          amount: 35,
          status: !1,
          item: "celular"
      }, {
          name: "IGOR",
          id: 1,
          date: "15/01/2003",
          role: "GERENTE",
          amount: 35,
          status: !1,
          item: "celular"
      }, {
          name: "IGOR",
          id: 1,
          date: "15/01/2003",
          role: "GERENTE",
          amount: 35,
          status: !1,
          item: "celular"
      }]).then(r)
  }
  , []),
  w(k.div, {
      initial: {
          opacity: 0
      },
      animate: {
          opacity: 1
      },
      className: "p-4",
      children: [w(k.div, {
          initial: {
              y: -20,
              opacity: 0
          },
          animate: {
              y: 0,
              opacity: 1
          },
          className: "flex items-center justify-between",
          children: [w("div", {
              className: "flex items-center gap-[.44rem]",
              children: [c(k.div, {
                  whileHover: {
                      scale: 1.05
                  },
                  className: "w-[2.125rem] h-[2.125rem] bg-primary flex items-center justify-center rounded-[.25rem]",
                  children: c(di, {
                      size: 18,
                      color: "white"
                  })
              }), c("p", {
                  className: "text-white text-xs font-medium",
                  children: "ARMAZEM"
              })]
          }), w(k.div, {
              initial: {
                  x: 20,
                  opacity: 0
              },
              animate: {
                  x: 0,
                  opacity: 1
              },
              className: "flex gap-2 px-3 items-center w-[22.8125rem] h-[2.125rem] rounded-[.25rem] bg-white/[.04] border border-white/[.04]",
              children: [c(mm, {
                  size: 16,
                  className: "text-primary"
              }), c("input", {
                  onChange: d => t(d.target.value),
                  type: "text",
                  className: "bg-transparent flex-1 h-full outline-none text-white text-xs font-normal",
                  placeholder: "Pesquisar por nome, id ou data"
              })]
          })]
      }), w(k.div, {
          initial: {
              y: 20,
              opacity: 0
          },
          animate: {
              y: 0,
              opacity: 1
          },
          transition: {
              delay: .2
          },
          className: "flex flex-col gap-[.63rem] mt-6",
          children: [w("div", {
              className: "flex items-center",
              children: [c("p", {
                  className: "text-white text-[.625rem] font-medium w-[8.625rem]",
                  children: "#"
              }), c("p", {
                  className: "text-white text-[.625rem] font-medium w-[15.1875rem]",
                  children: "Nome"
              }), c("p", {
                  className: "text-white text-[.625rem] font-medium w-[12.4375rem]",
                  children: "Cargo"
              }), c("p", {
                  className: "text-white text-[.625rem] font-medium w-[8.6875rem]",
                  children: "Item"
              }), c("p", {
                  className: "text-white text-[.625rem] font-medium w-[7.375rem]",
                  children: "Quantidade"
              }), c("p", {
                  className: "text-white text-[.625rem] font-medium w-[]",
                  children: "Data"
              })]
          }), c("div", {
              className: "flex flex-col gap-2 max-h-[17.1875rem] h-[17.1875rem] overflow-auto",
              children: o == null ? void 0 : o.map( (d, m) => w(k.div, {
                  initial: {
                      opacity: 0,
                      x: -20
                  },
                  animate: {
                      opacity: 1,
                      x: 0
                  },
                  transition: {
                      delay: m * .1
                  },
                  whileHover: {
                      scale: 1.01
                  },
                  className: "flex flex-none items-center bg-white/[.04] rounded-[.25rem] border border-white/[.04] h-10 pl-[.31rem]",
                  children: [c(k.div, {
                      whileHover: {
                          scale: 1.1
                      },
                      className: "w-[1.875rem] h-[1.875rem] bg-primary border border-white/[.04] flex items-center justify-center rounded-[.1875rem] mr-[6.4rem]",
                      children: c(u0, {
                          size: 18,
                          color: "white"
                      })
                  }), c("p", {
                      className: "text-white text-[.625rem] font-medium w-[15.1875rem]",
                      children: d.name
                  }), c("p", {
                      className: "text-white text-[.625rem] font-medium w-[12.4375rem]",
                      children: d.role
                  }), c("p", {
                      className: "text-white text-[.625rem] font-medium w-[8.6875rem]",
                      children: d.item
                  }), w("p", {
                      className: "text-white text-[.625rem] font-medium w-[7.375rem]",
                      children: [d.amount, "x"]
                  }), c("p", {
                      className: "text-white text-[.625rem] font-medium w-[]",
                      children: d.date
                  })]
              }, m))
          })]
      }), w(k.div, {
          initial: {
              y: 20,
              opacity: 0
          },
          animate: {
              y: 0,
              opacity: 1
          },
          transition: {
              delay: .4
          },
          className: "flex flex-col gap-3 mt-4",
          children: [w("div", {
              className: "flex items-center gap-[.44rem]",
              children: [c(k.div, {
                  whileHover: {
                      scale: 1.05
                  },
                  className: "w-[2.125rem] h-[2.125rem] bg-primary flex items-center justify-center rounded-[.25rem]",
                  children: c(di, {
                      size: 18,
                      color: "white"
                  })
              }), c("p", {
                  className: "text-white text-xs font-medium",
                  children: "MAIOR DEP\xD3SITO NO ARMAZEM"
              })]
          }), w(k.div, {
              whileHover: {
                  scale: 1.01
              },
              className: "flex flex-none items-center bg-gradient-to-b from-primary to-primary/95 rounded-[.25rem] h-10 pl-[.31rem]",
              style: {
                  boxShadow: "inset 0 0 0 1px rgb(255, 255, 255, .05)"
              },
              children: [c(k.div, {
                  whileHover: {
                      scale: 1.1
                  },
                  className: "w-[1.875rem] h-[1.875rem] bg-transparent border border-white flex items-center justify-center rounded-[.1875rem] mr-[6.4rem]",
                  children: c(u0, {
                      size: 18,
                      color: "white"
                  })
              }), c("p", {
                  className: "text-white text-[.625rem] font-medium w-[15.1875rem]",
                  children: (a = n.sort( (d, m) => m.amount - d.amount)[0]) == null ? void 0 : a.name
              }), c("p", {
                  className: "text-white text-[.625rem] font-medium w-[12.4375rem]",
                  children: (s = n.sort( (d, m) => m.amount - d.amount)[0]) == null ? void 0 : s.role
              }), c("p", {
                  className: "text-white text-[.625rem] font-medium w-[8.6875rem]",
                  children: (l = n.sort( (d, m) => m.amount - d.amount)[0]) == null ? void 0 : l.item
              }), w("p", {
                  className: "text-white text-[.625rem] font-medium w-[7.375rem]",
                  children: [(u = n.sort( (d, m) => m.amount - d.amount)[0]) == null ? void 0 : u.amount, "x"]
              }), c("p", {
                  className: "text-white text-[.625rem] font-medium w-[]",
                  children: (f = n.sort( (d, m) => m.amount - d.amount)[0]) == null ? void 0 : f.date
              })]
          })]
      }), i && c(ex, {})]
  })
}
function nx() {
  const {serverIcon: e, nextPayment: t, salary: n, store: r, setNextPayment: i, nextPaymentMax: o} = oe()
    , [a,s] = E.exports.useState("");
  return E.exports.useEffect( () => {
      if (typeof t == "number") {
          const l = setInterval( () => {
              const u = Math.floor(t / 3600)
                , f = Math.floor(t % 3600 / 60)
                , d = t % 60;
              s(`${u}h ${f}m ${d}s`),
              i(t - 1),
              t <= 0 && i(o)
          }
          , 1e3);
          return () => clearInterval(l)
      }
  }
  , [t]),
  w(ui, {
      children: [c("div", {
          className: "w-[82.5rem] h-[5rem] bg-banner border border-primary rounded mt-4 flex items-center justify-center",
          children: c("img", {
              className: "h-[4rem]",
              src: e,
              alt: ""
          })
      }), w("div", {
          className: "flex items-end gap-2",
          children: [t && c(Uh, {
              className: "text-white/50",
              size: 20
          }), t && w("p", {
              className: "text-white/50 text-xs mt-2 text-right",
              children: ["Pr\xF3ximo Sal\xE1rio da organiza\xE7\xE3o em: ", a || "00:00", " | ", w("span", {
                  className: "font-medium text-white",
                  children: ["R$ ", n == null ? void 0 : n.toLocaleString("pt-br")]
              })]
          }), !t && c(Kh, {
              className: "text-white/50",
              size: 20
          }), !t && w("p", {
              onClick: () => window.invokeNative("openUrl", r),
              className: "text-white/50 text-xs mt-2 text-right cursor-pointer",
              children: ["Sua organiza\xE7\xE3o n\xE3o possui salario de fac\xE7\xE3o compre em nosso ", c("span", {
                  className: "border-b border-white/50 text-white",
                  children: "site"
              })]
          })]
      })]
  })
}
function Uo(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          strokeWidth: "2",
          strokeLinecap: "round",
          strokeLinejoin: "round"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M5 5a5 5 0 0 1 7 0a5 5 0 0 0 7 0v9a5 5 0 0 1 -7 0a5 5 0 0 0 -7 0v-9z"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M5 21v-7"
          },
          child: []
      }]
  })(e)
}
function qh() {
  const {avatar: e, logo: t, membersOnline: n, members: r, leader: i, orgBalance: o} = oe()
    , a = {
      hidden: {
          opacity: 0,
          y: -20
      },
      visible: {
          opacity: 1,
          y: 0,
          transition: {
              duration: .5,
              staggerChildren: .1
          }
      }
  }
    , s = {
      hidden: {
          opacity: 0,
          x: -20
      },
      visible: {
          opacity: 1,
          x: 0,
          transition: {
              duration: .3
          }
      }
  }
    , l = {
      hover: {
          scale: 1.1,
          rotate: 5,
          transition: {
              duration: .2
          }
      }
  };
  return w(k.div, {
      variants: a,
      initial: "hidden",
      animate: "visible",
      className: "rounded-[0.3125rem] mt-4 mb-[.88rem] w-[61.875rem] h-[7.875rem] flex items-center gap-[.63rem] p-4 bg-primary-gradient",
      children: [w(k.div, {
          variants: s,
          className: "w-[14.375rem] h-[5.875rem] bg-primary border border-white/[.15] rounded-[.25rem] px-[.94rem] pt-[.97rem]",
          children: [w("div", {
              className: "flex items-center justify-between",
              children: [w("div", {
                  children: [c("small", {
                      className: "text-white text-[.625rem] font-normal",
                      children: "MEMBROS"
                  }), c("p", {
                      className: "text-white text-xl font-bold",
                      children: r
                  })]
              }), c(k.div, {
                  whileHover: "hover",
                  variants: l,
                  className: "w-[2.1875rem] h-[2.1875rem] bg-primary flex items-center justify-center rounded-[.25rem]",
                  children: c(di, {
                      size: 21,
                      className: "text-white"
                  })
              })]
          }), c("div", {
              className: "w-full h-[0.125rem] bg-white mt-2"
          })]
      }), w(k.div, {
          variants: s,
          className: "w-[14.375rem] h-[5.875rem] bg-white/[.04] border border-white/[.04] rounded-[.25rem] px-[.94rem] pt-[.97rem]",
          children: [w("div", {
              className: "flex items-center justify-between",
              children: [w("div", {
                  children: [c("small", {
                      className: "text-white text-[.625rem] font-normal",
                      children: "ONLINE"
                  }), c("p", {
                      className: "text-primary text-xl font-bold",
                      children: n
                  })]
              }), c(k.div, {
                  whileHover: "hover",
                  variants: l,
                  className: "w-[2.1875rem] h-[2.1875rem] bg-primary flex items-center justify-center rounded-[.25rem]",
                  children: c(di, {
                      size: 21,
                      className: "text-white"
                  })
              })]
          }), c("div", {
              className: "w-full h-[0.125rem] bg-primary mt-2"
          })]
      }), w(k.div, {
          variants: s,
          className: "w-[14.375rem] h-[5.875rem] bg-white/[.04] border border-white/[.04] rounded-[.25rem] px-[.94rem] pt-[.97rem]",
          children: [w("div", {
              className: "flex items-center justify-between",
              children: [w("div", {
                  children: [c("small", {
                      className: "text-white text-[.625rem] font-normal",
                      children: "SALDO"
                  }), w("p", {
                      className: "text-primary text-xl font-bold",
                      children: ["$", o == null ? void 0 : o.toLocaleString("pt-br")]
                  })]
              }), c(k.div, {
                  whileHover: "hover",
                  variants: l,
                  className: "w-[2.1875rem] h-[2.1875rem] bg-primary flex items-center justify-center rounded-[.25rem]",
                  children: c(hm, {
                      size: 21,
                      className: "text-white"
                  })
              })]
          }), c("div", {
              className: "w-full h-[0.125rem] bg-primary mt-2"
          })]
      }), w(k.div, {
          variants: s,
          className: "w-[14.375rem] h-[5.875rem] bg-white/[.04] border border-white/[.04] rounded-[.25rem] px-[.94rem] pt-[.97rem]",
          children: [w("div", {
              className: "flex items-center justify-between",
              children: [w("div", {
                  children: [c("small", {
                      className: "text-white text-[.625rem] font-normal",
                      children: "L\xCDDER"
                  }), c("p", {
                      className: "text-primary text-xl font-bold w-[10rem] whitespace-nowrap overflow-hidden",
                      children: i
                  })]
              }), c(k.div, {
                  whileHover: "hover",
                  variants: l,
                  className: "w-[2.1875rem] h-[2.1875rem] bg-primary flex items-center justify-center rounded-[.25rem]",
                  children: c(Uo, {
                      size: 21,
                      className: "text-white"
                  })
              })]
          }), c("div", {
              className: "w-full h-[0.125rem] bg-primary mt-2"
          })]
      })]
  })
}
function rx(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M12.71 2.29a1 1 0 0 0-1.42 0l-9 9a1 1 0 0 0 0 1.42A1 1 0 0 0 3 13h1v7a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-7h1a1 1 0 0 0 1-1 1 1 0 0 0-.29-.71zM6 20v-9.59l6-6 6 6V20z"
          },
          child: []
      }]
  })(e)
}
function ix(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M16 12a4 4 0 1 1-8 0 4 4 0 0 1 8 0Zm-1.5 0a2.5 2.5 0 1 0-5 0 2.5 2.5 0 0 0 5 0Z"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M12 1c.266 0 .532.009.797.028.763.055 1.345.617 1.512 1.304l.352 1.45c.019.078.09.171.225.221.247.089.49.19.728.302.13.061.246.044.315.002l1.275-.776c.603-.368 1.411-.353 1.99.147.402.349.78.726 1.128 1.129.501.578.515 1.386.147 1.99l-.776 1.274c-.042.069-.058.185.002.315.112.238.213.481.303.728.048.135.142.205.22.225l1.45.352c.687.167 1.249.749 1.303 1.512.038.531.038 1.063 0 1.594-.054.763-.616 1.345-1.303 1.512l-1.45.352c-.078.019-.171.09-.221.225-.089.248-.19.491-.302.728-.061.13-.044.246-.002.315l.776 1.275c.368.603.353 1.411-.147 1.99-.349.402-.726.78-1.129 1.128-.578.501-1.386.515-1.99.147l-1.274-.776c-.069-.042-.185-.058-.314.002a8.606 8.606 0 0 1-.729.303c-.135.048-.205.142-.225.22l-.352 1.45c-.167.687-.749 1.249-1.512 1.303-.531.038-1.063.038-1.594 0-.763-.054-1.345-.616-1.512-1.303l-.352-1.45c-.019-.078-.09-.171-.225-.221a8.138 8.138 0 0 1-.728-.302c-.13-.061-.246-.044-.315-.002l-1.275.776c-.603.368-1.411.353-1.99-.147-.402-.349-.78-.726-1.128-1.129-.501-.578-.515-1.386-.147-1.99l.776-1.274c.042-.069.058-.185-.002-.314a8.606 8.606 0 0 1-.303-.729c-.048-.135-.142-.205-.22-.225l-1.45-.352c-.687-.167-1.249-.749-1.304-1.512a11.158 11.158 0 0 1 0-1.594c.055-.763.617-1.345 1.304-1.512l1.45-.352c.078-.019.171-.09.221-.225.089-.248.19-.491.302-.728.061-.13.044-.246.002-.315l-.776-1.275c-.368-.603-.353-1.411.147-1.99.349-.402.726-.78 1.129-1.128.578-.501 1.386-.515 1.99-.147l1.274.776c.069.042.185.058.315-.002.238-.112.481-.213.728-.303.135-.048.205-.142.225-.22l.352-1.45c.167-.687.749-1.249 1.512-1.304C11.466 1.01 11.732 1 12 1Zm-.69 1.525c-.055.004-.135.05-.161.161l-.353 1.45a1.832 1.832 0 0 1-1.172 1.277 7.147 7.147 0 0 0-.6.249 1.833 1.833 0 0 1-1.734-.074l-1.274-.776c-.098-.06-.186-.036-.228 0a9.774 9.774 0 0 0-.976.976c-.036.042-.06.131 0 .228l.776 1.274c.314.529.342 1.18.074 1.734a7.147 7.147 0 0 0-.249.6 1.831 1.831 0 0 1-1.278 1.173l-1.45.351c-.11.027-.156.107-.16.162a9.63 9.63 0 0 0 0 1.38c.004.055.05.135.161.161l1.45.353a1.832 1.832 0 0 1 1.277 1.172c.074.204.157.404.249.6.268.553.24 1.204-.074 1.733l-.776 1.275c-.06.098-.036.186 0 .228.301.348.628.675.976.976.042.036.131.06.228 0l1.274-.776a1.83 1.83 0 0 1 1.734-.075c.196.093.396.176.6.25a1.831 1.831 0 0 1 1.173 1.278l.351 1.45c.027.11.107.156.162.16a9.63 9.63 0 0 0 1.38 0c.055-.004.135-.05.161-.161l.353-1.45a1.834 1.834 0 0 1 1.172-1.278 6.82 6.82 0 0 0 .6-.248 1.831 1.831 0 0 1 1.733.074l1.275.776c.098.06.186.036.228 0 .348-.301.675-.628.976-.976.036-.042.06-.131 0-.228l-.776-1.275a1.834 1.834 0 0 1-.075-1.733c.093-.196.176-.396.25-.6a1.831 1.831 0 0 1 1.278-1.173l1.45-.351c.11-.027.156-.107.16-.162a9.63 9.63 0 0 0 0-1.38c-.004-.055-.05-.135-.161-.161l-1.45-.353c-.626-.152-1.08-.625-1.278-1.172a6.576 6.576 0 0 0-.248-.6 1.833 1.833 0 0 1 .074-1.734l.776-1.274c.06-.098.036-.186 0-.228a9.774 9.774 0 0 0-.976-.976c-.042-.036-.131-.06-.228 0l-1.275.776a1.831 1.831 0 0 1-1.733.074 6.88 6.88 0 0 0-.6-.249 1.835 1.835 0 0 1-1.173-1.278l-.351-1.45c-.027-.11-.107-.156-.162-.16a9.63 9.63 0 0 0-1.38 0Z"
          },
          child: []
      }]
  })(e)
}
function Jh() {
  const e = xu()
    , t = rm()
    , {setPermissionsModalVisible: n, discord: r, permissions: i, painelType: o} = oe();
  return c("nav", {
      className: "rounded-[0.25rem] w-[61.875rem] h-[3.625rem] flex items-center bg-primary-gradient",
      children: w("ul", {
          className: "flex items-center",
          children: [w("li", {
              onClick: () => t("/"),
              className: `cursor-pointer text-white text-base font-medium flex items-center gap-3 px-6 h-[3.625rem] rounded-[.25rem] border border-transparent ${e.pathname === "/" && "bg-primary !border-white/10"}`,
              children: [c(rx, {
                  size: 22,
                  className: "text-white"
              }), "IN\xCDCIO"]
          }), o !== "legal" && w("li", {
              onClick: () => t("/farms"),
              className: `cursor-pointer text-white text-base font-medium flex items-center gap-3 px-6 h-[3.625rem] rounded-[.25rem] border border-transparent ${e.pathname === "/farms" && "bg-primary !border-white/10"}`,
              children: [c(cy, {
                  size: 22,
                  className: "text-white"
              }), "ARMAZEM"]
          }), o !== "legal" && w("li", {
              onClick: () => t("/goals"),
              className: `cursor-pointer text-white text-base font-medium flex items-center gap-3 px-6 h-[3.625rem] rounded-[.25rem] border border-transparent ${e.pathname === "/goals" && "bg-primary !border-white/10"}`,
              children: [c(Uo, {
                  size: 22,
                  className: "text-white"
              }), "METAS"]
          }), w("li", {
              onClick: () => t("/bank"),
              className: `cursor-pointer text-white text-base font-medium flex items-center gap-3 px-6 h-[3.625rem] rounded-[.25rem] border border-transparent ${e.pathname === "/bank" && "bg-primary !border-white/10"}`,
              children: [c(hm, {
                  size: 22,
                  className: "text-white"
              }), "BANCO"]
          }), i.leader && w("li", {
              onClick: () => t("/configuration"),
              className: `cursor-pointer text-white text-base font-medium flex items-center gap-3 px-6 h-[3.625rem] rounded-[.25rem] border border-transparent ${e.pathname === "/configuration" && "bg-primary !border-white/10"}`,
              children: [c(ix, {
                  size: 22,
                  className: "text-white"
              }), "CONFIGURA\xC7\xD5ES"]
          }), w("li", {
              onClick: () => t("/partners"),
              className: `cursor-pointer text-white text-base font-medium flex items-center gap-3 px-6 h-[3.625rem] rounded-[.25rem] border border-transparent ${e.pathname === "/partners" && "bg-primary !border-white/10"}`,
              children: [c(uy, {
                  size: 22,
                  className: "text-white"
              }), "PARCERIAS"]
          })]
      })
  })
}
function ep({author: e, author_id: t, author_avatar: n, date: r, message: i, index: o, setWarnings: a}) {
  const {permissions: s} = oe();
  function l() {
      z("DeleteWarning", {
          index: o
      }, []).then(a)
  }
  return w("div", {
      className: wi("w-[17.75rem] p-[.94rem] rounded-[.25rem] relative border border-white/[.04] bg-white/[.04] animate-duration-150"),
      children: [w("div", {
          className: "flex items-center justify-between",
          children: [w("div", {
              className: "flex items-center gap-[.62rem]",
              children: [c("div", {
                  className: "w-[1.875rem] h-[1.875rem] rounded-full !bg-center !bg-cover bg-no-repeat",
                  style: {
                      background: `url("${n}")`
                  }
              }), w("p", {
                  className: "text-white text-[0.6875rem] font-normal",
                  children: [e, w("b", {
                      className: "text-primary font-normal",
                      children: ["#", t]
                  })]
              })]
          }), s.leader && c(Yh, {
              onClick: l,
              className: "text-white cursor-pointer",
              size: 20,
              weight: "fill"
          })]
      }), c("p", {
          className: "text-white/40 text-[.625rem] font-normal mt-[.44rem] mb-4",
          children: i
      }), w("div", {
          className: "flex items-center justify-between",
          children: [c("p", {
              className: "text-white text-[.6875rem] font-normal",
              children: r
          }), c(pm, {
              size: 16,
              className: "text-primary"
          })]
      })]
  })
}
function ox() {
  const {warnings: e, permissions: t, setWarningModalVisible: n, setWarnings: r} = oe();
  function i() {
      !t.alerts || n(!0)
  }
  return Sn("UpdateWarnings", r),
  w(k.div, {
      initial: {
          opacity: 0,
          scale: .9
      },
      animate: {
          opacity: 1,
          scale: 1
      },
      transition: {
          duration: .3
      },
      className: "w-[18.125rem] h-[31.875rem] rounded primary-gradient border border-primary p-5",
      children: [w(k.div, {
          initial: {
              x: -20,
              opacity: 0
          },
          animate: {
              x: 0,
              opacity: 1
          },
          transition: {
              delay: .2
          },
          className: "flex items-center gap-3",
          children: [c(Wh, {
              className: "primary",
              size: 20
          }), c("p", {
              className: "text-white text-xs",
              children: "AVISOS"
          })]
      }), c(k.hr, {
          initial: {
              width: 0
          },
          animate: {
              width: "100%"
          },
          transition: {
              delay: .4
          },
          className: "border-none w-full bg-white/20 h-[0.0625rem] mt-5"
      }), c(k.button, {
          whileHover: {
              scale: 1.02
          },
          whileTap: {
              scale: .98
          },
          onClick: i,
          className: wi("bg-foreground border border-white/20 w-full cursor-pointer h-[3.75rem] rounded mt-3.5 grid place-items-center hover:bg-primary group", {
              "opacity-50": !t.alerts
          }),
          children: c(Qh, {
              size: 36,
              className: "primary group-hover:text-white"
          })
      }), c(k.div, {
          initial: {
              y: 20,
              opacity: 0
          },
          animate: {
              y: 0,
              opacity: 1
          },
          transition: {
              delay: .6
          },
          className: "flex flex-col gap-4 mt-4 h-[21rem] overflow-y-auto overflow-x-hidden",
          children: c(wn, {
              children: e == null ? void 0 : e.slice().reverse().map( (o, a) => c(k.div, {
                  initial: {
                      x: -20,
                      opacity: 0
                  },
                  animate: {
                      x: 0,
                      opacity: 1
                  },
                  exit: {
                      x: 20,
                      opacity: 0
                  },
                  transition: {
                      delay: a * .1
                  },
                  children: c(ep, {
                      ...o
                  })
              }, a))
          })
      })]
  })
}
function ax() {
  const [e,t] = E.exports.useState([]);
  return E.exports.useEffect( () => {
      z("GetRegisters", {}, [{
          avatar: "https://i.imgur.com/exJslvp.png",
          name: "IGOR",
          id: 1,
          role: "GERENTE",
          message: "Guardou 25x G36C No Bau",
          time: "02/04/2024 as 14h05m10s"
      }, {
          avatar: "https://i.imgur.com/exJslvp.png",
          name: "IGOR",
          id: 1,
          role: "GERENTE",
          message: "Guardou 25x G36C No Bau",
          time: "02/04/2024 as 14h05m10s"
      }, {
          avatar: "https://i.imgur.com/exJslvp.png",
          name: "IGOR",
          id: 1,
          role: "GERENTE",
          message: "Guardou 25x G36C No Bau",
          time: "02/04/2024 as 14h05m10s"
      }, {
          avatar: "https://i.imgur.com/exJslvp.png",
          name: "IGOR",
          id: 1,
          role: "GERENTE",
          message: "Guardou 25x G36C No Bau",
          time: "02/04/2024 as 14h05m10s"
      }, {
          avatar: "https://i.imgur.com/exJslvp.png",
          name: "IGOR",
          id: 1,
          role: "GERENTE",
          message: "Guardou 25x G36C No Bau",
          time: "02/04/2024 as 14h05m10s"
      }, {
          avatar: "https://i.imgur.com/exJslvp.png",
          name: "IGOR",
          id: 1,
          role: "GERENTE",
          message: "Guardou 25x G36C No Bau",
          time: "02/04/2024 as 14h05m10s"
      }, {
          avatar: "https://i.imgur.com/exJslvp.png",
          name: "IGOR",
          id: 1,
          role: "GERENTE",
          message: "Guardou 25x G36C No Bau",
          time: "02/04/2024 as 14h05m10s"
      }, {
          avatar: "https://i.imgur.com/exJslvp.png",
          name: "IGOR",
          id: 1,
          role: "GERENTE",
          message: "Guardou 25x G36C No Bau",
          time: "02/04/2024 as 14h05m10s"
      }, {
          avatar: "https://i.imgur.com/exJslvp.png",
          name: "IGOR",
          id: 1,
          role: "GERENTE",
          message: "Guardou 25x G36C No Bau Bau Bau Bau Bau Bau Bau Bau Bau",
          time: "02/04/2024 as 14h05m10s"
      }, {
          avatar: "https://i.imgur.com/exJslvp.png",
          name: "IGOR",
          id: 1,
          role: "GERENTE",
          message: "Guardou 25x G36C No Bau",
          time: "02/04/2024 as 14h05m10s"
      }]).then(t)
  }
  , []),
  w(k.div, {
      initial: {
          opacity: 0
      },
      animate: {
          opacity: 1
      },
      className: "flex gap-5",
      children: [c(Jh, {}), w("div", {
          className: "",
          children: [c(qh, {}), w(k.div, {
              initial: {
                  y: 20,
                  opacity: 0
              },
              animate: {
                  y: 0,
                  opacity: 1
              },
              transition: {
                  delay: .2
              },
              className: "mt-6 flex gap-5",
              children: [c(ox, {}), w(k.div, {
                  initial: {
                      scale: .95,
                      opacity: 0
                  },
                  animate: {
                      scale: 1,
                      opacity: 1
                  },
                  transition: {
                      delay: .3
                  },
                  className: "w-[63.125rem] h-[31.875rem] primary-gradient rounded border border-primary p-5",
                  children: [c(k.div, {
                      initial: {
                          x: -20,
                          opacity: 0
                      },
                      animate: {
                          x: 0,
                          opacity: 1
                      },
                      className: "flex items-center w-full justify-between",
                      children: w("div", {
                          className: "flex items-center gap-3",
                          children: [c(k.div, {
                              whileHover: {
                                  rotate: 360
                              },
                              transition: {
                                  duration: .5
                              },
                              className: "w-7 h-7 bg-primary grid place-items-center rounded",
                              children: c(Xh, {
                                  className: "text-white"
                              })
                          }), c(k.p, {
                              initial: {
                                  x: -10,
                                  opacity: 0
                              },
                              animate: {
                                  x: 0,
                                  opacity: 1
                              },
                              className: "text-xs text-white font-semibold",
                              children: "REGISTROS DO BA\xDA"
                          })]
                      })
                  }), w(k.div, {
                      initial: {
                          y: 10,
                          opacity: 0
                      },
                      animate: {
                          y: 0,
                          opacity: 1
                      },
                      transition: {
                          delay: .4
                      },
                      className: "mt-7 flex items-center px-8",
                      children: [c("p", {
                          className: "text-xs text-white w-[9.9375rem]",
                          children: "NOME"
                      }), c("p", {
                          className: "text-xs text-white w-[8.3125rem]",
                          children: "ID"
                      }), c("p", {
                          className: "text-xs text-white w-[11.3125rem]",
                          children: "CARGO"
                      }), c("p", {
                          className: "text-xs text-white w-[19rem]",
                          children: "REGISTRO"
                      }), c("p", {
                          className: "text-xs text-white",
                          children: "DATA"
                      })]
                  }), c(k.div, {
                      initial: {
                          opacity: 0
                      },
                      animate: {
                          opacity: 1
                      },
                      transition: {
                          delay: .5
                      },
                      className: "flex flex-col gap-2 mt-4 h-[24.5rem] overflow-y-auto",
                      children: c(wn, {
                          children: e == null ? void 0 : e.map( (n, r) => w(k.div, {
                              initial: {
                                  opacity: 0,
                                  x: -20
                              },
                              animate: {
                                  opacity: 1,
                                  x: 0
                              },
                              exit: {
                                  opacity: 0,
                                  x: 20
                              },
                              transition: {
                                  delay: r * .1
                              },
                              whileHover: {
                                  scale: 1.02
                              },
                              className: "min-h-[2.5rem] w-full bg-foreground flex-none rounded border border-white/20 py-2 flex items-center px-8",
                              children: [c("div", {
                                  className: "flex items-center gap-2.5",
                                  children: c("p", {
                                      className: "text-xs text-white/50 w-[9.4rem] truncate",
                                      children: n.name
                                  })
                              }), w("p", {
                                  className: "text-xs text-white/50 w-[8.4rem]",
                                  children: ["#", n.id]
                              }), c("p", {
                                  className: "text-xs text-white/50 w-[11.4rem]",
                                  children: n.role
                              }), c("div", {
                                  className: "w-[15.4rem]",
                                  children: c("p", {
                                      className: "text-xs text-white/50 w-[10rem]",
                                      children: n.message
                                  })
                              }), c("p", {
                                  className: wi("text-xs text-white/50"),
                                  children: n.time
                              })]
                          }, r))
                      })
                  })]
              })]
          }), c(nx, {})]
      })]
  })
}
function sx(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 20 20",
          fill: "currentColor",
          "aria-hidden": "true"
      },
      child: [{
          tag: "path",
          attr: {
              fillRule: "evenodd",
              d: "M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z",
              clipRule: "evenodd"
          },
          child: []
      }]
  })(e)
}
function lx() {
  var C;
  const [e,t] = E.exports.useState("")
    , {setModal: n} = ol()
    , {setOpenedPermissionsModal: r, logo: i, setLogo: o, discord: a, setDiscord: s, salary: l, roles: u, setOpenedModal: f, radio: d, setRadio: m, setPreset: p, preset: v, setRoleEdit: x} = oe()
    , P = u == null ? void 0 : u.filter(N => N.group.toLocaleLowerCase().includes(e.toLocaleLowerCase()));
  function y() {
      n({
          title: "RADIO",
          description: "Informe o MHz da r\xE1dio para salvar.",
          placeholder: "R\xC1DIO",
          save: N => z("SetRadio", {
              frequency: Number(N.inputValue)
          }).then(m)
      }),
      f(!0)
  }
  function h() {
      n({
          title: "PRESET",
          description: "Utilize o comando /ppreset para copiar sua roupa.",
          placeholder: "PRESET",
          save: N => z("SetPreset", {
              male: N.inputValue,
              female: N.inputValue2
          }).then(R => p({
              male: R.male,
              female: R.female
          }))
      }),
      f(!0)
  }
  function g() {
      n({
          title: "LOGO",
          description: "Altere a logo da sua organiza\xE7\xE3o.",
          placeholder: "LOGO",
          save: N => {
              !N.inputValue || z("SetConfig", {
                  logo: N.inputValue
              }, N.inputValue).then(o)
          }
      }),
      f(!0)
  }
  function S() {
      n({
          title: "DISCORD",
          description: "Altere o discord da sua organiza\xE7\xE3o.",
          placeholder: "DISCORD",
          save: N => {
              if (N.inputValue.startsWith("https://discord.gg/novaiguacu"))
                  z("SetConfig", {
                      discord: N.inputValue
                  }, N.inputValue).then(s);
              else {
                  s(a);
                  return
              }
          }
      }),
      f(!0)
  }
  function M() {
      z("Announce", {}, 1e3).then(N => {
          n({
              time: N,
              title: "AN\xDANCIAR RECRUTAMENTO",
              description: "Dispon\xEDvel para an\xFAnciar em: ",
              placeholder: "ANUNCIO",
              save: R => z("Announce", {
                  title: R.inputValue,
                  description: R.inputValue2
              }, {
                  title: "sdsd",
                  description: "sdsds"
              })
          })
      }
      ),
      f(!0)
  }
  function A(N) {
      x(N),
      r(!0)
  }
  return c(k.div, {
      initial: {
          opacity: 0
      },
      animate: {
          opacity: 1
      },
      transition: {
          duration: .5
      },
      className: "p-4",
      children: w(k.div, {
          className: "flex flex-col gap-3 max-h-[28.8rem] h-[28.8rem] overflow-auto",
          children: [w(k.div, {
              initial: {
                  y: 20,
                  opacity: 0
              },
              animate: {
                  y: 0,
                  opacity: 1
              },
              transition: {
                  delay: .2
              },
              className: "flex items-center justify-between",
              children: [w("div", {
                  className: "flex items-center gap-[.44rem]",
                  children: [c(k.div, {
                      whileHover: {
                          scale: 1.1
                      },
                      className: "w-[2.125rem] h-[2.125rem] bg-primary flex items-center justify-center rounded",
                      children: c(ry, {
                          color: "white",
                          size: 18
                      })
                  }), c("p", {
                      className: "text-white text-[.625rem] font-normal",
                      children: "CARGOS"
                  })]
              }), c(k.input, {
                  whileFocus: {
                      scale: 1.02
                  },
                  className: "w-[20.8125rem] h-[2.125rem] text-center outline-none text-white placeholder:text-white/50 text-xs bg-white/[.04] border border-white/[.04] rounded",
                  placeholder: "CARGO",
                  type: "text",
                  onChange: N => t(N.target.value)
              })]
          }), w("div", {
              className: "flex flex-col gap-2",
              children: [w("div", {
                  className: "flex items-center pl-[.69rem]",
                  children: [c("p", {
                      className: "text-white text-[.625rem] font-normal w-[3.4375rem]",
                      children: "#"
                  }), c("p", {
                      className: "text-white text-[.625rem] font-normal w-[22.8125rem]",
                      children: "Cargo"
                  }), c("p", {
                      className: "text-white text-[.625rem] font-normal w-[12rem]",
                      children: "Membros"
                  }), c("p", {
                      className: "text-white text-[.625rem] font-normal w-[3.375rem]",
                      children: "Permiss\xF5es"
                  })]
              }), c("div", {
                  className: "flex flex-col gap-2 max-h-[7.5rem] h-[7.5rem] overflow-auto",
                  children: (C = P.sort( (N, R) => N.nivel - R.nivel)) == null ? void 0 : C.map( (N, R) => w(k.div, {
                      initial: {
                          x: -20,
                          opacity: 0
                      },
                      animate: {
                          x: 0,
                          opacity: 1
                      },
                      transition: {
                          delay: R * .1
                      },
                      className: "flex flex-none items-center pl-[.69rem] w-[59.875rem] h-10 bg-white/[.04] rounded border border-white/[.04]",
                      children: [c("p", {
                          className: "text-white text-[.625rem] font-normal w-[3.4375rem]",
                          children: N.nivel
                      }), c("p", {
                          className: "text-white text-[.625rem] font-normal w-[22.8125rem]",
                          children: N.group
                      }), w("p", {
                          className: "text-white text-[.625rem] font-normal w-[12rem]",
                          children: [N.members, " ", c("b", {
                              className: "text-white/50 font-normal",
                              children: "membros"
                          })]
                      }), c(k.button, {
                          whileHover: {
                              scale: 1.05
                          },
                          whileTap: {
                              scale: .95
                          },
                          onClick: () => A(N.group),
                          className: "text-primary text-[.625rem] font-normal px-2 py-1 rounded bg-white/10",
                          children: "CLIQUE PARA EDITAR"
                      })]
                  }, R))
              })]
          }), w(k.div, {
              initial: {
                  x: -20,
                  opacity: 0
              },
              animate: {
                  x: 0,
                  opacity: 1
              },
              transition: {
                  delay: .3
              },
              className: "rounded w-full h-[3.125rem] bg-white/[.04] border border-white/[.04] flex flex-none items-center justify-between px-4",
              children: [c("p", {
                  className: "text-white text-sm font-normal",
                  children: "LOGO DA ORGANIZA\xC7\xC3O"
              }), w("div", {
                  className: "flex items-center gap-4",
                  children: [c("p", {
                      className: "text-white text-sm font-normal bg-transparent w-[30rem] outline-none text-right text-ellipsis whitespace-nowrap overflow-hidden",
                      children: i
                  }), c(k.button, {
                      whileHover: {
                          scale: 1.05
                      },
                      whileTap: {
                          scale: .95
                      },
                      onClick: g,
                      className: "text-white text-sm font-normal w-[12.625rem] h-[2.125rem] flex items-center justify-center bg-gradient-to-r from-primary to-secondary rounded border border-white/10",
                      children: "EDITAR"
                  })]
              })]
          }), w(k.div, {
              initial: {
                  x: -20,
                  opacity: 0
              },
              animate: {
                  x: 0,
                  opacity: 1
              },
              transition: {
                  delay: .4
              },
              className: "rounded w-full h-[3.125rem] bg-white/[.04] border border-white/[.04] flex flex-none items-center justify-between px-4",
              children: [c("p", {
                  className: "text-white text-sm font-normal",
                  children: "AN\xDANCIO DE RECRUTAMENTO"
              }), c("div", {
                  className: "flex items-center gap-4",
                  children: c(k.button, {
                      whileHover: {
                          scale: 1.05
                      },
                      whileTap: {
                          scale: .95
                      },
                      onClick: M,
                      className: "text-white text-sm font-normal w-[12.625rem] h-[2.125rem] flex items-center justify-center bg-gradient-to-r from-primary to-secondary rounded border border-white/10",
                      children: "ANUNCIAR"
                  })
              })]
          }), w(k.div, {
              initial: {
                  x: -20,
                  opacity: 0
              },
              animate: {
                  x: 0,
                  opacity: 1
              },
              transition: {
                  delay: .5
              },
              className: "rounded w-full h-[3.125rem] bg-white/[.04] border border-white/[.04] flex flex-none items-center justify-between px-4",
              children: [c("p", {
                  className: "text-white text-sm font-normal",
                  children: "DISCORD"
              }), w("div", {
                  className: "flex items-center gap-4",
                  children: [c("p", {
                      className: "text-white text-sm font-normal bg-transparent w-52 outline-none text-right",
                      children: a
                  }), c(k.button, {
                      whileHover: {
                          scale: 1.05
                      },
                      whileTap: {
                          scale: .95
                      },
                      onClick: S,
                      className: "text-white text-sm font-normal w-[12.625rem] h-[2.125rem] flex items-center justify-center bg-gradient-to-r from-primary to-secondary rounded border border-white/10",
                      children: "EDITAR"
                  })]
              })]
          }), w(k.div, {
              initial: {
                  x: -20,
                  opacity: 0
              },
              animate: {
                  x: 0,
                  opacity: 1
              },
              transition: {
                  delay: .6
              },
              className: "rounded w-full h-[3.125rem] bg-white/[.04] border border-white/[.04] flex flex-none items-center justify-between px-4",
              children: [c("p", {
                  className: "text-white text-sm font-normal",
                  children: "R\xC1DIO"
              }), w("div", {
                  className: "flex items-center gap-4",
                  children: [w("p", {
                      className: "text-white text-sm font-normal",
                      children: [d, " MHz"]
                  }), c(k.button, {
                      whileHover: {
                          scale: 1.05
                      },
                      whileTap: {
                          scale: .95
                      },
                      onClick: y,
                      className: "text-white text-sm font-normal w-[12.625rem] h-[2.125rem] flex items-center justify-center bg-gradient-to-r from-primary to-secondary rounded border border-white/10",
                      children: "EDITAR"
                  })]
              })]
          }), w(k.div, {
              initial: {
                  x: -20,
                  opacity: 0
              },
              animate: {
                  x: 0,
                  opacity: 1
              },
              transition: {
                  delay: .7
              },
              className: "rounded w-full h-[3.125rem] bg-white/[.04] border border-white/[.04] flex flex-none items-center justify-between px-4",
              children: [c("p", {
                  className: "text-white text-sm font-normal",
                  children: "PRESET DE ROUPA"
              }), w("div", {
                  className: "flex items-center gap-4",
                  children: [w("p", {
                      className: "text-white text-sm font-normal w-[30rem] outline-none text-right text-ellipsis whitespace-nowrap overflow-hidden",
                      children: ["masculaaaaaaasdadasdadasdsadino: ", v.male, " | feminino: ", v.female]
                  }), c(k.button, {
                      whileHover: {
                          scale: 1.05
                      },
                      whileTap: {
                          scale: .95
                      },
                      onClick: h,
                      className: "text-white text-sm font-normal w-[12.625rem] h-[2.125rem] flex items-center justify-center bg-gradient-to-r from-primary to-secondary rounded border border-white/10",
                      children: "EDITAR"
                  })]
              })]
          })]
      })
  })
}
function ux({title: e, description: t, save: n, time: r}) {
  const {setOpenedModal: i} = oe()
    , [o,a] = E.exports.useState("")
    , [s,l] = E.exports.useState("");
  function u() {
      !o || (n({
          inputValue: o,
          inputValue2: s != null ? s : null
      }),
      i(!1))
  }
  return c("div", {
      className: "w-screen z-10 h-screen bg-black/75 absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2",
      children: w("div", {
          className: "absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 p-6 flex flex-col gap-3 rounded-md border border-primary bg-primary-gradient",
          children: [w("div", {
              className: "flex justify-between gap-5",
              children: [w("div", {
                  children: [c("h3", {
                      className: "text-primary text-[1.125rem] font-semibold",
                      children: e
                  }), w("p", {
                      className: "text-white text-[.625rem] font-normal",
                      children: [t, " ", e === "AN\xDANCIAR RECRUTAMENTO" && r]
                  })]
              }), c(gr, {
                  size: 20,
                  className: "text-white/30 cursor-pointer",
                  onClick: () => i(!1)
              })]
          }), (e === "PRESET" || e === "AN\xDANCIAR RECRUTAMENTO" || e === "NOVO AVISO") && c("label", {
              className: "text-white text-[.625rem] font-normal",
              children: e === "AN\xDANCIAR RECRUTAMENTO" ? "T\xEDtulo do an\xFAncio" : e === "NOVO AVISO" ? "T\xEDtulo do aviso" : "Masculino"
          }), c("input", {
              onChange: f => a(f.target.value),
              type: `${e !== "RADIO" ? "text" : "number"}`,
              className: "bg-white/[.04] border border-white/[.04] h-10 rounded-[.25rem] px-4 text-white text-[.8125rem] font-normal outline-none"
          }), (e === "PRESET" || e === "AN\xDANCIAR RECRUTAMENTO" || e === "NOVO AVISO") && c("label", {
              className: "text-white text-[.625rem] font-normal",
              children: e === "AN\xDANCIAR RECRUTAMENTO" ? "Mensagem do an\xFAncio" : e === "NOVO AVISO" ? "Mensagem do aviso" : "Feminino"
          }), (e === "PRESET" || e === "AN\xDANCIAR RECRUTAMENTO" || e === "NOVO AVISO") && c("input", {
              onChange: f => l(f.target.value),
              type: "text",
              className: "bg-white/[.04] border border-white/[.04] h-10 rounded-[.25rem] px-4 text-white text-[.8125rem] font-normal outline-none"
          }), c("button", {
              onClick: u,
              className: "w-[21.375rem] text-white text-[.8125rem] font-normal h-10 border border-white/[.15] rounded-[.1875rem] bg-primary",
              children: "SALVAR"
          })]
      })
  })
}
const Id = {
  invite: {
      name: "Convidar",
      status: !1
  },
  demote: {
      name: "Rebaixar",
      status: !0
  },
  promote: {
      name: "Promover",
      status: !1
  },
  dismiss: {
      name: "Demitir",
      status: !1
  },
  withdraw: {
      name: "Sacar dinheiro",
      status: !1
  },
  deposit: {
      name: "Depositar dinheiro",
      status: !1
  },
  message: {
      name: "Escrever anota\xE7\xF5es",
      status: !1
  },
  alerts: {
      name: "Escrever Alertas",
      status: !0
  },
  chat: {
      name: "Escrever no chat",
      status: !1
  }
};
function cx() {
  const {roleEdit: e, setRoleEdit: t, setOpenedPermissionsModal: n} = oe()
    , [r,i] = E.exports.useState({});
  function o(s) {
      i(l => ({
          ...l,
          [s]: {
              ...l[s],
              status: !l[s].status
          }
      }))
  }
  function a() {
      z("SetPermissions", {
          role: e,
          permissions: r
      }),
      n(!1)
  }
  return E.exports.useEffect( () => {
      z("GetPermissions", {
          roleEdit: e
      }, Id).then(i),
      t(e)
  }
  , []),
  c("div", {
      className: "w-screen z-10 h-screen bg-black/75 absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2",
      children: w("div", {
          className: "w-[24.375rem] absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 p-6 flex flex-col gap-3 rounded-md border border-primary bg-primary-gradient",
          children: [w("div", {
              className: "flex justify-between gap-5",
              children: [w("div", {
                  children: [c("h3", {
                      className: "text-primary text-[1.125rem] font-semibold",
                      children: "PERMISS\xD5ES"
                  }), w("p", {
                      className: "text-white text-[.625rem] font-normal",
                      children: ["Permiss\xF5es do cargo ", e]
                  })]
              }), c(gr, {
                  size: 20,
                  className: "text-white/30 cursor-pointer",
                  onClick: () => n(!1)
              })]
          }), c("div", {
              className: "flex flex-col gap-3",
              children: Object.keys(r).map( (s, l) => {
                  const u = Id[s];
                  return w("div", {
                      className: "flex items-center gap-3",
                      children: [c("input", {
                          onClick: () => o(s),
                          type: "checkbox",
                          name: "chest",
                          id: "chest",
                          checked: r[s].status
                      }), c("label", {
                          htmlFor: "chest",
                          className: "text-white text-[.8125rem] font-normal",
                          children: u.name
                      })]
                  }, l)
              }
              )
          }), c("button", {
              onClick: a,
              className: "text-white text-[.8125rem] w-full h-10 border border-white/[.04] bg-gradient-to-r from-primary to-secondary rounded",
              children: "SALVAR"
          })]
      })
  })
}
function dx() {
  const [e,t] = E.exports.useState("")
    , {permissions: n, setOpenedPartnerModal: r, partners: i, setPartners: o} = oe()
    , a = Array.from({
      length: 5
  }, (m, p) => p + 1)
    , s = i.filter(m => m.name.toLocaleLowerCase().includes(e.toLocaleLowerCase()));
  function l(m) {
      z("MarkLocal", {
          cds: m
      }, !0)
  }
  function u(m) {
      z("DeletePartner", {
          partner: m
      }, []).then(o)
  }
  E.exports.useEffect( () => {
      z("GetPartners", {}, [{
          cds: "a; a; a;",
          note: 3,
          name: "test2",
          keyword: "bola gato",
          description: "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          icon: "https://i.pinimg.com/736x/ba/fa/56/bafa56ac64bb409481cbfee224ed0cbe.jpg"
      }, {
          cds: "a; a; a;",
          note: 3,
          name: "test2",
          keyword: "bola gato",
          description: "descricao",
          icon: "https://i.pinimg.com/736x/ba/fa/56/bafa56ac64bb409481cbfee224ed0cbe.jpg"
      }, {
          cds: "a; a; a;",
          note: 3,
          name: "test2",
          keyword: "bola gato",
          description: "descricao",
          icon: "https://i.pinimg.com/736x/ba/fa/56/bafa56ac64bb409481cbfee224ed0cbe.jpg"
      }]).then(o)
  }
  , []);
  const f = {
      hidden: {
          opacity: 0
      },
      visible: {
          opacity: 1,
          transition: {
              staggerChildren: .1
          }
      }
  }
    , d = {
      hidden: {
          opacity: 0,
          y: 20
      },
      visible: {
          opacity: 1,
          y: 0
      }
  };
  return w(k.div, {
      initial: "hidden",
      animate: "visible",
      variants: f,
      className: "p-4",
      children: [w(k.div, {
          variants: d,
          className: "flex items-center justify-between",
          children: [w("div", {
              className: "flex items-center gap-3",
              children: [c(k.div, {
                  whileHover: {
                      scale: 1.1,
                      rotate: 360
                  },
                  transition: {
                      duration: .5
                  },
                  className: "w-[1.875rem] h-[1.875rem] bg-primary flex items-center justify-center rounded",
                  children: c(dy, {
                      size: 22,
                      className: "text-white"
                  })
              }), c(k.p, {
                  initial: {
                      x: -20,
                      opacity: 0
                  },
                  animate: {
                      x: 0,
                      opacity: 1
                  },
                  transition: {
                      delay: .2
                  },
                  className: "text-white text-[.625rem] font-normal",
                  children: "PARCERIAS"
              })]
          }), w("div", {
              className: "flex items-center gap-3",
              children: [c(k.input, {
                  whileFocus: {
                      scale: 1.02
                  },
                  initial: {
                      opacity: 0,
                      x: 20
                  },
                  animate: {
                      opacity: 1,
                      x: 0
                  },
                  transition: {
                      delay: .3
                  },
                  onChange: m => t(m.target.value),
                  type: "text",
                  placeholder: "PESQUISAR",
                  className: "outline-none w-[13.75rem] h-[1.875rem] rounded border border-white/[.04] bg-white/[.04] text-white text-center text-xs font-normal"
              }), c(wn, {
                  children: n.leader && c(k.button, {
                      initial: {
                          opacity: 0,
                          x: 20
                      },
                      animate: {
                          opacity: 1,
                          x: 0
                      },
                      exit: {
                          opacity: 0,
                          x: 20
                      },
                      whileHover: {
                          scale: 1.02
                      },
                      whileTap: {
                          scale: .98
                      },
                      onClick: () => r(!0),
                      className: "w-[19.3125rem] h-[1.875rem] text-center text-white text-xs font-medium bg-gradient-to-r from-primary to-secondary rounded",
                      children: "ADICIONAR NOVO PARCEIRO"
                  })
              })]
          })]
      }), c(k.div, {
          variants: f,
          className: "flex items-center gap-4 mt-4 flex-wrap w-[59.9375rem] max-h-[25.5rem] overflow-auto",
          children: c(wn, {
              children: s == null ? void 0 : s.map( (m, p) => w(k.div, {
                  layout: !0,
                  initial: {
                      opacity: 0,
                      scale: .8
                  },
                  animate: {
                      opacity: 1,
                      scale: 1
                  },
                  exit: {
                      opacity: 0,
                      scale: .8
                  },
                  transition: {
                      delay: p * .1
                  },
                  whileHover: {
                      scale: 1.02
                  },
                  className: "w-[19.3125rem] h-[13.9375rem] bg-white/[.04] border border-white/[.04] rounded p-4 flex flex-col gap-2 relative",
                  children: [c(wn, {
                      children: n.leader && c(k.div, {
                          initial: {
                              opacity: 0,
                              scale: 0
                          },
                          animate: {
                              opacity: 1,
                              scale: 1
                          },
                          exit: {
                              opacity: 0,
                              scale: 0
                          },
                          whileHover: {
                              scale: 1.2
                          },
                          whileTap: {
                              scale: .9
                          },
                          children: c(al, {
                              onClick: () => u(m),
                              size: 22,
                              className: "text-primary absolute right-4 top-4 cursor-pointer"
                          })
                      })
                  }), w(k.div, {
                      initial: {
                          opacity: 0,
                          y: 20
                      },
                      animate: {
                          opacity: 1,
                          y: 0
                      },
                      className: "flex items-center gap-4",
                      children: [c(k.div, {
                          whileHover: {
                              scale: 1.1,
                              rotate: 360
                          },
                          transition: {
                              duration: .5
                          },
                          className: "w-[4.875rem] h-[4.875rem] border-2 border-primary rounded-full !bg-center bg-no-repeat !bg-cover",
                          style: {
                              background: `url(${m.icon})`
                          }
                      }), w("div", {
                          children: [c(k.h3, {
                              initial: {
                                  opacity: 0,
                                  x: -20
                              },
                              animate: {
                                  opacity: 1,
                                  x: 0
                              },
                              className: "text-white text-base font-medium",
                              children: m.name
                          }), c("div", {
                              className: "flex items-center gap-2",
                              children: a.map(v => c(k.div, {
                                  initial: {
                                      opacity: 0,
                                      scale: 0
                                  },
                                  animate: {
                                      opacity: 1,
                                      scale: 1
                                  },
                                  transition: {
                                      delay: v * .1
                                  },
                                  whileHover: {
                                      scale: 1.2
                                  },
                                  whileTap: {
                                      scale: .9
                                  },
                                  children: v <= m.note ? c(gm, {
                                      className: "text-primary",
                                      size: 20
                                  }) : c(ym, {
                                      className: "text-white/20",
                                      size: 20
                                  })
                              }, v))
                          })]
                      })]
                  }), w(k.p, {
                      initial: {
                          opacity: 0
                      },
                      animate: {
                          opacity: 1
                      },
                      transition: {
                          delay: .3
                      },
                      className: "text-xs text-white/75 font-normal",
                      children: ["Palavra chave: ", c("span", {
                          className: "text-primary uppercase font-medium",
                          children: m.keyword
                      })]
                  }), c(k.div, {
                      initial: {
                          opacity: 0,
                          y: 20
                      },
                      animate: {
                          opacity: 1,
                          y: 0
                      },
                      transition: {
                          delay: .4
                      },
                      className: "w-[17.3125rem] h-[3.375rem] max-h-[3.375rem] overflow-auto",
                      children: c("p", {
                          className: "text-white/50 text-xs font-normal",
                          children: m.description
                      })
                  }), c(k.button, {
                      initial: {
                          opacity: 0,
                          y: 20
                      },
                      animate: {
                          opacity: 1,
                          y: 0
                      },
                      transition: {
                          delay: .5
                      },
                      whileHover: {
                          scale: 1.02
                      },
                      whileTap: {
                          scale: .98
                      },
                      onClick: () => l(m.cds),
                      className: "w-[17.3125rem] h-[2.25rem] rounded border border-white/[.04] bg-gradient-to-r from-primary to-secondary text-white text-xs font-medium",
                      children: "CLIQUE PARA MARCAR NO MAPA"
                  })]
              }, p))
          })
      })]
  })
}
function fx(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 384 512"
      },
      child: [{
          tag: "path",
          attr: {
              d: "M215.7 499.2C267 435 384 279.4 384 192C384 86 298 0 192 0S0 86 0 192c0 87.4 117 243 168.3 307.2c12.3 15.3 35.1 15.3 47.4 0zM192 128a64 64 0 1 1 0 128 64 64 0 1 1 0-128z"
          },
          child: []
      }]
  })(e)
}
function mx() {
  const [e,t] = E.exports.useState("")
    , [n,r] = E.exports.useState(0)
    , [i,o] = E.exports.useState("")
    , [a,s] = E.exports.useState("")
    , [l,u] = E.exports.useState("")
    , [f,d] = E.exports.useState("")
    , m = Array.from({
      length: 5
  }, (y, h) => h + 1)
    , {setOpenedPartnerModal: p, setPartners: v} = oe();
  function x() {
      z("NewPartner", {
          cds: e,
          note: n,
          name: i,
          keyword: l,
          description: f,
          icon: a
      }, []).then(y => {
          v(y),
          p(!1)
      }
      )
  }
  function P() {
      z("GetCDS", {}, "asdadasd").then(t)
  }
  return c("div", {
      className: "w-screen z-10 h-screen bg-black/75 absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2",
      children: w("div", {
          className: "absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 p-6 flex flex-col gap-3 rounded-md border border-primary bg-primary-gradient",
          children: [w("div", {
              className: "flex justify-between gap-5",
              children: [w("div", {
                  children: [c("h3", {
                      className: "text-primary text-[1.125rem] font-semibold",
                      children: "NOVO PARCEIRO"
                  }), c("p", {
                      className: "text-white text-[.625rem] font-normal",
                      children: "Digite as informa\xE7\xF5es da sua nova parceria."
                  })]
              }), c(gr, {
                  size: 20,
                  className: "text-white/30 cursor-pointer",
                  onClick: () => p(!1)
              })]
          }), w("div", {
              className: "flex flex-col gap-3 w-full",
              children: [c("input", {
                  onChange: y => o(y.target.value),
                  className: "outline-none w-full h-10 rounded border border-white/[.04] bg-white/[.04] text-white text-[.8125rem] px-4",
                  type: "text",
                  placeholder: "Nome da fac\xE7\xE3o"
              }), c("input", {
                  onChange: y => s(y.target.value),
                  className: "outline-none w-full h-10 rounded border border-white/[.04] bg-white/[.04] text-white text-[.8125rem] px-4",
                  type: "text",
                  placeholder: "Icone da fac\xE7\xE3o"
              }), c("input", {
                  onChange: y => u(y.target.value),
                  className: "outline-none w-full h-10 rounded border border-white/[.04] bg-white/[.04] text-white text-[.8125rem] px-4",
                  type: "text",
                  placeholder: "Palavra-chave da fac\xE7\xE3o"
              }), c("input", {
                  onChange: y => d(y.target.value),
                  className: "outline-none w-full h-10 rounded border border-white/[.04] bg-white/[.04] text-white text-[.8125rem] px-4",
                  type: "text",
                  placeholder: "Descri\xE7\xE3o"
              }), w("div", {
                  className: "w-full flex items-center gap-3",
                  children: [c("input", {
                      disabled: !0,
                      onChange: y => t(y.target.value),
                      value: e,
                      className: "outline-none w-full h-10 rounded border border-white/[.04] bg-white/[.04] text-white text-[.8125rem] px-4",
                      type: "text",
                      placeholder: "CDS"
                  }), c("div", {
                      onClick: P,
                      className: "w-[3.625rem] h-10 flex items-center justify-center bg-white/[.04] border border-white/[.04] rounded",
                      children: c(fx, {
                          size: 22,
                          className: "text-primary"
                      })
                  })]
              }), w("div", {
                  className: "flex flex-col gap-2",
                  children: [c("p", {
                      className: "text-white text-xs font-normal",
                      children: "Nota da fac\xE7\xE3o"
                  }), c("div", {
                      className: "flex items-center justify-between",
                      children: m.map( (y, h) => y <= n ? c(gm, {
                          className: "text-primary cursor-pointer",
                          size: 20,
                          onClick: () => r(h + 1)
                      }, h) : c(ym, {
                          className: "text-white/20 cursor-pointer",
                          size: 20,
                          onClick: () => r(h + 1)
                      }, h))
                  })]
              })]
          }), c("button", {
              onClick: x,
              className: "w-[21.375rem] text-white text-[.8125rem] font-normal h-10 border border-white/[.15] rounded-[.1875rem] bg-primary",
              children: "SALVAR"
          })]
      })
  })
}
function Fd(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24"
      },
      child: [{
          tag: "path",
          attr: {
              fill: "none",
              d: "M0 0h24v24H0z"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M9 16.17 4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"
          },
          child: []
      }]
  })(e)
}
function hx(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24"
      },
      child: [{
          tag: "path",
          attr: {
              fill: "none",
              d: "M0 0h24v24H0z"
          },
          child: []
      }, {
          tag: "path",
          attr: {
              d: "M19 6.41 17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"
          },
          child: []
      }]
  })(e)
}
function px(e) {
  return $({
      tag: "svg",
      attr: {
          viewBox: "0 0 24 24"
      },
      child: [{
          tag: "g",
          attr: {
              id: "Clock_2"
          },
          child: [{
              tag: "g",
              attr: {},
              child: [{
                  tag: "path",
                  attr: {
                      d: "M12,21.933A9.933,9.933,0,1,1,21.933,12,9.944,9.944,0,0,1,12,21.933ZM12,3.067A8.933,8.933,0,1,0,20.933,12,8.943,8.943,0,0,0,12,3.067Z"
                  },
                  child: []
              }, {
                  tag: "path",
                  attr: {
                      d: "M18,12.5H12a.429.429,0,0,1-.34-.14c-.01,0-.01-.01-.02-.02A.429.429,0,0,1,11.5,12V6a.5.5,0,0,1,1,0v5.5H18A.5.5,0,0,1,18,12.5Z"
                  },
                  child: []
              }]
          }]
      }]
  })(e)
}
function gx() {
  var M;
  const [e,t] = E.exports.useState("")
    , [n,r] = E.exports.useState(0)
    , {setCurrent: i, update: o, goals: a, setGoals: s, permissions: l, setOpenedEditGoal: u, setOpenedNewGoal: f, setTypeNewGoal: d, setMax: m, setTitle: p, setDescription: v, setIndex: x} = oe()
    , P = (M = a == null ? void 0 : a.members) == null ? void 0 : M.filter(A => String(A.id) === e || A.name.toLocaleLowerCase().includes(e.toLocaleLowerCase()));
  function y() {
      !a.my.filter(C => C.needed).every(C => C.current >= C.max) || z("RedeemPrize", {}, !0)
  }
  function h() {
      m(0),
      p(""),
      v(""),
      n === 1 ? u(!0) : f(!0),
      d(n === 1 ? "faction" : "my"),
      x(null)
  }
  function g(A, C) {
      f(!0),
      d(C),
      m(a.faction[A].max),
      p(a.faction[A].title),
      v(a.faction[A].description),
      i(a.faction[A].current),
      x(A)
  }
  function S(A) {
      z("DeleteGoal", {
          goal: a.faction[A]
      }).then(C => o({
          goals: {
              ...a,
              faction: C
          }
      }))
  }
  return E.exports.useEffect( () => {
      z("GetGoals", {}, {
          prize: "money",
          my: [{
              name: "ITEM1",
              item: "test1",
              needed: !0,
              current: 20,
              max: 20
          }, {
              name: "ITEM1",
              item: "test2",
              needed: !1,
              current: 20,
              max: 20
          }, {
              name: "ITEM1",
              item: "test3",
              needed: !0,
              current: 2,
              max: 20
          }],
          faction: [{
              title: "test1",
              description: "testsetstsdscasd",
              current: 10,
              max: 40
          }, {
              title: "test2",
              description: "testsetstsdscasd",
              current: 1,
              max: 50
          }, {
              title: "test3",
              description: "testsetstsdscasd",
              current: 1,
              max: 60
          }, {
              title: "test4",
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
              current: 1,
              max: 10
          }, {
              title: "test5",
              description: "testsetstsdscasd",
              current: 1,
              max: 70
          }],
          members: []
      }).then(s)
  }
  , []),
  w(k.div, {
      initial: {
          opacity: 0
      },
      animate: {
          opacity: 1
      },
      className: "p-4",
      children: [w(k.div, {
          initial: {
              y: -20
          },
          animate: {
              y: 0
          },
          className: "flex items-center gap-4 w-full",
          children: [w("div", {
              className: "flex items-center gap-4 w-full",
              children: [c(k.button, {
                  whileHover: {
                      scale: 1.02
                  },
                  whileTap: {
                      scale: .98
                  },
                  onClick: () => r(0),
                  className: `${n === 0 && "!bg-primary"} w-full h-[2.375rem] border border-white/[.04] bg-white/[.04] text-white text-sm font-medium rounded`,
                  children: "METAS DA FAC\xC7\xC3O"
              }), c(k.button, {
                  whileHover: {
                      scale: 1.02
                  },
                  whileTap: {
                      scale: .98
                  },
                  onClick: () => r(1),
                  className: `${n === 1 && "!bg-primary"} w-full h-[2.375rem] border border-white/[.04] bg-white/[.04] text-white text-sm font-medium rounded`,
                  children: "METAS PESSOAIS"
              }), l.leader && c(k.button, {
                  whileHover: {
                      scale: 1.02
                  },
                  whileTap: {
                      scale: .98
                  },
                  onClick: () => r(2),
                  className: `${n === 2 && "!bg-primary"} w-full h-[2.375rem] border border-white/[.04] bg-white/[.04] text-white text-sm font-medium rounded`,
                  children: "METAS MEMBROS"
              })]
          }), c(k.div, {
              whileHover: {
                  scale: 1.1
              },
              whileTap: {
                  scale: .9
              },
              onClick: h,
              className: "w-[2.375rem] h-[2.375rem] bg-gradient-to-r from-primary to-secondary rounded flex items-center justify-center cursor-pointer",
              children: c(ly, {
                  size: 20,
                  className: "text-white"
              })
          })]
      }), w(wn, {
          mode: "wait",
          children: [n === 0 && c(k.section, {
              initial: {
                  opacity: 0,
                  y: 20
              },
              animate: {
                  opacity: 1,
                  y: 0
              },
              exit: {
                  opacity: 0,
                  y: -20
              },
              className: "mt-4 flex flex-wrap gap-4 w-[59.9375rem] max-h-[25.25rem] overflow-auto",
              children: a.faction.map( (A, C) => w(k.div, {
                  initial: {
                      opacity: 0,
                      scale: .8
                  },
                  animate: {
                      opacity: 1,
                      scale: 1
                  },
                  transition: {
                      delay: C * .1
                  },
                  className: "flex-none w-[19.3125rem] h-[9.875rem] relative",
                  children: [A.current >= A.max && w(k.div, {
                      initial: {
                          scale: 0
                      },
                      animate: {
                          scale: 1
                      },
                      className: "flex items-center justify-center gap-2 absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 z-20",
                      children: [l.leader && c(k.div, {
                          whileHover: {
                              scale: 1.2
                          },
                          children: c(al, {
                              onClick: () => S(C),
                              size: 40,
                              className: "text-primary cursor-pointer"
                          })
                      }), c(Fd, {
                          size: 40,
                          className: "text-primary"
                      })]
                  }), w(k.div, {
                      whileHover: {
                          scale: 1.02
                      },
                      className: `w-full h-full border border-white/[.04] bg-white/[.04] rounded p-4 relative ${A.current === A.max && "opacity-30"}`,
                      children: [w("div", {
                          className: "flex items-center justify-between",
                          children: [w("div", {
                              className: "flex items-center gap-3",
                              children: [c(k.div, {
                                  whileHover: {
                                      rotate: 360
                                  },
                                  transition: {
                                      duration: .5
                                  },
                                  className: "w-[2.25rem] h-[2.25rem] border border-primary bg-gradient-to-r from-primary to-secondary rounded flex items-center justify-center",
                                  children: c(Uo, {
                                      size: 22.4,
                                      className: "text-white"
                                  })
                              }), l.leader && c(k.div, {
                                  whileHover: {
                                      scale: 1.2
                                  },
                                  children: c(fy, {
                                      onClick: () => g(C, "faction"),
                                      size: 20,
                                      className: "text-primary cursor-pointer"
                                  })
                              })]
                          }), w("div", {
                              className: "flex flex-col items-center gap-2",
                              children: [w("p", {
                                  className: "text-primary text-right text-[.6875rem] font-normal",
                                  children: [A.current, "/", A.max]
                              }), l.leader && A.current < A.max && c(k.div, {
                                  whileHover: {
                                      scale: 1.2
                                  },
                                  children: c(al, {
                                      onClick: () => S(C),
                                      size: 16,
                                      className: "text-white/75 cursor-pointer"
                                  })
                              })]
                          })]
                      }), w("div", {
                          className: "mt-3 mb-5",
                          children: [c("h4", {
                              className: "text-white text-[.6875rem] font-medium",
                              children: A.title
                          }), c("p", {
                              className: "text-white/50 text-[.6875rem] font-normal h-[2.125rem] overflow-auto",
                              children: A.description
                          })]
                      }), c("div", {
                          className: "w-full h-[.3125rem] rounded bg-white/5",
                          children: c(k.div, {
                              initial: {
                                  width: 0
                              },
                              animate: {
                                  width: `${A.current / A.max * 100}%`
                              },
                              transition: {
                                  duration: 1
                              },
                              className: "h-full bg-primary rounded"
                          })
                      })]
                  })]
              }, C))
          }), n === 1 && w(k.section, {
              initial: {
                  opacity: 0,
                  y: 20
              },
              animate: {
                  opacity: 1,
                  y: 0
              },
              exit: {
                  opacity: 0,
                  y: -20
              },
              children: [c("div", {
                  className: "mt-4 flex flex-wrap gap-4 w-[59.9375rem] max-h-[21.375rem] h-[21.375rem] content-start overflow-auto",
                  children: a.my.map( (A, C) => w(k.div, {
                      initial: {
                          opacity: 0,
                          x: -50
                      },
                      animate: {
                          opacity: 1,
                          x: 0
                      },
                      transition: {
                          delay: C * .1
                      },
                      className: `px-2 flex items-center justify-between w-[59.9375rem] h-[3.25rem] border border-white/[.04] bg-white/[.04] rounded ${!A.needed && "opacity-20"}`,
                      children: [w("div", {
                          className: "flex items-center gap-3",
                          children: [c(k.div, {
                              whileHover: {
                                  rotate: 360
                              },
                              transition: {
                                  duration: .5
                              },
                              className: "w-[2.25rem] h-[2.25rem] rounded flex items-center justify-center border border-primary bg-gradient-to-r from-primary to-secondary",
                              children: c(Uo, {
                                  size: 22.4,
                                  className: "text-white"
                              })
                          }), c("p", {
                              className: "text-white text-[.8125rem] font-normal",
                              children: A.name
                          })]
                      }), w("div", {
                          className: "flex items-center gap-4",
                          children: [A.current >= A.max && A.needed && c(k.p, {
                              initial: {
                                  scale: 0
                              },
                              animate: {
                                  scale: 1
                              },
                              className: "py-[.375rem] px-6 text-[.8125rem] font-normal text-green-500 bg-green-500/20 rounded",
                              children: "META CONCLUIDA"
                          }), w("p", {
                              className: "py-[.375rem] px-6 text-[.8125rem] font-normal text-white bg-primary rounded",
                              children: [A.needed ? A.current : "--", "/", A.needed ? A.max : "--"]
                          })]
                      })]
                  }, C))
              }), w(k.button, {
                  whileHover: {
                      scale: 1.02
                  },
                  whileTap: {
                      scale: .98
                  },
                  onClick: y,
                  className: "text-white text-sm font-medium w-full h-[2.875rem] bg-primary rounded mt-4",
                  children: ["RESGATAR PAGAMENTO - ", Number(a.prize).toLocaleString("pt-BR", {
                      currency: "BRL",
                      style: "currency"
                  }).replace("BRL ", "R$ ")]
              })]
          }), n === 2 && w(k.section, {
              initial: {
                  opacity: 0,
                  y: 20
              },
              animate: {
                  opacity: 1,
                  y: 0
              },
              exit: {
                  opacity: 0,
                  y: -20
              },
              children: [w("div", {
                  className: "flex items-center justify-between mt-4",
                  children: [w("div", {
                      className: "flex items-center gap-3",
                      children: [c(k.div, {
                          whileHover: {
                              rotate: 360
                          },
                          transition: {
                              duration: .5
                          },
                          className: "w-[2.125rem] h-[2.125rem] flex items-center justify-center bg-gradient-to-r from-primary to-secondary rounded",
                          children: c(my, {
                              size: 20,
                              className: "text-white"
                          })
                      }), c("p", {
                          className: "text-white text-xs font-medium",
                          children: "METAS DE MEMBROS"
                      })]
                  }), c(k.input, {
                      whileFocus: {
                          scale: 1.02
                      },
                      type: "text",
                      onChange: A => t(A.target.value),
                      placeholder: "PESQUISAR NOME OU ID...",
                      className: "outline-none w-[22.8125rem] h-[2.125rem] border border-white/[.04] bg-white/[.04] text-white text-xs font-normal text-center px-4"
                  })]
              }), w("div", {
                  className: "mt-4",
                  children: [w("div", {
                      className: "flex items-center pl-6",
                      children: [c("p", {
                          className: "text-white text-[.625rem] font-normal w-[16.75rem]",
                          children: "Nome"
                      }), c("p", {
                          className: "text-white text-[.625rem] font-normal w-[26rem]",
                          children: "Id"
                      }), w("div", {
                          className: "flex items-center gap-4",
                          children: [c("p", {
                              className: "text-white text-[.625rem] font-normal ",
                              children: "Seg"
                          }), c("p", {
                              className: "text-white text-[.625rem] font-normal ",
                              children: "Ter"
                          }), c("p", {
                              className: "text-white text-[.625rem] font-normal ",
                              children: "Qua"
                          }), c("p", {
                              className: "text-white text-[.625rem] font-normal ",
                              children: "Qui"
                          }), c("p", {
                              className: "text-white text-[.625rem] font-normal ",
                              children: "Sex"
                          }), c("p", {
                              className: "text-white text-[.625rem] font-normal ",
                              children: "Sab"
                          }), c("p", {
                              className: "text-white text-[.625rem] font-normal ",
                              children: "Dom"
                          })]
                      })]
                  }), c("div", {
                      className: "flex flex-col mt-2 gap-2 max-h-[20.6875rem] overflow-auto",
                      children: P.map( (A, C) => w(k.div, {
                          initial: {
                              opacity: 0,
                              x: -50
                          },
                          animate: {
                              opacity: 1,
                              x: 0
                          },
                          transition: {
                              delay: C * .1
                          },
                          whileHover: {
                              scale: 1.01
                          },
                          className: "w-full bg-white/[.04] flex items-center border border-white/[.04] h-10 rounded pl-6 flex-none",
                          children: [c("p", {
                              className: "text-white text-[.6875rem] font-normal w-[16.75rem]",
                              children: A.name
                          }), c("p", {
                              className: "text-white text-[.6875rem] font-normal w-[25.75rem]",
                              children: A.id
                          }), c("div", {
                              className: "flex items-center gap-2",
                              children: A.status.map( (N, R) => c(k.div, {
                                  initial: {
                                      scale: 0
                                  },
                                  animate: {
                                      scale: 1
                                  },
                                  transition: {
                                      delay: R * .1
                                  },
                                  className: `w-[1.625rem] h-[1.625rem] rounded flex items-center justify-center ${N === 1 ? "bg-green-500/30" : N === 2 ? "bg-red-500/30" : "bg-purple-600/30"}`,
                                  children: N === 1 ? c(Fd, {
                                      size: 20,
                                      className: "text-green-500"
                                  }) : N === 2 ? c(hx, {
                                      size: 20,
                                      className: "text-red-500"
                                  }) : c(px, {
                                      size: 20,
                                      className: "text-purple-500"
                                  })
                              }, R))
                          })]
                      }, C))
                  })]
              })]
          })]
      })]
  })
}
function yx() {
  const {setOpenedNewGoal: e, goals: t, update: n, max: r, title: i, description: o, typeNewGoal: a, index: s, current: l, setCurrent: u, setMax: f} = oe();
  return c("div", {
      className: "w-screen z-30 h-screen bg-black/75 absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2",
      children: w("div", {
          className: "absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 p-6 flex flex-col gap-3 rounded-md border border-primary bg-primary-gradient",
          children: [w("div", {
              className: "flex justify-between gap-5",
              children: [c("h3", {
                  className: "text-primary text-[1.125rem] font-semibold",
                  children: s === null ? "NOVA META" : "EDITAR META"
              }), c(gr, {
                  onClick: () => e(!1),
                  size: 20,
                  className: "text-white/30 cursor-pointer"
              })]
          }), w("fieldset", {
              className: "flex flex-col gap-2",
              children: [c("label", {
                  className: "text-white text-[.625rem] font-normal",
                  children: "T\xEDtulo da meta"
              }), c("input", {
                  defaultValue: i,
                  type: "text",
                  onChange: p => n({
                      title: p.target.value
                  }),
                  className: "w-full h-10 rounded border border-white/[.04] bg-white/[.04] outline-none px-4 text-white text-sm font-normal"
              })]
          }), w("fieldset", {
              className: "flex flex-col gap-2",
              children: [c("label", {
                  className: "text-white text-[.625rem] font-normal",
                  children: "Descri\xE7\xE3o"
              }), c("input", {
                  defaultValue: o,
                  type: "text",
                  onChange: p => n({
                      description: p.target.value
                  }),
                  className: "w-full h-10 rounded border border-white/[.04] bg-white/[.04] outline-none px-4 text-white text-sm font-normal"
              })]
          }), w("fieldset", {
              className: "flex flex-col gap-2",
              children: [w("div", {
                  className: "flex items-center justify-between",
                  children: [c("label", {
                      className: "text-white text-[.625rem] font-normal",
                      children: "Quantia da meta"
                  }), s !== null && w("p", {
                      className: "text-white text-[.625rem] font-normal",
                      children: ["(", l, "/", r, ")"]
                  })]
              }), s === null ? c("input", {
                  onChange: p => f(Number(p.target.value)),
                  max: r,
                  min: 1,
                  type: "number",
                  className: "w-full h-10 rounded border border-white/[.04] bg-white/[.04] outline-none px-4 text-white text-sm font-normal"
              }) : c("input", {
                  onChange: p => u(Number(p.target.value)),
                  type: "range",
                  value: l,
                  max: r,
                  name: "",
                  id: ""
              })]
          }), c("button", {
              onClick: s === null ? () => {
                  a === "faction" ? z("NewFactionGoal", {
                      type: a,
                      title: i,
                      description: o,
                      max: r,
                      current: 0
                  }).then(p => {
                      t.faction = p,
                      n({
                          goals: t
                      }),
                      e(!1)
                  }
                  ) : z("NewGoal", {
                      type: a,
                      title: i,
                      description: o,
                      max: r,
                      current: 0
                  }).then(p => {
                      t.faction = p,
                      n({
                          goals: t
                      }),
                      e(!1)
                  }
                  )
              }
              : () => {
                  if (a === "faction") {
                      const p = t.faction;
                      p[s].title = i,
                      p[s].description = o,
                      p[s].max = r,
                      p[s].current = l,
                      n({
                          goals: {
                              ...t,
                              faction: p
                          }
                      }),
                      z("EditFactionGoal", {
                          ...t.faction[s],
                          title: i,
                          description: o,
                          max: r,
                          current: l
                      }).then(v => {
                          e(!1)
                      }
                      )
                  } else {
                      const p = t.my;
                      p[s].name = i,
                      p[s].max = r,
                      n({
                          goals: {
                              ...t,
                              my: p
                          }
                      }),
                      z("EditMyGoal", {
                          ...t.faction[s],
                          title: i,
                          description: o,
                          max: r
                      }).then(v => {
                          e(!1)
                      }
                      )
                  }
              }
              ,
              className: "w-[21.375rem] text-white text-[.8125rem] font-normal h-10 border border-white/[.15] rounded-[.1875rem] bg-primary",
              children: s === null ? "NOVA META" : "EDITAR META"
          })]
      })
  })
}
function vx() {
  const [e,t] = E.exports.useState("")
    , {goals: n, update: r, setOpenedEditGoal: i} = oe();
  function o(u) {
      n.my[u].needed = !n.my[u].needed,
      r({
          goals: n
      })
  }
  const a = E.exports.useCallback( (u, f) => {
      n.my[f].max = u,
      r({
          goals: n
      })
  }
  , [n])
    , s = ({target: u}) => {
      t(u.value),
      r({
          goals: {
              ...n,
              prize: u.value
          }
      })
  }
  ;
  function l() {
      z("EditMyGoal", {
          payment: n.prize,
          items: n.my
      }, n).then( () => {
          i(!1)
      }
      )
  }
  return c("div", {
      className: "w-screen z-10 h-screen bg-black/75 absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2",
      children: w("div", {
          className: "w-[24.375rem] absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 p-6 flex flex-col gap-3 rounded-md border border-primary bg-primary-gradient",
          children: [w("div", {
              className: "flex justify-between gap-5",
              children: [c("h3", {
                  className: "text-primary text-[1.125rem] font-semibold",
                  children: "EDITAR METAS PESSOAIS"
              }), c(gr, {
                  size: 20,
                  className: "text-white/30 cursor-pointer",
                  onClick: () => i(!1)
              })]
          }), n.my.map( (u, f) => w("fieldset", {
              className: "flex flex-col gap-2",
              children: [w("div", {
                  className: "flex items-center justify-between",
                  children: [c("label", {
                      className: "text-white text-[.625rem] font-normal",
                      children: u.name
                  }), c("div", {
                      children: c("div", {
                          onClick: () => o(f),
                          className: `w-8 h-4 relative flex items-center cursor-pointer rounded-[3rem] duration-200 ${u.needed ? "bg-green-500" : "bg-white/30"}`,
                          children: c("span", {
                              className: `absolute bg-white rounded-full w-[.8rem] h-[.8rem] ${u.needed ? "right-[.1rem]" : "right-4"} duration-200`
                          })
                      })
                  })]
              }), c("input", {
                  type: "text",
                  defaultValue: u.max || 0,
                  onChange: ({currentTarget: d}) => a(Number(d.value), f),
                  className: "w-full h-10 rounded border border-white/[.04] bg-white/[.04] outline-none px-4 text-white text-sm font-normal"
              })]
          }, f)), w("div", {
              className: "flex flex-col gap-2",
              children: [c("p", {
                  className: "text-white text-[.625rem] font-normal",
                  children: "Valor do pagamento"
              }), c("input", {
                  onChange: u => s(u),
                  type: "text",
                  className: "w-full h-10 rounded border border-white/[.04] bg-white/[.04] outline-none px-4 text-white text-sm font-normal"
              }), c("p", {
                  className: "text-primary text-[.625rem] font-normal",
                  children: "*O valor do pagamento \xE9 resgatado diretamente do banco da organiza\xE7\xE3o."
              })]
          }), c("button", {
              onClick: l,
              className: "w-[21.375rem] text-white text-[.8125rem] font-normal h-10 border border-white/[.15] rounded-[.1875rem] bg-primary",
              children: "SALVAR META"
          })]
      })
  })
}
function xx() {
  const {modal: e} = ol()
    , {setModal: t} = ol()
    , {setOpenedModal: n, warnings: r, logo: i, openedModal: o, openedPermissionsModal: a, openedPartnerModal: s, openedEditGoal: l, openedNewGoal: u, setWarnings: f, permissions: d} = oe();
  function m() {
      t({
          title: "NOVO AVISO",
          description: "Digite seu novo aviso!",
          placeholder: "AVISO",
          save: v => z("NewWarn", {
              title: v.inputValue,
              message: v.inputValue2
          }, []).then(f)
      }),
      n(!0)
  }
  function p() {
      z("MarkFaction", null, !0)
  }
  return w(L5, {
      children: [o && c(ux, {
          ...e
      }), s && c(mx, {}), a && c(cx, {}), u && c(yx, {}), l && c(vx, {}), c("div", {
          className: wi("w-screen h-screen flex flex-col relative items-center justify-center bg-center bg-cover bg-black/90"),
          children: c("div", {
              className: "max-[800px]:scale-[0.5] max-[1100px]:scale-[0.7] max-[1440px]:scale-[0.8] max-[1600px]:scale-[0.9] max-[1920px]:scale-[1]",
              children: w("div", {
                  className: "flex gap-4",
                  children: [w("div", {
                      className: "border border-white/[.08] w-[20.75rem] h-[44.5rem] flex flex-col items-center pt-10 px-6 bg-primary-gradient",
                      children: [c("div", {
                          className: "w-40 h-40 rounded-full border-2 !bg-cover !bg-center border-primary bg-logo"
                      }), w("div", {
                          className: "flex items-center justify-between w-full mt-[1.19rem]",
                          children: [w("p", {
                              className: "text-white text-xs font-normal flex items-center gap-[.44rem]",
                              children: [c(pm, {
                                  size: 16,
                                  className: "text-primary"
                              }), "AVISOS"]
                          }), w("div", {
                              className: "flex items-center gap-2",
                              children: [c("button", {
                                  onClick: p,
                                  className: "w-7 h-7 bg-gradient-to-r from-primary to-secondary flex items-center justify-center rounded-[0.1875rem]",
                                  children: c(Gh, {
                                      weight: "fill",
                                      color: "white",
                                      size: 16
                                  })
                              }), (d.alerts || d.leader) && c("button", {
                                  onClick: m,
                                  className: "w-7 h-7 bg-gradient-to-r from-primary to-secondary flex items-center justify-center rounded-[0.1875rem]",
                                  children: c(sx, {
                                      color: "white",
                                      size: 16
                                  })
                              })]
                          })]
                      }), c("hr", {
                          className: "w-full h-[0.0625rem] bg-white/[.06] border-none outline-none mt-[.94rem]"
                      }), c(k.div, {
                          initial: {
                              opacity: 0
                          },
                          animate: {
                              opacity: 1
                          },
                          className: "flex flex-col-reverse gap-2 max-h-[26rem] overflow-auto",
                          children: c(wn, {
                              children: r == null ? void 0 : r.map( (v, x) => c(k.div, {
                                  initial: {
                                      opacity: 0,
                                      x: -20
                                  },
                                  animate: {
                                      opacity: 1,
                                      x: 0
                                  },
                                  exit: {
                                      opacity: 0,
                                      x: 20
                                  },
                                  transition: {
                                      delay: x * .1
                                  },
                                  children: c(ep, {
                                      ...v,
                                      index: x,
                                      setWarnings: f
                                  })
                              }, x))
                          })
                      })]
                  }), w("div", {
                      children: [c(Jh, {}), c(qh, {}), c("div", {
                          className: "mb-6 rounded-[0.3125rem] w-[61.875rem] h-[30.625rem] bg-primary-gradient",
                          children: w(v4, {
                              children: [c(mt, {
                                  path: "*",
                                  element: c(pd, {})
                              }), c(mt, {
                                  path: "/home",
                                  element: c(pd, {})
                              }), c(mt, {
                                  path: "/bank",
                                  element: c(J3, {})
                              }), c(mt, {
                                  path: "/goals",
                                  element: c(gx, {})
                              }), c(mt, {
                                  path: "/farms",
                                  element: c(tx, {})
                              }), c(mt, {
                                  path: "/partners",
                                  element: c(dx, {})
                              }), c(mt, {
                                  path: "/registers",
                                  element: c(ax, {})
                              }), c(mt, {
                                  path: "/configuration",
                                  element: c(lx, {})
                              })]
                          })
                      })]
                  })]
              })
          })
      })]
  })
}
var Sl = {}
, _d = Zo.exports;
Sl.createRoot = _d.createRoot,
Sl.hydrateRoot = _d.hydrateRoot;
Sl.createRoot(document.getElementById("root")).render(c(T.StrictMode, {
  children: c(N4, {
      children: c(xx, {})
  })
}));