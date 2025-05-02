function Wd(e, t) {
    for (var n = 0; n < t.length; n++) {
        const r = t[n];
        if (typeof r != "string" && !Array.isArray(r)) {
            for (const l in r)
                if (l !== "default" && !(l in e)) {
                    const s = Object.getOwnPropertyDescriptor(r, l);
                    s && Object.defineProperty(e, l, s.get ? s : {
                        enumerable: !0,
                        get: () => r[l]
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
    for (const l of document.querySelectorAll('link[rel="modulepreload"]'))
        r(l);
    new MutationObserver(l => {
        for (const s of l)
            if (s.type === "childList")
                for (const o of s.addedNodes)
                    o.tagName === "LINK" && o.rel === "modulepreload" && r(o)
    }
    ).observe(document, {
        childList: !0,
        subtree: !0
    });
    function n(l) {
        const s = {};
        return l.integrity && (s.integrity = l.integrity),
        l.referrerPolicy && (s.referrerPolicy = l.referrerPolicy),
        l.crossOrigin === "use-credentials" ? s.credentials = "include" : l.crossOrigin === "anonymous" ? s.credentials = "omit" : s.credentials = "same-origin",
        s
    }
    function r(l) {
        if (l.ep)
            return;
        l.ep = !0;
        const s = n(l);
        fetch(l.href, s)
    }
}
)();
function ou(e) {
    return e && e.__esModule && Object.prototype.hasOwnProperty.call(e, "default") ? e.default : e
}
var au = {
    exports: {}
}
  , Ol = {}
  , uu = {
    exports: {}
}
  , D = {};
/**
 * @license React
 * react.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var Nr = Symbol.for("react.element")
  , Hd = Symbol.for("react.portal")
  , Qd = Symbol.for("react.fragment")
  , Kd = Symbol.for("react.strict_mode")
  , Gd = Symbol.for("react.profiler")
  , Xd = Symbol.for("react.provider")
  , Yd = Symbol.for("react.context")
  , Jd = Symbol.for("react.forward_ref")
  , Zd = Symbol.for("react.suspense")
  , qd = Symbol.for("react.memo")
  , em = Symbol.for("react.lazy")
  , Fo = Symbol.iterator;
function tm(e) {
    return e === null || typeof e != "object" ? null : (e = Fo && e[Fo] || e["@@iterator"],
    typeof e == "function" ? e : null)
}
var cu = {
    isMounted: function() {
        return !1
    },
    enqueueForceUpdate: function() {},
    enqueueReplaceState: function() {},
    enqueueSetState: function() {}
}
  , du = Object.assign
  , mu = {};
function Ln(e, t, n) {
    this.props = e,
    this.context = t,
    this.refs = mu,
    this.updater = n || cu
}
Ln.prototype.isReactComponent = {};
Ln.prototype.setState = function(e, t) {
    if (typeof e != "object" && typeof e != "function" && e != null)
        throw Error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.");
    this.updater.enqueueSetState(this, e, t, "setState")
}
;
Ln.prototype.forceUpdate = function(e) {
    this.updater.enqueueForceUpdate(this, e, "forceUpdate")
}
;
function fu() {}
fu.prototype = Ln.prototype;
function Di(e, t, n) {
    this.props = e,
    this.context = t,
    this.refs = mu,
    this.updater = n || cu
}
var Ii = Di.prototype = new fu;
Ii.constructor = Di;
du(Ii, Ln.prototype);
Ii.isPureReactComponent = !0;
var Do = Array.isArray
  , pu = Object.prototype.hasOwnProperty
  , Ai = {
    current: null
}
  , hu = {
    key: !0,
    ref: !0,
    __self: !0,
    __source: !0
};
function gu(e, t, n) {
    var r, l = {}, s = null, o = null;
    if (t != null)
        for (r in t.ref !== void 0 && (o = t.ref),
        t.key !== void 0 && (s = "" + t.key),
        t)
            pu.call(t, r) && !hu.hasOwnProperty(r) && (l[r] = t[r]);
    var a = arguments.length - 2;
    if (a === 1)
        l.children = n;
    else if (1 < a) {
        for (var u = Array(a), d = 0; d < a; d++)
            u[d] = arguments[d + 2];
        l.children = u
    }
    if (e && e.defaultProps)
        for (r in a = e.defaultProps,
        a)
            l[r] === void 0 && (l[r] = a[r]);
    return {
        $$typeof: Nr,
        type: e,
        key: s,
        ref: o,
        props: l,
        _owner: Ai.current
    }
}
function nm(e, t) {
    return {
        $$typeof: Nr,
        type: e.type,
        key: t,
        ref: e.ref,
        props: e.props,
        _owner: e._owner
    }
}
function Ui(e) {
    return typeof e == "object" && e !== null && e.$$typeof === Nr
}
function rm(e) {
    var t = {
        "=": "=0",
        ":": "=2"
    };
    return "$" + e.replace(/[=:]/g, function(n) {
        return t[n]
    })
}
var Io = /\/+/g;
function is(e, t) {
    return typeof e == "object" && e !== null && e.key != null ? rm("" + e.key) : t.toString(36)
}
function Kr(e, t, n, r, l) {
    var s = typeof e;
    (s === "undefined" || s === "boolean") && (e = null);
    var o = !1;
    if (e === null)
        o = !0;
    else
        switch (s) {
        case "string":
        case "number":
            o = !0;
            break;
        case "object":
            switch (e.$$typeof) {
            case Nr:
            case Hd:
                o = !0
            }
        }
    if (o)
        return o = e,
        l = l(o),
        e = r === "" ? "." + is(o, 0) : r,
        Do(l) ? (n = "",
        e != null && (n = e.replace(Io, "$&/") + "/"),
        Kr(l, t, n, "", function(d) {
            return d
        })) : l != null && (Ui(l) && (l = nm(l, n + (!l.key || o && o.key === l.key ? "" : ("" + l.key).replace(Io, "$&/") + "/") + e)),
        t.push(l)),
        1;
    if (o = 0,
    r = r === "" ? "." : r + ":",
    Do(e))
        for (var a = 0; a < e.length; a++) {
            s = e[a];
            var u = r + is(s, a);
            o += Kr(s, t, n, u, l)
        }
    else if (u = tm(e),
    typeof u == "function")
        for (e = u.call(e),
        a = 0; !(s = e.next()).done; )
            s = s.value,
            u = r + is(s, a++),
            o += Kr(s, t, n, u, l);
    else if (s === "object")
        throw t = String(e),
        Error("Objects are not valid as a React child (found: " + (t === "[object Object]" ? "object with keys {" + Object.keys(e).join(", ") + "}" : t) + "). If you meant to render a collection of children, use an array instead.");
    return o
}
function br(e, t, n) {
    if (e == null)
        return e;
    var r = []
      , l = 0;
    return Kr(e, r, "", "", function(s) {
        return t.call(n, s, l++)
    }),
    r
}
function lm(e) {
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
var he = {
    current: null
}
  , Gr = {
    transition: null
}
  , sm = {
    ReactCurrentDispatcher: he,
    ReactCurrentBatchConfig: Gr,
    ReactCurrentOwner: Ai
};
D.Children = {
    map: br,
    forEach: function(e, t, n) {
        br(e, function() {
            t.apply(this, arguments)
        }, n)
    },
    count: function(e) {
        var t = 0;
        return br(e, function() {
            t++
        }),
        t
    },
    toArray: function(e) {
        return br(e, function(t) {
            return t
        }) || []
    },
    only: function(e) {
        if (!Ui(e))
            throw Error("React.Children.only expected to receive a single React element child.");
        return e
    }
};
D.Component = Ln;
D.Fragment = Qd;
D.Profiler = Gd;
D.PureComponent = Di;
D.StrictMode = Kd;
D.Suspense = Zd;
D.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = sm;
D.cloneElement = function(e, t, n) {
    if (e == null)
        throw Error("React.cloneElement(...): The argument must be a React element, but you passed " + e + ".");
    var r = du({}, e.props)
      , l = e.key
      , s = e.ref
      , o = e._owner;
    if (t != null) {
        if (t.ref !== void 0 && (s = t.ref,
        o = Ai.current),
        t.key !== void 0 && (l = "" + t.key),
        e.type && e.type.defaultProps)
            var a = e.type.defaultProps;
        for (u in t)
            pu.call(t, u) && !hu.hasOwnProperty(u) && (r[u] = t[u] === void 0 && a !== void 0 ? a[u] : t[u])
    }
    var u = arguments.length - 2;
    if (u === 1)
        r.children = n;
    else if (1 < u) {
        a = Array(u);
        for (var d = 0; d < u; d++)
            a[d] = arguments[d + 2];
        r.children = a
    }
    return {
        $$typeof: Nr,
        type: e.type,
        key: l,
        ref: s,
        props: r,
        _owner: o
    }
}
;
D.createContext = function(e) {
    return e = {
        $$typeof: Yd,
        _currentValue: e,
        _currentValue2: e,
        _threadCount: 0,
        Provider: null,
        Consumer: null,
        _defaultValue: null,
        _globalName: null
    },
    e.Provider = {
        $$typeof: Xd,
        _context: e
    },
    e.Consumer = e
}
;
D.createElement = gu;
D.createFactory = function(e) {
    var t = gu.bind(null, e);
    return t.type = e,
    t
}
;
D.createRef = function() {
    return {
        current: null
    }
}
;
D.forwardRef = function(e) {
    return {
        $$typeof: Jd,
        render: e
    }
}
;
D.isValidElement = Ui;
D.lazy = function(e) {
    return {
        $$typeof: em,
        _payload: {
            _status: -1,
            _result: e
        },
        _init: lm
    }
}
;
D.memo = function(e, t) {
    return {
        $$typeof: qd,
        type: e,
        compare: t === void 0 ? null : t
    }
}
;
D.startTransition = function(e) {
    var t = Gr.transition;
    Gr.transition = {};
    try {
        e()
    } finally {
        Gr.transition = t
    }
}
;
D.unstable_act = function() {
    throw Error("act(...) is not supported in production builds of React.")
}
;
D.useCallback = function(e, t) {
    return he.current.useCallback(e, t)
}
;
D.useContext = function(e) {
    return he.current.useContext(e)
}
;
D.useDebugValue = function() {}
;
D.useDeferredValue = function(e) {
    return he.current.useDeferredValue(e)
}
;
D.useEffect = function(e, t) {
    return he.current.useEffect(e, t)
}
;
D.useId = function() {
    return he.current.useId()
}
;
D.useImperativeHandle = function(e, t, n) {
    return he.current.useImperativeHandle(e, t, n)
}
;
D.useInsertionEffect = function(e, t) {
    return he.current.useInsertionEffect(e, t)
}
;
D.useLayoutEffect = function(e, t) {
    return he.current.useLayoutEffect(e, t)
}
;
D.useMemo = function(e, t) {
    return he.current.useMemo(e, t)
}
;
D.useReducer = function(e, t, n) {
    return he.current.useReducer(e, t, n)
}
;
D.useRef = function(e) {
    return he.current.useRef(e)
}
;
D.useState = function(e) {
    return he.current.useState(e)
}
;
D.useSyncExternalStore = function(e, t, n) {
    return he.current.useSyncExternalStore(e, t, n)
}
;
D.useTransition = function() {
    return he.current.useTransition()
}
;
D.version = "18.2.0";
uu.exports = D;
var v = uu.exports;
const Je = ou(v)
  , im = Wd({
    __proto__: null,
    default: Je
}, [v]);
/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var om = v
  , am = Symbol.for("react.element")
  , um = Symbol.for("react.fragment")
  , cm = Object.prototype.hasOwnProperty
  , dm = om.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner
  , mm = {
    key: !0,
    ref: !0,
    __self: !0,
    __source: !0
};
function xu(e, t, n) {
    var r, l = {}, s = null, o = null;
    n !== void 0 && (s = "" + n),
    t.key !== void 0 && (s = "" + t.key),
    t.ref !== void 0 && (o = t.ref);
    for (r in t)
        cm.call(t, r) && !mm.hasOwnProperty(r) && (l[r] = t[r]);
    if (e && e.defaultProps)
        for (r in t = e.defaultProps,
        t)
            l[r] === void 0 && (l[r] = t[r]);
    return {
        $$typeof: am,
        type: e,
        key: s,
        ref: o,
        props: l,
        _owner: dm.current
    }
}
Ol.Fragment = um;
Ol.jsx = xu;
Ol.jsxs = xu;
au.exports = Ol;
var i = au.exports
  , Ds = {}
  , vu = {
    exports: {}
}
  , be = {}
  , yu = {
    exports: {}
}
  , wu = {};
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
    function t(_, z) {
        var T = _.length;
        _.push(z);
        e: for (; 0 < T; ) {
            var R = T - 1 >>> 1
              , O = _[R];
            if (0 < l(O, z))
                _[R] = z,
                _[T] = O,
                T = R;
            else
                break e
        }
    }
    function n(_) {
        return _.length === 0 ? null : _[0]
    }
    function r(_) {
        if (_.length === 0)
            return null;
        var z = _[0]
          , T = _.pop();
        if (T !== z) {
            _[0] = T;
            e: for (var R = 0, O = _.length, st = O >>> 1; R < st; ) {
                var He = 2 * (R + 1) - 1
                  , nn = _[He]
                  , Qe = He + 1
                  , At = _[Qe];
                if (0 > l(nn, T))
                    Qe < O && 0 > l(At, nn) ? (_[R] = At,
                    _[Qe] = T,
                    R = Qe) : (_[R] = nn,
                    _[He] = T,
                    R = He);
                else if (Qe < O && 0 > l(At, T))
                    _[R] = At,
                    _[Qe] = T,
                    R = Qe;
                else
                    break e
            }
        }
        return z
    }
    function l(_, z) {
        var T = _.sortIndex - z.sortIndex;
        return T !== 0 ? T : _.id - z.id
    }
    if (typeof performance == "object" && typeof performance.now == "function") {
        var s = performance;
        e.unstable_now = function() {
            return s.now()
        }
    } else {
        var o = Date
          , a = o.now();
        e.unstable_now = function() {
            return o.now() - a
        }
    }
    var u = []
      , d = []
      , p = 1
      , c = null
      , m = 3
      , x = !1
      , y = !1
      , w = !1
      , j = typeof setTimeout == "function" ? setTimeout : null
      , h = typeof clearTimeout == "function" ? clearTimeout : null
      , f = typeof setImmediate < "u" ? setImmediate : null;
    typeof navigator < "u" && navigator.scheduling !== void 0 && navigator.scheduling.isInputPending !== void 0 && navigator.scheduling.isInputPending.bind(navigator.scheduling);
    function g(_) {
        for (var z = n(d); z !== null; ) {
            if (z.callback === null)
                r(d);
            else if (z.startTime <= _)
                r(d),
                z.sortIndex = z.expirationTime,
                t(u, z);
            else
                break;
            z = n(d)
        }
    }
    function N(_) {
        if (w = !1,
        g(_),
        !y)
            if (n(u) !== null)
                y = !0,
                rt(E);
            else {
                var z = n(d);
                z !== null && lt(N, z.startTime - _)
            }
    }
    function E(_, z) {
        y = !1,
        w && (w = !1,
        h(C),
        C = -1),
        x = !0;
        var T = m;
        try {
            for (g(z),
            c = n(u); c !== null && (!(c.expirationTime > z) || _ && !M()); ) {
                var R = c.callback;
                if (typeof R == "function") {
                    c.callback = null,
                    m = c.priorityLevel;
                    var O = R(c.expirationTime <= z);
                    z = e.unstable_now(),
                    typeof O == "function" ? c.callback = O : c === n(u) && r(u),
                    g(z)
                } else
                    r(u);
                c = n(u)
            }
            if (c !== null)
                var st = !0;
            else {
                var He = n(d);
                He !== null && lt(N, He.startTime - z),
                st = !1
            }
            return st
        } finally {
            c = null,
            m = T,
            x = !1
        }
    }
    var b = !1
      , k = null
      , C = -1
      , I = 5
      , L = -1;
    function M() {
        return !(e.unstable_now() - L < I)
    }
    function K() {
        if (k !== null) {
            var _ = e.unstable_now();
            L = _;
            var z = !0;
            try {
                z = k(!0, _)
            } finally {
                z ? je() : (b = !1,
                k = null)
            }
        } else
            b = !1
    }
    var je;
    if (typeof f == "function")
        je = function() {
            f(K)
        }
        ;
    else if (typeof MessageChannel < "u") {
        var We = new MessageChannel
          , It = We.port2;
        We.port1.onmessage = K,
        je = function() {
            It.postMessage(null)
        }
    } else
        je = function() {
            j(K, 0)
        }
        ;
    function rt(_) {
        k = _,
        b || (b = !0,
        je())
    }
    function lt(_, z) {
        C = j(function() {
            _(e.unstable_now())
        }, z)
    }
    e.unstable_IdlePriority = 5,
    e.unstable_ImmediatePriority = 1,
    e.unstable_LowPriority = 4,
    e.unstable_NormalPriority = 3,
    e.unstable_Profiling = null,
    e.unstable_UserBlockingPriority = 2,
    e.unstable_cancelCallback = function(_) {
        _.callback = null
    }
    ,
    e.unstable_continueExecution = function() {
        y || x || (y = !0,
        rt(E))
    }
    ,
    e.unstable_forceFrameRate = function(_) {
        0 > _ || 125 < _ ? console.error("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported") : I = 0 < _ ? Math.floor(1e3 / _) : 5
    }
    ,
    e.unstable_getCurrentPriorityLevel = function() {
        return m
    }
    ,
    e.unstable_getFirstCallbackNode = function() {
        return n(u)
    }
    ,
    e.unstable_next = function(_) {
        switch (m) {
        case 1:
        case 2:
        case 3:
            var z = 3;
            break;
        default:
            z = m
        }
        var T = m;
        m = z;
        try {
            return _()
        } finally {
            m = T
        }
    }
    ,
    e.unstable_pauseExecution = function() {}
    ,
    e.unstable_requestPaint = function() {}
    ,
    e.unstable_runWithPriority = function(_, z) {
        switch (_) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            break;
        default:
            _ = 3
        }
        var T = m;
        m = _;
        try {
            return z()
        } finally {
            m = T
        }
    }
    ,
    e.unstable_scheduleCallback = function(_, z, T) {
        var R = e.unstable_now();
        switch (typeof T == "object" && T !== null ? (T = T.delay,
        T = typeof T == "number" && 0 < T ? R + T : R) : T = R,
        _) {
        case 1:
            var O = -1;
            break;
        case 2:
            O = 250;
            break;
        case 5:
            O = 1073741823;
            break;
        case 4:
            O = 1e4;
            break;
        default:
            O = 5e3
        }
        return O = T + O,
        _ = {
            id: p++,
            callback: z,
            priorityLevel: _,
            startTime: T,
            expirationTime: O,
            sortIndex: -1
        },
        T > R ? (_.sortIndex = T,
        t(d, _),
        n(u) === null && _ === n(d) && (w ? (h(C),
        C = -1) : w = !0,
        lt(N, T - R))) : (_.sortIndex = O,
        t(u, _),
        y || x || (y = !0,
        rt(E))),
        _
    }
    ,
    e.unstable_shouldYield = M,
    e.unstable_wrapCallback = function(_) {
        var z = m;
        return function() {
            var T = m;
            m = z;
            try {
                return _.apply(this, arguments)
            } finally {
                m = T
            }
        }
    }
}
)(wu);
yu.exports = wu;
var fm = yu.exports;
/**
 * @license React
 * react-dom.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var Nu = v
  , Ce = fm;
function S(e) {
    for (var t = "https://reactjs.org/docs/error-decoder.html?invariant=" + e, n = 1; n < arguments.length; n++)
        t += "&args[]=" + encodeURIComponent(arguments[n]);
    return "Minified React error #" + e + "; visit " + t + " for the full message or use the non-minified dev environment for full errors and additional helpful warnings."
}
var ju = new Set
  , nr = {};
function Zt(e, t) {
    Sn(e, t),
    Sn(e + "Capture", t)
}
function Sn(e, t) {
    for (nr[e] = t,
    e = 0; e < t.length; e++)
        ju.add(t[e])
}
var dt = !(typeof window > "u" || typeof window.document > "u" || typeof window.document.createElement > "u")
  , Is = Object.prototype.hasOwnProperty
  , pm = /^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/
  , Ao = {}
  , Uo = {};
function hm(e) {
    return Is.call(Uo, e) ? !0 : Is.call(Ao, e) ? !1 : pm.test(e) ? Uo[e] = !0 : (Ao[e] = !0,
    !1)
}
function gm(e, t, n, r) {
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
function xm(e, t, n, r) {
    if (t === null || typeof t > "u" || gm(e, t, n, r))
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
function ge(e, t, n, r, l, s, o) {
    this.acceptsBooleans = t === 2 || t === 3 || t === 4,
    this.attributeName = r,
    this.attributeNamespace = l,
    this.mustUseProperty = n,
    this.propertyName = e,
    this.type = t,
    this.sanitizeURL = s,
    this.removeEmptyString = o
}
var ae = {};
"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style".split(" ").forEach(function(e) {
    ae[e] = new ge(e,0,!1,e,null,!1,!1)
});
[["acceptCharset", "accept-charset"], ["className", "class"], ["htmlFor", "for"], ["httpEquiv", "http-equiv"]].forEach(function(e) {
    var t = e[0];
    ae[t] = new ge(t,1,!1,e[1],null,!1,!1)
});
["contentEditable", "draggable", "spellCheck", "value"].forEach(function(e) {
    ae[e] = new ge(e,2,!1,e.toLowerCase(),null,!1,!1)
});
["autoReverse", "externalResourcesRequired", "focusable", "preserveAlpha"].forEach(function(e) {
    ae[e] = new ge(e,2,!1,e,null,!1,!1)
});
"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope".split(" ").forEach(function(e) {
    ae[e] = new ge(e,3,!1,e.toLowerCase(),null,!1,!1)
});
["checked", "multiple", "muted", "selected"].forEach(function(e) {
    ae[e] = new ge(e,3,!0,e,null,!1,!1)
});
["capture", "download"].forEach(function(e) {
    ae[e] = new ge(e,4,!1,e,null,!1,!1)
});
["cols", "rows", "size", "span"].forEach(function(e) {
    ae[e] = new ge(e,6,!1,e,null,!1,!1)
});
["rowSpan", "start"].forEach(function(e) {
    ae[e] = new ge(e,5,!1,e.toLowerCase(),null,!1,!1)
});
var Mi = /[\-:]([a-z])/g;
function $i(e) {
    return e[1].toUpperCase()
}
"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height".split(" ").forEach(function(e) {
    var t = e.replace(Mi, $i);
    ae[t] = new ge(t,1,!1,e,null,!1,!1)
});
"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type".split(" ").forEach(function(e) {
    var t = e.replace(Mi, $i);
    ae[t] = new ge(t,1,!1,e,"http://www.w3.org/1999/xlink",!1,!1)
});
["xml:base", "xml:lang", "xml:space"].forEach(function(e) {
    var t = e.replace(Mi, $i);
    ae[t] = new ge(t,1,!1,e,"http://www.w3.org/XML/1998/namespace",!1,!1)
});
["tabIndex", "crossOrigin"].forEach(function(e) {
    ae[e] = new ge(e,1,!1,e.toLowerCase(),null,!1,!1)
});
ae.xlinkHref = new ge("xlinkHref",1,!1,"xlink:href","http://www.w3.org/1999/xlink",!0,!1);
["src", "href", "action", "formAction"].forEach(function(e) {
    ae[e] = new ge(e,1,!1,e.toLowerCase(),null,!0,!0)
});
function Bi(e, t, n, r) {
    var l = ae.hasOwnProperty(t) ? ae[t] : null;
    (l !== null ? l.type !== 0 : r || !(2 < t.length) || t[0] !== "o" && t[0] !== "O" || t[1] !== "n" && t[1] !== "N") && (xm(t, n, l, r) && (n = null),
    r || l === null ? hm(t) && (n === null ? e.removeAttribute(t) : e.setAttribute(t, "" + n)) : l.mustUseProperty ? e[l.propertyName] = n === null ? l.type === 3 ? !1 : "" : n : (t = l.attributeName,
    r = l.attributeNamespace,
    n === null ? e.removeAttribute(t) : (l = l.type,
    n = l === 3 || l === 4 && n === !0 ? "" : "" + n,
    r ? e.setAttributeNS(r, t, n) : e.setAttribute(t, n))))
}
var ht = Nu.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED
  , _r = Symbol.for("react.element")
  , ln = Symbol.for("react.portal")
  , sn = Symbol.for("react.fragment")
  , Vi = Symbol.for("react.strict_mode")
  , As = Symbol.for("react.profiler")
  , Su = Symbol.for("react.provider")
  , ku = Symbol.for("react.context")
  , Wi = Symbol.for("react.forward_ref")
  , Us = Symbol.for("react.suspense")
  , Ms = Symbol.for("react.suspense_list")
  , Hi = Symbol.for("react.memo")
  , xt = Symbol.for("react.lazy")
  , Eu = Symbol.for("react.offscreen")
  , Mo = Symbol.iterator;
function Fn(e) {
    return e === null || typeof e != "object" ? null : (e = Mo && e[Mo] || e["@@iterator"],
    typeof e == "function" ? e : null)
}
var Y = Object.assign, os;
function Vn(e) {
    if (os === void 0)
        try {
            throw Error()
        } catch (n) {
            var t = n.stack.trim().match(/\n( *(at )?)/);
            os = t && t[1] || ""
        }
    return `
` + os + e
}
var as = !1;
function us(e, t) {
    if (!e || as)
        return "";
    as = !0;
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
                } catch (d) {
                    var r = d
                }
                Reflect.construct(e, [], t)
            } else {
                try {
                    t.call()
                } catch (d) {
                    r = d
                }
                e.call(t.prototype)
            }
        else {
            try {
                throw Error()
            } catch (d) {
                r = d
            }
            e()
        }
    } catch (d) {
        if (d && r && typeof d.stack == "string") {
            for (var l = d.stack.split(`
`), s = r.stack.split(`
`), o = l.length - 1, a = s.length - 1; 1 <= o && 0 <= a && l[o] !== s[a]; )
                a--;
            for (; 1 <= o && 0 <= a; o--,
            a--)
                if (l[o] !== s[a]) {
                    if (o !== 1 || a !== 1)
                        do
                            if (o--,
                            a--,
                            0 > a || l[o] !== s[a]) {
                                var u = `
` + l[o].replace(" at new ", " at ");
                                return e.displayName && u.includes("<anonymous>") && (u = u.replace("<anonymous>", e.displayName)),
                                u
                            }
                        while (1 <= o && 0 <= a);
                    break
                }
        }
    } finally {
        as = !1,
        Error.prepareStackTrace = n
    }
    return (e = e ? e.displayName || e.name : "") ? Vn(e) : ""
}
function vm(e) {
    switch (e.tag) {
    case 5:
        return Vn(e.type);
    case 16:
        return Vn("Lazy");
    case 13:
        return Vn("Suspense");
    case 19:
        return Vn("SuspenseList");
    case 0:
    case 2:
    case 15:
        return e = us(e.type, !1),
        e;
    case 11:
        return e = us(e.type.render, !1),
        e;
    case 1:
        return e = us(e.type, !0),
        e;
    default:
        return ""
    }
}
function $s(e) {
    if (e == null)
        return null;
    if (typeof e == "function")
        return e.displayName || e.name || null;
    if (typeof e == "string")
        return e;
    switch (e) {
    case sn:
        return "Fragment";
    case ln:
        return "Portal";
    case As:
        return "Profiler";
    case Vi:
        return "StrictMode";
    case Us:
        return "Suspense";
    case Ms:
        return "SuspenseList"
    }
    if (typeof e == "object")
        switch (e.$$typeof) {
        case ku:
            return (e.displayName || "Context") + ".Consumer";
        case Su:
            return (e._context.displayName || "Context") + ".Provider";
        case Wi:
            var t = e.render;
            return e = e.displayName,
            e || (e = t.displayName || t.name || "",
            e = e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef"),
            e;
        case Hi:
            return t = e.displayName || null,
            t !== null ? t : $s(e.type) || "Memo";
        case xt:
            t = e._payload,
            e = e._init;
            try {
                return $s(e(t))
            } catch {}
        }
    return null
}
function ym(e) {
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
        return $s(t);
    case 8:
        return t === Vi ? "StrictMode" : "Mode";
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
function zt(e) {
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
function Cu(e) {
    var t = e.type;
    return (e = e.nodeName) && e.toLowerCase() === "input" && (t === "checkbox" || t === "radio")
}
function wm(e) {
    var t = Cu(e) ? "checked" : "value"
      , n = Object.getOwnPropertyDescriptor(e.constructor.prototype, t)
      , r = "" + e[t];
    if (!e.hasOwnProperty(t) && typeof n < "u" && typeof n.get == "function" && typeof n.set == "function") {
        var l = n.get
          , s = n.set;
        return Object.defineProperty(e, t, {
            configurable: !0,
            get: function() {
                return l.call(this)
            },
            set: function(o) {
                r = "" + o,
                s.call(this, o)
            }
        }),
        Object.defineProperty(e, t, {
            enumerable: n.enumerable
        }),
        {
            getValue: function() {
                return r
            },
            setValue: function(o) {
                r = "" + o
            },
            stopTracking: function() {
                e._valueTracker = null,
                delete e[t]
            }
        }
    }
}
function Pr(e) {
    e._valueTracker || (e._valueTracker = wm(e))
}
function bu(e) {
    if (!e)
        return !1;
    var t = e._valueTracker;
    if (!t)
        return !0;
    var n = t.getValue()
      , r = "";
    return e && (r = Cu(e) ? e.checked ? "true" : "false" : e.value),
    e = r,
    e !== n ? (t.setValue(e),
    !0) : !1
}
function il(e) {
    if (e = e || (typeof document < "u" ? document : void 0),
    typeof e > "u")
        return null;
    try {
        return e.activeElement || e.body
    } catch {
        return e.body
    }
}
function Bs(e, t) {
    var n = t.checked;
    return Y({}, t, {
        defaultChecked: void 0,
        defaultValue: void 0,
        value: void 0,
        checked: n ?? e._wrapperState.initialChecked
    })
}
function $o(e, t) {
    var n = t.defaultValue == null ? "" : t.defaultValue
      , r = t.checked != null ? t.checked : t.defaultChecked;
    n = zt(t.value != null ? t.value : n),
    e._wrapperState = {
        initialChecked: r,
        initialValue: n,
        controlled: t.type === "checkbox" || t.type === "radio" ? t.checked != null : t.value != null
    }
}
function _u(e, t) {
    t = t.checked,
    t != null && Bi(e, "checked", t, !1)
}
function Vs(e, t) {
    _u(e, t);
    var n = zt(t.value)
      , r = t.type;
    if (n != null)
        r === "number" ? (n === 0 && e.value === "" || e.value != n) && (e.value = "" + n) : e.value !== "" + n && (e.value = "" + n);
    else if (r === "submit" || r === "reset") {
        e.removeAttribute("value");
        return
    }
    t.hasOwnProperty("value") ? Ws(e, t.type, n) : t.hasOwnProperty("defaultValue") && Ws(e, t.type, zt(t.defaultValue)),
    t.checked == null && t.defaultChecked != null && (e.defaultChecked = !!t.defaultChecked)
}
function Bo(e, t, n) {
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
function Ws(e, t, n) {
    (t !== "number" || il(e.ownerDocument) !== e) && (n == null ? e.defaultValue = "" + e._wrapperState.initialValue : e.defaultValue !== "" + n && (e.defaultValue = "" + n))
}
var Wn = Array.isArray;
function xn(e, t, n, r) {
    if (e = e.options,
    t) {
        t = {};
        for (var l = 0; l < n.length; l++)
            t["$" + n[l]] = !0;
        for (n = 0; n < e.length; n++)
            l = t.hasOwnProperty("$" + e[n].value),
            e[n].selected !== l && (e[n].selected = l),
            l && r && (e[n].defaultSelected = !0)
    } else {
        for (n = "" + zt(n),
        t = null,
        l = 0; l < e.length; l++) {
            if (e[l].value === n) {
                e[l].selected = !0,
                r && (e[l].defaultSelected = !0);
                return
            }
            t !== null || e[l].disabled || (t = e[l])
        }
        t !== null && (t.selected = !0)
    }
}
function Hs(e, t) {
    if (t.dangerouslySetInnerHTML != null)
        throw Error(S(91));
    return Y({}, t, {
        value: void 0,
        defaultValue: void 0,
        children: "" + e._wrapperState.initialValue
    })
}
function Vo(e, t) {
    var n = t.value;
    if (n == null) {
        if (n = t.children,
        t = t.defaultValue,
        n != null) {
            if (t != null)
                throw Error(S(92));
            if (Wn(n)) {
                if (1 < n.length)
                    throw Error(S(93));
                n = n[0]
            }
            t = n
        }
        t == null && (t = ""),
        n = t
    }
    e._wrapperState = {
        initialValue: zt(n)
    }
}
function Pu(e, t) {
    var n = zt(t.value)
      , r = zt(t.defaultValue);
    n != null && (n = "" + n,
    n !== e.value && (e.value = n),
    t.defaultValue == null && e.defaultValue !== n && (e.defaultValue = n)),
    r != null && (e.defaultValue = "" + r)
}
function Wo(e) {
    var t = e.textContent;
    t === e._wrapperState.initialValue && t !== "" && t !== null && (e.value = t)
}
function Ru(e) {
    switch (e) {
    case "svg":
        return "http://www.w3.org/2000/svg";
    case "math":
        return "http://www.w3.org/1998/Math/MathML";
    default:
        return "http://www.w3.org/1999/xhtml"
    }
}
function Qs(e, t) {
    return e == null || e === "http://www.w3.org/1999/xhtml" ? Ru(t) : e === "http://www.w3.org/2000/svg" && t === "foreignObject" ? "http://www.w3.org/1999/xhtml" : e
}
var Rr, Lu = function(e) {
    return typeof MSApp < "u" && MSApp.execUnsafeLocalFunction ? function(t, n, r, l) {
        MSApp.execUnsafeLocalFunction(function() {
            return e(t, n, r, l)
        })
    }
    : e
}(function(e, t) {
    if (e.namespaceURI !== "http://www.w3.org/2000/svg" || "innerHTML"in e)
        e.innerHTML = t;
    else {
        for (Rr = Rr || document.createElement("div"),
        Rr.innerHTML = "<svg>" + t.valueOf().toString() + "</svg>",
        t = Rr.firstChild; e.firstChild; )
            e.removeChild(e.firstChild);
        for (; t.firstChild; )
            e.appendChild(t.firstChild)
    }
});
function rr(e, t) {
    if (t) {
        var n = e.firstChild;
        if (n && n === e.lastChild && n.nodeType === 3) {
            n.nodeValue = t;
            return
        }
    }
    e.textContent = t
}
var Kn = {
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
  , Nm = ["Webkit", "ms", "Moz", "O"];
Object.keys(Kn).forEach(function(e) {
    Nm.forEach(function(t) {
        t = t + e.charAt(0).toUpperCase() + e.substring(1),
        Kn[t] = Kn[e]
    })
});
function zu(e, t, n) {
    return t == null || typeof t == "boolean" || t === "" ? "" : n || typeof t != "number" || t === 0 || Kn.hasOwnProperty(e) && Kn[e] ? ("" + t).trim() : t + "px"
}
function Tu(e, t) {
    e = e.style;
    for (var n in t)
        if (t.hasOwnProperty(n)) {
            var r = n.indexOf("--") === 0
              , l = zu(n, t[n], r);
            n === "float" && (n = "cssFloat"),
            r ? e.setProperty(n, l) : e[n] = l
        }
}
var jm = Y({
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
function Ks(e, t) {
    if (t) {
        if (jm[e] && (t.children != null || t.dangerouslySetInnerHTML != null))
            throw Error(S(137, e));
        if (t.dangerouslySetInnerHTML != null) {
            if (t.children != null)
                throw Error(S(60));
            if (typeof t.dangerouslySetInnerHTML != "object" || !("__html"in t.dangerouslySetInnerHTML))
                throw Error(S(61))
        }
        if (t.style != null && typeof t.style != "object")
            throw Error(S(62))
    }
}
function Gs(e, t) {
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
var Xs = null;
function Qi(e) {
    return e = e.target || e.srcElement || window,
    e.correspondingUseElement && (e = e.correspondingUseElement),
    e.nodeType === 3 ? e.parentNode : e
}
var Ys = null
  , vn = null
  , yn = null;
function Ho(e) {
    if (e = kr(e)) {
        if (typeof Ys != "function")
            throw Error(S(280));
        var t = e.stateNode;
        t && (t = Ul(t),
        Ys(e.stateNode, e.type, t))
    }
}
function Ou(e) {
    vn ? yn ? yn.push(e) : yn = [e] : vn = e
}
function Fu() {
    if (vn) {
        var e = vn
          , t = yn;
        if (yn = vn = null,
        Ho(e),
        t)
            for (e = 0; e < t.length; e++)
                Ho(t[e])
    }
}
function Du(e, t) {
    return e(t)
}
function Iu() {}
var cs = !1;
function Au(e, t, n) {
    if (cs)
        return e(t, n);
    cs = !0;
    try {
        return Du(e, t, n)
    } finally {
        cs = !1,
        (vn !== null || yn !== null) && (Iu(),
        Fu())
    }
}
function lr(e, t) {
    var n = e.stateNode;
    if (n === null)
        return null;
    var r = Ul(n);
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
        throw Error(S(231, t, typeof n));
    return n
}
var Js = !1;
if (dt)
    try {
        var Dn = {};
        Object.defineProperty(Dn, "passive", {
            get: function() {
                Js = !0
            }
        }),
        window.addEventListener("test", Dn, Dn),
        window.removeEventListener("test", Dn, Dn)
    } catch {
        Js = !1
    }
function Sm(e, t, n, r, l, s, o, a, u) {
    var d = Array.prototype.slice.call(arguments, 3);
    try {
        t.apply(n, d)
    } catch (p) {
        this.onError(p)
    }
}
var Gn = !1
  , ol = null
  , al = !1
  , Zs = null
  , km = {
    onError: function(e) {
        Gn = !0,
        ol = e
    }
};
function Em(e, t, n, r, l, s, o, a, u) {
    Gn = !1,
    ol = null,
    Sm.apply(km, arguments)
}
function Cm(e, t, n, r, l, s, o, a, u) {
    if (Em.apply(this, arguments),
    Gn) {
        if (Gn) {
            var d = ol;
            Gn = !1,
            ol = null
        } else
            throw Error(S(198));
        al || (al = !0,
        Zs = d)
    }
}
function qt(e) {
    var t = e
      , n = e;
    if (e.alternate)
        for (; t.return; )
            t = t.return;
    else {
        e = t;
        do
            t = e,
            t.flags & 4098 && (n = t.return),
            e = t.return;
        while (e)
    }
    return t.tag === 3 ? n : null
}
function Uu(e) {
    if (e.tag === 13) {
        var t = e.memoizedState;
        if (t === null && (e = e.alternate,
        e !== null && (t = e.memoizedState)),
        t !== null)
            return t.dehydrated
    }
    return null
}
function Qo(e) {
    if (qt(e) !== e)
        throw Error(S(188))
}
function bm(e) {
    var t = e.alternate;
    if (!t) {
        if (t = qt(e),
        t === null)
            throw Error(S(188));
        return t !== e ? null : e
    }
    for (var n = e, r = t; ; ) {
        var l = n.return;
        if (l === null)
            break;
        var s = l.alternate;
        if (s === null) {
            if (r = l.return,
            r !== null) {
                n = r;
                continue
            }
            break
        }
        if (l.child === s.child) {
            for (s = l.child; s; ) {
                if (s === n)
                    return Qo(l),
                    e;
                if (s === r)
                    return Qo(l),
                    t;
                s = s.sibling
            }
            throw Error(S(188))
        }
        if (n.return !== r.return)
            n = l,
            r = s;
        else {
            for (var o = !1, a = l.child; a; ) {
                if (a === n) {
                    o = !0,
                    n = l,
                    r = s;
                    break
                }
                if (a === r) {
                    o = !0,
                    r = l,
                    n = s;
                    break
                }
                a = a.sibling
            }
            if (!o) {
                for (a = s.child; a; ) {
                    if (a === n) {
                        o = !0,
                        n = s,
                        r = l;
                        break
                    }
                    if (a === r) {
                        o = !0,
                        r = s,
                        n = l;
                        break
                    }
                    a = a.sibling
                }
                if (!o)
                    throw Error(S(189))
            }
        }
        if (n.alternate !== r)
            throw Error(S(190))
    }
    if (n.tag !== 3)
        throw Error(S(188));
    return n.stateNode.current === n ? e : t
}
function Mu(e) {
    return e = bm(e),
    e !== null ? $u(e) : null
}
function $u(e) {
    if (e.tag === 5 || e.tag === 6)
        return e;
    for (e = e.child; e !== null; ) {
        var t = $u(e);
        if (t !== null)
            return t;
        e = e.sibling
    }
    return null
}
var Bu = Ce.unstable_scheduleCallback
  , Ko = Ce.unstable_cancelCallback
  , _m = Ce.unstable_shouldYield
  , Pm = Ce.unstable_requestPaint
  , Z = Ce.unstable_now
  , Rm = Ce.unstable_getCurrentPriorityLevel
  , Ki = Ce.unstable_ImmediatePriority
  , Vu = Ce.unstable_UserBlockingPriority
  , ul = Ce.unstable_NormalPriority
  , Lm = Ce.unstable_LowPriority
  , Wu = Ce.unstable_IdlePriority
  , Fl = null
  , Ze = null;
function zm(e) {
    if (Ze && typeof Ze.onCommitFiberRoot == "function")
        try {
            Ze.onCommitFiberRoot(Fl, e, void 0, (e.current.flags & 128) === 128)
        } catch {}
}
var $e = Math.clz32 ? Math.clz32 : Fm
  , Tm = Math.log
  , Om = Math.LN2;
function Fm(e) {
    return e >>>= 0,
    e === 0 ? 32 : 31 - (Tm(e) / Om | 0) | 0
}
var Lr = 64
  , zr = 4194304;
function Hn(e) {
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
function cl(e, t) {
    var n = e.pendingLanes;
    if (n === 0)
        return 0;
    var r = 0
      , l = e.suspendedLanes
      , s = e.pingedLanes
      , o = n & 268435455;
    if (o !== 0) {
        var a = o & ~l;
        a !== 0 ? r = Hn(a) : (s &= o,
        s !== 0 && (r = Hn(s)))
    } else
        o = n & ~l,
        o !== 0 ? r = Hn(o) : s !== 0 && (r = Hn(s));
    if (r === 0)
        return 0;
    if (t !== 0 && t !== r && !(t & l) && (l = r & -r,
    s = t & -t,
    l >= s || l === 16 && (s & 4194240) !== 0))
        return t;
    if (r & 4 && (r |= n & 16),
    t = e.entangledLanes,
    t !== 0)
        for (e = e.entanglements,
        t &= r; 0 < t; )
            n = 31 - $e(t),
            l = 1 << n,
            r |= e[n],
            t &= ~l;
    return r
}
function Dm(e, t) {
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
function Im(e, t) {
    for (var n = e.suspendedLanes, r = e.pingedLanes, l = e.expirationTimes, s = e.pendingLanes; 0 < s; ) {
        var o = 31 - $e(s)
          , a = 1 << o
          , u = l[o];
        u === -1 ? (!(a & n) || a & r) && (l[o] = Dm(a, t)) : u <= t && (e.expiredLanes |= a),
        s &= ~a
    }
}
function qs(e) {
    return e = e.pendingLanes & -1073741825,
    e !== 0 ? e : e & 1073741824 ? 1073741824 : 0
}
function Hu() {
    var e = Lr;
    return Lr <<= 1,
    !(Lr & 4194240) && (Lr = 64),
    e
}
function ds(e) {
    for (var t = [], n = 0; 31 > n; n++)
        t.push(e);
    return t
}
function jr(e, t, n) {
    e.pendingLanes |= t,
    t !== 536870912 && (e.suspendedLanes = 0,
    e.pingedLanes = 0),
    e = e.eventTimes,
    t = 31 - $e(t),
    e[t] = n
}
function Am(e, t) {
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
        var l = 31 - $e(n)
          , s = 1 << l;
        t[l] = 0,
        r[l] = -1,
        e[l] = -1,
        n &= ~s
    }
}
function Gi(e, t) {
    var n = e.entangledLanes |= t;
    for (e = e.entanglements; n; ) {
        var r = 31 - $e(n)
          , l = 1 << r;
        l & t | e[r] & t && (e[r] |= t),
        n &= ~l
    }
}
var U = 0;
function Qu(e) {
    return e &= -e,
    1 < e ? 4 < e ? e & 268435455 ? 16 : 536870912 : 4 : 1
}
var Ku, Xi, Gu, Xu, Yu, ei = !1, Tr = [], kt = null, Et = null, Ct = null, sr = new Map, ir = new Map, yt = [], Um = "mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(" ");
function Go(e, t) {
    switch (e) {
    case "focusin":
    case "focusout":
        kt = null;
        break;
    case "dragenter":
    case "dragleave":
        Et = null;
        break;
    case "mouseover":
    case "mouseout":
        Ct = null;
        break;
    case "pointerover":
    case "pointerout":
        sr.delete(t.pointerId);
        break;
    case "gotpointercapture":
    case "lostpointercapture":
        ir.delete(t.pointerId)
    }
}
function In(e, t, n, r, l, s) {
    return e === null || e.nativeEvent !== s ? (e = {
        blockedOn: t,
        domEventName: n,
        eventSystemFlags: r,
        nativeEvent: s,
        targetContainers: [l]
    },
    t !== null && (t = kr(t),
    t !== null && Xi(t)),
    e) : (e.eventSystemFlags |= r,
    t = e.targetContainers,
    l !== null && t.indexOf(l) === -1 && t.push(l),
    e)
}
function Mm(e, t, n, r, l) {
    switch (t) {
    case "focusin":
        return kt = In(kt, e, t, n, r, l),
        !0;
    case "dragenter":
        return Et = In(Et, e, t, n, r, l),
        !0;
    case "mouseover":
        return Ct = In(Ct, e, t, n, r, l),
        !0;
    case "pointerover":
        var s = l.pointerId;
        return sr.set(s, In(sr.get(s) || null, e, t, n, r, l)),
        !0;
    case "gotpointercapture":
        return s = l.pointerId,
        ir.set(s, In(ir.get(s) || null, e, t, n, r, l)),
        !0
    }
    return !1
}
function Ju(e) {
    var t = $t(e.target);
    if (t !== null) {
        var n = qt(t);
        if (n !== null) {
            if (t = n.tag,
            t === 13) {
                if (t = Uu(n),
                t !== null) {
                    e.blockedOn = t,
                    Yu(e.priority, function() {
                        Gu(n)
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
function Xr(e) {
    if (e.blockedOn !== null)
        return !1;
    for (var t = e.targetContainers; 0 < t.length; ) {
        var n = ti(e.domEventName, e.eventSystemFlags, t[0], e.nativeEvent);
        if (n === null) {
            n = e.nativeEvent;
            var r = new n.constructor(n.type,n);
            Xs = r,
            n.target.dispatchEvent(r),
            Xs = null
        } else
            return t = kr(n),
            t !== null && Xi(t),
            e.blockedOn = n,
            !1;
        t.shift()
    }
    return !0
}
function Xo(e, t, n) {
    Xr(e) && n.delete(t)
}
function $m() {
    ei = !1,
    kt !== null && Xr(kt) && (kt = null),
    Et !== null && Xr(Et) && (Et = null),
    Ct !== null && Xr(Ct) && (Ct = null),
    sr.forEach(Xo),
    ir.forEach(Xo)
}
function An(e, t) {
    e.blockedOn === t && (e.blockedOn = null,
    ei || (ei = !0,
    Ce.unstable_scheduleCallback(Ce.unstable_NormalPriority, $m)))
}
function or(e) {
    function t(l) {
        return An(l, e)
    }
    if (0 < Tr.length) {
        An(Tr[0], e);
        for (var n = 1; n < Tr.length; n++) {
            var r = Tr[n];
            r.blockedOn === e && (r.blockedOn = null)
        }
    }
    for (kt !== null && An(kt, e),
    Et !== null && An(Et, e),
    Ct !== null && An(Ct, e),
    sr.forEach(t),
    ir.forEach(t),
    n = 0; n < yt.length; n++)
        r = yt[n],
        r.blockedOn === e && (r.blockedOn = null);
    for (; 0 < yt.length && (n = yt[0],
    n.blockedOn === null); )
        Ju(n),
        n.blockedOn === null && yt.shift()
}
var wn = ht.ReactCurrentBatchConfig
  , dl = !0;
function Bm(e, t, n, r) {
    var l = U
      , s = wn.transition;
    wn.transition = null;
    try {
        U = 1,
        Yi(e, t, n, r)
    } finally {
        U = l,
        wn.transition = s
    }
}
function Vm(e, t, n, r) {
    var l = U
      , s = wn.transition;
    wn.transition = null;
    try {
        U = 4,
        Yi(e, t, n, r)
    } finally {
        U = l,
        wn.transition = s
    }
}
function Yi(e, t, n, r) {
    if (dl) {
        var l = ti(e, t, n, r);
        if (l === null)
            Ns(e, t, r, ml, n),
            Go(e, r);
        else if (Mm(l, e, t, n, r))
            r.stopPropagation();
        else if (Go(e, r),
        t & 4 && -1 < Um.indexOf(e)) {
            for (; l !== null; ) {
                var s = kr(l);
                if (s !== null && Ku(s),
                s = ti(e, t, n, r),
                s === null && Ns(e, t, r, ml, n),
                s === l)
                    break;
                l = s
            }
            l !== null && r.stopPropagation()
        } else
            Ns(e, t, r, null, n)
    }
}
var ml = null;
function ti(e, t, n, r) {
    if (ml = null,
    e = Qi(r),
    e = $t(e),
    e !== null)
        if (t = qt(e),
        t === null)
            e = null;
        else if (n = t.tag,
        n === 13) {
            if (e = Uu(t),
            e !== null)
                return e;
            e = null
        } else if (n === 3) {
            if (t.stateNode.current.memoizedState.isDehydrated)
                return t.tag === 3 ? t.stateNode.containerInfo : null;
            e = null
        } else
            t !== e && (e = null);
    return ml = e,
    null
}
function Zu(e) {
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
        switch (Rm()) {
        case Ki:
            return 1;
        case Vu:
            return 4;
        case ul:
        case Lm:
            return 16;
        case Wu:
            return 536870912;
        default:
            return 16
        }
    default:
        return 16
    }
}
var Nt = null
  , Ji = null
  , Yr = null;
function qu() {
    if (Yr)
        return Yr;
    var e, t = Ji, n = t.length, r, l = "value"in Nt ? Nt.value : Nt.textContent, s = l.length;
    for (e = 0; e < n && t[e] === l[e]; e++)
        ;
    var o = n - e;
    for (r = 1; r <= o && t[n - r] === l[s - r]; r++)
        ;
    return Yr = l.slice(e, 1 < r ? 1 - r : void 0)
}
function Jr(e) {
    var t = e.keyCode;
    return "charCode"in e ? (e = e.charCode,
    e === 0 && t === 13 && (e = 13)) : e = t,
    e === 10 && (e = 13),
    32 <= e || e === 13 ? e : 0
}
function Or() {
    return !0
}
function Yo() {
    return !1
}
function _e(e) {
    function t(n, r, l, s, o) {
        this._reactName = n,
        this._targetInst = l,
        this.type = r,
        this.nativeEvent = s,
        this.target = o,
        this.currentTarget = null;
        for (var a in e)
            e.hasOwnProperty(a) && (n = e[a],
            this[a] = n ? n(s) : s[a]);
        return this.isDefaultPrevented = (s.defaultPrevented != null ? s.defaultPrevented : s.returnValue === !1) ? Or : Yo,
        this.isPropagationStopped = Yo,
        this
    }
    return Y(t.prototype, {
        preventDefault: function() {
            this.defaultPrevented = !0;
            var n = this.nativeEvent;
            n && (n.preventDefault ? n.preventDefault() : typeof n.returnValue != "unknown" && (n.returnValue = !1),
            this.isDefaultPrevented = Or)
        },
        stopPropagation: function() {
            var n = this.nativeEvent;
            n && (n.stopPropagation ? n.stopPropagation() : typeof n.cancelBubble != "unknown" && (n.cancelBubble = !0),
            this.isPropagationStopped = Or)
        },
        persist: function() {},
        isPersistent: Or
    }),
    t
}
var zn = {
    eventPhase: 0,
    bubbles: 0,
    cancelable: 0,
    timeStamp: function(e) {
        return e.timeStamp || Date.now()
    },
    defaultPrevented: 0,
    isTrusted: 0
}, Zi = _e(zn), Sr = Y({}, zn, {
    view: 0,
    detail: 0
}), Wm = _e(Sr), ms, fs, Un, Dl = Y({}, Sr, {
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
    getModifierState: qi,
    button: 0,
    buttons: 0,
    relatedTarget: function(e) {
        return e.relatedTarget === void 0 ? e.fromElement === e.srcElement ? e.toElement : e.fromElement : e.relatedTarget
    },
    movementX: function(e) {
        return "movementX"in e ? e.movementX : (e !== Un && (Un && e.type === "mousemove" ? (ms = e.screenX - Un.screenX,
        fs = e.screenY - Un.screenY) : fs = ms = 0,
        Un = e),
        ms)
    },
    movementY: function(e) {
        return "movementY"in e ? e.movementY : fs
    }
}), Jo = _e(Dl), Hm = Y({}, Dl, {
    dataTransfer: 0
}), Qm = _e(Hm), Km = Y({}, Sr, {
    relatedTarget: 0
}), ps = _e(Km), Gm = Y({}, zn, {
    animationName: 0,
    elapsedTime: 0,
    pseudoElement: 0
}), Xm = _e(Gm), Ym = Y({}, zn, {
    clipboardData: function(e) {
        return "clipboardData"in e ? e.clipboardData : window.clipboardData
    }
}), Jm = _e(Ym), Zm = Y({}, zn, {
    data: 0
}), Zo = _e(Zm), qm = {
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
}, ef = {
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
}, tf = {
    Alt: "altKey",
    Control: "ctrlKey",
    Meta: "metaKey",
    Shift: "shiftKey"
};
function nf(e) {
    var t = this.nativeEvent;
    return t.getModifierState ? t.getModifierState(e) : (e = tf[e]) ? !!t[e] : !1
}
function qi() {
    return nf
}
var rf = Y({}, Sr, {
    key: function(e) {
        if (e.key) {
            var t = qm[e.key] || e.key;
            if (t !== "Unidentified")
                return t
        }
        return e.type === "keypress" ? (e = Jr(e),
        e === 13 ? "Enter" : String.fromCharCode(e)) : e.type === "keydown" || e.type === "keyup" ? ef[e.keyCode] || "Unidentified" : ""
    },
    code: 0,
    location: 0,
    ctrlKey: 0,
    shiftKey: 0,
    altKey: 0,
    metaKey: 0,
    repeat: 0,
    locale: 0,
    getModifierState: qi,
    charCode: function(e) {
        return e.type === "keypress" ? Jr(e) : 0
    },
    keyCode: function(e) {
        return e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
    },
    which: function(e) {
        return e.type === "keypress" ? Jr(e) : e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
    }
})
  , lf = _e(rf)
  , sf = Y({}, Dl, {
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
  , qo = _e(sf)
  , of = Y({}, Sr, {
    touches: 0,
    targetTouches: 0,
    changedTouches: 0,
    altKey: 0,
    metaKey: 0,
    ctrlKey: 0,
    shiftKey: 0,
    getModifierState: qi
})
  , af = _e(of)
  , uf = Y({}, zn, {
    propertyName: 0,
    elapsedTime: 0,
    pseudoElement: 0
})
  , cf = _e(uf)
  , df = Y({}, Dl, {
    deltaX: function(e) {
        return "deltaX"in e ? e.deltaX : "wheelDeltaX"in e ? -e.wheelDeltaX : 0
    },
    deltaY: function(e) {
        return "deltaY"in e ? e.deltaY : "wheelDeltaY"in e ? -e.wheelDeltaY : "wheelDelta"in e ? -e.wheelDelta : 0
    },
    deltaZ: 0,
    deltaMode: 0
})
  , mf = _e(df)
  , ff = [9, 13, 27, 32]
  , eo = dt && "CompositionEvent"in window
  , Xn = null;
dt && "documentMode"in document && (Xn = document.documentMode);
var pf = dt && "TextEvent"in window && !Xn
  , ec = dt && (!eo || Xn && 8 < Xn && 11 >= Xn)
  , ea = " "
  , ta = !1;
function tc(e, t) {
    switch (e) {
    case "keyup":
        return ff.indexOf(t.keyCode) !== -1;
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
function nc(e) {
    return e = e.detail,
    typeof e == "object" && "data"in e ? e.data : null
}
var on = !1;
function hf(e, t) {
    switch (e) {
    case "compositionend":
        return nc(t);
    case "keypress":
        return t.which !== 32 ? null : (ta = !0,
        ea);
    case "textInput":
        return e = t.data,
        e === ea && ta ? null : e;
    default:
        return null
    }
}
function gf(e, t) {
    if (on)
        return e === "compositionend" || !eo && tc(e, t) ? (e = qu(),
        Yr = Ji = Nt = null,
        on = !1,
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
        return ec && t.locale !== "ko" ? null : t.data;
    default:
        return null
    }
}
var xf = {
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
function na(e) {
    var t = e && e.nodeName && e.nodeName.toLowerCase();
    return t === "input" ? !!xf[e.type] : t === "textarea"
}
function rc(e, t, n, r) {
    Ou(r),
    t = fl(t, "onChange"),
    0 < t.length && (n = new Zi("onChange","change",null,n,r),
    e.push({
        event: n,
        listeners: t
    }))
}
var Yn = null
  , ar = null;
function vf(e) {
    pc(e, 0)
}
function Il(e) {
    var t = cn(e);
    if (bu(t))
        return e
}
function yf(e, t) {
    if (e === "change")
        return t
}
var lc = !1;
if (dt) {
    var hs;
    if (dt) {
        var gs = "oninput"in document;
        if (!gs) {
            var ra = document.createElement("div");
            ra.setAttribute("oninput", "return;"),
            gs = typeof ra.oninput == "function"
        }
        hs = gs
    } else
        hs = !1;
    lc = hs && (!document.documentMode || 9 < document.documentMode)
}
function la() {
    Yn && (Yn.detachEvent("onpropertychange", sc),
    ar = Yn = null)
}
function sc(e) {
    if (e.propertyName === "value" && Il(ar)) {
        var t = [];
        rc(t, ar, e, Qi(e)),
        Au(vf, t)
    }
}
function wf(e, t, n) {
    e === "focusin" ? (la(),
    Yn = t,
    ar = n,
    Yn.attachEvent("onpropertychange", sc)) : e === "focusout" && la()
}
function Nf(e) {
    if (e === "selectionchange" || e === "keyup" || e === "keydown")
        return Il(ar)
}
function jf(e, t) {
    if (e === "click")
        return Il(t)
}
function Sf(e, t) {
    if (e === "input" || e === "change")
        return Il(t)
}
function kf(e, t) {
    return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var Ve = typeof Object.is == "function" ? Object.is : kf;
function ur(e, t) {
    if (Ve(e, t))
        return !0;
    if (typeof e != "object" || e === null || typeof t != "object" || t === null)
        return !1;
    var n = Object.keys(e)
      , r = Object.keys(t);
    if (n.length !== r.length)
        return !1;
    for (r = 0; r < n.length; r++) {
        var l = n[r];
        if (!Is.call(t, l) || !Ve(e[l], t[l]))
            return !1
    }
    return !0
}
function sa(e) {
    for (; e && e.firstChild; )
        e = e.firstChild;
    return e
}
function ia(e, t) {
    var n = sa(e);
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
        n = sa(n)
    }
}
function ic(e, t) {
    return e && t ? e === t ? !0 : e && e.nodeType === 3 ? !1 : t && t.nodeType === 3 ? ic(e, t.parentNode) : "contains"in e ? e.contains(t) : e.compareDocumentPosition ? !!(e.compareDocumentPosition(t) & 16) : !1 : !1
}
function oc() {
    for (var e = window, t = il(); t instanceof e.HTMLIFrameElement; ) {
        try {
            var n = typeof t.contentWindow.location.href == "string"
        } catch {
            n = !1
        }
        if (n)
            e = t.contentWindow;
        else
            break;
        t = il(e.document)
    }
    return t
}
function to(e) {
    var t = e && e.nodeName && e.nodeName.toLowerCase();
    return t && (t === "input" && (e.type === "text" || e.type === "search" || e.type === "tel" || e.type === "url" || e.type === "password") || t === "textarea" || e.contentEditable === "true")
}
function Ef(e) {
    var t = oc()
      , n = e.focusedElem
      , r = e.selectionRange;
    if (t !== n && n && n.ownerDocument && ic(n.ownerDocument.documentElement, n)) {
        if (r !== null && to(n)) {
            if (t = r.start,
            e = r.end,
            e === void 0 && (e = t),
            "selectionStart"in n)
                n.selectionStart = t,
                n.selectionEnd = Math.min(e, n.value.length);
            else if (e = (t = n.ownerDocument || document) && t.defaultView || window,
            e.getSelection) {
                e = e.getSelection();
                var l = n.textContent.length
                  , s = Math.min(r.start, l);
                r = r.end === void 0 ? s : Math.min(r.end, l),
                !e.extend && s > r && (l = r,
                r = s,
                s = l),
                l = ia(n, s);
                var o = ia(n, r);
                l && o && (e.rangeCount !== 1 || e.anchorNode !== l.node || e.anchorOffset !== l.offset || e.focusNode !== o.node || e.focusOffset !== o.offset) && (t = t.createRange(),
                t.setStart(l.node, l.offset),
                e.removeAllRanges(),
                s > r ? (e.addRange(t),
                e.extend(o.node, o.offset)) : (t.setEnd(o.node, o.offset),
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
var Cf = dt && "documentMode"in document && 11 >= document.documentMode
  , an = null
  , ni = null
  , Jn = null
  , ri = !1;
function oa(e, t, n) {
    var r = n.window === n ? n.document : n.nodeType === 9 ? n : n.ownerDocument;
    ri || an == null || an !== il(r) || (r = an,
    "selectionStart"in r && to(r) ? r = {
        start: r.selectionStart,
        end: r.selectionEnd
    } : (r = (r.ownerDocument && r.ownerDocument.defaultView || window).getSelection(),
    r = {
        anchorNode: r.anchorNode,
        anchorOffset: r.anchorOffset,
        focusNode: r.focusNode,
        focusOffset: r.focusOffset
    }),
    Jn && ur(Jn, r) || (Jn = r,
    r = fl(ni, "onSelect"),
    0 < r.length && (t = new Zi("onSelect","select",null,t,n),
    e.push({
        event: t,
        listeners: r
    }),
    t.target = an)))
}
function Fr(e, t) {
    var n = {};
    return n[e.toLowerCase()] = t.toLowerCase(),
    n["Webkit" + e] = "webkit" + t,
    n["Moz" + e] = "moz" + t,
    n
}
var un = {
    animationend: Fr("Animation", "AnimationEnd"),
    animationiteration: Fr("Animation", "AnimationIteration"),
    animationstart: Fr("Animation", "AnimationStart"),
    transitionend: Fr("Transition", "TransitionEnd")
}
  , xs = {}
  , ac = {};
dt && (ac = document.createElement("div").style,
"AnimationEvent"in window || (delete un.animationend.animation,
delete un.animationiteration.animation,
delete un.animationstart.animation),
"TransitionEvent"in window || delete un.transitionend.transition);
function Al(e) {
    if (xs[e])
        return xs[e];
    if (!un[e])
        return e;
    var t = un[e], n;
    for (n in t)
        if (t.hasOwnProperty(n) && n in ac)
            return xs[e] = t[n];
    return e
}
var uc = Al("animationend")
  , cc = Al("animationiteration")
  , dc = Al("animationstart")
  , mc = Al("transitionend")
  , fc = new Map
  , aa = "abort auxClick cancel canPlay canPlayThrough click close contextMenu copy cut drag dragEnd dragEnter dragExit dragLeave dragOver dragStart drop durationChange emptied encrypted ended error gotPointerCapture input invalid keyDown keyPress keyUp load loadedData loadedMetadata loadStart lostPointerCapture mouseDown mouseMove mouseOut mouseOver mouseUp paste pause play playing pointerCancel pointerDown pointerMove pointerOut pointerOver pointerUp progress rateChange reset resize seeked seeking stalled submit suspend timeUpdate touchCancel touchEnd touchStart volumeChange scroll toggle touchMove waiting wheel".split(" ");
function Ot(e, t) {
    fc.set(e, t),
    Zt(t, [e])
}
for (var vs = 0; vs < aa.length; vs++) {
    var ys = aa[vs]
      , bf = ys.toLowerCase()
      , _f = ys[0].toUpperCase() + ys.slice(1);
    Ot(bf, "on" + _f)
}
Ot(uc, "onAnimationEnd");
Ot(cc, "onAnimationIteration");
Ot(dc, "onAnimationStart");
Ot("dblclick", "onDoubleClick");
Ot("focusin", "onFocus");
Ot("focusout", "onBlur");
Ot(mc, "onTransitionEnd");
Sn("onMouseEnter", ["mouseout", "mouseover"]);
Sn("onMouseLeave", ["mouseout", "mouseover"]);
Sn("onPointerEnter", ["pointerout", "pointerover"]);
Sn("onPointerLeave", ["pointerout", "pointerover"]);
Zt("onChange", "change click focusin focusout input keydown keyup selectionchange".split(" "));
Zt("onSelect", "focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(" "));
Zt("onBeforeInput", ["compositionend", "keypress", "textInput", "paste"]);
Zt("onCompositionEnd", "compositionend focusout keydown keypress keyup mousedown".split(" "));
Zt("onCompositionStart", "compositionstart focusout keydown keypress keyup mousedown".split(" "));
Zt("onCompositionUpdate", "compositionupdate focusout keydown keypress keyup mousedown".split(" "));
var Qn = "abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange resize seeked seeking stalled suspend timeupdate volumechange waiting".split(" ")
  , Pf = new Set("cancel close invalid load scroll toggle".split(" ").concat(Qn));
function ua(e, t, n) {
    var r = e.type || "unknown-event";
    e.currentTarget = n,
    Cm(r, t, void 0, e),
    e.currentTarget = null
}
function pc(e, t) {
    t = (t & 4) !== 0;
    for (var n = 0; n < e.length; n++) {
        var r = e[n]
          , l = r.event;
        r = r.listeners;
        e: {
            var s = void 0;
            if (t)
                for (var o = r.length - 1; 0 <= o; o--) {
                    var a = r[o]
                      , u = a.instance
                      , d = a.currentTarget;
                    if (a = a.listener,
                    u !== s && l.isPropagationStopped())
                        break e;
                    ua(l, a, d),
                    s = u
                }
            else
                for (o = 0; o < r.length; o++) {
                    if (a = r[o],
                    u = a.instance,
                    d = a.currentTarget,
                    a = a.listener,
                    u !== s && l.isPropagationStopped())
                        break e;
                    ua(l, a, d),
                    s = u
                }
        }
    }
    if (al)
        throw e = Zs,
        al = !1,
        Zs = null,
        e
}
function W(e, t) {
    var n = t[ai];
    n === void 0 && (n = t[ai] = new Set);
    var r = e + "__bubble";
    n.has(r) || (hc(t, e, 2, !1),
    n.add(r))
}
function ws(e, t, n) {
    var r = 0;
    t && (r |= 4),
    hc(n, e, r, t)
}
var Dr = "_reactListening" + Math.random().toString(36).slice(2);
function cr(e) {
    if (!e[Dr]) {
        e[Dr] = !0,
        ju.forEach(function(n) {
            n !== "selectionchange" && (Pf.has(n) || ws(n, !1, e),
            ws(n, !0, e))
        });
        var t = e.nodeType === 9 ? e : e.ownerDocument;
        t === null || t[Dr] || (t[Dr] = !0,
        ws("selectionchange", !1, t))
    }
}
function hc(e, t, n, r) {
    switch (Zu(t)) {
    case 1:
        var l = Bm;
        break;
    case 4:
        l = Vm;
        break;
    default:
        l = Yi
    }
    n = l.bind(null, t, n, e),
    l = void 0,
    !Js || t !== "touchstart" && t !== "touchmove" && t !== "wheel" || (l = !0),
    r ? l !== void 0 ? e.addEventListener(t, n, {
        capture: !0,
        passive: l
    }) : e.addEventListener(t, n, !0) : l !== void 0 ? e.addEventListener(t, n, {
        passive: l
    }) : e.addEventListener(t, n, !1)
}
function Ns(e, t, n, r, l) {
    var s = r;
    if (!(t & 1) && !(t & 2) && r !== null)
        e: for (; ; ) {
            if (r === null)
                return;
            var o = r.tag;
            if (o === 3 || o === 4) {
                var a = r.stateNode.containerInfo;
                if (a === l || a.nodeType === 8 && a.parentNode === l)
                    break;
                if (o === 4)
                    for (o = r.return; o !== null; ) {
                        var u = o.tag;
                        if ((u === 3 || u === 4) && (u = o.stateNode.containerInfo,
                        u === l || u.nodeType === 8 && u.parentNode === l))
                            return;
                        o = o.return
                    }
                for (; a !== null; ) {
                    if (o = $t(a),
                    o === null)
                        return;
                    if (u = o.tag,
                    u === 5 || u === 6) {
                        r = s = o;
                        continue e
                    }
                    a = a.parentNode
                }
            }
            r = r.return
        }
    Au(function() {
        var d = s
          , p = Qi(n)
          , c = [];
        e: {
            var m = fc.get(e);
            if (m !== void 0) {
                var x = Zi
                  , y = e;
                switch (e) {
                case "keypress":
                    if (Jr(n) === 0)
                        break e;
                case "keydown":
                case "keyup":
                    x = lf;
                    break;
                case "focusin":
                    y = "focus",
                    x = ps;
                    break;
                case "focusout":
                    y = "blur",
                    x = ps;
                    break;
                case "beforeblur":
                case "afterblur":
                    x = ps;
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
                    x = Jo;
                    break;
                case "drag":
                case "dragend":
                case "dragenter":
                case "dragexit":
                case "dragleave":
                case "dragover":
                case "dragstart":
                case "drop":
                    x = Qm;
                    break;
                case "touchcancel":
                case "touchend":
                case "touchmove":
                case "touchstart":
                    x = af;
                    break;
                case uc:
                case cc:
                case dc:
                    x = Xm;
                    break;
                case mc:
                    x = cf;
                    break;
                case "scroll":
                    x = Wm;
                    break;
                case "wheel":
                    x = mf;
                    break;
                case "copy":
                case "cut":
                case "paste":
                    x = Jm;
                    break;
                case "gotpointercapture":
                case "lostpointercapture":
                case "pointercancel":
                case "pointerdown":
                case "pointermove":
                case "pointerout":
                case "pointerover":
                case "pointerup":
                    x = qo
                }
                var w = (t & 4) !== 0
                  , j = !w && e === "scroll"
                  , h = w ? m !== null ? m + "Capture" : null : m;
                w = [];
                for (var f = d, g; f !== null; ) {
                    g = f;
                    var N = g.stateNode;
                    if (g.tag === 5 && N !== null && (g = N,
                    h !== null && (N = lr(f, h),
                    N != null && w.push(dr(f, N, g)))),
                    j)
                        break;
                    f = f.return
                }
                0 < w.length && (m = new x(m,y,null,n,p),
                c.push({
                    event: m,
                    listeners: w
                }))
            }
        }
        if (!(t & 7)) {
            e: {
                if (m = e === "mouseover" || e === "pointerover",
                x = e === "mouseout" || e === "pointerout",
                m && n !== Xs && (y = n.relatedTarget || n.fromElement) && ($t(y) || y[mt]))
                    break e;
                if ((x || m) && (m = p.window === p ? p : (m = p.ownerDocument) ? m.defaultView || m.parentWindow : window,
                x ? (y = n.relatedTarget || n.toElement,
                x = d,
                y = y ? $t(y) : null,
                y !== null && (j = qt(y),
                y !== j || y.tag !== 5 && y.tag !== 6) && (y = null)) : (x = null,
                y = d),
                x !== y)) {
                    if (w = Jo,
                    N = "onMouseLeave",
                    h = "onMouseEnter",
                    f = "mouse",
                    (e === "pointerout" || e === "pointerover") && (w = qo,
                    N = "onPointerLeave",
                    h = "onPointerEnter",
                    f = "pointer"),
                    j = x == null ? m : cn(x),
                    g = y == null ? m : cn(y),
                    m = new w(N,f + "leave",x,n,p),
                    m.target = j,
                    m.relatedTarget = g,
                    N = null,
                    $t(p) === d && (w = new w(h,f + "enter",y,n,p),
                    w.target = g,
                    w.relatedTarget = j,
                    N = w),
                    j = N,
                    x && y)
                        t: {
                            for (w = x,
                            h = y,
                            f = 0,
                            g = w; g; g = rn(g))
                                f++;
                            for (g = 0,
                            N = h; N; N = rn(N))
                                g++;
                            for (; 0 < f - g; )
                                w = rn(w),
                                f--;
                            for (; 0 < g - f; )
                                h = rn(h),
                                g--;
                            for (; f--; ) {
                                if (w === h || h !== null && w === h.alternate)
                                    break t;
                                w = rn(w),
                                h = rn(h)
                            }
                            w = null
                        }
                    else
                        w = null;
                    x !== null && ca(c, m, x, w, !1),
                    y !== null && j !== null && ca(c, j, y, w, !0)
                }
            }
            e: {
                if (m = d ? cn(d) : window,
                x = m.nodeName && m.nodeName.toLowerCase(),
                x === "select" || x === "input" && m.type === "file")
                    var E = yf;
                else if (na(m))
                    if (lc)
                        E = Sf;
                    else {
                        E = Nf;
                        var b = wf
                    }
                else
                    (x = m.nodeName) && x.toLowerCase() === "input" && (m.type === "checkbox" || m.type === "radio") && (E = jf);
                if (E && (E = E(e, d))) {
                    rc(c, E, n, p);
                    break e
                }
                b && b(e, m, d),
                e === "focusout" && (b = m._wrapperState) && b.controlled && m.type === "number" && Ws(m, "number", m.value)
            }
            switch (b = d ? cn(d) : window,
            e) {
            case "focusin":
                (na(b) || b.contentEditable === "true") && (an = b,
                ni = d,
                Jn = null);
                break;
            case "focusout":
                Jn = ni = an = null;
                break;
            case "mousedown":
                ri = !0;
                break;
            case "contextmenu":
            case "mouseup":
            case "dragend":
                ri = !1,
                oa(c, n, p);
                break;
            case "selectionchange":
                if (Cf)
                    break;
            case "keydown":
            case "keyup":
                oa(c, n, p)
            }
            var k;
            if (eo)
                e: {
                    switch (e) {
                    case "compositionstart":
                        var C = "onCompositionStart";
                        break e;
                    case "compositionend":
                        C = "onCompositionEnd";
                        break e;
                    case "compositionupdate":
                        C = "onCompositionUpdate";
                        break e
                    }
                    C = void 0
                }
            else
                on ? tc(e, n) && (C = "onCompositionEnd") : e === "keydown" && n.keyCode === 229 && (C = "onCompositionStart");
            C && (ec && n.locale !== "ko" && (on || C !== "onCompositionStart" ? C === "onCompositionEnd" && on && (k = qu()) : (Nt = p,
            Ji = "value"in Nt ? Nt.value : Nt.textContent,
            on = !0)),
            b = fl(d, C),
            0 < b.length && (C = new Zo(C,e,null,n,p),
            c.push({
                event: C,
                listeners: b
            }),
            k ? C.data = k : (k = nc(n),
            k !== null && (C.data = k)))),
            (k = pf ? hf(e, n) : gf(e, n)) && (d = fl(d, "onBeforeInput"),
            0 < d.length && (p = new Zo("onBeforeInput","beforeinput",null,n,p),
            c.push({
                event: p,
                listeners: d
            }),
            p.data = k))
        }
        pc(c, t)
    })
}
function dr(e, t, n) {
    return {
        instance: e,
        listener: t,
        currentTarget: n
    }
}
function fl(e, t) {
    for (var n = t + "Capture", r = []; e !== null; ) {
        var l = e
          , s = l.stateNode;
        l.tag === 5 && s !== null && (l = s,
        s = lr(e, n),
        s != null && r.unshift(dr(e, s, l)),
        s = lr(e, t),
        s != null && r.push(dr(e, s, l))),
        e = e.return
    }
    return r
}
function rn(e) {
    if (e === null)
        return null;
    do
        e = e.return;
    while (e && e.tag !== 5);
    return e || null
}
function ca(e, t, n, r, l) {
    for (var s = t._reactName, o = []; n !== null && n !== r; ) {
        var a = n
          , u = a.alternate
          , d = a.stateNode;
        if (u !== null && u === r)
            break;
        a.tag === 5 && d !== null && (a = d,
        l ? (u = lr(n, s),
        u != null && o.unshift(dr(n, u, a))) : l || (u = lr(n, s),
        u != null && o.push(dr(n, u, a)))),
        n = n.return
    }
    o.length !== 0 && e.push({
        event: t,
        listeners: o
    })
}
var Rf = /\r\n?/g
  , Lf = /\u0000|\uFFFD/g;
function da(e) {
    return (typeof e == "string" ? e : "" + e).replace(Rf, `
`).replace(Lf, "")
}
function Ir(e, t, n) {
    if (t = da(t),
    da(e) !== t && n)
        throw Error(S(425))
}
function pl() {}
var li = null
  , si = null;
function ii(e, t) {
    return e === "textarea" || e === "noscript" || typeof t.children == "string" || typeof t.children == "number" || typeof t.dangerouslySetInnerHTML == "object" && t.dangerouslySetInnerHTML !== null && t.dangerouslySetInnerHTML.__html != null
}
var oi = typeof setTimeout == "function" ? setTimeout : void 0
  , zf = typeof clearTimeout == "function" ? clearTimeout : void 0
  , ma = typeof Promise == "function" ? Promise : void 0
  , Tf = typeof queueMicrotask == "function" ? queueMicrotask : typeof ma < "u" ? function(e) {
    return ma.resolve(null).then(e).catch(Of)
}
: oi;
function Of(e) {
    setTimeout(function() {
        throw e
    })
}
function js(e, t) {
    var n = t
      , r = 0;
    do {
        var l = n.nextSibling;
        if (e.removeChild(n),
        l && l.nodeType === 8)
            if (n = l.data,
            n === "/$") {
                if (r === 0) {
                    e.removeChild(l),
                    or(t);
                    return
                }
                r--
            } else
                n !== "$" && n !== "$?" && n !== "$!" || r++;
        n = l
    } while (n);
    or(t)
}
function bt(e) {
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
function fa(e) {
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
var Tn = Math.random().toString(36).slice(2)
  , Ye = "__reactFiber$" + Tn
  , mr = "__reactProps$" + Tn
  , mt = "__reactContainer$" + Tn
  , ai = "__reactEvents$" + Tn
  , Ff = "__reactListeners$" + Tn
  , Df = "__reactHandles$" + Tn;
function $t(e) {
    var t = e[Ye];
    if (t)
        return t;
    for (var n = e.parentNode; n; ) {
        if (t = n[mt] || n[Ye]) {
            if (n = t.alternate,
            t.child !== null || n !== null && n.child !== null)
                for (e = fa(e); e !== null; ) {
                    if (n = e[Ye])
                        return n;
                    e = fa(e)
                }
            return t
        }
        e = n,
        n = e.parentNode
    }
    return null
}
function kr(e) {
    return e = e[Ye] || e[mt],
    !e || e.tag !== 5 && e.tag !== 6 && e.tag !== 13 && e.tag !== 3 ? null : e
}
function cn(e) {
    if (e.tag === 5 || e.tag === 6)
        return e.stateNode;
    throw Error(S(33))
}
function Ul(e) {
    return e[mr] || null
}
var ui = []
  , dn = -1;
function Ft(e) {
    return {
        current: e
    }
}
function H(e) {
    0 > dn || (e.current = ui[dn],
    ui[dn] = null,
    dn--)
}
function V(e, t) {
    dn++,
    ui[dn] = e.current,
    e.current = t
}
var Tt = {}
  , me = Ft(Tt)
  , ye = Ft(!1)
  , Kt = Tt;
function kn(e, t) {
    var n = e.type.contextTypes;
    if (!n)
        return Tt;
    var r = e.stateNode;
    if (r && r.__reactInternalMemoizedUnmaskedChildContext === t)
        return r.__reactInternalMemoizedMaskedChildContext;
    var l = {}, s;
    for (s in n)
        l[s] = t[s];
    return r && (e = e.stateNode,
    e.__reactInternalMemoizedUnmaskedChildContext = t,
    e.__reactInternalMemoizedMaskedChildContext = l),
    l
}
function we(e) {
    return e = e.childContextTypes,
    e != null
}
function hl() {
    H(ye),
    H(me)
}
function pa(e, t, n) {
    if (me.current !== Tt)
        throw Error(S(168));
    V(me, t),
    V(ye, n)
}
function gc(e, t, n) {
    var r = e.stateNode;
    if (t = t.childContextTypes,
    typeof r.getChildContext != "function")
        return n;
    r = r.getChildContext();
    for (var l in r)
        if (!(l in t))
            throw Error(S(108, ym(e) || "Unknown", l));
    return Y({}, n, r)
}
function gl(e) {
    return e = (e = e.stateNode) && e.__reactInternalMemoizedMergedChildContext || Tt,
    Kt = me.current,
    V(me, e),
    V(ye, ye.current),
    !0
}
function ha(e, t, n) {
    var r = e.stateNode;
    if (!r)
        throw Error(S(169));
    n ? (e = gc(e, t, Kt),
    r.__reactInternalMemoizedMergedChildContext = e,
    H(ye),
    H(me),
    V(me, e)) : H(ye),
    V(ye, n)
}
var ot = null
  , Ml = !1
  , Ss = !1;
function xc(e) {
    ot === null ? ot = [e] : ot.push(e)
}
function If(e) {
    Ml = !0,
    xc(e)
}
function Dt() {
    if (!Ss && ot !== null) {
        Ss = !0;
        var e = 0
          , t = U;
        try {
            var n = ot;
            for (U = 1; e < n.length; e++) {
                var r = n[e];
                do
                    r = r(!0);
                while (r !== null)
            }
            ot = null,
            Ml = !1
        } catch (l) {
            throw ot !== null && (ot = ot.slice(e + 1)),
            Bu(Ki, Dt),
            l
        } finally {
            U = t,
            Ss = !1
        }
    }
    return null
}
var mn = []
  , fn = 0
  , xl = null
  , vl = 0
  , Re = []
  , Le = 0
  , Gt = null
  , at = 1
  , ut = "";
function Ut(e, t) {
    mn[fn++] = vl,
    mn[fn++] = xl,
    xl = e,
    vl = t
}
function vc(e, t, n) {
    Re[Le++] = at,
    Re[Le++] = ut,
    Re[Le++] = Gt,
    Gt = e;
    var r = at;
    e = ut;
    var l = 32 - $e(r) - 1;
    r &= ~(1 << l),
    n += 1;
    var s = 32 - $e(t) + l;
    if (30 < s) {
        var o = l - l % 5;
        s = (r & (1 << o) - 1).toString(32),
        r >>= o,
        l -= o,
        at = 1 << 32 - $e(t) + l | n << l | r,
        ut = s + e
    } else
        at = 1 << s | n << l | r,
        ut = e
}
function no(e) {
    e.return !== null && (Ut(e, 1),
    vc(e, 1, 0))
}
function ro(e) {
    for (; e === xl; )
        xl = mn[--fn],
        mn[fn] = null,
        vl = mn[--fn],
        mn[fn] = null;
    for (; e === Gt; )
        Gt = Re[--Le],
        Re[Le] = null,
        ut = Re[--Le],
        Re[Le] = null,
        at = Re[--Le],
        Re[Le] = null
}
var Ee = null
  , ke = null
  , Q = !1
  , Me = null;
function yc(e, t) {
    var n = ze(5, null, null, 0);
    n.elementType = "DELETED",
    n.stateNode = t,
    n.return = e,
    t = e.deletions,
    t === null ? (e.deletions = [n],
    e.flags |= 16) : t.push(n)
}
function ga(e, t) {
    switch (e.tag) {
    case 5:
        var n = e.type;
        return t = t.nodeType !== 1 || n.toLowerCase() !== t.nodeName.toLowerCase() ? null : t,
        t !== null ? (e.stateNode = t,
        Ee = e,
        ke = bt(t.firstChild),
        !0) : !1;
    case 6:
        return t = e.pendingProps === "" || t.nodeType !== 3 ? null : t,
        t !== null ? (e.stateNode = t,
        Ee = e,
        ke = null,
        !0) : !1;
    case 13:
        return t = t.nodeType !== 8 ? null : t,
        t !== null ? (n = Gt !== null ? {
            id: at,
            overflow: ut
        } : null,
        e.memoizedState = {
            dehydrated: t,
            treeContext: n,
            retryLane: 1073741824
        },
        n = ze(18, null, null, 0),
        n.stateNode = t,
        n.return = e,
        e.child = n,
        Ee = e,
        ke = null,
        !0) : !1;
    default:
        return !1
    }
}
function ci(e) {
    return (e.mode & 1) !== 0 && (e.flags & 128) === 0
}
function di(e) {
    if (Q) {
        var t = ke;
        if (t) {
            var n = t;
            if (!ga(e, t)) {
                if (ci(e))
                    throw Error(S(418));
                t = bt(n.nextSibling);
                var r = Ee;
                t && ga(e, t) ? yc(r, n) : (e.flags = e.flags & -4097 | 2,
                Q = !1,
                Ee = e)
            }
        } else {
            if (ci(e))
                throw Error(S(418));
            e.flags = e.flags & -4097 | 2,
            Q = !1,
            Ee = e
        }
    }
}
function xa(e) {
    for (e = e.return; e !== null && e.tag !== 5 && e.tag !== 3 && e.tag !== 13; )
        e = e.return;
    Ee = e
}
function Ar(e) {
    if (e !== Ee)
        return !1;
    if (!Q)
        return xa(e),
        Q = !0,
        !1;
    var t;
    if ((t = e.tag !== 3) && !(t = e.tag !== 5) && (t = e.type,
    t = t !== "head" && t !== "body" && !ii(e.type, e.memoizedProps)),
    t && (t = ke)) {
        if (ci(e))
            throw wc(),
            Error(S(418));
        for (; t; )
            yc(e, t),
            t = bt(t.nextSibling)
    }
    if (xa(e),
    e.tag === 13) {
        if (e = e.memoizedState,
        e = e !== null ? e.dehydrated : null,
        !e)
            throw Error(S(317));
        e: {
            for (e = e.nextSibling,
            t = 0; e; ) {
                if (e.nodeType === 8) {
                    var n = e.data;
                    if (n === "/$") {
                        if (t === 0) {
                            ke = bt(e.nextSibling);
                            break e
                        }
                        t--
                    } else
                        n !== "$" && n !== "$!" && n !== "$?" || t++
                }
                e = e.nextSibling
            }
            ke = null
        }
    } else
        ke = Ee ? bt(e.stateNode.nextSibling) : null;
    return !0
}
function wc() {
    for (var e = ke; e; )
        e = bt(e.nextSibling)
}
function En() {
    ke = Ee = null,
    Q = !1
}
function lo(e) {
    Me === null ? Me = [e] : Me.push(e)
}
var Af = ht.ReactCurrentBatchConfig;
function Ie(e, t) {
    if (e && e.defaultProps) {
        t = Y({}, t),
        e = e.defaultProps;
        for (var n in e)
            t[n] === void 0 && (t[n] = e[n]);
        return t
    }
    return t
}
var yl = Ft(null)
  , wl = null
  , pn = null
  , so = null;
function io() {
    so = pn = wl = null
}
function oo(e) {
    var t = yl.current;
    H(yl),
    e._currentValue = t
}
function mi(e, t, n) {
    for (; e !== null; ) {
        var r = e.alternate;
        if ((e.childLanes & t) !== t ? (e.childLanes |= t,
        r !== null && (r.childLanes |= t)) : r !== null && (r.childLanes & t) !== t && (r.childLanes |= t),
        e === n)
            break;
        e = e.return
    }
}
function Nn(e, t) {
    wl = e,
    so = pn = null,
    e = e.dependencies,
    e !== null && e.firstContext !== null && (e.lanes & t && (ve = !0),
    e.firstContext = null)
}
function Oe(e) {
    var t = e._currentValue;
    if (so !== e)
        if (e = {
            context: e,
            memoizedValue: t,
            next: null
        },
        pn === null) {
            if (wl === null)
                throw Error(S(308));
            pn = e,
            wl.dependencies = {
                lanes: 0,
                firstContext: e
            }
        } else
            pn = pn.next = e;
    return t
}
var Bt = null;
function ao(e) {
    Bt === null ? Bt = [e] : Bt.push(e)
}
function Nc(e, t, n, r) {
    var l = t.interleaved;
    return l === null ? (n.next = n,
    ao(t)) : (n.next = l.next,
    l.next = n),
    t.interleaved = n,
    ft(e, r)
}
function ft(e, t) {
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
var vt = !1;
function uo(e) {
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
function jc(e, t) {
    e = e.updateQueue,
    t.updateQueue === e && (t.updateQueue = {
        baseState: e.baseState,
        firstBaseUpdate: e.firstBaseUpdate,
        lastBaseUpdate: e.lastBaseUpdate,
        shared: e.shared,
        effects: e.effects
    })
}
function ct(e, t) {
    return {
        eventTime: e,
        lane: t,
        tag: 0,
        payload: null,
        callback: null,
        next: null
    }
}
function _t(e, t, n) {
    var r = e.updateQueue;
    if (r === null)
        return null;
    if (r = r.shared,
    A & 2) {
        var l = r.pending;
        return l === null ? t.next = t : (t.next = l.next,
        l.next = t),
        r.pending = t,
        ft(e, n)
    }
    return l = r.interleaved,
    l === null ? (t.next = t,
    ao(r)) : (t.next = l.next,
    l.next = t),
    r.interleaved = t,
    ft(e, n)
}
function Zr(e, t, n) {
    if (t = t.updateQueue,
    t !== null && (t = t.shared,
    (n & 4194240) !== 0)) {
        var r = t.lanes;
        r &= e.pendingLanes,
        n |= r,
        t.lanes = n,
        Gi(e, n)
    }
}
function va(e, t) {
    var n = e.updateQueue
      , r = e.alternate;
    if (r !== null && (r = r.updateQueue,
    n === r)) {
        var l = null
          , s = null;
        if (n = n.firstBaseUpdate,
        n !== null) {
            do {
                var o = {
                    eventTime: n.eventTime,
                    lane: n.lane,
                    tag: n.tag,
                    payload: n.payload,
                    callback: n.callback,
                    next: null
                };
                s === null ? l = s = o : s = s.next = o,
                n = n.next
            } while (n !== null);
            s === null ? l = s = t : s = s.next = t
        } else
            l = s = t;
        n = {
            baseState: r.baseState,
            firstBaseUpdate: l,
            lastBaseUpdate: s,
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
function Nl(e, t, n, r) {
    var l = e.updateQueue;
    vt = !1;
    var s = l.firstBaseUpdate
      , o = l.lastBaseUpdate
      , a = l.shared.pending;
    if (a !== null) {
        l.shared.pending = null;
        var u = a
          , d = u.next;
        u.next = null,
        o === null ? s = d : o.next = d,
        o = u;
        var p = e.alternate;
        p !== null && (p = p.updateQueue,
        a = p.lastBaseUpdate,
        a !== o && (a === null ? p.firstBaseUpdate = d : a.next = d,
        p.lastBaseUpdate = u))
    }
    if (s !== null) {
        var c = l.baseState;
        o = 0,
        p = d = u = null,
        a = s;
        do {
            var m = a.lane
              , x = a.eventTime;
            if ((r & m) === m) {
                p !== null && (p = p.next = {
                    eventTime: x,
                    lane: 0,
                    tag: a.tag,
                    payload: a.payload,
                    callback: a.callback,
                    next: null
                });
                e: {
                    var y = e
                      , w = a;
                    switch (m = t,
                    x = n,
                    w.tag) {
                    case 1:
                        if (y = w.payload,
                        typeof y == "function") {
                            c = y.call(x, c, m);
                            break e
                        }
                        c = y;
                        break e;
                    case 3:
                        y.flags = y.flags & -65537 | 128;
                    case 0:
                        if (y = w.payload,
                        m = typeof y == "function" ? y.call(x, c, m) : y,
                        m == null)
                            break e;
                        c = Y({}, c, m);
                        break e;
                    case 2:
                        vt = !0
                    }
                }
                a.callback !== null && a.lane !== 0 && (e.flags |= 64,
                m = l.effects,
                m === null ? l.effects = [a] : m.push(a))
            } else
                x = {
                    eventTime: x,
                    lane: m,
                    tag: a.tag,
                    payload: a.payload,
                    callback: a.callback,
                    next: null
                },
                p === null ? (d = p = x,
                u = c) : p = p.next = x,
                o |= m;
            if (a = a.next,
            a === null) {
                if (a = l.shared.pending,
                a === null)
                    break;
                m = a,
                a = m.next,
                m.next = null,
                l.lastBaseUpdate = m,
                l.shared.pending = null
            }
        } while (!0);
        if (p === null && (u = c),
        l.baseState = u,
        l.firstBaseUpdate = d,
        l.lastBaseUpdate = p,
        t = l.shared.interleaved,
        t !== null) {
            l = t;
            do
                o |= l.lane,
                l = l.next;
            while (l !== t)
        } else
            s === null && (l.shared.lanes = 0);
        Yt |= o,
        e.lanes = o,
        e.memoizedState = c
    }
}
function ya(e, t, n) {
    if (e = t.effects,
    t.effects = null,
    e !== null)
        for (t = 0; t < e.length; t++) {
            var r = e[t]
              , l = r.callback;
            if (l !== null) {
                if (r.callback = null,
                r = n,
                typeof l != "function")
                    throw Error(S(191, l));
                l.call(r)
            }
        }
}
var Sc = new Nu.Component().refs;
function fi(e, t, n, r) {
    t = e.memoizedState,
    n = n(r, t),
    n = n == null ? t : Y({}, t, n),
    e.memoizedState = n,
    e.lanes === 0 && (e.updateQueue.baseState = n)
}
var $l = {
    isMounted: function(e) {
        return (e = e._reactInternals) ? qt(e) === e : !1
    },
    enqueueSetState: function(e, t, n) {
        e = e._reactInternals;
        var r = pe()
          , l = Rt(e)
          , s = ct(r, l);
        s.payload = t,
        n != null && (s.callback = n),
        t = _t(e, s, l),
        t !== null && (Be(t, e, l, r),
        Zr(t, e, l))
    },
    enqueueReplaceState: function(e, t, n) {
        e = e._reactInternals;
        var r = pe()
          , l = Rt(e)
          , s = ct(r, l);
        s.tag = 1,
        s.payload = t,
        n != null && (s.callback = n),
        t = _t(e, s, l),
        t !== null && (Be(t, e, l, r),
        Zr(t, e, l))
    },
    enqueueForceUpdate: function(e, t) {
        e = e._reactInternals;
        var n = pe()
          , r = Rt(e)
          , l = ct(n, r);
        l.tag = 2,
        t != null && (l.callback = t),
        t = _t(e, l, r),
        t !== null && (Be(t, e, r, n),
        Zr(t, e, r))
    }
};
function wa(e, t, n, r, l, s, o) {
    return e = e.stateNode,
    typeof e.shouldComponentUpdate == "function" ? e.shouldComponentUpdate(r, s, o) : t.prototype && t.prototype.isPureReactComponent ? !ur(n, r) || !ur(l, s) : !0
}
function kc(e, t, n) {
    var r = !1
      , l = Tt
      , s = t.contextType;
    return typeof s == "object" && s !== null ? s = Oe(s) : (l = we(t) ? Kt : me.current,
    r = t.contextTypes,
    s = (r = r != null) ? kn(e, l) : Tt),
    t = new t(n,s),
    e.memoizedState = t.state !== null && t.state !== void 0 ? t.state : null,
    t.updater = $l,
    e.stateNode = t,
    t._reactInternals = e,
    r && (e = e.stateNode,
    e.__reactInternalMemoizedUnmaskedChildContext = l,
    e.__reactInternalMemoizedMaskedChildContext = s),
    t
}
function Na(e, t, n, r) {
    e = t.state,
    typeof t.componentWillReceiveProps == "function" && t.componentWillReceiveProps(n, r),
    typeof t.UNSAFE_componentWillReceiveProps == "function" && t.UNSAFE_componentWillReceiveProps(n, r),
    t.state !== e && $l.enqueueReplaceState(t, t.state, null)
}
function pi(e, t, n, r) {
    var l = e.stateNode;
    l.props = n,
    l.state = e.memoizedState,
    l.refs = Sc,
    uo(e);
    var s = t.contextType;
    typeof s == "object" && s !== null ? l.context = Oe(s) : (s = we(t) ? Kt : me.current,
    l.context = kn(e, s)),
    l.state = e.memoizedState,
    s = t.getDerivedStateFromProps,
    typeof s == "function" && (fi(e, t, s, n),
    l.state = e.memoizedState),
    typeof t.getDerivedStateFromProps == "function" || typeof l.getSnapshotBeforeUpdate == "function" || typeof l.UNSAFE_componentWillMount != "function" && typeof l.componentWillMount != "function" || (t = l.state,
    typeof l.componentWillMount == "function" && l.componentWillMount(),
    typeof l.UNSAFE_componentWillMount == "function" && l.UNSAFE_componentWillMount(),
    t !== l.state && $l.enqueueReplaceState(l, l.state, null),
    Nl(e, n, l, r),
    l.state = e.memoizedState),
    typeof l.componentDidMount == "function" && (e.flags |= 4194308)
}
function Mn(e, t, n) {
    if (e = n.ref,
    e !== null && typeof e != "function" && typeof e != "object") {
        if (n._owner) {
            if (n = n._owner,
            n) {
                if (n.tag !== 1)
                    throw Error(S(309));
                var r = n.stateNode
            }
            if (!r)
                throw Error(S(147, e));
            var l = r
              , s = "" + e;
            return t !== null && t.ref !== null && typeof t.ref == "function" && t.ref._stringRef === s ? t.ref : (t = function(o) {
                var a = l.refs;
                a === Sc && (a = l.refs = {}),
                o === null ? delete a[s] : a[s] = o
            }
            ,
            t._stringRef = s,
            t)
        }
        if (typeof e != "string")
            throw Error(S(284));
        if (!n._owner)
            throw Error(S(290, e))
    }
    return e
}
function Ur(e, t) {
    throw e = Object.prototype.toString.call(t),
    Error(S(31, e === "[object Object]" ? "object with keys {" + Object.keys(t).join(", ") + "}" : e))
}
function ja(e) {
    var t = e._init;
    return t(e._payload)
}
function Ec(e) {
    function t(h, f) {
        if (e) {
            var g = h.deletions;
            g === null ? (h.deletions = [f],
            h.flags |= 16) : g.push(f)
        }
    }
    function n(h, f) {
        if (!e)
            return null;
        for (; f !== null; )
            t(h, f),
            f = f.sibling;
        return null
    }
    function r(h, f) {
        for (h = new Map; f !== null; )
            f.key !== null ? h.set(f.key, f) : h.set(f.index, f),
            f = f.sibling;
        return h
    }
    function l(h, f) {
        return h = Lt(h, f),
        h.index = 0,
        h.sibling = null,
        h
    }
    function s(h, f, g) {
        return h.index = g,
        e ? (g = h.alternate,
        g !== null ? (g = g.index,
        g < f ? (h.flags |= 2,
        f) : g) : (h.flags |= 2,
        f)) : (h.flags |= 1048576,
        f)
    }
    function o(h) {
        return e && h.alternate === null && (h.flags |= 2),
        h
    }
    function a(h, f, g, N) {
        return f === null || f.tag !== 6 ? (f = Rs(g, h.mode, N),
        f.return = h,
        f) : (f = l(f, g),
        f.return = h,
        f)
    }
    function u(h, f, g, N) {
        var E = g.type;
        return E === sn ? p(h, f, g.props.children, N, g.key) : f !== null && (f.elementType === E || typeof E == "object" && E !== null && E.$$typeof === xt && ja(E) === f.type) ? (N = l(f, g.props),
        N.ref = Mn(h, f, g),
        N.return = h,
        N) : (N = ll(g.type, g.key, g.props, null, h.mode, N),
        N.ref = Mn(h, f, g),
        N.return = h,
        N)
    }
    function d(h, f, g, N) {
        return f === null || f.tag !== 4 || f.stateNode.containerInfo !== g.containerInfo || f.stateNode.implementation !== g.implementation ? (f = Ls(g, h.mode, N),
        f.return = h,
        f) : (f = l(f, g.children || []),
        f.return = h,
        f)
    }
    function p(h, f, g, N, E) {
        return f === null || f.tag !== 7 ? (f = Ht(g, h.mode, N, E),
        f.return = h,
        f) : (f = l(f, g),
        f.return = h,
        f)
    }
    function c(h, f, g) {
        if (typeof f == "string" && f !== "" || typeof f == "number")
            return f = Rs("" + f, h.mode, g),
            f.return = h,
            f;
        if (typeof f == "object" && f !== null) {
            switch (f.$$typeof) {
            case _r:
                return g = ll(f.type, f.key, f.props, null, h.mode, g),
                g.ref = Mn(h, null, f),
                g.return = h,
                g;
            case ln:
                return f = Ls(f, h.mode, g),
                f.return = h,
                f;
            case xt:
                var N = f._init;
                return c(h, N(f._payload), g)
            }
            if (Wn(f) || Fn(f))
                return f = Ht(f, h.mode, g, null),
                f.return = h,
                f;
            Ur(h, f)
        }
        return null
    }
    function m(h, f, g, N) {
        var E = f !== null ? f.key : null;
        if (typeof g == "string" && g !== "" || typeof g == "number")
            return E !== null ? null : a(h, f, "" + g, N);
        if (typeof g == "object" && g !== null) {
            switch (g.$$typeof) {
            case _r:
                return g.key === E ? u(h, f, g, N) : null;
            case ln:
                return g.key === E ? d(h, f, g, N) : null;
            case xt:
                return E = g._init,
                m(h, f, E(g._payload), N)
            }
            if (Wn(g) || Fn(g))
                return E !== null ? null : p(h, f, g, N, null);
            Ur(h, g)
        }
        return null
    }
    function x(h, f, g, N, E) {
        if (typeof N == "string" && N !== "" || typeof N == "number")
            return h = h.get(g) || null,
            a(f, h, "" + N, E);
        if (typeof N == "object" && N !== null) {
            switch (N.$$typeof) {
            case _r:
                return h = h.get(N.key === null ? g : N.key) || null,
                u(f, h, N, E);
            case ln:
                return h = h.get(N.key === null ? g : N.key) || null,
                d(f, h, N, E);
            case xt:
                var b = N._init;
                return x(h, f, g, b(N._payload), E)
            }
            if (Wn(N) || Fn(N))
                return h = h.get(g) || null,
                p(f, h, N, E, null);
            Ur(f, N)
        }
        return null
    }
    function y(h, f, g, N) {
        for (var E = null, b = null, k = f, C = f = 0, I = null; k !== null && C < g.length; C++) {
            k.index > C ? (I = k,
            k = null) : I = k.sibling;
            var L = m(h, k, g[C], N);
            if (L === null) {
                k === null && (k = I);
                break
            }
            e && k && L.alternate === null && t(h, k),
            f = s(L, f, C),
            b === null ? E = L : b.sibling = L,
            b = L,
            k = I
        }
        if (C === g.length)
            return n(h, k),
            Q && Ut(h, C),
            E;
        if (k === null) {
            for (; C < g.length; C++)
                k = c(h, g[C], N),
                k !== null && (f = s(k, f, C),
                b === null ? E = k : b.sibling = k,
                b = k);
            return Q && Ut(h, C),
            E
        }
        for (k = r(h, k); C < g.length; C++)
            I = x(k, h, C, g[C], N),
            I !== null && (e && I.alternate !== null && k.delete(I.key === null ? C : I.key),
            f = s(I, f, C),
            b === null ? E = I : b.sibling = I,
            b = I);
        return e && k.forEach(function(M) {
            return t(h, M)
        }),
        Q && Ut(h, C),
        E
    }
    function w(h, f, g, N) {
        var E = Fn(g);
        if (typeof E != "function")
            throw Error(S(150));
        if (g = E.call(g),
        g == null)
            throw Error(S(151));
        for (var b = E = null, k = f, C = f = 0, I = null, L = g.next(); k !== null && !L.done; C++,
        L = g.next()) {
            k.index > C ? (I = k,
            k = null) : I = k.sibling;
            var M = m(h, k, L.value, N);
            if (M === null) {
                k === null && (k = I);
                break
            }
            e && k && M.alternate === null && t(h, k),
            f = s(M, f, C),
            b === null ? E = M : b.sibling = M,
            b = M,
            k = I
        }
        if (L.done)
            return n(h, k),
            Q && Ut(h, C),
            E;
        if (k === null) {
            for (; !L.done; C++,
            L = g.next())
                L = c(h, L.value, N),
                L !== null && (f = s(L, f, C),
                b === null ? E = L : b.sibling = L,
                b = L);
            return Q && Ut(h, C),
            E
        }
        for (k = r(h, k); !L.done; C++,
        L = g.next())
            L = x(k, h, C, L.value, N),
            L !== null && (e && L.alternate !== null && k.delete(L.key === null ? C : L.key),
            f = s(L, f, C),
            b === null ? E = L : b.sibling = L,
            b = L);
        return e && k.forEach(function(K) {
            return t(h, K)
        }),
        Q && Ut(h, C),
        E
    }
    function j(h, f, g, N) {
        if (typeof g == "object" && g !== null && g.type === sn && g.key === null && (g = g.props.children),
        typeof g == "object" && g !== null) {
            switch (g.$$typeof) {
            case _r:
                e: {
                    for (var E = g.key, b = f; b !== null; ) {
                        if (b.key === E) {
                            if (E = g.type,
                            E === sn) {
                                if (b.tag === 7) {
                                    n(h, b.sibling),
                                    f = l(b, g.props.children),
                                    f.return = h,
                                    h = f;
                                    break e
                                }
                            } else if (b.elementType === E || typeof E == "object" && E !== null && E.$$typeof === xt && ja(E) === b.type) {
                                n(h, b.sibling),
                                f = l(b, g.props),
                                f.ref = Mn(h, b, g),
                                f.return = h,
                                h = f;
                                break e
                            }
                            n(h, b);
                            break
                        } else
                            t(h, b);
                        b = b.sibling
                    }
                    g.type === sn ? (f = Ht(g.props.children, h.mode, N, g.key),
                    f.return = h,
                    h = f) : (N = ll(g.type, g.key, g.props, null, h.mode, N),
                    N.ref = Mn(h, f, g),
                    N.return = h,
                    h = N)
                }
                return o(h);
            case ln:
                e: {
                    for (b = g.key; f !== null; ) {
                        if (f.key === b)
                            if (f.tag === 4 && f.stateNode.containerInfo === g.containerInfo && f.stateNode.implementation === g.implementation) {
                                n(h, f.sibling),
                                f = l(f, g.children || []),
                                f.return = h,
                                h = f;
                                break e
                            } else {
                                n(h, f);
                                break
                            }
                        else
                            t(h, f);
                        f = f.sibling
                    }
                    f = Ls(g, h.mode, N),
                    f.return = h,
                    h = f
                }
                return o(h);
            case xt:
                return b = g._init,
                j(h, f, b(g._payload), N)
            }
            if (Wn(g))
                return y(h, f, g, N);
            if (Fn(g))
                return w(h, f, g, N);
            Ur(h, g)
        }
        return typeof g == "string" && g !== "" || typeof g == "number" ? (g = "" + g,
        f !== null && f.tag === 6 ? (n(h, f.sibling),
        f = l(f, g),
        f.return = h,
        h = f) : (n(h, f),
        f = Rs(g, h.mode, N),
        f.return = h,
        h = f),
        o(h)) : n(h, f)
    }
    return j
}
var Cn = Ec(!0)
  , Cc = Ec(!1)
  , Er = {}
  , qe = Ft(Er)
  , fr = Ft(Er)
  , pr = Ft(Er);
function Vt(e) {
    if (e === Er)
        throw Error(S(174));
    return e
}
function co(e, t) {
    switch (V(pr, t),
    V(fr, e),
    V(qe, Er),
    e = t.nodeType,
    e) {
    case 9:
    case 11:
        t = (t = t.documentElement) ? t.namespaceURI : Qs(null, "");
        break;
    default:
        e = e === 8 ? t.parentNode : t,
        t = e.namespaceURI || null,
        e = e.tagName,
        t = Qs(t, e)
    }
    H(qe),
    V(qe, t)
}
function bn() {
    H(qe),
    H(fr),
    H(pr)
}
function bc(e) {
    Vt(pr.current);
    var t = Vt(qe.current)
      , n = Qs(t, e.type);
    t !== n && (V(fr, e),
    V(qe, n))
}
function mo(e) {
    fr.current === e && (H(qe),
    H(fr))
}
var G = Ft(0);
function jl(e) {
    for (var t = e; t !== null; ) {
        if (t.tag === 13) {
            var n = t.memoizedState;
            if (n !== null && (n = n.dehydrated,
            n === null || n.data === "$?" || n.data === "$!"))
                return t
        } else if (t.tag === 19 && t.memoizedProps.revealOrder !== void 0) {
            if (t.flags & 128)
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
var ks = [];
function fo() {
    for (var e = 0; e < ks.length; e++)
        ks[e]._workInProgressVersionPrimary = null;
    ks.length = 0
}
var qr = ht.ReactCurrentDispatcher
  , Es = ht.ReactCurrentBatchConfig
  , Xt = 0
  , X = null
  , ee = null
  , re = null
  , Sl = !1
  , Zn = !1
  , hr = 0
  , Uf = 0;
function ue() {
    throw Error(S(321))
}
function po(e, t) {
    if (t === null)
        return !1;
    for (var n = 0; n < t.length && n < e.length; n++)
        if (!Ve(e[n], t[n]))
            return !1;
    return !0
}
function ho(e, t, n, r, l, s) {
    if (Xt = s,
    X = t,
    t.memoizedState = null,
    t.updateQueue = null,
    t.lanes = 0,
    qr.current = e === null || e.memoizedState === null ? Vf : Wf,
    e = n(r, l),
    Zn) {
        s = 0;
        do {
            if (Zn = !1,
            hr = 0,
            25 <= s)
                throw Error(S(301));
            s += 1,
            re = ee = null,
            t.updateQueue = null,
            qr.current = Hf,
            e = n(r, l)
        } while (Zn)
    }
    if (qr.current = kl,
    t = ee !== null && ee.next !== null,
    Xt = 0,
    re = ee = X = null,
    Sl = !1,
    t)
        throw Error(S(300));
    return e
}
function go() {
    var e = hr !== 0;
    return hr = 0,
    e
}
function Xe() {
    var e = {
        memoizedState: null,
        baseState: null,
        baseQueue: null,
        queue: null,
        next: null
    };
    return re === null ? X.memoizedState = re = e : re = re.next = e,
    re
}
function Fe() {
    if (ee === null) {
        var e = X.alternate;
        e = e !== null ? e.memoizedState : null
    } else
        e = ee.next;
    var t = re === null ? X.memoizedState : re.next;
    if (t !== null)
        re = t,
        ee = e;
    else {
        if (e === null)
            throw Error(S(310));
        ee = e,
        e = {
            memoizedState: ee.memoizedState,
            baseState: ee.baseState,
            baseQueue: ee.baseQueue,
            queue: ee.queue,
            next: null
        },
        re === null ? X.memoizedState = re = e : re = re.next = e
    }
    return re
}
function gr(e, t) {
    return typeof t == "function" ? t(e) : t
}
function Cs(e) {
    var t = Fe()
      , n = t.queue;
    if (n === null)
        throw Error(S(311));
    n.lastRenderedReducer = e;
    var r = ee
      , l = r.baseQueue
      , s = n.pending;
    if (s !== null) {
        if (l !== null) {
            var o = l.next;
            l.next = s.next,
            s.next = o
        }
        r.baseQueue = l = s,
        n.pending = null
    }
    if (l !== null) {
        s = l.next,
        r = r.baseState;
        var a = o = null
          , u = null
          , d = s;
        do {
            var p = d.lane;
            if ((Xt & p) === p)
                u !== null && (u = u.next = {
                    lane: 0,
                    action: d.action,
                    hasEagerState: d.hasEagerState,
                    eagerState: d.eagerState,
                    next: null
                }),
                r = d.hasEagerState ? d.eagerState : e(r, d.action);
            else {
                var c = {
                    lane: p,
                    action: d.action,
                    hasEagerState: d.hasEagerState,
                    eagerState: d.eagerState,
                    next: null
                };
                u === null ? (a = u = c,
                o = r) : u = u.next = c,
                X.lanes |= p,
                Yt |= p
            }
            d = d.next
        } while (d !== null && d !== s);
        u === null ? o = r : u.next = a,
        Ve(r, t.memoizedState) || (ve = !0),
        t.memoizedState = r,
        t.baseState = o,
        t.baseQueue = u,
        n.lastRenderedState = r
    }
    if (e = n.interleaved,
    e !== null) {
        l = e;
        do
            s = l.lane,
            X.lanes |= s,
            Yt |= s,
            l = l.next;
        while (l !== e)
    } else
        l === null && (n.lanes = 0);
    return [t.memoizedState, n.dispatch]
}
function bs(e) {
    var t = Fe()
      , n = t.queue;
    if (n === null)
        throw Error(S(311));
    n.lastRenderedReducer = e;
    var r = n.dispatch
      , l = n.pending
      , s = t.memoizedState;
    if (l !== null) {
        n.pending = null;
        var o = l = l.next;
        do
            s = e(s, o.action),
            o = o.next;
        while (o !== l);
        Ve(s, t.memoizedState) || (ve = !0),
        t.memoizedState = s,
        t.baseQueue === null && (t.baseState = s),
        n.lastRenderedState = s
    }
    return [s, r]
}
function _c() {}
function Pc(e, t) {
    var n = X
      , r = Fe()
      , l = t()
      , s = !Ve(r.memoizedState, l);
    if (s && (r.memoizedState = l,
    ve = !0),
    r = r.queue,
    xo(zc.bind(null, n, r, e), [e]),
    r.getSnapshot !== t || s || re !== null && re.memoizedState.tag & 1) {
        if (n.flags |= 2048,
        xr(9, Lc.bind(null, n, r, l, t), void 0, null),
        le === null)
            throw Error(S(349));
        Xt & 30 || Rc(n, t, l)
    }
    return l
}
function Rc(e, t, n) {
    e.flags |= 16384,
    e = {
        getSnapshot: t,
        value: n
    },
    t = X.updateQueue,
    t === null ? (t = {
        lastEffect: null,
        stores: null
    },
    X.updateQueue = t,
    t.stores = [e]) : (n = t.stores,
    n === null ? t.stores = [e] : n.push(e))
}
function Lc(e, t, n, r) {
    t.value = n,
    t.getSnapshot = r,
    Tc(t) && Oc(e)
}
function zc(e, t, n) {
    return n(function() {
        Tc(t) && Oc(e)
    })
}
function Tc(e) {
    var t = e.getSnapshot;
    e = e.value;
    try {
        var n = t();
        return !Ve(e, n)
    } catch {
        return !0
    }
}
function Oc(e) {
    var t = ft(e, 1);
    t !== null && Be(t, e, 1, -1)
}
function Sa(e) {
    var t = Xe();
    return typeof e == "function" && (e = e()),
    t.memoizedState = t.baseState = e,
    e = {
        pending: null,
        interleaved: null,
        lanes: 0,
        dispatch: null,
        lastRenderedReducer: gr,
        lastRenderedState: e
    },
    t.queue = e,
    e = e.dispatch = Bf.bind(null, X, e),
    [t.memoizedState, e]
}
function xr(e, t, n, r) {
    return e = {
        tag: e,
        create: t,
        destroy: n,
        deps: r,
        next: null
    },
    t = X.updateQueue,
    t === null ? (t = {
        lastEffect: null,
        stores: null
    },
    X.updateQueue = t,
    t.lastEffect = e.next = e) : (n = t.lastEffect,
    n === null ? t.lastEffect = e.next = e : (r = n.next,
    n.next = e,
    e.next = r,
    t.lastEffect = e)),
    e
}
function Fc() {
    return Fe().memoizedState
}
function el(e, t, n, r) {
    var l = Xe();
    X.flags |= e,
    l.memoizedState = xr(1 | t, n, void 0, r === void 0 ? null : r)
}
function Bl(e, t, n, r) {
    var l = Fe();
    r = r === void 0 ? null : r;
    var s = void 0;
    if (ee !== null) {
        var o = ee.memoizedState;
        if (s = o.destroy,
        r !== null && po(r, o.deps)) {
            l.memoizedState = xr(t, n, s, r);
            return
        }
    }
    X.flags |= e,
    l.memoizedState = xr(1 | t, n, s, r)
}
function ka(e, t) {
    return el(8390656, 8, e, t)
}
function xo(e, t) {
    return Bl(2048, 8, e, t)
}
function Dc(e, t) {
    return Bl(4, 2, e, t)
}
function Ic(e, t) {
    return Bl(4, 4, e, t)
}
function Ac(e, t) {
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
function Uc(e, t, n) {
    return n = n != null ? n.concat([e]) : null,
    Bl(4, 4, Ac.bind(null, t, e), n)
}
function vo() {}
function Mc(e, t) {
    var n = Fe();
    t = t === void 0 ? null : t;
    var r = n.memoizedState;
    return r !== null && t !== null && po(t, r[1]) ? r[0] : (n.memoizedState = [e, t],
    e)
}
function $c(e, t) {
    var n = Fe();
    t = t === void 0 ? null : t;
    var r = n.memoizedState;
    return r !== null && t !== null && po(t, r[1]) ? r[0] : (e = e(),
    n.memoizedState = [e, t],
    e)
}
function Bc(e, t, n) {
    return Xt & 21 ? (Ve(n, t) || (n = Hu(),
    X.lanes |= n,
    Yt |= n,
    e.baseState = !0),
    t) : (e.baseState && (e.baseState = !1,
    ve = !0),
    e.memoizedState = n)
}
function Mf(e, t) {
    var n = U;
    U = n !== 0 && 4 > n ? n : 4,
    e(!0);
    var r = Es.transition;
    Es.transition = {};
    try {
        e(!1),
        t()
    } finally {
        U = n,
        Es.transition = r
    }
}
function Vc() {
    return Fe().memoizedState
}
function $f(e, t, n) {
    var r = Rt(e);
    if (n = {
        lane: r,
        action: n,
        hasEagerState: !1,
        eagerState: null,
        next: null
    },
    Wc(e))
        Hc(t, n);
    else if (n = Nc(e, t, n, r),
    n !== null) {
        var l = pe();
        Be(n, e, r, l),
        Qc(n, t, r)
    }
}
function Bf(e, t, n) {
    var r = Rt(e)
      , l = {
        lane: r,
        action: n,
        hasEagerState: !1,
        eagerState: null,
        next: null
    };
    if (Wc(e))
        Hc(t, l);
    else {
        var s = e.alternate;
        if (e.lanes === 0 && (s === null || s.lanes === 0) && (s = t.lastRenderedReducer,
        s !== null))
            try {
                var o = t.lastRenderedState
                  , a = s(o, n);
                if (l.hasEagerState = !0,
                l.eagerState = a,
                Ve(a, o)) {
                    var u = t.interleaved;
                    u === null ? (l.next = l,
                    ao(t)) : (l.next = u.next,
                    u.next = l),
                    t.interleaved = l;
                    return
                }
            } catch {} finally {}
        n = Nc(e, t, l, r),
        n !== null && (l = pe(),
        Be(n, e, r, l),
        Qc(n, t, r))
    }
}
function Wc(e) {
    var t = e.alternate;
    return e === X || t !== null && t === X
}
function Hc(e, t) {
    Zn = Sl = !0;
    var n = e.pending;
    n === null ? t.next = t : (t.next = n.next,
    n.next = t),
    e.pending = t
}
function Qc(e, t, n) {
    if (n & 4194240) {
        var r = t.lanes;
        r &= e.pendingLanes,
        n |= r,
        t.lanes = n,
        Gi(e, n)
    }
}
var kl = {
    readContext: Oe,
    useCallback: ue,
    useContext: ue,
    useEffect: ue,
    useImperativeHandle: ue,
    useInsertionEffect: ue,
    useLayoutEffect: ue,
    useMemo: ue,
    useReducer: ue,
    useRef: ue,
    useState: ue,
    useDebugValue: ue,
    useDeferredValue: ue,
    useTransition: ue,
    useMutableSource: ue,
    useSyncExternalStore: ue,
    useId: ue,
    unstable_isNewReconciler: !1
}
  , Vf = {
    readContext: Oe,
    useCallback: function(e, t) {
        return Xe().memoizedState = [e, t === void 0 ? null : t],
        e
    },
    useContext: Oe,
    useEffect: ka,
    useImperativeHandle: function(e, t, n) {
        return n = n != null ? n.concat([e]) : null,
        el(4194308, 4, Ac.bind(null, t, e), n)
    },
    useLayoutEffect: function(e, t) {
        return el(4194308, 4, e, t)
    },
    useInsertionEffect: function(e, t) {
        return el(4, 2, e, t)
    },
    useMemo: function(e, t) {
        var n = Xe();
        return t = t === void 0 ? null : t,
        e = e(),
        n.memoizedState = [e, t],
        e
    },
    useReducer: function(e, t, n) {
        var r = Xe();
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
        e = e.dispatch = $f.bind(null, X, e),
        [r.memoizedState, e]
    },
    useRef: function(e) {
        var t = Xe();
        return e = {
            current: e
        },
        t.memoizedState = e
    },
    useState: Sa,
    useDebugValue: vo,
    useDeferredValue: function(e) {
        return Xe().memoizedState = e
    },
    useTransition: function() {
        var e = Sa(!1)
          , t = e[0];
        return e = Mf.bind(null, e[1]),
        Xe().memoizedState = e,
        [t, e]
    },
    useMutableSource: function() {},
    useSyncExternalStore: function(e, t, n) {
        var r = X
          , l = Xe();
        if (Q) {
            if (n === void 0)
                throw Error(S(407));
            n = n()
        } else {
            if (n = t(),
            le === null)
                throw Error(S(349));
            Xt & 30 || Rc(r, t, n)
        }
        l.memoizedState = n;
        var s = {
            value: n,
            getSnapshot: t
        };
        return l.queue = s,
        ka(zc.bind(null, r, s, e), [e]),
        r.flags |= 2048,
        xr(9, Lc.bind(null, r, s, n, t), void 0, null),
        n
    },
    useId: function() {
        var e = Xe()
          , t = le.identifierPrefix;
        if (Q) {
            var n = ut
              , r = at;
            n = (r & ~(1 << 32 - $e(r) - 1)).toString(32) + n,
            t = ":" + t + "R" + n,
            n = hr++,
            0 < n && (t += "H" + n.toString(32)),
            t += ":"
        } else
            n = Uf++,
            t = ":" + t + "r" + n.toString(32) + ":";
        return e.memoizedState = t
    },
    unstable_isNewReconciler: !1
}
  , Wf = {
    readContext: Oe,
    useCallback: Mc,
    useContext: Oe,
    useEffect: xo,
    useImperativeHandle: Uc,
    useInsertionEffect: Dc,
    useLayoutEffect: Ic,
    useMemo: $c,
    useReducer: Cs,
    useRef: Fc,
    useState: function() {
        return Cs(gr)
    },
    useDebugValue: vo,
    useDeferredValue: function(e) {
        var t = Fe();
        return Bc(t, ee.memoizedState, e)
    },
    useTransition: function() {
        var e = Cs(gr)[0]
          , t = Fe().memoizedState;
        return [e, t]
    },
    useMutableSource: _c,
    useSyncExternalStore: Pc,
    useId: Vc,
    unstable_isNewReconciler: !1
}
  , Hf = {
    readContext: Oe,
    useCallback: Mc,
    useContext: Oe,
    useEffect: xo,
    useImperativeHandle: Uc,
    useInsertionEffect: Dc,
    useLayoutEffect: Ic,
    useMemo: $c,
    useReducer: bs,
    useRef: Fc,
    useState: function() {
        return bs(gr)
    },
    useDebugValue: vo,
    useDeferredValue: function(e) {
        var t = Fe();
        return ee === null ? t.memoizedState = e : Bc(t, ee.memoizedState, e)
    },
    useTransition: function() {
        var e = bs(gr)[0]
          , t = Fe().memoizedState;
        return [e, t]
    },
    useMutableSource: _c,
    useSyncExternalStore: Pc,
    useId: Vc,
    unstable_isNewReconciler: !1
};
function _n(e, t) {
    try {
        var n = ""
          , r = t;
        do
            n += vm(r),
            r = r.return;
        while (r);
        var l = n
    } catch (s) {
        l = `
Error generating stack: ` + s.message + `
` + s.stack
    }
    return {
        value: e,
        source: t,
        stack: l,
        digest: null
    }
}
function _s(e, t, n) {
    return {
        value: e,
        source: null,
        stack: n ?? null,
        digest: t ?? null
    }
}
function hi(e, t) {
    try {
        console.error(t.value)
    } catch (n) {
        setTimeout(function() {
            throw n
        })
    }
}
var Qf = typeof WeakMap == "function" ? WeakMap : Map;
function Kc(e, t, n) {
    n = ct(-1, n),
    n.tag = 3,
    n.payload = {
        element: null
    };
    var r = t.value;
    return n.callback = function() {
        Cl || (Cl = !0,
        Ei = r),
        hi(e, t)
    }
    ,
    n
}
function Gc(e, t, n) {
    n = ct(-1, n),
    n.tag = 3;
    var r = e.type.getDerivedStateFromError;
    if (typeof r == "function") {
        var l = t.value;
        n.payload = function() {
            return r(l)
        }
        ,
        n.callback = function() {
            hi(e, t)
        }
    }
    var s = e.stateNode;
    return s !== null && typeof s.componentDidCatch == "function" && (n.callback = function() {
        hi(e, t),
        typeof r != "function" && (Pt === null ? Pt = new Set([this]) : Pt.add(this));
        var o = t.stack;
        this.componentDidCatch(t.value, {
            componentStack: o !== null ? o : ""
        })
    }
    ),
    n
}
function Ea(e, t, n) {
    var r = e.pingCache;
    if (r === null) {
        r = e.pingCache = new Qf;
        var l = new Set;
        r.set(t, l)
    } else
        l = r.get(t),
        l === void 0 && (l = new Set,
        r.set(t, l));
    l.has(n) || (l.add(n),
    e = ip.bind(null, e, t, n),
    t.then(e, e))
}
function Ca(e) {
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
function ba(e, t, n, r, l) {
    return e.mode & 1 ? (e.flags |= 65536,
    e.lanes = l,
    e) : (e === t ? e.flags |= 65536 : (e.flags |= 128,
    n.flags |= 131072,
    n.flags &= -52805,
    n.tag === 1 && (n.alternate === null ? n.tag = 17 : (t = ct(-1, 1),
    t.tag = 2,
    _t(n, t, 1))),
    n.lanes |= 1),
    e)
}
var Kf = ht.ReactCurrentOwner
  , ve = !1;
function fe(e, t, n, r) {
    t.child = e === null ? Cc(t, null, n, r) : Cn(t, e.child, n, r)
}
function _a(e, t, n, r, l) {
    n = n.render;
    var s = t.ref;
    return Nn(t, l),
    r = ho(e, t, n, r, s, l),
    n = go(),
    e !== null && !ve ? (t.updateQueue = e.updateQueue,
    t.flags &= -2053,
    e.lanes &= ~l,
    pt(e, t, l)) : (Q && n && no(t),
    t.flags |= 1,
    fe(e, t, r, l),
    t.child)
}
function Pa(e, t, n, r, l) {
    if (e === null) {
        var s = n.type;
        return typeof s == "function" && !Co(s) && s.defaultProps === void 0 && n.compare === null && n.defaultProps === void 0 ? (t.tag = 15,
        t.type = s,
        Xc(e, t, s, r, l)) : (e = ll(n.type, null, r, t, t.mode, l),
        e.ref = t.ref,
        e.return = t,
        t.child = e)
    }
    if (s = e.child,
    !(e.lanes & l)) {
        var o = s.memoizedProps;
        if (n = n.compare,
        n = n !== null ? n : ur,
        n(o, r) && e.ref === t.ref)
            return pt(e, t, l)
    }
    return t.flags |= 1,
    e = Lt(s, r),
    e.ref = t.ref,
    e.return = t,
    t.child = e
}
function Xc(e, t, n, r, l) {
    if (e !== null) {
        var s = e.memoizedProps;
        if (ur(s, r) && e.ref === t.ref)
            if (ve = !1,
            t.pendingProps = r = s,
            (e.lanes & l) !== 0)
                e.flags & 131072 && (ve = !0);
            else
                return t.lanes = e.lanes,
                pt(e, t, l)
    }
    return gi(e, t, n, r, l)
}
function Yc(e, t, n) {
    var r = t.pendingProps
      , l = r.children
      , s = e !== null ? e.memoizedState : null;
    if (r.mode === "hidden")
        if (!(t.mode & 1))
            t.memoizedState = {
                baseLanes: 0,
                cachePool: null,
                transitions: null
            },
            V(gn, Se),
            Se |= n;
        else {
            if (!(n & 1073741824))
                return e = s !== null ? s.baseLanes | n : n,
                t.lanes = t.childLanes = 1073741824,
                t.memoizedState = {
                    baseLanes: e,
                    cachePool: null,
                    transitions: null
                },
                t.updateQueue = null,
                V(gn, Se),
                Se |= e,
                null;
            t.memoizedState = {
                baseLanes: 0,
                cachePool: null,
                transitions: null
            },
            r = s !== null ? s.baseLanes : n,
            V(gn, Se),
            Se |= r
        }
    else
        s !== null ? (r = s.baseLanes | n,
        t.memoizedState = null) : r = n,
        V(gn, Se),
        Se |= r;
    return fe(e, t, l, n),
    t.child
}
function Jc(e, t) {
    var n = t.ref;
    (e === null && n !== null || e !== null && e.ref !== n) && (t.flags |= 512,
    t.flags |= 2097152)
}
function gi(e, t, n, r, l) {
    var s = we(n) ? Kt : me.current;
    return s = kn(t, s),
    Nn(t, l),
    n = ho(e, t, n, r, s, l),
    r = go(),
    e !== null && !ve ? (t.updateQueue = e.updateQueue,
    t.flags &= -2053,
    e.lanes &= ~l,
    pt(e, t, l)) : (Q && r && no(t),
    t.flags |= 1,
    fe(e, t, n, l),
    t.child)
}
function Ra(e, t, n, r, l) {
    if (we(n)) {
        var s = !0;
        gl(t)
    } else
        s = !1;
    if (Nn(t, l),
    t.stateNode === null)
        tl(e, t),
        kc(t, n, r),
        pi(t, n, r, l),
        r = !0;
    else if (e === null) {
        var o = t.stateNode
          , a = t.memoizedProps;
        o.props = a;
        var u = o.context
          , d = n.contextType;
        typeof d == "object" && d !== null ? d = Oe(d) : (d = we(n) ? Kt : me.current,
        d = kn(t, d));
        var p = n.getDerivedStateFromProps
          , c = typeof p == "function" || typeof o.getSnapshotBeforeUpdate == "function";
        c || typeof o.UNSAFE_componentWillReceiveProps != "function" && typeof o.componentWillReceiveProps != "function" || (a !== r || u !== d) && Na(t, o, r, d),
        vt = !1;
        var m = t.memoizedState;
        o.state = m,
        Nl(t, r, o, l),
        u = t.memoizedState,
        a !== r || m !== u || ye.current || vt ? (typeof p == "function" && (fi(t, n, p, r),
        u = t.memoizedState),
        (a = vt || wa(t, n, a, r, m, u, d)) ? (c || typeof o.UNSAFE_componentWillMount != "function" && typeof o.componentWillMount != "function" || (typeof o.componentWillMount == "function" && o.componentWillMount(),
        typeof o.UNSAFE_componentWillMount == "function" && o.UNSAFE_componentWillMount()),
        typeof o.componentDidMount == "function" && (t.flags |= 4194308)) : (typeof o.componentDidMount == "function" && (t.flags |= 4194308),
        t.memoizedProps = r,
        t.memoizedState = u),
        o.props = r,
        o.state = u,
        o.context = d,
        r = a) : (typeof o.componentDidMount == "function" && (t.flags |= 4194308),
        r = !1)
    } else {
        o = t.stateNode,
        jc(e, t),
        a = t.memoizedProps,
        d = t.type === t.elementType ? a : Ie(t.type, a),
        o.props = d,
        c = t.pendingProps,
        m = o.context,
        u = n.contextType,
        typeof u == "object" && u !== null ? u = Oe(u) : (u = we(n) ? Kt : me.current,
        u = kn(t, u));
        var x = n.getDerivedStateFromProps;
        (p = typeof x == "function" || typeof o.getSnapshotBeforeUpdate == "function") || typeof o.UNSAFE_componentWillReceiveProps != "function" && typeof o.componentWillReceiveProps != "function" || (a !== c || m !== u) && Na(t, o, r, u),
        vt = !1,
        m = t.memoizedState,
        o.state = m,
        Nl(t, r, o, l);
        var y = t.memoizedState;
        a !== c || m !== y || ye.current || vt ? (typeof x == "function" && (fi(t, n, x, r),
        y = t.memoizedState),
        (d = vt || wa(t, n, d, r, m, y, u) || !1) ? (p || typeof o.UNSAFE_componentWillUpdate != "function" && typeof o.componentWillUpdate != "function" || (typeof o.componentWillUpdate == "function" && o.componentWillUpdate(r, y, u),
        typeof o.UNSAFE_componentWillUpdate == "function" && o.UNSAFE_componentWillUpdate(r, y, u)),
        typeof o.componentDidUpdate == "function" && (t.flags |= 4),
        typeof o.getSnapshotBeforeUpdate == "function" && (t.flags |= 1024)) : (typeof o.componentDidUpdate != "function" || a === e.memoizedProps && m === e.memoizedState || (t.flags |= 4),
        typeof o.getSnapshotBeforeUpdate != "function" || a === e.memoizedProps && m === e.memoizedState || (t.flags |= 1024),
        t.memoizedProps = r,
        t.memoizedState = y),
        o.props = r,
        o.state = y,
        o.context = u,
        r = d) : (typeof o.componentDidUpdate != "function" || a === e.memoizedProps && m === e.memoizedState || (t.flags |= 4),
        typeof o.getSnapshotBeforeUpdate != "function" || a === e.memoizedProps && m === e.memoizedState || (t.flags |= 1024),
        r = !1)
    }
    return xi(e, t, n, r, s, l)
}
function xi(e, t, n, r, l, s) {
    Jc(e, t);
    var o = (t.flags & 128) !== 0;
    if (!r && !o)
        return l && ha(t, n, !1),
        pt(e, t, s);
    r = t.stateNode,
    Kf.current = t;
    var a = o && typeof n.getDerivedStateFromError != "function" ? null : r.render();
    return t.flags |= 1,
    e !== null && o ? (t.child = Cn(t, e.child, null, s),
    t.child = Cn(t, null, a, s)) : fe(e, t, a, s),
    t.memoizedState = r.state,
    l && ha(t, n, !0),
    t.child
}
function Zc(e) {
    var t = e.stateNode;
    t.pendingContext ? pa(e, t.pendingContext, t.pendingContext !== t.context) : t.context && pa(e, t.context, !1),
    co(e, t.containerInfo)
}
function La(e, t, n, r, l) {
    return En(),
    lo(l),
    t.flags |= 256,
    fe(e, t, n, r),
    t.child
}
var vi = {
    dehydrated: null,
    treeContext: null,
    retryLane: 0
};
function yi(e) {
    return {
        baseLanes: e,
        cachePool: null,
        transitions: null
    }
}
function qc(e, t, n) {
    var r = t.pendingProps, l = G.current, s = !1, o = (t.flags & 128) !== 0, a;
    if ((a = o) || (a = e !== null && e.memoizedState === null ? !1 : (l & 2) !== 0),
    a ? (s = !0,
    t.flags &= -129) : (e === null || e.memoizedState !== null) && (l |= 1),
    V(G, l & 1),
    e === null)
        return di(t),
        e = t.memoizedState,
        e !== null && (e = e.dehydrated,
        e !== null) ? (t.mode & 1 ? e.data === "$!" ? t.lanes = 8 : t.lanes = 1073741824 : t.lanes = 1,
        null) : (o = r.children,
        e = r.fallback,
        s ? (r = t.mode,
        s = t.child,
        o = {
            mode: "hidden",
            children: o
        },
        !(r & 1) && s !== null ? (s.childLanes = 0,
        s.pendingProps = o) : s = Hl(o, r, 0, null),
        e = Ht(e, r, n, null),
        s.return = t,
        e.return = t,
        s.sibling = e,
        t.child = s,
        t.child.memoizedState = yi(n),
        t.memoizedState = vi,
        e) : yo(t, o));
    if (l = e.memoizedState,
    l !== null && (a = l.dehydrated,
    a !== null))
        return Gf(e, t, o, r, a, l, n);
    if (s) {
        s = r.fallback,
        o = t.mode,
        l = e.child,
        a = l.sibling;
        var u = {
            mode: "hidden",
            children: r.children
        };
        return !(o & 1) && t.child !== l ? (r = t.child,
        r.childLanes = 0,
        r.pendingProps = u,
        t.deletions = null) : (r = Lt(l, u),
        r.subtreeFlags = l.subtreeFlags & 14680064),
        a !== null ? s = Lt(a, s) : (s = Ht(s, o, n, null),
        s.flags |= 2),
        s.return = t,
        r.return = t,
        r.sibling = s,
        t.child = r,
        r = s,
        s = t.child,
        o = e.child.memoizedState,
        o = o === null ? yi(n) : {
            baseLanes: o.baseLanes | n,
            cachePool: null,
            transitions: o.transitions
        },
        s.memoizedState = o,
        s.childLanes = e.childLanes & ~n,
        t.memoizedState = vi,
        r
    }
    return s = e.child,
    e = s.sibling,
    r = Lt(s, {
        mode: "visible",
        children: r.children
    }),
    !(t.mode & 1) && (r.lanes = n),
    r.return = t,
    r.sibling = null,
    e !== null && (n = t.deletions,
    n === null ? (t.deletions = [e],
    t.flags |= 16) : n.push(e)),
    t.child = r,
    t.memoizedState = null,
    r
}
function yo(e, t) {
    return t = Hl({
        mode: "visible",
        children: t
    }, e.mode, 0, null),
    t.return = e,
    e.child = t
}
function Mr(e, t, n, r) {
    return r !== null && lo(r),
    Cn(t, e.child, null, n),
    e = yo(t, t.pendingProps.children),
    e.flags |= 2,
    t.memoizedState = null,
    e
}
function Gf(e, t, n, r, l, s, o) {
    if (n)
        return t.flags & 256 ? (t.flags &= -257,
        r = _s(Error(S(422))),
        Mr(e, t, o, r)) : t.memoizedState !== null ? (t.child = e.child,
        t.flags |= 128,
        null) : (s = r.fallback,
        l = t.mode,
        r = Hl({
            mode: "visible",
            children: r.children
        }, l, 0, null),
        s = Ht(s, l, o, null),
        s.flags |= 2,
        r.return = t,
        s.return = t,
        r.sibling = s,
        t.child = r,
        t.mode & 1 && Cn(t, e.child, null, o),
        t.child.memoizedState = yi(o),
        t.memoizedState = vi,
        s);
    if (!(t.mode & 1))
        return Mr(e, t, o, null);
    if (l.data === "$!") {
        if (r = l.nextSibling && l.nextSibling.dataset,
        r)
            var a = r.dgst;
        return r = a,
        s = Error(S(419)),
        r = _s(s, r, void 0),
        Mr(e, t, o, r)
    }
    if (a = (o & e.childLanes) !== 0,
    ve || a) {
        if (r = le,
        r !== null) {
            switch (o & -o) {
            case 4:
                l = 2;
                break;
            case 16:
                l = 8;
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
                l = 32;
                break;
            case 536870912:
                l = 268435456;
                break;
            default:
                l = 0
            }
            l = l & (r.suspendedLanes | o) ? 0 : l,
            l !== 0 && l !== s.retryLane && (s.retryLane = l,
            ft(e, l),
            Be(r, e, l, -1))
        }
        return Eo(),
        r = _s(Error(S(421))),
        Mr(e, t, o, r)
    }
    return l.data === "$?" ? (t.flags |= 128,
    t.child = e.child,
    t = op.bind(null, e),
    l._reactRetry = t,
    null) : (e = s.treeContext,
    ke = bt(l.nextSibling),
    Ee = t,
    Q = !0,
    Me = null,
    e !== null && (Re[Le++] = at,
    Re[Le++] = ut,
    Re[Le++] = Gt,
    at = e.id,
    ut = e.overflow,
    Gt = t),
    t = yo(t, r.children),
    t.flags |= 4096,
    t)
}
function za(e, t, n) {
    e.lanes |= t;
    var r = e.alternate;
    r !== null && (r.lanes |= t),
    mi(e.return, t, n)
}
function Ps(e, t, n, r, l) {
    var s = e.memoizedState;
    s === null ? e.memoizedState = {
        isBackwards: t,
        rendering: null,
        renderingStartTime: 0,
        last: r,
        tail: n,
        tailMode: l
    } : (s.isBackwards = t,
    s.rendering = null,
    s.renderingStartTime = 0,
    s.last = r,
    s.tail = n,
    s.tailMode = l)
}
function ed(e, t, n) {
    var r = t.pendingProps
      , l = r.revealOrder
      , s = r.tail;
    if (fe(e, t, r.children, n),
    r = G.current,
    r & 2)
        r = r & 1 | 2,
        t.flags |= 128;
    else {
        if (e !== null && e.flags & 128)
            e: for (e = t.child; e !== null; ) {
                if (e.tag === 13)
                    e.memoizedState !== null && za(e, n, t);
                else if (e.tag === 19)
                    za(e, n, t);
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
    if (V(G, r),
    !(t.mode & 1))
        t.memoizedState = null;
    else
        switch (l) {
        case "forwards":
            for (n = t.child,
            l = null; n !== null; )
                e = n.alternate,
                e !== null && jl(e) === null && (l = n),
                n = n.sibling;
            n = l,
            n === null ? (l = t.child,
            t.child = null) : (l = n.sibling,
            n.sibling = null),
            Ps(t, !1, l, n, s);
            break;
        case "backwards":
            for (n = null,
            l = t.child,
            t.child = null; l !== null; ) {
                if (e = l.alternate,
                e !== null && jl(e) === null) {
                    t.child = l;
                    break
                }
                e = l.sibling,
                l.sibling = n,
                n = l,
                l = e
            }
            Ps(t, !0, n, null, s);
            break;
        case "together":
            Ps(t, !1, null, null, void 0);
            break;
        default:
            t.memoizedState = null
        }
    return t.child
}
function tl(e, t) {
    !(t.mode & 1) && e !== null && (e.alternate = null,
    t.alternate = null,
    t.flags |= 2)
}
function pt(e, t, n) {
    if (e !== null && (t.dependencies = e.dependencies),
    Yt |= t.lanes,
    !(n & t.childLanes))
        return null;
    if (e !== null && t.child !== e.child)
        throw Error(S(153));
    if (t.child !== null) {
        for (e = t.child,
        n = Lt(e, e.pendingProps),
        t.child = n,
        n.return = t; e.sibling !== null; )
            e = e.sibling,
            n = n.sibling = Lt(e, e.pendingProps),
            n.return = t;
        n.sibling = null
    }
    return t.child
}
function Xf(e, t, n) {
    switch (t.tag) {
    case 3:
        Zc(t),
        En();
        break;
    case 5:
        bc(t);
        break;
    case 1:
        we(t.type) && gl(t);
        break;
    case 4:
        co(t, t.stateNode.containerInfo);
        break;
    case 10:
        var r = t.type._context
          , l = t.memoizedProps.value;
        V(yl, r._currentValue),
        r._currentValue = l;
        break;
    case 13:
        if (r = t.memoizedState,
        r !== null)
            return r.dehydrated !== null ? (V(G, G.current & 1),
            t.flags |= 128,
            null) : n & t.child.childLanes ? qc(e, t, n) : (V(G, G.current & 1),
            e = pt(e, t, n),
            e !== null ? e.sibling : null);
        V(G, G.current & 1);
        break;
    case 19:
        if (r = (n & t.childLanes) !== 0,
        e.flags & 128) {
            if (r)
                return ed(e, t, n);
            t.flags |= 128
        }
        if (l = t.memoizedState,
        l !== null && (l.rendering = null,
        l.tail = null,
        l.lastEffect = null),
        V(G, G.current),
        r)
            break;
        return null;
    case 22:
    case 23:
        return t.lanes = 0,
        Yc(e, t, n)
    }
    return pt(e, t, n)
}
var td, wi, nd, rd;
td = function(e, t) {
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
wi = function() {}
;
nd = function(e, t, n, r) {
    var l = e.memoizedProps;
    if (l !== r) {
        e = t.stateNode,
        Vt(qe.current);
        var s = null;
        switch (n) {
        case "input":
            l = Bs(e, l),
            r = Bs(e, r),
            s = [];
            break;
        case "select":
            l = Y({}, l, {
                value: void 0
            }),
            r = Y({}, r, {
                value: void 0
            }),
            s = [];
            break;
        case "textarea":
            l = Hs(e, l),
            r = Hs(e, r),
            s = [];
            break;
        default:
            typeof l.onClick != "function" && typeof r.onClick == "function" && (e.onclick = pl)
        }
        Ks(n, r);
        var o;
        n = null;
        for (d in l)
            if (!r.hasOwnProperty(d) && l.hasOwnProperty(d) && l[d] != null)
                if (d === "style") {
                    var a = l[d];
                    for (o in a)
                        a.hasOwnProperty(o) && (n || (n = {}),
                        n[o] = "")
                } else
                    d !== "dangerouslySetInnerHTML" && d !== "children" && d !== "suppressContentEditableWarning" && d !== "suppressHydrationWarning" && d !== "autoFocus" && (nr.hasOwnProperty(d) ? s || (s = []) : (s = s || []).push(d, null));
        for (d in r) {
            var u = r[d];
            if (a = l != null ? l[d] : void 0,
            r.hasOwnProperty(d) && u !== a && (u != null || a != null))
                if (d === "style")
                    if (a) {
                        for (o in a)
                            !a.hasOwnProperty(o) || u && u.hasOwnProperty(o) || (n || (n = {}),
                            n[o] = "");
                        for (o in u)
                            u.hasOwnProperty(o) && a[o] !== u[o] && (n || (n = {}),
                            n[o] = u[o])
                    } else
                        n || (s || (s = []),
                        s.push(d, n)),
                        n = u;
                else
                    d === "dangerouslySetInnerHTML" ? (u = u ? u.__html : void 0,
                    a = a ? a.__html : void 0,
                    u != null && a !== u && (s = s || []).push(d, u)) : d === "children" ? typeof u != "string" && typeof u != "number" || (s = s || []).push(d, "" + u) : d !== "suppressContentEditableWarning" && d !== "suppressHydrationWarning" && (nr.hasOwnProperty(d) ? (u != null && d === "onScroll" && W("scroll", e),
                    s || a === u || (s = [])) : (s = s || []).push(d, u))
        }
        n && (s = s || []).push("style", n);
        var d = s;
        (t.updateQueue = d) && (t.flags |= 4)
    }
}
;
rd = function(e, t, n, r) {
    n !== r && (t.flags |= 4)
}
;
function $n(e, t) {
    if (!Q)
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
function ce(e) {
    var t = e.alternate !== null && e.alternate.child === e.child
      , n = 0
      , r = 0;
    if (t)
        for (var l = e.child; l !== null; )
            n |= l.lanes | l.childLanes,
            r |= l.subtreeFlags & 14680064,
            r |= l.flags & 14680064,
            l.return = e,
            l = l.sibling;
    else
        for (l = e.child; l !== null; )
            n |= l.lanes | l.childLanes,
            r |= l.subtreeFlags,
            r |= l.flags,
            l.return = e,
            l = l.sibling;
    return e.subtreeFlags |= r,
    e.childLanes = n,
    t
}
function Yf(e, t, n) {
    var r = t.pendingProps;
    switch (ro(t),
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
        return ce(t),
        null;
    case 1:
        return we(t.type) && hl(),
        ce(t),
        null;
    case 3:
        return r = t.stateNode,
        bn(),
        H(ye),
        H(me),
        fo(),
        r.pendingContext && (r.context = r.pendingContext,
        r.pendingContext = null),
        (e === null || e.child === null) && (Ar(t) ? t.flags |= 4 : e === null || e.memoizedState.isDehydrated && !(t.flags & 256) || (t.flags |= 1024,
        Me !== null && (_i(Me),
        Me = null))),
        wi(e, t),
        ce(t),
        null;
    case 5:
        mo(t);
        var l = Vt(pr.current);
        if (n = t.type,
        e !== null && t.stateNode != null)
            nd(e, t, n, r, l),
            e.ref !== t.ref && (t.flags |= 512,
            t.flags |= 2097152);
        else {
            if (!r) {
                if (t.stateNode === null)
                    throw Error(S(166));
                return ce(t),
                null
            }
            if (e = Vt(qe.current),
            Ar(t)) {
                r = t.stateNode,
                n = t.type;
                var s = t.memoizedProps;
                switch (r[Ye] = t,
                r[mr] = s,
                e = (t.mode & 1) !== 0,
                n) {
                case "dialog":
                    W("cancel", r),
                    W("close", r);
                    break;
                case "iframe":
                case "object":
                case "embed":
                    W("load", r);
                    break;
                case "video":
                case "audio":
                    for (l = 0; l < Qn.length; l++)
                        W(Qn[l], r);
                    break;
                case "source":
                    W("error", r);
                    break;
                case "img":
                case "image":
                case "link":
                    W("error", r),
                    W("load", r);
                    break;
                case "details":
                    W("toggle", r);
                    break;
                case "input":
                    $o(r, s),
                    W("invalid", r);
                    break;
                case "select":
                    r._wrapperState = {
                        wasMultiple: !!s.multiple
                    },
                    W("invalid", r);
                    break;
                case "textarea":
                    Vo(r, s),
                    W("invalid", r)
                }
                Ks(n, s),
                l = null;
                for (var o in s)
                    if (s.hasOwnProperty(o)) {
                        var a = s[o];
                        o === "children" ? typeof a == "string" ? r.textContent !== a && (s.suppressHydrationWarning !== !0 && Ir(r.textContent, a, e),
                        l = ["children", a]) : typeof a == "number" && r.textContent !== "" + a && (s.suppressHydrationWarning !== !0 && Ir(r.textContent, a, e),
                        l = ["children", "" + a]) : nr.hasOwnProperty(o) && a != null && o === "onScroll" && W("scroll", r)
                    }
                switch (n) {
                case "input":
                    Pr(r),
                    Bo(r, s, !0);
                    break;
                case "textarea":
                    Pr(r),
                    Wo(r);
                    break;
                case "select":
                case "option":
                    break;
                default:
                    typeof s.onClick == "function" && (r.onclick = pl)
                }
                r = l,
                t.updateQueue = r,
                r !== null && (t.flags |= 4)
            } else {
                o = l.nodeType === 9 ? l : l.ownerDocument,
                e === "http://www.w3.org/1999/xhtml" && (e = Ru(n)),
                e === "http://www.w3.org/1999/xhtml" ? n === "script" ? (e = o.createElement("div"),
                e.innerHTML = "<script><\/script>",
                e = e.removeChild(e.firstChild)) : typeof r.is == "string" ? e = o.createElement(n, {
                    is: r.is
                }) : (e = o.createElement(n),
                n === "select" && (o = e,
                r.multiple ? o.multiple = !0 : r.size && (o.size = r.size))) : e = o.createElementNS(e, n),
                e[Ye] = t,
                e[mr] = r,
                td(e, t, !1, !1),
                t.stateNode = e;
                e: {
                    switch (o = Gs(n, r),
                    n) {
                    case "dialog":
                        W("cancel", e),
                        W("close", e),
                        l = r;
                        break;
                    case "iframe":
                    case "object":
                    case "embed":
                        W("load", e),
                        l = r;
                        break;
                    case "video":
                    case "audio":
                        for (l = 0; l < Qn.length; l++)
                            W(Qn[l], e);
                        l = r;
                        break;
                    case "source":
                        W("error", e),
                        l = r;
                        break;
                    case "img":
                    case "image":
                    case "link":
                        W("error", e),
                        W("load", e),
                        l = r;
                        break;
                    case "details":
                        W("toggle", e),
                        l = r;
                        break;
                    case "input":
                        $o(e, r),
                        l = Bs(e, r),
                        W("invalid", e);
                        break;
                    case "option":
                        l = r;
                        break;
                    case "select":
                        e._wrapperState = {
                            wasMultiple: !!r.multiple
                        },
                        l = Y({}, r, {
                            value: void 0
                        }),
                        W("invalid", e);
                        break;
                    case "textarea":
                        Vo(e, r),
                        l = Hs(e, r),
                        W("invalid", e);
                        break;
                    default:
                        l = r
                    }
                    Ks(n, l),
                    a = l;
                    for (s in a)
                        if (a.hasOwnProperty(s)) {
                            var u = a[s];
                            s === "style" ? Tu(e, u) : s === "dangerouslySetInnerHTML" ? (u = u ? u.__html : void 0,
                            u != null && Lu(e, u)) : s === "children" ? typeof u == "string" ? (n !== "textarea" || u !== "") && rr(e, u) : typeof u == "number" && rr(e, "" + u) : s !== "suppressContentEditableWarning" && s !== "suppressHydrationWarning" && s !== "autoFocus" && (nr.hasOwnProperty(s) ? u != null && s === "onScroll" && W("scroll", e) : u != null && Bi(e, s, u, o))
                        }
                    switch (n) {
                    case "input":
                        Pr(e),
                        Bo(e, r, !1);
                        break;
                    case "textarea":
                        Pr(e),
                        Wo(e);
                        break;
                    case "option":
                        r.value != null && e.setAttribute("value", "" + zt(r.value));
                        break;
                    case "select":
                        e.multiple = !!r.multiple,
                        s = r.value,
                        s != null ? xn(e, !!r.multiple, s, !1) : r.defaultValue != null && xn(e, !!r.multiple, r.defaultValue, !0);
                        break;
                    default:
                        typeof l.onClick == "function" && (e.onclick = pl)
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
        return ce(t),
        null;
    case 6:
        if (e && t.stateNode != null)
            rd(e, t, e.memoizedProps, r);
        else {
            if (typeof r != "string" && t.stateNode === null)
                throw Error(S(166));
            if (n = Vt(pr.current),
            Vt(qe.current),
            Ar(t)) {
                if (r = t.stateNode,
                n = t.memoizedProps,
                r[Ye] = t,
                (s = r.nodeValue !== n) && (e = Ee,
                e !== null))
                    switch (e.tag) {
                    case 3:
                        Ir(r.nodeValue, n, (e.mode & 1) !== 0);
                        break;
                    case 5:
                        e.memoizedProps.suppressHydrationWarning !== !0 && Ir(r.nodeValue, n, (e.mode & 1) !== 0)
                    }
                s && (t.flags |= 4)
            } else
                r = (n.nodeType === 9 ? n : n.ownerDocument).createTextNode(r),
                r[Ye] = t,
                t.stateNode = r
        }
        return ce(t),
        null;
    case 13:
        if (H(G),
        r = t.memoizedState,
        e === null || e.memoizedState !== null && e.memoizedState.dehydrated !== null) {
            if (Q && ke !== null && t.mode & 1 && !(t.flags & 128))
                wc(),
                En(),
                t.flags |= 98560,
                s = !1;
            else if (s = Ar(t),
            r !== null && r.dehydrated !== null) {
                if (e === null) {
                    if (!s)
                        throw Error(S(318));
                    if (s = t.memoizedState,
                    s = s !== null ? s.dehydrated : null,
                    !s)
                        throw Error(S(317));
                    s[Ye] = t
                } else
                    En(),
                    !(t.flags & 128) && (t.memoizedState = null),
                    t.flags |= 4;
                ce(t),
                s = !1
            } else
                Me !== null && (_i(Me),
                Me = null),
                s = !0;
            if (!s)
                return t.flags & 65536 ? t : null
        }
        return t.flags & 128 ? (t.lanes = n,
        t) : (r = r !== null,
        r !== (e !== null && e.memoizedState !== null) && r && (t.child.flags |= 8192,
        t.mode & 1 && (e === null || G.current & 1 ? te === 0 && (te = 3) : Eo())),
        t.updateQueue !== null && (t.flags |= 4),
        ce(t),
        null);
    case 4:
        return bn(),
        wi(e, t),
        e === null && cr(t.stateNode.containerInfo),
        ce(t),
        null;
    case 10:
        return oo(t.type._context),
        ce(t),
        null;
    case 17:
        return we(t.type) && hl(),
        ce(t),
        null;
    case 19:
        if (H(G),
        s = t.memoizedState,
        s === null)
            return ce(t),
            null;
        if (r = (t.flags & 128) !== 0,
        o = s.rendering,
        o === null)
            if (r)
                $n(s, !1);
            else {
                if (te !== 0 || e !== null && e.flags & 128)
                    for (e = t.child; e !== null; ) {
                        if (o = jl(e),
                        o !== null) {
                            for (t.flags |= 128,
                            $n(s, !1),
                            r = o.updateQueue,
                            r !== null && (t.updateQueue = r,
                            t.flags |= 4),
                            t.subtreeFlags = 0,
                            r = n,
                            n = t.child; n !== null; )
                                s = n,
                                e = r,
                                s.flags &= 14680066,
                                o = s.alternate,
                                o === null ? (s.childLanes = 0,
                                s.lanes = e,
                                s.child = null,
                                s.subtreeFlags = 0,
                                s.memoizedProps = null,
                                s.memoizedState = null,
                                s.updateQueue = null,
                                s.dependencies = null,
                                s.stateNode = null) : (s.childLanes = o.childLanes,
                                s.lanes = o.lanes,
                                s.child = o.child,
                                s.subtreeFlags = 0,
                                s.deletions = null,
                                s.memoizedProps = o.memoizedProps,
                                s.memoizedState = o.memoizedState,
                                s.updateQueue = o.updateQueue,
                                s.type = o.type,
                                e = o.dependencies,
                                s.dependencies = e === null ? null : {
                                    lanes: e.lanes,
                                    firstContext: e.firstContext
                                }),
                                n = n.sibling;
                            return V(G, G.current & 1 | 2),
                            t.child
                        }
                        e = e.sibling
                    }
                s.tail !== null && Z() > Pn && (t.flags |= 128,
                r = !0,
                $n(s, !1),
                t.lanes = 4194304)
            }
        else {
            if (!r)
                if (e = jl(o),
                e !== null) {
                    if (t.flags |= 128,
                    r = !0,
                    n = e.updateQueue,
                    n !== null && (t.updateQueue = n,
                    t.flags |= 4),
                    $n(s, !0),
                    s.tail === null && s.tailMode === "hidden" && !o.alternate && !Q)
                        return ce(t),
                        null
                } else
                    2 * Z() - s.renderingStartTime > Pn && n !== 1073741824 && (t.flags |= 128,
                    r = !0,
                    $n(s, !1),
                    t.lanes = 4194304);
            s.isBackwards ? (o.sibling = t.child,
            t.child = o) : (n = s.last,
            n !== null ? n.sibling = o : t.child = o,
            s.last = o)
        }
        return s.tail !== null ? (t = s.tail,
        s.rendering = t,
        s.tail = t.sibling,
        s.renderingStartTime = Z(),
        t.sibling = null,
        n = G.current,
        V(G, r ? n & 1 | 2 : n & 1),
        t) : (ce(t),
        null);
    case 22:
    case 23:
        return ko(),
        r = t.memoizedState !== null,
        e !== null && e.memoizedState !== null !== r && (t.flags |= 8192),
        r && t.mode & 1 ? Se & 1073741824 && (ce(t),
        t.subtreeFlags & 6 && (t.flags |= 8192)) : ce(t),
        null;
    case 24:
        return null;
    case 25:
        return null
    }
    throw Error(S(156, t.tag))
}
function Jf(e, t) {
    switch (ro(t),
    t.tag) {
    case 1:
        return we(t.type) && hl(),
        e = t.flags,
        e & 65536 ? (t.flags = e & -65537 | 128,
        t) : null;
    case 3:
        return bn(),
        H(ye),
        H(me),
        fo(),
        e = t.flags,
        e & 65536 && !(e & 128) ? (t.flags = e & -65537 | 128,
        t) : null;
    case 5:
        return mo(t),
        null;
    case 13:
        if (H(G),
        e = t.memoizedState,
        e !== null && e.dehydrated !== null) {
            if (t.alternate === null)
                throw Error(S(340));
            En()
        }
        return e = t.flags,
        e & 65536 ? (t.flags = e & -65537 | 128,
        t) : null;
    case 19:
        return H(G),
        null;
    case 4:
        return bn(),
        null;
    case 10:
        return oo(t.type._context),
        null;
    case 22:
    case 23:
        return ko(),
        null;
    case 24:
        return null;
    default:
        return null
    }
}
var $r = !1
  , de = !1
  , Zf = typeof WeakSet == "function" ? WeakSet : Set
  , P = null;
function hn(e, t) {
    var n = e.ref;
    if (n !== null)
        if (typeof n == "function")
            try {
                n(null)
            } catch (r) {
                J(e, t, r)
            }
        else
            n.current = null
}
function Ni(e, t, n) {
    try {
        n()
    } catch (r) {
        J(e, t, r)
    }
}
var Ta = !1;
function qf(e, t) {
    if (li = dl,
    e = oc(),
    to(e)) {
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
                    var l = r.anchorOffset
                      , s = r.focusNode;
                    r = r.focusOffset;
                    try {
                        n.nodeType,
                        s.nodeType
                    } catch {
                        n = null;
                        break e
                    }
                    var o = 0
                      , a = -1
                      , u = -1
                      , d = 0
                      , p = 0
                      , c = e
                      , m = null;
                    t: for (; ; ) {
                        for (var x; c !== n || l !== 0 && c.nodeType !== 3 || (a = o + l),
                        c !== s || r !== 0 && c.nodeType !== 3 || (u = o + r),
                        c.nodeType === 3 && (o += c.nodeValue.length),
                        (x = c.firstChild) !== null; )
                            m = c,
                            c = x;
                        for (; ; ) {
                            if (c === e)
                                break t;
                            if (m === n && ++d === l && (a = o),
                            m === s && ++p === r && (u = o),
                            (x = c.nextSibling) !== null)
                                break;
                            c = m,
                            m = c.parentNode
                        }
                        c = x
                    }
                    n = a === -1 || u === -1 ? null : {
                        start: a,
                        end: u
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
    for (si = {
        focusedElem: e,
        selectionRange: n
    },
    dl = !1,
    P = t; P !== null; )
        if (t = P,
        e = t.child,
        (t.subtreeFlags & 1028) !== 0 && e !== null)
            e.return = t,
            P = e;
        else
            for (; P !== null; ) {
                t = P;
                try {
                    var y = t.alternate;
                    if (t.flags & 1024)
                        switch (t.tag) {
                        case 0:
                        case 11:
                        case 15:
                            break;
                        case 1:
                            if (y !== null) {
                                var w = y.memoizedProps
                                  , j = y.memoizedState
                                  , h = t.stateNode
                                  , f = h.getSnapshotBeforeUpdate(t.elementType === t.type ? w : Ie(t.type, w), j);
                                h.__reactInternalSnapshotBeforeUpdate = f
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
                            throw Error(S(163))
                        }
                } catch (N) {
                    J(t, t.return, N)
                }
                if (e = t.sibling,
                e !== null) {
                    e.return = t.return,
                    P = e;
                    break
                }
                P = t.return
            }
    return y = Ta,
    Ta = !1,
    y
}
function qn(e, t, n) {
    var r = t.updateQueue;
    if (r = r !== null ? r.lastEffect : null,
    r !== null) {
        var l = r = r.next;
        do {
            if ((l.tag & e) === e) {
                var s = l.destroy;
                l.destroy = void 0,
                s !== void 0 && Ni(t, n, s)
            }
            l = l.next
        } while (l !== r)
    }
}
function Vl(e, t) {
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
function ji(e) {
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
function ld(e) {
    var t = e.alternate;
    t !== null && (e.alternate = null,
    ld(t)),
    e.child = null,
    e.deletions = null,
    e.sibling = null,
    e.tag === 5 && (t = e.stateNode,
    t !== null && (delete t[Ye],
    delete t[mr],
    delete t[ai],
    delete t[Ff],
    delete t[Df])),
    e.stateNode = null,
    e.return = null,
    e.dependencies = null,
    e.memoizedProps = null,
    e.memoizedState = null,
    e.pendingProps = null,
    e.stateNode = null,
    e.updateQueue = null
}
function sd(e) {
    return e.tag === 5 || e.tag === 3 || e.tag === 4
}
function Oa(e) {
    e: for (; ; ) {
        for (; e.sibling === null; ) {
            if (e.return === null || sd(e.return))
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
function Si(e, t, n) {
    var r = e.tag;
    if (r === 5 || r === 6)
        e = e.stateNode,
        t ? n.nodeType === 8 ? n.parentNode.insertBefore(e, t) : n.insertBefore(e, t) : (n.nodeType === 8 ? (t = n.parentNode,
        t.insertBefore(e, n)) : (t = n,
        t.appendChild(e)),
        n = n._reactRootContainer,
        n != null || t.onclick !== null || (t.onclick = pl));
    else if (r !== 4 && (e = e.child,
    e !== null))
        for (Si(e, t, n),
        e = e.sibling; e !== null; )
            Si(e, t, n),
            e = e.sibling
}
function ki(e, t, n) {
    var r = e.tag;
    if (r === 5 || r === 6)
        e = e.stateNode,
        t ? n.insertBefore(e, t) : n.appendChild(e);
    else if (r !== 4 && (e = e.child,
    e !== null))
        for (ki(e, t, n),
        e = e.sibling; e !== null; )
            ki(e, t, n),
            e = e.sibling
}
var ie = null
  , Ue = !1;
function gt(e, t, n) {
    for (n = n.child; n !== null; )
        id(e, t, n),
        n = n.sibling
}
function id(e, t, n) {
    if (Ze && typeof Ze.onCommitFiberUnmount == "function")
        try {
            Ze.onCommitFiberUnmount(Fl, n)
        } catch {}
    switch (n.tag) {
    case 5:
        de || hn(n, t);
    case 6:
        var r = ie
          , l = Ue;
        ie = null,
        gt(e, t, n),
        ie = r,
        Ue = l,
        ie !== null && (Ue ? (e = ie,
        n = n.stateNode,
        e.nodeType === 8 ? e.parentNode.removeChild(n) : e.removeChild(n)) : ie.removeChild(n.stateNode));
        break;
    case 18:
        ie !== null && (Ue ? (e = ie,
        n = n.stateNode,
        e.nodeType === 8 ? js(e.parentNode, n) : e.nodeType === 1 && js(e, n),
        or(e)) : js(ie, n.stateNode));
        break;
    case 4:
        r = ie,
        l = Ue,
        ie = n.stateNode.containerInfo,
        Ue = !0,
        gt(e, t, n),
        ie = r,
        Ue = l;
        break;
    case 0:
    case 11:
    case 14:
    case 15:
        if (!de && (r = n.updateQueue,
        r !== null && (r = r.lastEffect,
        r !== null))) {
            l = r = r.next;
            do {
                var s = l
                  , o = s.destroy;
                s = s.tag,
                o !== void 0 && (s & 2 || s & 4) && Ni(n, t, o),
                l = l.next
            } while (l !== r)
        }
        gt(e, t, n);
        break;
    case 1:
        if (!de && (hn(n, t),
        r = n.stateNode,
        typeof r.componentWillUnmount == "function"))
            try {
                r.props = n.memoizedProps,
                r.state = n.memoizedState,
                r.componentWillUnmount()
            } catch (a) {
                J(n, t, a)
            }
        gt(e, t, n);
        break;
    case 21:
        gt(e, t, n);
        break;
    case 22:
        n.mode & 1 ? (de = (r = de) || n.memoizedState !== null,
        gt(e, t, n),
        de = r) : gt(e, t, n);
        break;
    default:
        gt(e, t, n)
    }
}
function Fa(e) {
    var t = e.updateQueue;
    if (t !== null) {
        e.updateQueue = null;
        var n = e.stateNode;
        n === null && (n = e.stateNode = new Zf),
        t.forEach(function(r) {
            var l = ap.bind(null, e, r);
            n.has(r) || (n.add(r),
            r.then(l, l))
        })
    }
}
function De(e, t) {
    var n = t.deletions;
    if (n !== null)
        for (var r = 0; r < n.length; r++) {
            var l = n[r];
            try {
                var s = e
                  , o = t
                  , a = o;
                e: for (; a !== null; ) {
                    switch (a.tag) {
                    case 5:
                        ie = a.stateNode,
                        Ue = !1;
                        break e;
                    case 3:
                        ie = a.stateNode.containerInfo,
                        Ue = !0;
                        break e;
                    case 4:
                        ie = a.stateNode.containerInfo,
                        Ue = !0;
                        break e
                    }
                    a = a.return
                }
                if (ie === null)
                    throw Error(S(160));
                id(s, o, l),
                ie = null,
                Ue = !1;
                var u = l.alternate;
                u !== null && (u.return = null),
                l.return = null
            } catch (d) {
                J(l, t, d)
            }
        }
    if (t.subtreeFlags & 12854)
        for (t = t.child; t !== null; )
            od(t, e),
            t = t.sibling
}
function od(e, t) {
    var n = e.alternate
      , r = e.flags;
    switch (e.tag) {
    case 0:
    case 11:
    case 14:
    case 15:
        if (De(t, e),
        Ge(e),
        r & 4) {
            try {
                qn(3, e, e.return),
                Vl(3, e)
            } catch (w) {
                J(e, e.return, w)
            }
            try {
                qn(5, e, e.return)
            } catch (w) {
                J(e, e.return, w)
            }
        }
        break;
    case 1:
        De(t, e),
        Ge(e),
        r & 512 && n !== null && hn(n, n.return);
        break;
    case 5:
        if (De(t, e),
        Ge(e),
        r & 512 && n !== null && hn(n, n.return),
        e.flags & 32) {
            var l = e.stateNode;
            try {
                rr(l, "")
            } catch (w) {
                J(e, e.return, w)
            }
        }
        if (r & 4 && (l = e.stateNode,
        l != null)) {
            var s = e.memoizedProps
              , o = n !== null ? n.memoizedProps : s
              , a = e.type
              , u = e.updateQueue;
            if (e.updateQueue = null,
            u !== null)
                try {
                    a === "input" && s.type === "radio" && s.name != null && _u(l, s),
                    Gs(a, o);
                    var d = Gs(a, s);
                    for (o = 0; o < u.length; o += 2) {
                        var p = u[o]
                          , c = u[o + 1];
                        p === "style" ? Tu(l, c) : p === "dangerouslySetInnerHTML" ? Lu(l, c) : p === "children" ? rr(l, c) : Bi(l, p, c, d)
                    }
                    switch (a) {
                    case "input":
                        Vs(l, s);
                        break;
                    case "textarea":
                        Pu(l, s);
                        break;
                    case "select":
                        var m = l._wrapperState.wasMultiple;
                        l._wrapperState.wasMultiple = !!s.multiple;
                        var x = s.value;
                        x != null ? xn(l, !!s.multiple, x, !1) : m !== !!s.multiple && (s.defaultValue != null ? xn(l, !!s.multiple, s.defaultValue, !0) : xn(l, !!s.multiple, s.multiple ? [] : "", !1))
                    }
                    l[mr] = s
                } catch (w) {
                    J(e, e.return, w)
                }
        }
        break;
    case 6:
        if (De(t, e),
        Ge(e),
        r & 4) {
            if (e.stateNode === null)
                throw Error(S(162));
            l = e.stateNode,
            s = e.memoizedProps;
            try {
                l.nodeValue = s
            } catch (w) {
                J(e, e.return, w)
            }
        }
        break;
    case 3:
        if (De(t, e),
        Ge(e),
        r & 4 && n !== null && n.memoizedState.isDehydrated)
            try {
                or(t.containerInfo)
            } catch (w) {
                J(e, e.return, w)
            }
        break;
    case 4:
        De(t, e),
        Ge(e);
        break;
    case 13:
        De(t, e),
        Ge(e),
        l = e.child,
        l.flags & 8192 && (s = l.memoizedState !== null,
        l.stateNode.isHidden = s,
        !s || l.alternate !== null && l.alternate.memoizedState !== null || (jo = Z())),
        r & 4 && Fa(e);
        break;
    case 22:
        if (p = n !== null && n.memoizedState !== null,
        e.mode & 1 ? (de = (d = de) || p,
        De(t, e),
        de = d) : De(t, e),
        Ge(e),
        r & 8192) {
            if (d = e.memoizedState !== null,
            (e.stateNode.isHidden = d) && !p && e.mode & 1)
                for (P = e,
                p = e.child; p !== null; ) {
                    for (c = P = p; P !== null; ) {
                        switch (m = P,
                        x = m.child,
                        m.tag) {
                        case 0:
                        case 11:
                        case 14:
                        case 15:
                            qn(4, m, m.return);
                            break;
                        case 1:
                            hn(m, m.return);
                            var y = m.stateNode;
                            if (typeof y.componentWillUnmount == "function") {
                                r = m,
                                n = m.return;
                                try {
                                    t = r,
                                    y.props = t.memoizedProps,
                                    y.state = t.memoizedState,
                                    y.componentWillUnmount()
                                } catch (w) {
                                    J(r, n, w)
                                }
                            }
                            break;
                        case 5:
                            hn(m, m.return);
                            break;
                        case 22:
                            if (m.memoizedState !== null) {
                                Ia(c);
                                continue
                            }
                        }
                        x !== null ? (x.return = m,
                        P = x) : Ia(c)
                    }
                    p = p.sibling
                }
            e: for (p = null,
            c = e; ; ) {
                if (c.tag === 5) {
                    if (p === null) {
                        p = c;
                        try {
                            l = c.stateNode,
                            d ? (s = l.style,
                            typeof s.setProperty == "function" ? s.setProperty("display", "none", "important") : s.display = "none") : (a = c.stateNode,
                            u = c.memoizedProps.style,
                            o = u != null && u.hasOwnProperty("display") ? u.display : null,
                            a.style.display = zu("display", o))
                        } catch (w) {
                            J(e, e.return, w)
                        }
                    }
                } else if (c.tag === 6) {
                    if (p === null)
                        try {
                            c.stateNode.nodeValue = d ? "" : c.memoizedProps
                        } catch (w) {
                            J(e, e.return, w)
                        }
                } else if ((c.tag !== 22 && c.tag !== 23 || c.memoizedState === null || c === e) && c.child !== null) {
                    c.child.return = c,
                    c = c.child;
                    continue
                }
                if (c === e)
                    break e;
                for (; c.sibling === null; ) {
                    if (c.return === null || c.return === e)
                        break e;
                    p === c && (p = null),
                    c = c.return
                }
                p === c && (p = null),
                c.sibling.return = c.return,
                c = c.sibling
            }
        }
        break;
    case 19:
        De(t, e),
        Ge(e),
        r & 4 && Fa(e);
        break;
    case 21:
        break;
    default:
        De(t, e),
        Ge(e)
    }
}
function Ge(e) {
    var t = e.flags;
    if (t & 2) {
        try {
            e: {
                for (var n = e.return; n !== null; ) {
                    if (sd(n)) {
                        var r = n;
                        break e
                    }
                    n = n.return
                }
                throw Error(S(160))
            }
            switch (r.tag) {
            case 5:
                var l = r.stateNode;
                r.flags & 32 && (rr(l, ""),
                r.flags &= -33);
                var s = Oa(e);
                ki(e, s, l);
                break;
            case 3:
            case 4:
                var o = r.stateNode.containerInfo
                  , a = Oa(e);
                Si(e, a, o);
                break;
            default:
                throw Error(S(161))
            }
        } catch (u) {
            J(e, e.return, u)
        }
        e.flags &= -3
    }
    t & 4096 && (e.flags &= -4097)
}
function ep(e, t, n) {
    P = e,
    ad(e)
}
function ad(e, t, n) {
    for (var r = (e.mode & 1) !== 0; P !== null; ) {
        var l = P
          , s = l.child;
        if (l.tag === 22 && r) {
            var o = l.memoizedState !== null || $r;
            if (!o) {
                var a = l.alternate
                  , u = a !== null && a.memoizedState !== null || de;
                a = $r;
                var d = de;
                if ($r = o,
                (de = u) && !d)
                    for (P = l; P !== null; )
                        o = P,
                        u = o.child,
                        o.tag === 22 && o.memoizedState !== null ? Aa(l) : u !== null ? (u.return = o,
                        P = u) : Aa(l);
                for (; s !== null; )
                    P = s,
                    ad(s),
                    s = s.sibling;
                P = l,
                $r = a,
                de = d
            }
            Da(e)
        } else
            l.subtreeFlags & 8772 && s !== null ? (s.return = l,
            P = s) : Da(e)
    }
}
function Da(e) {
    for (; P !== null; ) {
        var t = P;
        if (t.flags & 8772) {
            var n = t.alternate;
            try {
                if (t.flags & 8772)
                    switch (t.tag) {
                    case 0:
                    case 11:
                    case 15:
                        de || Vl(5, t);
                        break;
                    case 1:
                        var r = t.stateNode;
                        if (t.flags & 4 && !de)
                            if (n === null)
                                r.componentDidMount();
                            else {
                                var l = t.elementType === t.type ? n.memoizedProps : Ie(t.type, n.memoizedProps);
                                r.componentDidUpdate(l, n.memoizedState, r.__reactInternalSnapshotBeforeUpdate)
                            }
                        var s = t.updateQueue;
                        s !== null && ya(t, s, r);
                        break;
                    case 3:
                        var o = t.updateQueue;
                        if (o !== null) {
                            if (n = null,
                            t.child !== null)
                                switch (t.child.tag) {
                                case 5:
                                    n = t.child.stateNode;
                                    break;
                                case 1:
                                    n = t.child.stateNode
                                }
                            ya(t, o, n)
                        }
                        break;
                    case 5:
                        var a = t.stateNode;
                        if (n === null && t.flags & 4) {
                            n = a;
                            var u = t.memoizedProps;
                            switch (t.type) {
                            case "button":
                            case "input":
                            case "select":
                            case "textarea":
                                u.autoFocus && n.focus();
                                break;
                            case "img":
                                u.src && (n.src = u.src)
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
                            var d = t.alternate;
                            if (d !== null) {
                                var p = d.memoizedState;
                                if (p !== null) {
                                    var c = p.dehydrated;
                                    c !== null && or(c)
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
                        throw Error(S(163))
                    }
                de || t.flags & 512 && ji(t)
            } catch (m) {
                J(t, t.return, m)
            }
        }
        if (t === e) {
            P = null;
            break
        }
        if (n = t.sibling,
        n !== null) {
            n.return = t.return,
            P = n;
            break
        }
        P = t.return
    }
}
function Ia(e) {
    for (; P !== null; ) {
        var t = P;
        if (t === e) {
            P = null;
            break
        }
        var n = t.sibling;
        if (n !== null) {
            n.return = t.return,
            P = n;
            break
        }
        P = t.return
    }
}
function Aa(e) {
    for (; P !== null; ) {
        var t = P;
        try {
            switch (t.tag) {
            case 0:
            case 11:
            case 15:
                var n = t.return;
                try {
                    Vl(4, t)
                } catch (u) {
                    J(t, n, u)
                }
                break;
            case 1:
                var r = t.stateNode;
                if (typeof r.componentDidMount == "function") {
                    var l = t.return;
                    try {
                        r.componentDidMount()
                    } catch (u) {
                        J(t, l, u)
                    }
                }
                var s = t.return;
                try {
                    ji(t)
                } catch (u) {
                    J(t, s, u)
                }
                break;
            case 5:
                var o = t.return;
                try {
                    ji(t)
                } catch (u) {
                    J(t, o, u)
                }
            }
        } catch (u) {
            J(t, t.return, u)
        }
        if (t === e) {
            P = null;
            break
        }
        var a = t.sibling;
        if (a !== null) {
            a.return = t.return,
            P = a;
            break
        }
        P = t.return
    }
}
var tp = Math.ceil
  , El = ht.ReactCurrentDispatcher
  , wo = ht.ReactCurrentOwner
  , Te = ht.ReactCurrentBatchConfig
  , A = 0
  , le = null
  , q = null
  , oe = 0
  , Se = 0
  , gn = Ft(0)
  , te = 0
  , vr = null
  , Yt = 0
  , Wl = 0
  , No = 0
  , er = null
  , xe = null
  , jo = 0
  , Pn = 1 / 0
  , it = null
  , Cl = !1
  , Ei = null
  , Pt = null
  , Br = !1
  , jt = null
  , bl = 0
  , tr = 0
  , Ci = null
  , nl = -1
  , rl = 0;
function pe() {
    return A & 6 ? Z() : nl !== -1 ? nl : nl = Z()
}
function Rt(e) {
    return e.mode & 1 ? A & 2 && oe !== 0 ? oe & -oe : Af.transition !== null ? (rl === 0 && (rl = Hu()),
    rl) : (e = U,
    e !== 0 || (e = window.event,
    e = e === void 0 ? 16 : Zu(e.type)),
    e) : 1
}
function Be(e, t, n, r) {
    if (50 < tr)
        throw tr = 0,
        Ci = null,
        Error(S(185));
    jr(e, n, r),
    (!(A & 2) || e !== le) && (e === le && (!(A & 2) && (Wl |= n),
    te === 4 && wt(e, oe)),
    Ne(e, r),
    n === 1 && A === 0 && !(t.mode & 1) && (Pn = Z() + 500,
    Ml && Dt()))
}
function Ne(e, t) {
    var n = e.callbackNode;
    Im(e, t);
    var r = cl(e, e === le ? oe : 0);
    if (r === 0)
        n !== null && Ko(n),
        e.callbackNode = null,
        e.callbackPriority = 0;
    else if (t = r & -r,
    e.callbackPriority !== t) {
        if (n != null && Ko(n),
        t === 1)
            e.tag === 0 ? If(Ua.bind(null, e)) : xc(Ua.bind(null, e)),
            Tf(function() {
                !(A & 6) && Dt()
            }),
            n = null;
        else {
            switch (Qu(r)) {
            case 1:
                n = Ki;
                break;
            case 4:
                n = Vu;
                break;
            case 16:
                n = ul;
                break;
            case 536870912:
                n = Wu;
                break;
            default:
                n = ul
            }
            n = gd(n, ud.bind(null, e))
        }
        e.callbackPriority = t,
        e.callbackNode = n
    }
}
function ud(e, t) {
    if (nl = -1,
    rl = 0,
    A & 6)
        throw Error(S(327));
    var n = e.callbackNode;
    if (jn() && e.callbackNode !== n)
        return null;
    var r = cl(e, e === le ? oe : 0);
    if (r === 0)
        return null;
    if (r & 30 || r & e.expiredLanes || t)
        t = _l(e, r);
    else {
        t = r;
        var l = A;
        A |= 2;
        var s = dd();
        (le !== e || oe !== t) && (it = null,
        Pn = Z() + 500,
        Wt(e, t));
        do
            try {
                lp();
                break
            } catch (a) {
                cd(e, a)
            }
        while (!0);
        io(),
        El.current = s,
        A = l,
        q !== null ? t = 0 : (le = null,
        oe = 0,
        t = te)
    }
    if (t !== 0) {
        if (t === 2 && (l = qs(e),
        l !== 0 && (r = l,
        t = bi(e, l))),
        t === 1)
            throw n = vr,
            Wt(e, 0),
            wt(e, r),
            Ne(e, Z()),
            n;
        if (t === 6)
            wt(e, r);
        else {
            if (l = e.current.alternate,
            !(r & 30) && !np(l) && (t = _l(e, r),
            t === 2 && (s = qs(e),
            s !== 0 && (r = s,
            t = bi(e, s))),
            t === 1))
                throw n = vr,
                Wt(e, 0),
                wt(e, r),
                Ne(e, Z()),
                n;
            switch (e.finishedWork = l,
            e.finishedLanes = r,
            t) {
            case 0:
            case 1:
                throw Error(S(345));
            case 2:
                Mt(e, xe, it);
                break;
            case 3:
                if (wt(e, r),
                (r & 130023424) === r && (t = jo + 500 - Z(),
                10 < t)) {
                    if (cl(e, 0) !== 0)
                        break;
                    if (l = e.suspendedLanes,
                    (l & r) !== r) {
                        pe(),
                        e.pingedLanes |= e.suspendedLanes & l;
                        break
                    }
                    e.timeoutHandle = oi(Mt.bind(null, e, xe, it), t);
                    break
                }
                Mt(e, xe, it);
                break;
            case 4:
                if (wt(e, r),
                (r & 4194240) === r)
                    break;
                for (t = e.eventTimes,
                l = -1; 0 < r; ) {
                    var o = 31 - $e(r);
                    s = 1 << o,
                    o = t[o],
                    o > l && (l = o),
                    r &= ~s
                }
                if (r = l,
                r = Z() - r,
                r = (120 > r ? 120 : 480 > r ? 480 : 1080 > r ? 1080 : 1920 > r ? 1920 : 3e3 > r ? 3e3 : 4320 > r ? 4320 : 1960 * tp(r / 1960)) - r,
                10 < r) {
                    e.timeoutHandle = oi(Mt.bind(null, e, xe, it), r);
                    break
                }
                Mt(e, xe, it);
                break;
            case 5:
                Mt(e, xe, it);
                break;
            default:
                throw Error(S(329))
            }
        }
    }
    return Ne(e, Z()),
    e.callbackNode === n ? ud.bind(null, e) : null
}
function bi(e, t) {
    var n = er;
    return e.current.memoizedState.isDehydrated && (Wt(e, t).flags |= 256),
    e = _l(e, t),
    e !== 2 && (t = xe,
    xe = n,
    t !== null && _i(t)),
    e
}
function _i(e) {
    xe === null ? xe = e : xe.push.apply(xe, e)
}
function np(e) {
    for (var t = e; ; ) {
        if (t.flags & 16384) {
            var n = t.updateQueue;
            if (n !== null && (n = n.stores,
            n !== null))
                for (var r = 0; r < n.length; r++) {
                    var l = n[r]
                      , s = l.getSnapshot;
                    l = l.value;
                    try {
                        if (!Ve(s(), l))
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
function wt(e, t) {
    for (t &= ~No,
    t &= ~Wl,
    e.suspendedLanes |= t,
    e.pingedLanes &= ~t,
    e = e.expirationTimes; 0 < t; ) {
        var n = 31 - $e(t)
          , r = 1 << n;
        e[n] = -1,
        t &= ~r
    }
}
function Ua(e) {
    if (A & 6)
        throw Error(S(327));
    jn();
    var t = cl(e, 0);
    if (!(t & 1))
        return Ne(e, Z()),
        null;
    var n = _l(e, t);
    if (e.tag !== 0 && n === 2) {
        var r = qs(e);
        r !== 0 && (t = r,
        n = bi(e, r))
    }
    if (n === 1)
        throw n = vr,
        Wt(e, 0),
        wt(e, t),
        Ne(e, Z()),
        n;
    if (n === 6)
        throw Error(S(345));
    return e.finishedWork = e.current.alternate,
    e.finishedLanes = t,
    Mt(e, xe, it),
    Ne(e, Z()),
    null
}
function So(e, t) {
    var n = A;
    A |= 1;
    try {
        return e(t)
    } finally {
        A = n,
        A === 0 && (Pn = Z() + 500,
        Ml && Dt())
    }
}
function Jt(e) {
    jt !== null && jt.tag === 0 && !(A & 6) && jn();
    var t = A;
    A |= 1;
    var n = Te.transition
      , r = U;
    try {
        if (Te.transition = null,
        U = 1,
        e)
            return e()
    } finally {
        U = r,
        Te.transition = n,
        A = t,
        !(A & 6) && Dt()
    }
}
function ko() {
    Se = gn.current,
    H(gn)
}
function Wt(e, t) {
    e.finishedWork = null,
    e.finishedLanes = 0;
    var n = e.timeoutHandle;
    if (n !== -1 && (e.timeoutHandle = -1,
    zf(n)),
    q !== null)
        for (n = q.return; n !== null; ) {
            var r = n;
            switch (ro(r),
            r.tag) {
            case 1:
                r = r.type.childContextTypes,
                r != null && hl();
                break;
            case 3:
                bn(),
                H(ye),
                H(me),
                fo();
                break;
            case 5:
                mo(r);
                break;
            case 4:
                bn();
                break;
            case 13:
                H(G);
                break;
            case 19:
                H(G);
                break;
            case 10:
                oo(r.type._context);
                break;
            case 22:
            case 23:
                ko()
            }
            n = n.return
        }
    if (le = e,
    q = e = Lt(e.current, null),
    oe = Se = t,
    te = 0,
    vr = null,
    No = Wl = Yt = 0,
    xe = er = null,
    Bt !== null) {
        for (t = 0; t < Bt.length; t++)
            if (n = Bt[t],
            r = n.interleaved,
            r !== null) {
                n.interleaved = null;
                var l = r.next
                  , s = n.pending;
                if (s !== null) {
                    var o = s.next;
                    s.next = l,
                    r.next = o
                }
                n.pending = r
            }
        Bt = null
    }
    return e
}
function cd(e, t) {
    do {
        var n = q;
        try {
            if (io(),
            qr.current = kl,
            Sl) {
                for (var r = X.memoizedState; r !== null; ) {
                    var l = r.queue;
                    l !== null && (l.pending = null),
                    r = r.next
                }
                Sl = !1
            }
            if (Xt = 0,
            re = ee = X = null,
            Zn = !1,
            hr = 0,
            wo.current = null,
            n === null || n.return === null) {
                te = 1,
                vr = t,
                q = null;
                break
            }
            e: {
                var s = e
                  , o = n.return
                  , a = n
                  , u = t;
                if (t = oe,
                a.flags |= 32768,
                u !== null && typeof u == "object" && typeof u.then == "function") {
                    var d = u
                      , p = a
                      , c = p.tag;
                    if (!(p.mode & 1) && (c === 0 || c === 11 || c === 15)) {
                        var m = p.alternate;
                        m ? (p.updateQueue = m.updateQueue,
                        p.memoizedState = m.memoizedState,
                        p.lanes = m.lanes) : (p.updateQueue = null,
                        p.memoizedState = null)
                    }
                    var x = Ca(o);
                    if (x !== null) {
                        x.flags &= -257,
                        ba(x, o, a, s, t),
                        x.mode & 1 && Ea(s, d, t),
                        t = x,
                        u = d;
                        var y = t.updateQueue;
                        if (y === null) {
                            var w = new Set;
                            w.add(u),
                            t.updateQueue = w
                        } else
                            y.add(u);
                        break e
                    } else {
                        if (!(t & 1)) {
                            Ea(s, d, t),
                            Eo();
                            break e
                        }
                        u = Error(S(426))
                    }
                } else if (Q && a.mode & 1) {
                    var j = Ca(o);
                    if (j !== null) {
                        !(j.flags & 65536) && (j.flags |= 256),
                        ba(j, o, a, s, t),
                        lo(_n(u, a));
                        break e
                    }
                }
                s = u = _n(u, a),
                te !== 4 && (te = 2),
                er === null ? er = [s] : er.push(s),
                s = o;
                do {
                    switch (s.tag) {
                    case 3:
                        s.flags |= 65536,
                        t &= -t,
                        s.lanes |= t;
                        var h = Kc(s, u, t);
                        va(s, h);
                        break e;
                    case 1:
                        a = u;
                        var f = s.type
                          , g = s.stateNode;
                        if (!(s.flags & 128) && (typeof f.getDerivedStateFromError == "function" || g !== null && typeof g.componentDidCatch == "function" && (Pt === null || !Pt.has(g)))) {
                            s.flags |= 65536,
                            t &= -t,
                            s.lanes |= t;
                            var N = Gc(s, a, t);
                            va(s, N);
                            break e
                        }
                    }
                    s = s.return
                } while (s !== null)
            }
            fd(n)
        } catch (E) {
            t = E,
            q === n && n !== null && (q = n = n.return);
            continue
        }
        break
    } while (!0)
}
function dd() {
    var e = El.current;
    return El.current = kl,
    e === null ? kl : e
}
function Eo() {
    (te === 0 || te === 3 || te === 2) && (te = 4),
    le === null || !(Yt & 268435455) && !(Wl & 268435455) || wt(le, oe)
}
function _l(e, t) {
    var n = A;
    A |= 2;
    var r = dd();
    (le !== e || oe !== t) && (it = null,
    Wt(e, t));
    do
        try {
            rp();
            break
        } catch (l) {
            cd(e, l)
        }
    while (!0);
    if (io(),
    A = n,
    El.current = r,
    q !== null)
        throw Error(S(261));
    return le = null,
    oe = 0,
    te
}
function rp() {
    for (; q !== null; )
        md(q)
}
function lp() {
    for (; q !== null && !_m(); )
        md(q)
}
function md(e) {
    var t = hd(e.alternate, e, Se);
    e.memoizedProps = e.pendingProps,
    t === null ? fd(e) : q = t,
    wo.current = null
}
function fd(e) {
    var t = e;
    do {
        var n = t.alternate;
        if (e = t.return,
        t.flags & 32768) {
            if (n = Jf(n, t),
            n !== null) {
                n.flags &= 32767,
                q = n;
                return
            }
            if (e !== null)
                e.flags |= 32768,
                e.subtreeFlags = 0,
                e.deletions = null;
            else {
                te = 6,
                q = null;
                return
            }
        } else if (n = Yf(n, t, Se),
        n !== null) {
            q = n;
            return
        }
        if (t = t.sibling,
        t !== null) {
            q = t;
            return
        }
        q = t = e
    } while (t !== null);
    te === 0 && (te = 5)
}
function Mt(e, t, n) {
    var r = U
      , l = Te.transition;
    try {
        Te.transition = null,
        U = 1,
        sp(e, t, n, r)
    } finally {
        Te.transition = l,
        U = r
    }
    return null
}
function sp(e, t, n, r) {
    do
        jn();
    while (jt !== null);
    if (A & 6)
        throw Error(S(327));
    n = e.finishedWork;
    var l = e.finishedLanes;
    if (n === null)
        return null;
    if (e.finishedWork = null,
    e.finishedLanes = 0,
    n === e.current)
        throw Error(S(177));
    e.callbackNode = null,
    e.callbackPriority = 0;
    var s = n.lanes | n.childLanes;
    if (Am(e, s),
    e === le && (q = le = null,
    oe = 0),
    !(n.subtreeFlags & 2064) && !(n.flags & 2064) || Br || (Br = !0,
    gd(ul, function() {
        return jn(),
        null
    })),
    s = (n.flags & 15990) !== 0,
    n.subtreeFlags & 15990 || s) {
        s = Te.transition,
        Te.transition = null;
        var o = U;
        U = 1;
        var a = A;
        A |= 4,
        wo.current = null,
        qf(e, n),
        od(n, e),
        Ef(si),
        dl = !!li,
        si = li = null,
        e.current = n,
        ep(n),
        Pm(),
        A = a,
        U = o,
        Te.transition = s
    } else
        e.current = n;
    if (Br && (Br = !1,
    jt = e,
    bl = l),
    s = e.pendingLanes,
    s === 0 && (Pt = null),
    zm(n.stateNode),
    Ne(e, Z()),
    t !== null)
        for (r = e.onRecoverableError,
        n = 0; n < t.length; n++)
            l = t[n],
            r(l.value, {
                componentStack: l.stack,
                digest: l.digest
            });
    if (Cl)
        throw Cl = !1,
        e = Ei,
        Ei = null,
        e;
    return bl & 1 && e.tag !== 0 && jn(),
    s = e.pendingLanes,
    s & 1 ? e === Ci ? tr++ : (tr = 0,
    Ci = e) : tr = 0,
    Dt(),
    null
}
function jn() {
    if (jt !== null) {
        var e = Qu(bl)
          , t = Te.transition
          , n = U;
        try {
            if (Te.transition = null,
            U = 16 > e ? 16 : e,
            jt === null)
                var r = !1;
            else {
                if (e = jt,
                jt = null,
                bl = 0,
                A & 6)
                    throw Error(S(331));
                var l = A;
                for (A |= 4,
                P = e.current; P !== null; ) {
                    var s = P
                      , o = s.child;
                    if (P.flags & 16) {
                        var a = s.deletions;
                        if (a !== null) {
                            for (var u = 0; u < a.length; u++) {
                                var d = a[u];
                                for (P = d; P !== null; ) {
                                    var p = P;
                                    switch (p.tag) {
                                    case 0:
                                    case 11:
                                    case 15:
                                        qn(8, p, s)
                                    }
                                    var c = p.child;
                                    if (c !== null)
                                        c.return = p,
                                        P = c;
                                    else
                                        for (; P !== null; ) {
                                            p = P;
                                            var m = p.sibling
                                              , x = p.return;
                                            if (ld(p),
                                            p === d) {
                                                P = null;
                                                break
                                            }
                                            if (m !== null) {
                                                m.return = x,
                                                P = m;
                                                break
                                            }
                                            P = x
                                        }
                                }
                            }
                            var y = s.alternate;
                            if (y !== null) {
                                var w = y.child;
                                if (w !== null) {
                                    y.child = null;
                                    do {
                                        var j = w.sibling;
                                        w.sibling = null,
                                        w = j
                                    } while (w !== null)
                                }
                            }
                            P = s
                        }
                    }
                    if (s.subtreeFlags & 2064 && o !== null)
                        o.return = s,
                        P = o;
                    else
                        e: for (; P !== null; ) {
                            if (s = P,
                            s.flags & 2048)
                                switch (s.tag) {
                                case 0:
                                case 11:
                                case 15:
                                    qn(9, s, s.return)
                                }
                            var h = s.sibling;
                            if (h !== null) {
                                h.return = s.return,
                                P = h;
                                break e
                            }
                            P = s.return
                        }
                }
                var f = e.current;
                for (P = f; P !== null; ) {
                    o = P;
                    var g = o.child;
                    if (o.subtreeFlags & 2064 && g !== null)
                        g.return = o,
                        P = g;
                    else
                        e: for (o = f; P !== null; ) {
                            if (a = P,
                            a.flags & 2048)
                                try {
                                    switch (a.tag) {
                                    case 0:
                                    case 11:
                                    case 15:
                                        Vl(9, a)
                                    }
                                } catch (E) {
                                    J(a, a.return, E)
                                }
                            if (a === o) {
                                P = null;
                                break e
                            }
                            var N = a.sibling;
                            if (N !== null) {
                                N.return = a.return,
                                P = N;
                                break e
                            }
                            P = a.return
                        }
                }
                if (A = l,
                Dt(),
                Ze && typeof Ze.onPostCommitFiberRoot == "function")
                    try {
                        Ze.onPostCommitFiberRoot(Fl, e)
                    } catch {}
                r = !0
            }
            return r
        } finally {
            U = n,
            Te.transition = t
        }
    }
    return !1
}
function Ma(e, t, n) {
    t = _n(n, t),
    t = Kc(e, t, 1),
    e = _t(e, t, 1),
    t = pe(),
    e !== null && (jr(e, 1, t),
    Ne(e, t))
}
function J(e, t, n) {
    if (e.tag === 3)
        Ma(e, e, n);
    else
        for (; t !== null; ) {
            if (t.tag === 3) {
                Ma(t, e, n);
                break
            } else if (t.tag === 1) {
                var r = t.stateNode;
                if (typeof t.type.getDerivedStateFromError == "function" || typeof r.componentDidCatch == "function" && (Pt === null || !Pt.has(r))) {
                    e = _n(n, e),
                    e = Gc(t, e, 1),
                    t = _t(t, e, 1),
                    e = pe(),
                    t !== null && (jr(t, 1, e),
                    Ne(t, e));
                    break
                }
            }
            t = t.return
        }
}
function ip(e, t, n) {
    var r = e.pingCache;
    r !== null && r.delete(t),
    t = pe(),
    e.pingedLanes |= e.suspendedLanes & n,
    le === e && (oe & n) === n && (te === 4 || te === 3 && (oe & 130023424) === oe && 500 > Z() - jo ? Wt(e, 0) : No |= n),
    Ne(e, t)
}
function pd(e, t) {
    t === 0 && (e.mode & 1 ? (t = zr,
    zr <<= 1,
    !(zr & 130023424) && (zr = 4194304)) : t = 1);
    var n = pe();
    e = ft(e, t),
    e !== null && (jr(e, t, n),
    Ne(e, n))
}
function op(e) {
    var t = e.memoizedState
      , n = 0;
    t !== null && (n = t.retryLane),
    pd(e, n)
}
function ap(e, t) {
    var n = 0;
    switch (e.tag) {
    case 13:
        var r = e.stateNode
          , l = e.memoizedState;
        l !== null && (n = l.retryLane);
        break;
    case 19:
        r = e.stateNode;
        break;
    default:
        throw Error(S(314))
    }
    r !== null && r.delete(t),
    pd(e, n)
}
var hd;
hd = function(e, t, n) {
    if (e !== null)
        if (e.memoizedProps !== t.pendingProps || ye.current)
            ve = !0;
        else {
            if (!(e.lanes & n) && !(t.flags & 128))
                return ve = !1,
                Xf(e, t, n);
            ve = !!(e.flags & 131072)
        }
    else
        ve = !1,
        Q && t.flags & 1048576 && vc(t, vl, t.index);
    switch (t.lanes = 0,
    t.tag) {
    case 2:
        var r = t.type;
        tl(e, t),
        e = t.pendingProps;
        var l = kn(t, me.current);
        Nn(t, n),
        l = ho(null, t, r, e, l, n);
        var s = go();
        return t.flags |= 1,
        typeof l == "object" && l !== null && typeof l.render == "function" && l.$$typeof === void 0 ? (t.tag = 1,
        t.memoizedState = null,
        t.updateQueue = null,
        we(r) ? (s = !0,
        gl(t)) : s = !1,
        t.memoizedState = l.state !== null && l.state !== void 0 ? l.state : null,
        uo(t),
        l.updater = $l,
        t.stateNode = l,
        l._reactInternals = t,
        pi(t, r, e, n),
        t = xi(null, t, r, !0, s, n)) : (t.tag = 0,
        Q && s && no(t),
        fe(null, t, l, n),
        t = t.child),
        t;
    case 16:
        r = t.elementType;
        e: {
            switch (tl(e, t),
            e = t.pendingProps,
            l = r._init,
            r = l(r._payload),
            t.type = r,
            l = t.tag = cp(r),
            e = Ie(r, e),
            l) {
            case 0:
                t = gi(null, t, r, e, n);
                break e;
            case 1:
                t = Ra(null, t, r, e, n);
                break e;
            case 11:
                t = _a(null, t, r, e, n);
                break e;
            case 14:
                t = Pa(null, t, r, Ie(r.type, e), n);
                break e
            }
            throw Error(S(306, r, ""))
        }
        return t;
    case 0:
        return r = t.type,
        l = t.pendingProps,
        l = t.elementType === r ? l : Ie(r, l),
        gi(e, t, r, l, n);
    case 1:
        return r = t.type,
        l = t.pendingProps,
        l = t.elementType === r ? l : Ie(r, l),
        Ra(e, t, r, l, n);
    case 3:
        e: {
            if (Zc(t),
            e === null)
                throw Error(S(387));
            r = t.pendingProps,
            s = t.memoizedState,
            l = s.element,
            jc(e, t),
            Nl(t, r, null, n);
            var o = t.memoizedState;
            if (r = o.element,
            s.isDehydrated)
                if (s = {
                    element: r,
                    isDehydrated: !1,
                    cache: o.cache,
                    pendingSuspenseBoundaries: o.pendingSuspenseBoundaries,
                    transitions: o.transitions
                },
                t.updateQueue.baseState = s,
                t.memoizedState = s,
                t.flags & 256) {
                    l = _n(Error(S(423)), t),
                    t = La(e, t, r, n, l);
                    break e
                } else if (r !== l) {
                    l = _n(Error(S(424)), t),
                    t = La(e, t, r, n, l);
                    break e
                } else
                    for (ke = bt(t.stateNode.containerInfo.firstChild),
                    Ee = t,
                    Q = !0,
                    Me = null,
                    n = Cc(t, null, r, n),
                    t.child = n; n; )
                        n.flags = n.flags & -3 | 4096,
                        n = n.sibling;
            else {
                if (En(),
                r === l) {
                    t = pt(e, t, n);
                    break e
                }
                fe(e, t, r, n)
            }
            t = t.child
        }
        return t;
    case 5:
        return bc(t),
        e === null && di(t),
        r = t.type,
        l = t.pendingProps,
        s = e !== null ? e.memoizedProps : null,
        o = l.children,
        ii(r, l) ? o = null : s !== null && ii(r, s) && (t.flags |= 32),
        Jc(e, t),
        fe(e, t, o, n),
        t.child;
    case 6:
        return e === null && di(t),
        null;
    case 13:
        return qc(e, t, n);
    case 4:
        return co(t, t.stateNode.containerInfo),
        r = t.pendingProps,
        e === null ? t.child = Cn(t, null, r, n) : fe(e, t, r, n),
        t.child;
    case 11:
        return r = t.type,
        l = t.pendingProps,
        l = t.elementType === r ? l : Ie(r, l),
        _a(e, t, r, l, n);
    case 7:
        return fe(e, t, t.pendingProps, n),
        t.child;
    case 8:
        return fe(e, t, t.pendingProps.children, n),
        t.child;
    case 12:
        return fe(e, t, t.pendingProps.children, n),
        t.child;
    case 10:
        e: {
            if (r = t.type._context,
            l = t.pendingProps,
            s = t.memoizedProps,
            o = l.value,
            V(yl, r._currentValue),
            r._currentValue = o,
            s !== null)
                if (Ve(s.value, o)) {
                    if (s.children === l.children && !ye.current) {
                        t = pt(e, t, n);
                        break e
                    }
                } else
                    for (s = t.child,
                    s !== null && (s.return = t); s !== null; ) {
                        var a = s.dependencies;
                        if (a !== null) {
                            o = s.child;
                            for (var u = a.firstContext; u !== null; ) {
                                if (u.context === r) {
                                    if (s.tag === 1) {
                                        u = ct(-1, n & -n),
                                        u.tag = 2;
                                        var d = s.updateQueue;
                                        if (d !== null) {
                                            d = d.shared;
                                            var p = d.pending;
                                            p === null ? u.next = u : (u.next = p.next,
                                            p.next = u),
                                            d.pending = u
                                        }
                                    }
                                    s.lanes |= n,
                                    u = s.alternate,
                                    u !== null && (u.lanes |= n),
                                    mi(s.return, n, t),
                                    a.lanes |= n;
                                    break
                                }
                                u = u.next
                            }
                        } else if (s.tag === 10)
                            o = s.type === t.type ? null : s.child;
                        else if (s.tag === 18) {
                            if (o = s.return,
                            o === null)
                                throw Error(S(341));
                            o.lanes |= n,
                            a = o.alternate,
                            a !== null && (a.lanes |= n),
                            mi(o, n, t),
                            o = s.sibling
                        } else
                            o = s.child;
                        if (o !== null)
                            o.return = s;
                        else
                            for (o = s; o !== null; ) {
                                if (o === t) {
                                    o = null;
                                    break
                                }
                                if (s = o.sibling,
                                s !== null) {
                                    s.return = o.return,
                                    o = s;
                                    break
                                }
                                o = o.return
                            }
                        s = o
                    }
            fe(e, t, l.children, n),
            t = t.child
        }
        return t;
    case 9:
        return l = t.type,
        r = t.pendingProps.children,
        Nn(t, n),
        l = Oe(l),
        r = r(l),
        t.flags |= 1,
        fe(e, t, r, n),
        t.child;
    case 14:
        return r = t.type,
        l = Ie(r, t.pendingProps),
        l = Ie(r.type, l),
        Pa(e, t, r, l, n);
    case 15:
        return Xc(e, t, t.type, t.pendingProps, n);
    case 17:
        return r = t.type,
        l = t.pendingProps,
        l = t.elementType === r ? l : Ie(r, l),
        tl(e, t),
        t.tag = 1,
        we(r) ? (e = !0,
        gl(t)) : e = !1,
        Nn(t, n),
        kc(t, r, l),
        pi(t, r, l, n),
        xi(null, t, r, !0, e, n);
    case 19:
        return ed(e, t, n);
    case 22:
        return Yc(e, t, n)
    }
    throw Error(S(156, t.tag))
}
;
function gd(e, t) {
    return Bu(e, t)
}
function up(e, t, n, r) {
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
function ze(e, t, n, r) {
    return new up(e,t,n,r)
}
function Co(e) {
    return e = e.prototype,
    !(!e || !e.isReactComponent)
}
function cp(e) {
    if (typeof e == "function")
        return Co(e) ? 1 : 0;
    if (e != null) {
        if (e = e.$$typeof,
        e === Wi)
            return 11;
        if (e === Hi)
            return 14
    }
    return 2
}
function Lt(e, t) {
    var n = e.alternate;
    return n === null ? (n = ze(e.tag, t, e.key, e.mode),
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
function ll(e, t, n, r, l, s) {
    var o = 2;
    if (r = e,
    typeof e == "function")
        Co(e) && (o = 1);
    else if (typeof e == "string")
        o = 5;
    else
        e: switch (e) {
        case sn:
            return Ht(n.children, l, s, t);
        case Vi:
            o = 8,
            l |= 8;
            break;
        case As:
            return e = ze(12, n, t, l | 2),
            e.elementType = As,
            e.lanes = s,
            e;
        case Us:
            return e = ze(13, n, t, l),
            e.elementType = Us,
            e.lanes = s,
            e;
        case Ms:
            return e = ze(19, n, t, l),
            e.elementType = Ms,
            e.lanes = s,
            e;
        case Eu:
            return Hl(n, l, s, t);
        default:
            if (typeof e == "object" && e !== null)
                switch (e.$$typeof) {
                case Su:
                    o = 10;
                    break e;
                case ku:
                    o = 9;
                    break e;
                case Wi:
                    o = 11;
                    break e;
                case Hi:
                    o = 14;
                    break e;
                case xt:
                    o = 16,
                    r = null;
                    break e
                }
            throw Error(S(130, e == null ? e : typeof e, ""))
        }
    return t = ze(o, n, t, l),
    t.elementType = e,
    t.type = r,
    t.lanes = s,
    t
}
function Ht(e, t, n, r) {
    return e = ze(7, e, r, t),
    e.lanes = n,
    e
}
function Hl(e, t, n, r) {
    return e = ze(22, e, r, t),
    e.elementType = Eu,
    e.lanes = n,
    e.stateNode = {
        isHidden: !1
    },
    e
}
function Rs(e, t, n) {
    return e = ze(6, e, null, t),
    e.lanes = n,
    e
}
function Ls(e, t, n) {
    return t = ze(4, e.children !== null ? e.children : [], e.key, t),
    t.lanes = n,
    t.stateNode = {
        containerInfo: e.containerInfo,
        pendingChildren: null,
        implementation: e.implementation
    },
    t
}
function dp(e, t, n, r, l) {
    this.tag = t,
    this.containerInfo = e,
    this.finishedWork = this.pingCache = this.current = this.pendingChildren = null,
    this.timeoutHandle = -1,
    this.callbackNode = this.pendingContext = this.context = null,
    this.callbackPriority = 0,
    this.eventTimes = ds(0),
    this.expirationTimes = ds(-1),
    this.entangledLanes = this.finishedLanes = this.mutableReadLanes = this.expiredLanes = this.pingedLanes = this.suspendedLanes = this.pendingLanes = 0,
    this.entanglements = ds(0),
    this.identifierPrefix = r,
    this.onRecoverableError = l,
    this.mutableSourceEagerHydrationData = null
}
function bo(e, t, n, r, l, s, o, a, u) {
    return e = new dp(e,t,n,a,u),
    t === 1 ? (t = 1,
    s === !0 && (t |= 8)) : t = 0,
    s = ze(3, null, null, t),
    e.current = s,
    s.stateNode = e,
    s.memoizedState = {
        element: r,
        isDehydrated: n,
        cache: null,
        transitions: null,
        pendingSuspenseBoundaries: null
    },
    uo(s),
    e
}
function mp(e, t, n) {
    var r = 3 < arguments.length && arguments[3] !== void 0 ? arguments[3] : null;
    return {
        $$typeof: ln,
        key: r == null ? null : "" + r,
        children: e,
        containerInfo: t,
        implementation: n
    }
}
function xd(e) {
    if (!e)
        return Tt;
    e = e._reactInternals;
    e: {
        if (qt(e) !== e || e.tag !== 1)
            throw Error(S(170));
        var t = e;
        do {
            switch (t.tag) {
            case 3:
                t = t.stateNode.context;
                break e;
            case 1:
                if (we(t.type)) {
                    t = t.stateNode.__reactInternalMemoizedMergedChildContext;
                    break e
                }
            }
            t = t.return
        } while (t !== null);
        throw Error(S(171))
    }
    if (e.tag === 1) {
        var n = e.type;
        if (we(n))
            return gc(e, n, t)
    }
    return t
}
function vd(e, t, n, r, l, s, o, a, u) {
    return e = bo(n, r, !0, e, l, s, o, a, u),
    e.context = xd(null),
    n = e.current,
    r = pe(),
    l = Rt(n),
    s = ct(r, l),
    s.callback = t ?? null,
    _t(n, s, l),
    e.current.lanes = l,
    jr(e, l, r),
    Ne(e, r),
    e
}
function Ql(e, t, n, r) {
    var l = t.current
      , s = pe()
      , o = Rt(l);
    return n = xd(n),
    t.context === null ? t.context = n : t.pendingContext = n,
    t = ct(s, o),
    t.payload = {
        element: e
    },
    r = r === void 0 ? null : r,
    r !== null && (t.callback = r),
    e = _t(l, t, o),
    e !== null && (Be(e, l, o, s),
    Zr(e, l, o)),
    o
}
function Pl(e) {
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
function $a(e, t) {
    if (e = e.memoizedState,
    e !== null && e.dehydrated !== null) {
        var n = e.retryLane;
        e.retryLane = n !== 0 && n < t ? n : t
    }
}
function _o(e, t) {
    $a(e, t),
    (e = e.alternate) && $a(e, t)
}
function fp() {
    return null
}
var yd = typeof reportError == "function" ? reportError : function(e) {
    console.error(e)
}
;
function Po(e) {
    this._internalRoot = e
}
Kl.prototype.render = Po.prototype.render = function(e) {
    var t = this._internalRoot;
    if (t === null)
        throw Error(S(409));
    Ql(e, t, null, null)
}
;
Kl.prototype.unmount = Po.prototype.unmount = function() {
    var e = this._internalRoot;
    if (e !== null) {
        this._internalRoot = null;
        var t = e.containerInfo;
        Jt(function() {
            Ql(null, e, null, null)
        }),
        t[mt] = null
    }
}
;
function Kl(e) {
    this._internalRoot = e
}
Kl.prototype.unstable_scheduleHydration = function(e) {
    if (e) {
        var t = Xu();
        e = {
            blockedOn: null,
            target: e,
            priority: t
        };
        for (var n = 0; n < yt.length && t !== 0 && t < yt[n].priority; n++)
            ;
        yt.splice(n, 0, e),
        n === 0 && Ju(e)
    }
}
;
function Ro(e) {
    return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11)
}
function Gl(e) {
    return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11 && (e.nodeType !== 8 || e.nodeValue !== " react-mount-point-unstable "))
}
function Ba() {}
function pp(e, t, n, r, l) {
    if (l) {
        if (typeof r == "function") {
            var s = r;
            r = function() {
                var d = Pl(o);
                s.call(d)
            }
        }
        var o = vd(t, r, e, 0, null, !1, !1, "", Ba);
        return e._reactRootContainer = o,
        e[mt] = o.current,
        cr(e.nodeType === 8 ? e.parentNode : e),
        Jt(),
        o
    }
    for (; l = e.lastChild; )
        e.removeChild(l);
    if (typeof r == "function") {
        var a = r;
        r = function() {
            var d = Pl(u);
            a.call(d)
        }
    }
    var u = bo(e, 0, !1, null, null, !1, !1, "", Ba);
    return e._reactRootContainer = u,
    e[mt] = u.current,
    cr(e.nodeType === 8 ? e.parentNode : e),
    Jt(function() {
        Ql(t, u, n, r)
    }),
    u
}
function Xl(e, t, n, r, l) {
    var s = n._reactRootContainer;
    if (s) {
        var o = s;
        if (typeof l == "function") {
            var a = l;
            l = function() {
                var u = Pl(o);
                a.call(u)
            }
        }
        Ql(t, o, e, l)
    } else
        o = pp(n, t, e, l, r);
    return Pl(o)
}
Ku = function(e) {
    switch (e.tag) {
    case 3:
        var t = e.stateNode;
        if (t.current.memoizedState.isDehydrated) {
            var n = Hn(t.pendingLanes);
            n !== 0 && (Gi(t, n | 1),
            Ne(t, Z()),
            !(A & 6) && (Pn = Z() + 500,
            Dt()))
        }
        break;
    case 13:
        Jt(function() {
            var r = ft(e, 1);
            if (r !== null) {
                var l = pe();
                Be(r, e, 1, l)
            }
        }),
        _o(e, 1)
    }
}
;
Xi = function(e) {
    if (e.tag === 13) {
        var t = ft(e, 134217728);
        if (t !== null) {
            var n = pe();
            Be(t, e, 134217728, n)
        }
        _o(e, 134217728)
    }
}
;
Gu = function(e) {
    if (e.tag === 13) {
        var t = Rt(e)
          , n = ft(e, t);
        if (n !== null) {
            var r = pe();
            Be(n, e, t, r)
        }
        _o(e, t)
    }
}
;
Xu = function() {
    return U
}
;
Yu = function(e, t) {
    var n = U;
    try {
        return U = e,
        t()
    } finally {
        U = n
    }
}
;
Ys = function(e, t, n) {
    switch (t) {
    case "input":
        if (Vs(e, n),
        t = n.name,
        n.type === "radio" && t != null) {
            for (n = e; n.parentNode; )
                n = n.parentNode;
            for (n = n.querySelectorAll("input[name=" + JSON.stringify("" + t) + '][type="radio"]'),
            t = 0; t < n.length; t++) {
                var r = n[t];
                if (r !== e && r.form === e.form) {
                    var l = Ul(r);
                    if (!l)
                        throw Error(S(90));
                    bu(r),
                    Vs(r, l)
                }
            }
        }
        break;
    case "textarea":
        Pu(e, n);
        break;
    case "select":
        t = n.value,
        t != null && xn(e, !!n.multiple, t, !1)
    }
}
;
Du = So;
Iu = Jt;
var hp = {
    usingClientEntryPoint: !1,
    Events: [kr, cn, Ul, Ou, Fu, So]
}
  , Bn = {
    findFiberByHostInstance: $t,
    bundleType: 0,
    version: "18.2.0",
    rendererPackageName: "react-dom"
}
  , gp = {
    bundleType: Bn.bundleType,
    version: Bn.version,
    rendererPackageName: Bn.rendererPackageName,
    rendererConfig: Bn.rendererConfig,
    overrideHookState: null,
    overrideHookStateDeletePath: null,
    overrideHookStateRenamePath: null,
    overrideProps: null,
    overridePropsDeletePath: null,
    overridePropsRenamePath: null,
    setErrorHandler: null,
    setSuspenseHandler: null,
    scheduleUpdate: null,
    currentDispatcherRef: ht.ReactCurrentDispatcher,
    findHostInstanceByFiber: function(e) {
        return e = Mu(e),
        e === null ? null : e.stateNode
    },
    findFiberByHostInstance: Bn.findFiberByHostInstance || fp,
    findHostInstancesForRefresh: null,
    scheduleRefresh: null,
    scheduleRoot: null,
    setRefreshHandler: null,
    getCurrentFiber: null,
    reconcilerVersion: "18.2.0-next-9e3b772b8-20220608"
};
if (typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ < "u") {
    var Vr = __REACT_DEVTOOLS_GLOBAL_HOOK__;
    if (!Vr.isDisabled && Vr.supportsFiber)
        try {
            Fl = Vr.inject(gp),
            Ze = Vr
        } catch {}
}
be.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = hp;
be.createPortal = function(e, t) {
    var n = 2 < arguments.length && arguments[2] !== void 0 ? arguments[2] : null;
    if (!Ro(t))
        throw Error(S(200));
    return mp(e, t, null, n)
}
;
be.createRoot = function(e, t) {
    if (!Ro(e))
        throw Error(S(299));
    var n = !1
      , r = ""
      , l = yd;
    return t != null && (t.unstable_strictMode === !0 && (n = !0),
    t.identifierPrefix !== void 0 && (r = t.identifierPrefix),
    t.onRecoverableError !== void 0 && (l = t.onRecoverableError)),
    t = bo(e, 1, !1, null, null, n, !1, r, l),
    e[mt] = t.current,
    cr(e.nodeType === 8 ? e.parentNode : e),
    new Po(t)
}
;
be.findDOMNode = function(e) {
    if (e == null)
        return null;
    if (e.nodeType === 1)
        return e;
    var t = e._reactInternals;
    if (t === void 0)
        throw typeof e.render == "function" ? Error(S(188)) : (e = Object.keys(e).join(","),
        Error(S(268, e)));
    return e = Mu(t),
    e = e === null ? null : e.stateNode,
    e
}
;
be.flushSync = function(e) {
    return Jt(e)
}
;
be.hydrate = function(e, t, n) {
    if (!Gl(t))
        throw Error(S(200));
    return Xl(null, e, t, !0, n)
}
;
be.hydrateRoot = function(e, t, n) {
    if (!Ro(e))
        throw Error(S(405));
    var r = n != null && n.hydratedSources || null
      , l = !1
      , s = ""
      , o = yd;
    if (n != null && (n.unstable_strictMode === !0 && (l = !0),
    n.identifierPrefix !== void 0 && (s = n.identifierPrefix),
    n.onRecoverableError !== void 0 && (o = n.onRecoverableError)),
    t = vd(t, null, e, 1, n ?? null, l, !1, s, o),
    e[mt] = t.current,
    cr(e),
    r)
        for (e = 0; e < r.length; e++)
            n = r[e],
            l = n._getVersion,
            l = l(n._source),
            t.mutableSourceEagerHydrationData == null ? t.mutableSourceEagerHydrationData = [n, l] : t.mutableSourceEagerHydrationData.push(n, l);
    return new Kl(t)
}
;
be.render = function(e, t, n) {
    if (!Gl(t))
        throw Error(S(200));
    return Xl(null, e, t, !1, n)
}
;
be.unmountComponentAtNode = function(e) {
    if (!Gl(e))
        throw Error(S(40));
    return e._reactRootContainer ? (Jt(function() {
        Xl(null, null, e, !1, function() {
            e._reactRootContainer = null,
            e[mt] = null
        })
    }),
    !0) : !1
}
;
be.unstable_batchedUpdates = So;
be.unstable_renderSubtreeIntoContainer = function(e, t, n, r) {
    if (!Gl(n))
        throw Error(S(200));
    if (e == null || e._reactInternals === void 0)
        throw Error(S(38));
    return Xl(e, t, n, !1, r)
}
;
be.version = "18.2.0-next-9e3b772b8-20220608";
function wd() {
    if (!(typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ > "u" || typeof __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE != "function"))
        try {
            __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE(wd)
        } catch (e) {
            console.error(e)
        }
}
wd(),
vu.exports = be;
var xp = vu.exports
  , Va = xp;
Ds.createRoot = Va.createRoot,
Ds.hydrateRoot = Va.hydrateRoot;
/**
 * @remix-run/router v1.18.0
 *
 * Copyright (c) Remix Software Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.md file in the root directory of this source tree.
 *
 * @license MIT
 */
function yr() {
    return yr = Object.assign ? Object.assign.bind() : function(e) {
        for (var t = 1; t < arguments.length; t++) {
            var n = arguments[t];
            for (var r in n)
                Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r])
        }
        return e
    }
    ,
    yr.apply(this, arguments)
}
var St;
(function(e) {
    e.Pop = "POP",
    e.Push = "PUSH",
    e.Replace = "REPLACE"
}
)(St || (St = {}));
const Wa = "popstate";
function vp(e) {
    e === void 0 && (e = {});
    function t(r, l) {
        let {pathname: s, search: o, hash: a} = r.location;
        return Pi("", {
            pathname: s,
            search: o,
            hash: a
        }, l.state && l.state.usr || null, l.state && l.state.key || "default")
    }
    function n(r, l) {
        return typeof l == "string" ? l : jd(l)
    }
    return wp(t, n, null, e)
}
function ne(e, t) {
    if (e === !1 || e === null || typeof e > "u")
        throw new Error(t)
}
function Nd(e, t) {
    if (!e) {
        typeof console < "u" && console.warn(t);
        try {
            throw new Error(t)
        } catch {}
    }
}
function yp() {
    return Math.random().toString(36).substr(2, 8)
}
function Ha(e, t) {
    return {
        usr: e.state,
        key: e.key,
        idx: t
    }
}
function Pi(e, t, n, r) {
    return n === void 0 && (n = null),
    yr({
        pathname: typeof e == "string" ? e : e.pathname,
        search: "",
        hash: ""
    }, typeof t == "string" ? On(t) : t, {
        state: n,
        key: t && t.key || r || yp()
    })
}
function jd(e) {
    let {pathname: t="/", search: n="", hash: r=""} = e;
    return n && n !== "?" && (t += n.charAt(0) === "?" ? n : "?" + n),
    r && r !== "#" && (t += r.charAt(0) === "#" ? r : "#" + r),
    t
}
function On(e) {
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
function wp(e, t, n, r) {
    r === void 0 && (r = {});
    let {window: l=document.defaultView, v5Compat: s=!1} = r
      , o = l.history
      , a = St.Pop
      , u = null
      , d = p();
    d == null && (d = 0,
    o.replaceState(yr({}, o.state, {
        idx: d
    }), ""));
    function p() {
        return (o.state || {
            idx: null
        }).idx
    }
    function c() {
        a = St.Pop;
        let j = p()
          , h = j == null ? null : j - d;
        d = j,
        u && u({
            action: a,
            location: w.location,
            delta: h
        })
    }
    function m(j, h) {
        a = St.Push;
        let f = Pi(w.location, j, h);
        d = p() + 1;
        let g = Ha(f, d)
          , N = w.createHref(f);
        try {
            o.pushState(g, "", N)
        } catch (E) {
            if (E instanceof DOMException && E.name === "DataCloneError")
                throw E;
            l.location.assign(N)
        }
        s && u && u({
            action: a,
            location: w.location,
            delta: 1
        })
    }
    function x(j, h) {
        a = St.Replace;
        let f = Pi(w.location, j, h);
        d = p();
        let g = Ha(f, d)
          , N = w.createHref(f);
        o.replaceState(g, "", N),
        s && u && u({
            action: a,
            location: w.location,
            delta: 0
        })
    }
    function y(j) {
        let h = l.location.origin !== "null" ? l.location.origin : l.location.href
          , f = typeof j == "string" ? j : jd(j);
        return f = f.replace(/ $/, "%20"),
        ne(h, "No window.location.(origin|href) available to create URL for href: " + f),
        new URL(f,h)
    }
    let w = {
        get action() {
            return a
        },
        get location() {
            return e(l, o)
        },
        listen(j) {
            if (u)
                throw new Error("A history only accepts one active listener");
            return l.addEventListener(Wa, c),
            u = j,
            () => {
                l.removeEventListener(Wa, c),
                u = null
            }
        },
        createHref(j) {
            return t(l, j)
        },
        createURL: y,
        encodeLocation(j) {
            let h = y(j);
            return {
                pathname: h.pathname,
                search: h.search,
                hash: h.hash
            }
        },
        push: m,
        replace: x,
        go(j) {
            return o.go(j)
        }
    };
    return w
}
var Qa;
(function(e) {
    e.data = "data",
    e.deferred = "deferred",
    e.redirect = "redirect",
    e.error = "error"
}
)(Qa || (Qa = {}));
function Np(e, t, n) {
    return n === void 0 && (n = "/"),
    jp(e, t, n, !1)
}
function jp(e, t, n, r) {
    let l = typeof t == "string" ? On(t) : t
      , s = Ed(l.pathname || "/", n);
    if (s == null)
        return null;
    let o = Sd(e);
    Sp(o);
    let a = null;
    for (let u = 0; a == null && u < o.length; ++u) {
        let d = Op(s);
        a = zp(o[u], d, r)
    }
    return a
}
function Sd(e, t, n, r) {
    t === void 0 && (t = []),
    n === void 0 && (n = []),
    r === void 0 && (r = "");
    let l = (s, o, a) => {
        let u = {
            relativePath: a === void 0 ? s.path || "" : a,
            caseSensitive: s.caseSensitive === !0,
            childrenIndex: o,
            route: s
        };
        u.relativePath.startsWith("/") && (ne(u.relativePath.startsWith(r), 'Absolute route path "' + u.relativePath + '" nested under path ' + ('"' + r + '" is not valid. An absolute child route path ') + "must start with the combined path of all its parent routes."),
        u.relativePath = u.relativePath.slice(r.length));
        let d = Qt([r, u.relativePath])
          , p = n.concat(u);
        s.children && s.children.length > 0 && (ne(s.index !== !0, "Index routes must not have child routes. Please remove " + ('all child routes from route path "' + d + '".')),
        Sd(s.children, t, p, d)),
        !(s.path == null && !s.index) && t.push({
            path: d,
            score: Rp(d, s.index),
            routesMeta: p
        })
    }
    ;
    return e.forEach( (s, o) => {
        var a;
        if (s.path === "" || !((a = s.path) != null && a.includes("?")))
            l(s, o);
        else
            for (let u of kd(s.path))
                l(s, o, u)
    }
    ),
    t
}
function kd(e) {
    let t = e.split("/");
    if (t.length === 0)
        return [];
    let[n,...r] = t
      , l = n.endsWith("?")
      , s = n.replace(/\?$/, "");
    if (r.length === 0)
        return l ? [s, ""] : [s];
    let o = kd(r.join("/"))
      , a = [];
    return a.push(...o.map(u => u === "" ? s : [s, u].join("/"))),
    l && a.push(...o),
    a.map(u => e.startsWith("/") && u === "" ? "/" : u)
}
function Sp(e) {
    e.sort( (t, n) => t.score !== n.score ? n.score - t.score : Lp(t.routesMeta.map(r => r.childrenIndex), n.routesMeta.map(r => r.childrenIndex)))
}
const kp = /^:[\w-]+$/
  , Ep = 3
  , Cp = 2
  , bp = 1
  , _p = 10
  , Pp = -2
  , Ka = e => e === "*";
function Rp(e, t) {
    let n = e.split("/")
      , r = n.length;
    return n.some(Ka) && (r += Pp),
    t && (r += Cp),
    n.filter(l => !Ka(l)).reduce( (l, s) => l + (kp.test(s) ? Ep : s === "" ? bp : _p), r)
}
function Lp(e, t) {
    return e.length === t.length && e.slice(0, -1).every( (r, l) => r === t[l]) ? e[e.length - 1] - t[t.length - 1] : 0
}
function zp(e, t, n) {
    let {routesMeta: r} = e
      , l = {}
      , s = "/"
      , o = [];
    for (let a = 0; a < r.length; ++a) {
        let u = r[a]
          , d = a === r.length - 1
          , p = s === "/" ? t : t.slice(s.length) || "/"
          , c = Ga({
            path: u.relativePath,
            caseSensitive: u.caseSensitive,
            end: d
        }, p)
          , m = u.route;
        if (!c && d && n && !r[r.length - 1].route.index && (c = Ga({
            path: u.relativePath,
            caseSensitive: u.caseSensitive,
            end: !1
        }, p)),
        !c)
            return null;
        Object.assign(l, c.params),
        o.push({
            params: l,
            pathname: Qt([s, c.pathname]),
            pathnameBase: Mp(Qt([s, c.pathnameBase])),
            route: m
        }),
        c.pathnameBase !== "/" && (s = Qt([s, c.pathnameBase]))
    }
    return o
}
function Ga(e, t) {
    typeof e == "string" && (e = {
        path: e,
        caseSensitive: !1,
        end: !0
    });
    let[n,r] = Tp(e.path, e.caseSensitive, e.end)
      , l = t.match(n);
    if (!l)
        return null;
    let s = l[0]
      , o = s.replace(/(.)\/+$/, "$1")
      , a = l.slice(1);
    return {
        params: r.reduce( (d, p, c) => {
            let {paramName: m, isOptional: x} = p;
            if (m === "*") {
                let w = a[c] || "";
                o = s.slice(0, s.length - w.length).replace(/(.)\/+$/, "$1")
            }
            const y = a[c];
            return x && !y ? d[m] = void 0 : d[m] = (y || "").replace(/%2F/g, "/"),
            d
        }
        , {}),
        pathname: s,
        pathnameBase: o,
        pattern: e
    }
}
function Tp(e, t, n) {
    t === void 0 && (t = !1),
    n === void 0 && (n = !0),
    Nd(e === "*" || !e.endsWith("*") || e.endsWith("/*"), 'Route path "' + e + '" will be treated as if it were ' + ('"' + e.replace(/\*$/, "/*") + '" because the `*` character must ') + "always follow a `/` in the pattern. To get rid of this warning, " + ('please change the route path to "' + e.replace(/\*$/, "/*") + '".'));
    let r = []
      , l = "^" + e.replace(/\/*\*?$/, "").replace(/^\/*/, "/").replace(/[\\.*+^${}|()[\]]/g, "\\$&").replace(/\/:([\w-]+)(\?)?/g, (o, a, u) => (r.push({
        paramName: a,
        isOptional: u != null
    }),
    u ? "/?([^\\/]+)?" : "/([^\\/]+)"));
    return e.endsWith("*") ? (r.push({
        paramName: "*"
    }),
    l += e === "*" || e === "/*" ? "(.*)$" : "(?:\\/(.+)|\\/*)$") : n ? l += "\\/*$" : e !== "" && e !== "/" && (l += "(?:(?=\\/|$))"),
    [new RegExp(l,t ? void 0 : "i"), r]
}
function Op(e) {
    try {
        return e.split("/").map(t => decodeURIComponent(t).replace(/\//g, "%2F")).join("/")
    } catch (t) {
        return Nd(!1, 'The URL path "' + e + '" could not be decoded because it is is a malformed URL segment. This is probably due to a bad percent ' + ("encoding (" + t + ").")),
        e
    }
}
function Ed(e, t) {
    if (t === "/")
        return e;
    if (!e.toLowerCase().startsWith(t.toLowerCase()))
        return null;
    let n = t.endsWith("/") ? t.length - 1 : t.length
      , r = e.charAt(n);
    return r && r !== "/" ? null : e.slice(n) || "/"
}
function Fp(e, t) {
    t === void 0 && (t = "/");
    let {pathname: n, search: r="", hash: l=""} = typeof e == "string" ? On(e) : e;
    return {
        pathname: n ? n.startsWith("/") ? n : Dp(n, t) : t,
        search: $p(r),
        hash: Bp(l)
    }
}
function Dp(e, t) {
    let n = t.replace(/\/+$/, "").split("/");
    return e.split("/").forEach(l => {
        l === ".." ? n.length > 1 && n.pop() : l !== "." && n.push(l)
    }
    ),
    n.length > 1 ? n.join("/") : "/"
}
function zs(e, t, n, r) {
    return "Cannot include a '" + e + "' character in a manually specified " + ("`to." + t + "` field [" + JSON.stringify(r) + "].  Please separate it out to the ") + ("`to." + n + "` field. Alternatively you may provide the full path as ") + 'a string in <Link to="..."> and the router will parse it for you.'
}
function Ip(e) {
    return e.filter( (t, n) => n === 0 || t.route.path && t.route.path.length > 0)
}
function Ap(e, t) {
    let n = Ip(e);
    return t ? n.map( (r, l) => l === n.length - 1 ? r.pathname : r.pathnameBase) : n.map(r => r.pathnameBase)
}
function Up(e, t, n, r) {
    r === void 0 && (r = !1);
    let l;
    typeof e == "string" ? l = On(e) : (l = yr({}, e),
    ne(!l.pathname || !l.pathname.includes("?"), zs("?", "pathname", "search", l)),
    ne(!l.pathname || !l.pathname.includes("#"), zs("#", "pathname", "hash", l)),
    ne(!l.search || !l.search.includes("#"), zs("#", "search", "hash", l)));
    let s = e === "" || l.pathname === "", o = s ? "/" : l.pathname, a;
    if (o == null)
        a = n;
    else {
        let c = t.length - 1;
        if (!r && o.startsWith("..")) {
            let m = o.split("/");
            for (; m[0] === ".."; )
                m.shift(),
                c -= 1;
            l.pathname = m.join("/")
        }
        a = c >= 0 ? t[c] : "/"
    }
    let u = Fp(l, a)
      , d = o && o !== "/" && o.endsWith("/")
      , p = (s || o === ".") && n.endsWith("/");
    return !u.pathname.endsWith("/") && (d || p) && (u.pathname += "/"),
    u
}
const Qt = e => e.join("/").replace(/\/\/+/g, "/")
  , Mp = e => e.replace(/\/+$/, "").replace(/^\/*/, "/")
  , $p = e => !e || e === "?" ? "" : e.startsWith("?") ? e : "?" + e
  , Bp = e => !e || e === "#" ? "" : e.startsWith("#") ? e : "#" + e;
function Vp(e) {
    return e != null && typeof e.status == "number" && typeof e.statusText == "string" && typeof e.internal == "boolean" && "data"in e
}
const Cd = ["post", "put", "patch", "delete"];
new Set(Cd);
const Wp = ["get", ...Cd];
new Set(Wp);
/**
 * React Router v6.25.1
 *
 * Copyright (c) Remix Software Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.md file in the root directory of this source tree.
 *
 * @license MIT
 */
function wr() {
    return wr = Object.assign ? Object.assign.bind() : function(e) {
        for (var t = 1; t < arguments.length; t++) {
            var n = arguments[t];
            for (var r in n)
                Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r])
        }
        return e
    }
    ,
    wr.apply(this, arguments)
}
const Lo = v.createContext(null)
  , Hp = v.createContext(null)
  , Yl = v.createContext(null)
  , Jl = v.createContext(null)
  , en = v.createContext({
    outlet: null,
    matches: [],
    isDataRoute: !1
})
  , bd = v.createContext(null);
function Zl() {
    return v.useContext(Jl) != null
}
function ql() {
    return Zl() || ne(!1),
    v.useContext(Jl).location
}
function _d(e) {
    v.useContext(Yl).static || v.useLayoutEffect(e)
}
function tn() {
    let {isDataRoute: e} = v.useContext(en);
    return e ? lh() : Qp()
}
function Qp() {
    Zl() || ne(!1);
    let e = v.useContext(Lo)
      , {basename: t, future: n, navigator: r} = v.useContext(Yl)
      , {matches: l} = v.useContext(en)
      , {pathname: s} = ql()
      , o = JSON.stringify(Ap(l, n.v7_relativeSplatPath))
      , a = v.useRef(!1);
    return _d( () => {
        a.current = !0
    }
    ),
    v.useCallback(function(d, p) {
        if (p === void 0 && (p = {}),
        !a.current)
            return;
        if (typeof d == "number") {
            r.go(d);
            return
        }
        let c = Up(d, JSON.parse(o), s, p.relative === "path");
        e == null && t !== "/" && (c.pathname = c.pathname === "/" ? t : Qt([t, c.pathname])),
        (p.replace ? r.replace : r.push)(c, p.state, p)
    }, [t, r, o, s, e])
}
function Cr() {
    let {matches: e} = v.useContext(en)
      , t = e[e.length - 1];
    return t ? t.params : {}
}
function Kp(e, t) {
    return Gp(e, t)
}
function Gp(e, t, n, r) {
    Zl() || ne(!1);
    let {navigator: l} = v.useContext(Yl)
      , {matches: s} = v.useContext(en)
      , o = s[s.length - 1]
      , a = o ? o.params : {};
    o && o.pathname;
    let u = o ? o.pathnameBase : "/";
    o && o.route;
    let d = ql(), p;
    if (t) {
        var c;
        let j = typeof t == "string" ? On(t) : t;
        u === "/" || (c = j.pathname) != null && c.startsWith(u) || ne(!1),
        p = j
    } else
        p = d;
    let m = p.pathname || "/"
      , x = m;
    if (u !== "/") {
        let j = u.replace(/^\//, "").split("/");
        x = "/" + m.replace(/^\//, "").split("/").slice(j.length).join("/")
    }
    let y = Np(e, {
        pathname: x
    })
      , w = qp(y && y.map(j => Object.assign({}, j, {
        params: Object.assign({}, a, j.params),
        pathname: Qt([u, l.encodeLocation ? l.encodeLocation(j.pathname).pathname : j.pathname]),
        pathnameBase: j.pathnameBase === "/" ? u : Qt([u, l.encodeLocation ? l.encodeLocation(j.pathnameBase).pathname : j.pathnameBase])
    })), s, n, r);
    return t && w ? v.createElement(Jl.Provider, {
        value: {
            location: wr({
                pathname: "/",
                search: "",
                hash: "",
                state: null,
                key: "default"
            }, p),
            navigationType: St.Pop
        }
    }, w) : w
}
function Xp() {
    let e = rh()
      , t = Vp(e) ? e.status + " " + e.statusText : e instanceof Error ? e.message : JSON.stringify(e)
      , n = e instanceof Error ? e.stack : null
      , l = {
        padding: "0.5rem",
        backgroundColor: "rgba(200,200,200, 0.5)"
    };
    return v.createElement(v.Fragment, null, v.createElement("h2", null, "Unexpected Application Error!"), v.createElement("h3", {
        style: {
            fontStyle: "italic"
        }
    }, t), n ? v.createElement("pre", {
        style: l
    }, n) : null, null)
}
const Yp = v.createElement(Xp, null);
class Jp extends v.Component {
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
        return this.state.error !== void 0 ? v.createElement(en.Provider, {
            value: this.props.routeContext
        }, v.createElement(bd.Provider, {
            value: this.state.error,
            children: this.props.component
        })) : this.props.children
    }
}
function Zp(e) {
    let {routeContext: t, match: n, children: r} = e
      , l = v.useContext(Lo);
    return l && l.static && l.staticContext && (n.route.errorElement || n.route.ErrorBoundary) && (l.staticContext._deepestRenderedBoundaryId = n.route.id),
    v.createElement(en.Provider, {
        value: t
    }, r)
}
function qp(e, t, n, r) {
    var l;
    if (t === void 0 && (t = []),
    n === void 0 && (n = null),
    r === void 0 && (r = null),
    e == null) {
        var s;
        if ((s = n) != null && s.errors)
            e = n.matches;
        else
            return null
    }
    let o = e
      , a = (l = n) == null ? void 0 : l.errors;
    if (a != null) {
        let p = o.findIndex(c => c.route.id && (a == null ? void 0 : a[c.route.id]) !== void 0);
        p >= 0 || ne(!1),
        o = o.slice(0, Math.min(o.length, p + 1))
    }
    let u = !1
      , d = -1;
    if (n && r && r.v7_partialHydration)
        for (let p = 0; p < o.length; p++) {
            let c = o[p];
            if ((c.route.HydrateFallback || c.route.hydrateFallbackElement) && (d = p),
            c.route.id) {
                let {loaderData: m, errors: x} = n
                  , y = c.route.loader && m[c.route.id] === void 0 && (!x || x[c.route.id] === void 0);
                if (c.route.lazy || y) {
                    u = !0,
                    d >= 0 ? o = o.slice(0, d + 1) : o = [o[0]];
                    break
                }
            }
        }
    return o.reduceRight( (p, c, m) => {
        let x, y = !1, w = null, j = null;
        n && (x = a && c.route.id ? a[c.route.id] : void 0,
        w = c.route.errorElement || Yp,
        u && (d < 0 && m === 0 ? (y = !0,
        j = null) : d === m && (y = !0,
        j = c.route.hydrateFallbackElement || null)));
        let h = t.concat(o.slice(0, m + 1))
          , f = () => {
            let g;
            return x ? g = w : y ? g = j : c.route.Component ? g = v.createElement(c.route.Component, null) : c.route.element ? g = c.route.element : g = p,
            v.createElement(Zp, {
                match: c,
                routeContext: {
                    outlet: p,
                    matches: h,
                    isDataRoute: n != null
                },
                children: g
            })
        }
        ;
        return n && (c.route.ErrorBoundary || c.route.errorElement || m === 0) ? v.createElement(Jp, {
            location: n.location,
            revalidation: n.revalidation,
            component: w,
            error: x,
            children: f(),
            routeContext: {
                outlet: null,
                matches: h,
                isDataRoute: !0
            }
        }) : f()
    }
    , null)
}
var Pd = function(e) {
    return e.UseBlocker = "useBlocker",
    e.UseRevalidator = "useRevalidator",
    e.UseNavigateStable = "useNavigate",
    e
}(Pd || {})
  , Rl = function(e) {
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
}(Rl || {});
function eh(e) {
    let t = v.useContext(Lo);
    return t || ne(!1),
    t
}
function th(e) {
    let t = v.useContext(Hp);
    return t || ne(!1),
    t
}
function nh(e) {
    let t = v.useContext(en);
    return t || ne(!1),
    t
}
function Rd(e) {
    let t = nh()
      , n = t.matches[t.matches.length - 1];
    return n.route.id || ne(!1),
    n.route.id
}
function rh() {
    var e;
    let t = v.useContext(bd)
      , n = th(Rl.UseRouteError)
      , r = Rd(Rl.UseRouteError);
    return t !== void 0 ? t : (e = n.errors) == null ? void 0 : e[r]
}
function lh() {
    let {router: e} = eh(Pd.UseNavigateStable)
      , t = Rd(Rl.UseNavigateStable)
      , n = v.useRef(!1);
    return _d( () => {
        n.current = !0
    }
    ),
    v.useCallback(function(l, s) {
        s === void 0 && (s = {}),
        n.current && (typeof l == "number" ? e.navigate(l) : e.navigate(l, wr({
            fromRouteId: t
        }, s)))
    }, [e, t])
}
function Pe(e) {
    ne(!1)
}
function sh(e) {
    let {basename: t="/", children: n=null, location: r, navigationType: l=St.Pop, navigator: s, static: o=!1, future: a} = e;
    Zl() && ne(!1);
    let u = t.replace(/^\/*/, "/")
      , d = v.useMemo( () => ({
        basename: u,
        navigator: s,
        static: o,
        future: wr({
            v7_relativeSplatPath: !1
        }, a)
    }), [u, a, s, o]);
    typeof r == "string" && (r = On(r));
    let {pathname: p="/", search: c="", hash: m="", state: x=null, key: y="default"} = r
      , w = v.useMemo( () => {
        let j = Ed(p, u);
        return j == null ? null : {
            location: {
                pathname: j,
                search: c,
                hash: m,
                state: x,
                key: y
            },
            navigationType: l
        }
    }
    , [u, p, c, m, x, y, l]);
    return w == null ? null : v.createElement(Yl.Provider, {
        value: d
    }, v.createElement(Jl.Provider, {
        children: n,
        value: w
    }))
}
function ih(e) {
    let {children: t, location: n} = e;
    return Kp(Ri(t), n)
}
new Promise( () => {}
);
function Ri(e, t) {
    t === void 0 && (t = []);
    let n = [];
    return v.Children.forEach(e, (r, l) => {
        if (!v.isValidElement(r))
            return;
        let s = [...t, l];
        if (r.type === v.Fragment) {
            n.push.apply(n, Ri(r.props.children, s));
            return
        }
        r.type !== Pe && ne(!1),
        !r.props.index || !r.props.children || ne(!1);
        let o = {
            id: r.props.id || s.join("-"),
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
        r.props.children && (o.children = Ri(r.props.children, s)),
        n.push(o)
    }
    ),
    n
}
/**
 * React Router DOM v6.25.1
 *
 * Copyright (c) Remix Software Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.md file in the root directory of this source tree.
 *
 * @license MIT
 */
const oh = "6";
try {
    window.__reactRouterVersion = oh
} catch {}
const ah = "startTransition"
  , Xa = im[ah];
function uh(e) {
    let {basename: t, children: n, future: r, window: l} = e
      , s = v.useRef();
    s.current == null && (s.current = vp({
        window: l,
        v5Compat: !0
    }));
    let o = s.current
      , [a,u] = v.useState({
        action: o.action,
        location: o.location
    })
      , {v7_startTransition: d} = r || {}
      , p = v.useCallback(c => {
        d && Xa ? Xa( () => u(c)) : u(c)
    }
    , [u, d]);
    return v.useLayoutEffect( () => o.listen(p), [o, p]),
    v.createElement(sh, {
        basename: t,
        children: n,
        location: a.location,
        navigationType: a.action,
        navigator: o,
        future: r
    })
}
var Ya;
(function(e) {
    e.UseScrollRestoration = "useScrollRestoration",
    e.UseSubmit = "useSubmit",
    e.UseSubmitFetcher = "useSubmitFetcher",
    e.UseFetcher = "useFetcher",
    e.useViewTransitionState = "useViewTransitionState"
}
)(Ya || (Ya = {}));
var Ja;
(function(e) {
    e.UseFetcher = "useFetcher",
    e.UseFetchers = "useFetchers",
    e.UseScrollRestoration = "useScrollRestoration"
}
)(Ja || (Ja = {}));
var Ld = {
    color: void 0,
    size: void 0,
    className: void 0,
    style: void 0,
    attr: void 0
}
  , Za = Je.createContext && Je.createContext(Ld)
  , ch = ["attr", "size", "title"];
function dh(e, t) {
    if (e == null)
        return {};
    var n = mh(e, t), r, l;
    if (Object.getOwnPropertySymbols) {
        var s = Object.getOwnPropertySymbols(e);
        for (l = 0; l < s.length; l++)
            r = s[l],
            !(t.indexOf(r) >= 0) && Object.prototype.propertyIsEnumerable.call(e, r) && (n[r] = e[r])
    }
    return n
}
function mh(e, t) {
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
function Ll() {
    return Ll = Object.assign ? Object.assign.bind() : function(e) {
        for (var t = 1; t < arguments.length; t++) {
            var n = arguments[t];
            for (var r in n)
                Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r])
        }
        return e
    }
    ,
    Ll.apply(this, arguments)
}
function qa(e, t) {
    var n = Object.keys(e);
    if (Object.getOwnPropertySymbols) {
        var r = Object.getOwnPropertySymbols(e);
        t && (r = r.filter(function(l) {
            return Object.getOwnPropertyDescriptor(e, l).enumerable
        })),
        n.push.apply(n, r)
    }
    return n
}
function zl(e) {
    for (var t = 1; t < arguments.length; t++) {
        var n = arguments[t] != null ? arguments[t] : {};
        t % 2 ? qa(Object(n), !0).forEach(function(r) {
            fh(e, r, n[r])
        }) : Object.getOwnPropertyDescriptors ? Object.defineProperties(e, Object.getOwnPropertyDescriptors(n)) : qa(Object(n)).forEach(function(r) {
            Object.defineProperty(e, r, Object.getOwnPropertyDescriptor(n, r))
        })
    }
    return e
}
function fh(e, t, n) {
    return t = ph(t),
    t in e ? Object.defineProperty(e, t, {
        value: n,
        enumerable: !0,
        configurable: !0,
        writable: !0
    }) : e[t] = n,
    e
}
function ph(e) {
    var t = hh(e, "string");
    return typeof t == "symbol" ? t : t + ""
}
function hh(e, t) {
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
function zd(e) {
    return e && e.map( (t, n) => Je.createElement(t.tag, zl({
        key: n
    }, t.attr), zd(t.child)))
}
function es(e) {
    return t => Je.createElement(gh, Ll({
        attr: zl({}, e.attr)
    }, t), zd(e.child))
}
function gh(e) {
    var t = n => {
        var {attr: r, size: l, title: s} = e, o = dh(e, ch), a = l || n.size || "1em", u;
        return n.className && (u = n.className),
        e.className && (u = (u ? u + " " : "") + e.className),
        Je.createElement("svg", Ll({
            stroke: "currentColor",
            fill: "currentColor",
            strokeWidth: "0"
        }, n.attr, r, o, {
            className: u,
            style: zl(zl({
                color: e.color || n.color
            }, n.style), e.style),
            height: a,
            width: a,
            xmlns: "http://www.w3.org/2000/svg"
        }), s && Je.createElement("title", null, s), e.children)
    }
    ;
    return Za !== void 0 ? Je.createElement(Za.Consumer, null, n => t(n)) : t(Ld)
}
function Tl(e) {
    return es({
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
const Li = () => !window.invokeNative
  , xh = () => {}
;
async function F(e, t, n) {
    const r = {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify(t)
    };
    if (Li() && n !== void 0)
        return n;
    const l = window.GetParentResourceName ? window.GetParentResourceName() : "react-app";
    return await (await fetch(`https://${l}/${e}`, r)).json()
}
const ts = ["#FEFFFE", "#EBEBEB", "#D6D6D6", "#C2C2C2", "#ADADAD", "#999999", "#858585", "#707070", "#5C5C5C", "#474747", "#333333", "#000000", "#00374A", "#011D57", "#11053B", "#2E063D", "#3C071B", "#5C0701", "#5A1C00", "#583300", "#563D00", "#666100", "#4F5504", "#263E0F", "#004D65", "#012F7B", "#1A0A52", "#450D59", "#551029", "#831100", "#7B2900", "#7A4A00", "#785800", "#8D8602", "#6F760A", "#38571A", "#016E8F", "#0042A9", "#2C0977", "#61187C", "#791A3D", "#B51A00", "#AD3E00", "#A96800", "#A67B01", "#C4BC00", "#9BA50E", "#4E7A27", "#008CB4", "#0056D6", "#371A94", "#7A219E", "#99244F", "#E22400", "#DA5100", "#D38301", "#D19D01", "#F5EC00", "#C3D117", "#669D34", "#00A1D8", "#0061FD", "#4D22B2", "#982ABC", "#B92D5D", "#FF4015", "#FF6A00", "#FFAB01", "#FCC700", "#FEFB41", "#D9EC37", "#76BB40", "#01C7FC", "#3A87FD", "#5E30EB", "#BE38F3", "#E63B7A", "#FE6250", "#FE8648", "#FEB43F", "#FECB3E", "#FFF76B", "#E4EF65", "#96D35F", "#52D6FC", "#74A7FF", "#864FFD", "#D357FE", "#EE719E", "#FF8C82", "#FEA57D", "#FEC777", "#FED977", "#FFF994", "#EAF28F", "#B1DD8B", "#93E3FC", "#A7C6FF", "#B18CFE", "#E292FE", "#F4A4C0", "#FFB5AF", "#FFC5AB", "#FED9A8", "#FDE4A8", "#FFFBB9", "#F1F7B7", "#CDE8B5", "#CBF0FF", "#D2E2FE", "#D8C9FE", "#EFCAFE", "#F9D3E0", "#FFDAD8", "#FFE2D6", "#FEECD4", "#FEF1D5", "#FDFBDD", "#F6FADB", "#DEEED4"];
function vh() {
    const e = tn()
      , [t,n] = v.useState("")
      , [r,l] = v.useState("")
      , [s,o] = v.useState(!1)
      , [a,u] = v.useState("#9747FF")
      , d = m => {
        const y = m.target.value.replace(/[^a-zA-Z0-9]/g, "");
        l(y)
    }
      , p = m => {
        const y = m.target.value.replace(/[^a-zA-Z0-9]/g, "");
        n(y)
    }
      , c = () => {
        if (!r || !t) {
            console.log("Campos inválidos!");
            return
        }
        F("REGISTER_SQUAD", {
            name: r,
            tag: t,
            color: a
        }, !1).then(m => {
            m ? e("/") : console.log("Clan não foi criado!")
        }
        )
    }
    ;
    return i.jsxs("div", {
        className: "w-screen h-screen bg-back bg-cover bg-no-repeat bg-center grid place-items-center",
        children: [i.jsxs("div", {
            className: "flex flex-col gap-8 opacity-[.05]",
            children: [i.jsxs("div", {
                className: "flex items-center justify-between w-[88.5rem]",
                children: [i.jsxs("div", {
                    children: [i.jsx("h3", {
                        className: "font-fugaz text-primary text-[2rem] font-normal",
                        style: {
                            letterSpacing: "-0.16rem"
                        },
                        children: "FIVE ARENA"
                    }), i.jsx("h1", {
                        className: "font-days text-white text-[4rem] font-normal leading-[2rem]",
                        children: "CLÃS"
                    })]
                }), i.jsx("img", {
                    className: "cursor-pointer hover:scale-125 duration-200"
                })]
            }), i.jsx("div", {
                className: "w-[88.5rem] h-[44.3125rem] rounded-[0.3125rem] bg-default-gradient p-6 border border-white/[.075]"
            })]
        }), i.jsxs("div", {
            className: `p-8 absolute rounded-[0.3125rem] flex flex-col items-center gap-6 ${s && "opacity-[.05]"}`,
            children: [i.jsxs("div", {
                className: "flex flex-col items-center",
                children: [i.jsx("small", {
                    className: "text-primary text-[2rem] font-normal font-fugaz",
                    children: "CRIAR"
                }), i.jsx("h3", {
                    className: "text-white text-[4rem] font-normal font-days leading-[2rem]",
                    children: "MEU CLÃ"
                })]
            }), i.jsxs("div", {
                className: "flex flex-col items-center gap-3",
                children: [i.jsx("p", {
                    className: "text-white/25 text-sm font-medium",
                    children: "Cor do clã"
                }), i.jsx("div", {
                    onClick: () => o(!0),
                    className: "w-12 h-12 rounded-full cursor-pointer",
                    style: {
                        backgroundColor: a
                    }
                })]
            }), i.jsxs("div", {
                className: "flex flex-col items-center gap-3",
                children: [i.jsx("label", {
                    className: "text-white/25 text-sm font-medium",
                    children: "Nome"
                }), i.jsxs("div", {
                    className: "w-[25rem] h-12 border border-white/15 flex items-center gap-4 px-4 rounded",
                    children: [i.jsx(Tl, {
                        size: 18,
                        className: "text-white/35"
                    }), i.jsx("input", {
                        type: "text",
                        value: r,
                        maxLength: 16,
                        onChange: m => d(m),
                        placeholder: "Nome",
                        className: "flex-1 text-white text-sm font-medium bg-transparent outline-none placeholder:text-white"
                    })]
                })]
            }), i.jsxs("div", {
                className: "flex flex-col items-center gap-3",
                children: [i.jsx("label", {
                    className: "text-white/25 text-sm font-medium",
                    children: "Nametag do clã (3 caractereces)"
                }), i.jsxs("div", {
                    className: "w-[25rem] h-12 border border-white/15 flex items-center gap-4 px-4 rounded",
                    children: [i.jsx(Tl, {
                        size: 18,
                        className: "text-white/35"
                    }), i.jsx("input", {
                        type: "text",
                        value: t,
                        maxLength: 3,
                        onChange: m => p(m),
                        placeholder: "Nametag",
                        className: "flex-1 text-white text-sm font-medium bg-transparent outline-none placeholder:text-white"
                    })]
                })]
            }), i.jsx("button", {
                onClick: c,
                className: "w-[25rem] h-[3.25rem] border border-primary bg-primary-gradient text-white text-base font-bold rounded=[0.1875rem]",
                children: "CRIAR CLÃ"
            })]
        }), s && i.jsxs("div", {
            className: "absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 flex flex-col items-center gap-8 ",
            children: [i.jsx("p", {
                className: "text-white/55 text-lg font-medium",
                children: "Selecione a cor do seu perfil"
            }), i.jsx("div", {
                className: "flex flex-wrap w-[22.375rem]",
                children: ts.map( (m, x) => i.jsx("div", {
                    onClick: () => u(m),
                    className: `w-[1.86456rem] h-[1.8625rem] rounded-[.05rem] cursor-pointer relative ${a === m && 'before:absolute before:top-1/2 before:-translate-y-1/2 before:left-1/2 before:-translate-x-1/2 before:content-[""] before:w-[104%] before:h-[104%] before:bg-transparent before:border-4 before:border-white before:rounded'}`,
                    style: {
                        backgroundColor: m
                    }
                }, x))
            }), i.jsx("button", {
                onClick: () => o(!1),
                className: "w-[22.375rem] h-[3.25rem] bg-gradient-to-r from-primary to-primary/15 border border-primary rounded text-white text-lg font-bold",
                children: "ALTERAR COR"
            })]
        })]
    })
}
function yh() {
    return i.jsxs("div", {
        className: "w-screen h-screen bg-back bg-cover bg-no-repeat bg-center grid place-items-center",
        children: [i.jsxs("div", {
            className: "flex flex-col gap-8 opacity-[.05]",
            children: [i.jsxs("div", {
                className: "flex items-center justify-between w-[88.5rem]",
                children: [i.jsxs("div", {
                    children: [i.jsx("h3", {
                        className: "font-fugaz text-primary text-[2rem] font-normal",
                        style: {
                            letterSpacing: "-0.16rem"
                        },
                        children: "FIVE ARENA"
                    }), i.jsx("h1", {
                        className: "font-days text-white text-[4rem] font-normal leading-[2rem]",
                        children: "CLÃS"
                    })]
                }), i.jsx("img", {
                    className: "cursor-pointer hover:scale-125 duration-200"
                })]
            }), i.jsx("div", {
                className: "w-[88.5rem] h-[44.3125rem] rounded-[0.3125rem] bg-default-gradient p-6 border border-white/[.075]"
            })]
        }), i.jsxs("div", {
            className: "p-8 absolute rounded-[0.3125rem] flex flex-col items-center gap-6",
            children: [i.jsx("h3", {
                className: "text-white text-2xl font-medium",
                children: "Você não está em nenhum clã"
            }), i.jsxs("p", {
                className: "text-white/70 text-center text-base",
                children: ["Seja convidado para algum clã, ou crie seu próprio clã ", i.jsx("br", {}), " ", "adquirindo o Item ", i.jsx("b", {
                    className: "text-white",
                    children: "“Criar Clã”"
                }), " na loja da cidade."]
            }), i.jsx("button", {
                onClick: () => window.invokeNative("openUrl", "https://www.google.com"),
                className: "w-[26rem] h-12 border border-primary bg-primary-gradient text-white text-base font-bold rounded=[0.1875rem]",
                children: "ACESSAR SITE"
            })]
        })]
    })
}
const wh = "" + new URL("../icons/squad/x.svg",import.meta.url).href
  , Nh = "" + new URL("../icons/squad/exit.svg",import.meta.url).href
  , ns = "" + new URL("../icons/ranking/arrow-left.svg",import.meta.url).href
  , zi = "" + new URL("../icons/profile/edit.svg",import.meta.url).href
  , sl = "" + new URL("../icons/squad/close.svg",import.meta.url).href
  , et = "" + new URL("../images/ranking/gold.png",import.meta.url).href
  , tt = "" + new URL("../images/ranking/bronze.png",import.meta.url).href
  , nt = "" + new URL("../images/ranking/diamond.png",import.meta.url).href
  , jh = {
    BASE_URL: "./",
    DEV: !1,
    MODE: "production",
    PROD: !0,
    SSR: !1
}
  , eu = e => {
    let t;
    const n = new Set
      , r = (p, c) => {
        const m = typeof p == "function" ? p(t) : p;
        if (!Object.is(m, t)) {
            const x = t;
            t = c ?? (typeof m != "object" || m === null) ? m : Object.assign({}, t, m),
            n.forEach(y => y(t, x))
        }
    }
      , l = () => t
      , u = {
        setState: r,
        getState: l,
        getInitialState: () => d,
        subscribe: p => (n.add(p),
        () => n.delete(p)),
        destroy: () => {
            (jh ? "production" : void 0) !== "production" && console.warn("[DEPRECATED] The `destroy` method will be unsupported in a future version. Instead use unsubscribe function returned by subscribe. Everything will be garbage-collected if store is garbage-collected."),
            n.clear()
        }
    }
      , d = t = e(r, l, u);
    return u
}
  , Sh = e => e ? eu(e) : eu;
var Td = {
    exports: {}
}
  , Od = {}
  , Fd = {
    exports: {}
}
  , Dd = {};
/**
 * @license React
 * use-sync-external-store-shim.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var Rn = v;
function kh(e, t) {
    return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var Eh = typeof Object.is == "function" ? Object.is : kh
  , Ch = Rn.useState
  , bh = Rn.useEffect
  , _h = Rn.useLayoutEffect
  , Ph = Rn.useDebugValue;
function Rh(e, t) {
    var n = t()
      , r = Ch({
        inst: {
            value: n,
            getSnapshot: t
        }
    })
      , l = r[0].inst
      , s = r[1];
    return _h(function() {
        l.value = n,
        l.getSnapshot = t,
        Ts(l) && s({
            inst: l
        })
    }, [e, n, t]),
    bh(function() {
        return Ts(l) && s({
            inst: l
        }),
        e(function() {
            Ts(l) && s({
                inst: l
            })
        })
    }, [e]),
    Ph(n),
    n
}
function Ts(e) {
    var t = e.getSnapshot;
    e = e.value;
    try {
        var n = t();
        return !Eh(e, n)
    } catch {
        return !0
    }
}
function Lh(e, t) {
    return t()
}
var zh = typeof window > "u" || typeof window.document > "u" || typeof window.document.createElement > "u" ? Lh : Rh;
Dd.useSyncExternalStore = Rn.useSyncExternalStore !== void 0 ? Rn.useSyncExternalStore : zh;
Fd.exports = Dd;
var Th = Fd.exports;
/**
 * @license React
 * use-sync-external-store-shim/with-selector.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var rs = v
  , Oh = Th;
function Fh(e, t) {
    return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var Dh = typeof Object.is == "function" ? Object.is : Fh
  , Ih = Oh.useSyncExternalStore
  , Ah = rs.useRef
  , Uh = rs.useEffect
  , Mh = rs.useMemo
  , $h = rs.useDebugValue;
Od.useSyncExternalStoreWithSelector = function(e, t, n, r, l) {
    var s = Ah(null);
    if (s.current === null) {
        var o = {
            hasValue: !1,
            value: null
        };
        s.current = o
    } else
        o = s.current;
    s = Mh(function() {
        function u(x) {
            if (!d) {
                if (d = !0,
                p = x,
                x = r(x),
                l !== void 0 && o.hasValue) {
                    var y = o.value;
                    if (l(y, x))
                        return c = y
                }
                return c = x
            }
            if (y = c,
            Dh(p, x))
                return y;
            var w = r(x);
            return l !== void 0 && l(y, w) ? y : (p = x,
            c = w)
        }
        var d = !1, p, c, m = n === void 0 ? null : n;
        return [function() {
            return u(t())
        }
        , m === null ? void 0 : function() {
            return u(m())
        }
        ]
    }, [t, n, r, l]);
    var a = Ih(e, s[0], s[1]);
    return Uh(function() {
        o.hasValue = !0,
        o.value = a
    }, [a]),
    $h(a),
    a
}
;
Td.exports = Od;
var Bh = Td.exports;
const Vh = ou(Bh)
  , Id = {
    BASE_URL: "./",
    DEV: !1,
    MODE: "production",
    PROD: !0,
    SSR: !1
}
  , {useDebugValue: Wh} = Je
  , {useSyncExternalStoreWithSelector: Hh} = Vh;
let tu = !1;
const Qh = e => e;
function Kh(e, t=Qh, n) {
    (Id ? "production" : void 0) !== "production" && n && !tu && (console.warn("[DEPRECATED] Use `createWithEqualityFn` instead of `create` or use `useStoreWithEqualityFn` instead of `useStore`. They can be imported from 'zustand/traditional'. https://github.com/pmndrs/zustand/discussions/1937"),
    tu = !0);
    const r = Hh(e.subscribe, e.getState, e.getServerState || e.getInitialState, t, n);
    return Wh(r),
    r
}
const nu = e => {
    (Id ? "production" : void 0) !== "production" && typeof e != "function" && console.warn("[DEPRECATED] Passing a vanilla store will be unsupported in a future version. Instead use `import { useStore } from 'zustand'`.");
    const t = typeof e == "function" ? Sh(e) : e
      , n = (r, l) => Kh(t, r, l);
    return Object.assign(n, t),
    n
}
  , zo = e => e ? nu(e) : nu
  , ls = zo(e => ({
    profile: {},
    updateProfile: t => e({
        profile: t
    })
}));
function Gh() {
    var j, h, f, g, N, E, b;
    const e = tn()
      , {profile: t} = ls()
      , [n,r] = v.useState()
      , [l,s] = v.useState({})
      , [o,a] = v.useState("")
      , [u,d] = v.useState(!1)
      , [p,c] = v.useState(!1)
      , m = () => {
        F("UPDATE_SQUAD_BANNER", {
            color: o
        }, !0).then( () => s(k => ({
            ...k,
            color: o
        }))),
        c(!1)
    }
      , x = k => {
        F("REMOVE_MEMBER", {
            member: k
        }, !0).then( () => s(C => ({
            ...C,
            members: C.members.filter(I => I.id !== k.id)
        })))
    }
      , y = () => {
        F("QUIT_SQUAD", {
            id: t == null ? void 0 : t.id
        }, !0).then( () => e({
            pathname: "/"
        }))
    }
      , w = () => {
        F("INVITE_MEMBER", {
            id: n
        }, !0),
        d(!1)
    }
    ;
    return v.useEffect( () => {
        F("GET_SQUAD", {}, {
            tag: "col",
            name: "COLOCOLO",
            elo: !1,
            color: "#0aff0a",
            eloName: "Ouro III",
            points: {
                current: 50,
                max: 200
            },
            members: [{
                id: 1,
                elo: "bronze",
                name: "Pedro Silva",
                kills: 20,
                points: 30
            }, {
                id: 2,
                elo: "bronze",
                name: "Pedro Silva",
                kills: 20,
                points: 30
            }, {
                id: 3,
                elo: "bronze",
                name: "Pedro Silva",
                kills: 20,
                points: 30
            }, {
                id: 4,
                elo: "bronze",
                name: "Pedro Silva",
                kills: 20,
                points: 30
            }, {
                id: 5,
                elo: "bronze",
                name: "Pedro Silva",
                kills: 20,
                points: 30
            }, {
                id: 6,
                elo: "bronze",
                name: "Pedro Silva",
                kills: 20,
                points: 30
            }, {
                id: 7,
                elo: "bronze",
                name: "Pedro Silva",
                kills: 20,
                points: 30
            }, {
                id: 8,
                elo: "bronze",
                name: "Pedro Silva",
                kills: 20,
                points: 30
            }, {
                id: 9,
                elo: "bronze",
                name: "Pedro Silva",
                kills: 20,
                points: 30
            }, {
                id: 10,
                elo: "bronze",
                name: "Pedro Silva",
                kills: 20,
                points: 30
            }]
        }).then(s)
    }
    , []),
    i.jsxs("div", {
        className: "w-screen h-screen bg-back bg-cover bg-no-repeat bg-center grid place-items-center",
        children: [i.jsxs("div", {
            className: `flex flex-col gap-8 ${(u || p) && "opacity-[.05]"}`,
            children: [i.jsxs("div", {
                className: "flex items-center justify-between w-[88.5rem]",
                children: [i.jsxs("div", {
                    children: [i.jsx("h3", {
                        className: "font-fugaz text-primary text-[2rem] font-normal",
                        style: {
                            letterSpacing: "-0.16rem"
                        },
                        children: "FIVE ARENA"
                    }), i.jsx("h1", {
                        className: "font-days text-white text-[4rem] font-normal leading-[2rem]",
                        children: "CLÃS"
                    })]
                }), i.jsx("img", {
                    onClick: () => e({
                        pathname: "/"
                    }),
                    src: ns,
                    className: "cursor-pointer hover:scale-125 duration-200"
                })]
            }), i.jsxs("div", {
                className: "w-[88.5rem] h-[44.3125rem] rounded-[0.3125rem] bg-default-gradient p-6 border border-white/[.075]",
                children: [i.jsxs("div", {
                    style: {
                        background: l == null ? void 0 : l.color
                    },
                    className: "w-[85.5rem] h-[11.375rem] relative flex items-center justify-between rounded p-6 pr-[3.31rem] before:absolute before:content-[''] before:w-full before:h-full before:bg-black/55 before:left-0 before:top-0",
                    children: [i.jsxs("div", {
                        className: "flex items-center gap-[1.31rem] z-10",
                        children: [i.jsx("div", {
                            style: {
                                background: l == null ? void 0 : l.color
                            },
                            className: "w-[8.375rem] h-[8.375rem] rounded-full flex items-center justify-center text-white text-[4.0625rem] font-normal font-days",
                            children: ((l == null ? void 0 : l.name) ?? "").at(0)
                        }), i.jsxs("p", {
                            className: "text-white text-[1.375rem] font-days flex items-center gap-3",
                            children: [l == null ? void 0 : l.name, " ", i.jsx("span", {
                                className: "flex items-center justify-center text-base font-normal font-sans h-[1.625rem] rounded py-1 px-2 uppercase",
                                style: {
                                    background: l == null ? void 0 : l.color
                                },
                                children: l == null ? void 0 : l.tag
                            })]
                        })]
                    }), i.jsx("div", {
                        onClick: y,
                        className: "z-20 absolute w-[1.75rem] h-[1.75rem] bg-black/35 rounded flex items-center justify-center cursor-pointer bottom-[3.25rem] right-[1.13rem]",
                        children: i.jsx("img", {
                            src: Nh
                        })
                    }), (t == null ? void 0 : t.leader) && i.jsx("div", {
                        onClick: () => c(!0),
                        className: "z-20 absolute w-[1.75rem] h-[1.75rem] bg-black/35 rounded flex items-center justify-center cursor-pointer bottom-[1.13rem] right-[1.13rem]",
                        children: i.jsx("img", {
                            src: zi
                        })
                    })]
                }), i.jsxs("div", {
                    className: "flex items-center gap-4 mt-[.94rem]",
                    children: [i.jsxs("div", {
                        className: "w-[61.25rem] h-[29rem] rounded-[0.3125rem] bg-default-gradient p-3 border border-white/[.075]",
                        children: [i.jsxs("div", {
                            className: "flex items-center w-[59.75rem] h-[2.125rem] border border-white/[.08] pl-6 rounded relative",
                            children: [i.jsx("p", {
                                className: "text-white/[.45] text-sm font-medium w-[3.25rem]",
                                children: "#"
                            }), i.jsx("p", {
                                className: "text-white/[.45] text-sm font-medium w-[3.4375rem]",
                                children: "Elo"
                            }), i.jsx("p", {
                                className: "text-white/[.45] text-sm font-medium w-[17.125rem]",
                                children: "Nome"
                            }), i.jsx("p", {
                                className: "text-white/[.45] text-sm font-medium w-[14.875rem]",
                                children: "Kills"
                            }), i.jsx("p", {
                                className: "text-white/[.45] text-sm font-medium w-20",
                                children: "Pontuação"
                            }), (t == null ? void 0 : t.leader) && i.jsx("button", {
                                onClick: () => d(!0),
                                className: "w-[10.125rem] h-[1.5rem] rounded-[0.1875rem] border border-primary bg-gradient-to-r from-primary to-primary/15 text-white font-medium text-[0.8125rem] absolute right-[.31rem]",
                                children: "CONVIDAR"
                            })]
                        }), i.jsx("div", {
                            className: "flex flex-col gap-2 mt-3 max-h-[24.75rem] overflow-auto overflow-x-hidden",
                            children: (j = l == null ? void 0 : l.members) == null ? void 0 : j.map( (k, C) => i.jsxs("div", {
                                className: "flex flex-none items-center w-[59.75rem] h-[2.625rem] rounded bg-white/[.04] pl-6 relative",
                                children: [i.jsx("p", {
                                    className: "text-white text-sm font-medium w-[3.2rem]",
                                    children: k.id
                                }), i.jsx("img", {
                                    src: k.elo === "bronze" ? tt : k.elo === "gold" ? et : nt,
                                    className: "w-[2.375rem] h-[2.375rem] mr-5"
                                }), i.jsx("p", {
                                    className: "text-white text-sm font-medium w-[17.125rem]",
                                    children: k.name
                                }), i.jsx("p", {
                                    className: "text-white text-sm font-medium w-[14.875rem]",
                                    children: k.kills
                                }), i.jsx("p", {
                                    className: "text-white text-sm font-medium w-20",
                                    children: k.points
                                }), (t == null ? void 0 : t.leader) && i.jsx("img", {
                                    onClick: () => x(k),
                                    src: wh,
                                    className: "absolute right-[.62rem]"
                                })]
                            }, C))
                        })]
                    }), i.jsxs("div", {
                        className: "border border-white/[.075] w-[23.25rem] h-[29rem] rounded-[0.3125rem] p-3 flex flex-col items-center",
                        style: {
                            background: "linear-gradient(163deg, rgba(255, 255, 255, 0.04) 0%, rgba(255, 255, 255, 0.02) 100%)"
                        },
                        children: [i.jsx("p", {
                            className: "w-full h-[2.75rem] rounded bg-white/[.03] text-white text-base flex items-center justify-center font-days font-normal",
                            children: "ELO DO MEU CLÃ"
                        }), i.jsx("h3", {
                            className: "text-white text-[1.5rem] font-bold mt-4 mb-4",
                            children: l.elo ? l == null ? void 0 : l.eloName : "Sem elo"
                        }), i.jsx("img", {
                            src: (l == null ? void 0 : l.elo) === "bronze" ? tt : (l == null ? void 0 : l.elo) === "gold" ? et : (l == null ? void 0 : l.elo) === "diamond" ? nt : sl,
                            className: "w-[17.125rem] h-[17.125rem] mb-[.31rem]"
                        }), l.elo && i.jsxs(i.Fragment, {
                            children: [i.jsxs("div", {
                                className: "flex items-center gap-2 mb-3 ",
                                children: [i.jsxs("h4", {
                                    className: "text-white text-[1.25rem] font-bold",
                                    children: [((h = l == null ? void 0 : l.points) == null ? void 0 : h.current) ?? 0, i.jsxs("b", {
                                        className: "text-white/65",
                                        children: ["/", ((f = l == null ? void 0 : l.points) == null ? void 0 : f.max) ?? 0]
                                    })]
                                }), i.jsxs("p", {
                                    className: "text-base text-white/35 font-bold",
                                    children: [(((g = l == null ? void 0 : l.points) == null ? void 0 : g.max) ?? 0) - (((N = l == null ? void 0 : l.points) == null ? void 0 : N.current) ?? 0), " ", "pontos pra subir"]
                                })]
                            }), i.jsx("div", {
                                className: "w-[20.25rem] h-[0.625rem] rounded-[.125rem] bg-white/[.04]",
                                children: i.jsx("div", {
                                    className: `h-full rounded-[.125rem] ${(l == null ? void 0 : l.elo) === "bronze" ? "bg-bronze-gradient" : (l == null ? void 0 : l.elo) === "gold" ? "bg-gold-gradient" : "bg-diamond-gradient"}`,
                                    style: {
                                        width: `${(((E = l == null ? void 0 : l.points) == null ? void 0 : E.current) ?? 0) / (((b = l == null ? void 0 : l.points) == null ? void 0 : b.max) ?? 0) * 100}%`
                                    }
                                })
                            })]
                        })]
                    })]
                })]
            })]
        }), u && i.jsxs("div", {
            className: "p-8 absolute w-[30rem] h-[15.75rem] rounded-[0.3125rem] border border-white/[.03]",
            style: {
                background: "linear-gradient(163deg, rgba(255, 255, 255, 0.04)0%, rgba(255, 255, 255, 0.02)100%)"
            },
            children: [i.jsxs("div", {
                className: "flex items-center justify-between",
                children: [i.jsx("p", {
                    className: "text-white text-base font-medium",
                    children: "Convidar membro"
                }), i.jsx("img", {
                    src: sl,
                    onClick: () => d(!1),
                    className: "cursor-pointer"
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-2 my-6",
                children: [i.jsx("label", {
                    className: "text-white/45 text-sm font-medium",
                    children: "Identificador"
                }), i.jsx("input", {
                    onChange: k => r(Number(k.target.value)),
                    type: "number",
                    placeholder: "1337",
                    className: "text-center text-white text-sm font-medium w-full rounded border border-white/[.08] h-12 bg-transparent outline-none placeholder:text-white"
                })]
            }), i.jsx("button", {
                onClick: w,
                className: "w-full h-12 border border-primary bg-primary-gradient text-white text-base font-bold rounded=[0.1875rem]",
                children: "CONVIDAR"
            })]
        }), p && i.jsxs("div", {
            className: "w-screen h-screen absolute flex items-center justify-center gap-8 flex-col z-20",
            children: [i.jsx("img", {
                onClick: () => c(!1),
                src: sl,
                className: "w-[2.9375rem] h-[2.9375rem] absolute right-[3.75rem] top-[3.75rem] opacity-50 cursor-pointer"
            }), i.jsxs("div", {
                className: "flex flex-col items-center",
                children: [i.jsx("p", {
                    className: "text-primary text-2xl font-normal font-fugaz",
                    children: "SELECIONE UMA"
                }), i.jsx("h3", {
                    className: "text-white text-5xl font-normal font-days",
                    children: "COLORAÇÃO"
                })]
            }), i.jsx("div", {
                className: "w-[99.5rem] h-[35.125rem] max-h-[35.125rem] flex flex-wrap gap-4 overflow-auto",
                children: ts.slice(15, 45).map( (k, C) => i.jsx("div", {
                    onClick: () => a(k),
                    className: `w-[32.5rem] h-[9.25rem] rounded-lg bg-default-gradient flex items-center justify-center opacity-75 cursor-pointer ${k === o && "!opacity-100 border-2 border-white"}`,
                    style: {
                        background: k
                    }
                }, C))
            }), i.jsx("button", {
                onClick: m,
                className: "w-[32.5rem] h-[3.25rem] rounded-[.1875rem] border border-primary bg-hover-gradient text-white text-lg font-bold",
                children: "SELECIONAR BANNER"
            })]
        })]
    })
}
function Ad({title: e, subtitle: t, type: n}) {
    const r = tn()
      , l = () => {
        F("BACK_TEAM", null, !0).then( () => r("/"))
    }
    ;
    return i.jsxs("div", {
        className: "flex items-center justify-between w-[88.5rem] mb-8",
        children: [i.jsxs("div", {
            children: [i.jsx("h3", {
                className: "font-fugaz text-primary text-[2rem] font-normal",
                style: {
                    letterSpacing: "-0.16rem"
                },
                children: t || "FIVE"
            }), i.jsx("h1", {
                className: "font-days text-white text-[4rem] font-normal leading-[2rem] uppercase",
                children: e
            })]
        }), i.jsx("img", {
            onClick: () => n === "teams" ? l() : r({
                pathname: "/"
            }),
            src: ns,
            className: "cursor-pointer hover:scale-125 duration-200 w-[3.25rem]"
        })]
    })
}
function ru(e) {
    return es({
        tag: "svg",
        attr: {
            viewBox: "0 0 512 512"
        },
        child: [{
            tag: "path",
            attr: {
                d: "M173.898 439.404l-166.4-166.4c-9.997-9.997-9.997-26.206 0-36.204l36.203-36.204c9.997-9.998 26.207-9.998 36.204 0L192 312.69 432.095 72.596c9.997-9.997 26.207-9.997 36.204 0l36.203 36.204c9.997 9.997 9.997 26.206 0 36.204l-294.4 294.401c-9.998 9.997-26.207 9.997-36.204-.001z"
            },
            child: []
        }]
    })(e)
}
function Xh(e) {
    return es({
        tag: "svg",
        attr: {
            viewBox: "0 0 512 512"
        },
        child: [{
            tag: "path",
            attr: {
                d: "M0 168v-16c0-13.255 10.745-24 24-24h360V80c0-21.367 25.899-32.042 40.971-16.971l80 80c9.372 9.373 9.372 24.569 0 33.941l-80 80C409.956 271.982 384 261.456 384 240v-48H24c-13.255 0-24-10.745-24-24zm488 152H128v-48c0-21.314-25.862-32.08-40.971-16.971l-80 80c-9.372 9.373-9.372 24.569 0 33.941l80 80C102.057 463.997 128 453.437 128 432v-48h360c13.255 0 24-10.745 24-24v-16c0-13.255-10.745-24-24-24z"
            },
            child: []
        }]
    })(e)
}
const B = (e, t) => {
    const n = v.useRef(xh);
    v.useEffect( () => {
        n.current = t
    }
    , [t]),
    v.useEffect( () => {
        const r = l => {
            const {action: s, data: o} = l.data;
            n.current && s === e && n.current(o)
        }
        ;
        return window.addEventListener("message", r),
        () => window.removeEventListener("message", r)
    }
    , [e])
}
;
function Ud(e) {
    var t, n, r = "";
    if (typeof e == "string" || typeof e == "number")
        r += e;
    else if (typeof e == "object")
        if (Array.isArray(e)) {
            var l = e.length;
            for (t = 0; t < l; t++)
                e[t] && (n = Ud(e[t])) && (r && (r += " "),
                r += n)
        } else
            for (n in e)
                e[n] && (r && (r += " "),
                r += n);
    return r
}
function Ae() {
    for (var e, t, n = 0, r = "", l = arguments.length; n < l; n++)
        (e = arguments[n]) && (t = Ud(e)) && (r && (r += " "),
        r += t);
    return r
}
function Yh() {
    var s, o, a, u, d, p;
    const [e,t] = v.useState({})
      , n = ((s = e.teams) == null ? void 0 : s.ct.find(c => c.leader && c.my)) || ((o = e.teams) == null ? void 0 : o.tr.find(c => c.leader && c.my))
      , r = () => {
        t(c => {
            const m = c.teams.ct.find(x => x.my) || c.teams.tr.find(x => x.my);
            if (m) {
                const x = c.teams.ct.includes(m)
                  , y = x ? c.teams.ct.filter(j => j !== m) : [...c.teams.ct, {
                    ...m,
                    my: !0
                }]
                  , w = x ? [...c.teams.tr, {
                    ...m,
                    my: !0
                }] : c.teams.tr.filter(j => j !== m);
                return y.length > c.players.max || w.length > c.players.max ? (console.log("Time cheio!"),
                c) : {
                    ...c,
                    teams: {
                        ct: y,
                        tr: w
                    }
                }
            }
            return c
        }
        ),
        F("ROOM_UPDATED", e)
    }
      , l = () => {
        F("START_GAME", e, !0)
    }
    ;
    return B("ROOM_UPDATED", t),
    v.useEffect( () => {
        F("GET_ROOM", null, {
            id: 1,
            name: "Sala1",
            image: "/images/rooms/room1.png",
            owner_id: 123,
            players: {
                current: 1,
                max: 6
            },
            weapon: "AK-47",
            rounds: 10,
            mode: "DEATHMATCH",
            kills: 10,
            teams: {
                ct: [{
                    user_id: 33,
                    name: "Samuel Santana",
                    elo: "Diamond",
                    banner: "/images/ranking/bronze.png"
                }, {
                    user_id: 2,
                    name: "Pedro Santana",
                    elo: "Diamond",
                    banner: "/images/ranking/bronze.png"
                }, {
                    user_id: 14,
                    name: "Ruan Pablo",
                    elo: "Bronze",
                    clan: "BIBA",
                    banner: "/images/ranking/bronze.png"
                }],
                tr: [{
                    my: !0,
                    user_id: 123,
                    name: "Marcos Vinicius",
                    elo: "Diamond",
                    clan: "BIXA",
                    banner: "/images/ranking/bronze.png",
                    leader: !0
                }, {
                    user_id: 22,
                    name: "Flavio Jeremias",
                    elo: "Ouro",
                    clan: "BIBA",
                    banner: "/images/ranking/bronze.png"
                }, {
                    user_id: 55,
                    name: "Flavio Jeremias",
                    elo: "Ouro",
                    clan: "BIBA",
                    banner: "/images/ranking/bronze.png"
                }]
            }
        }).then(t)
    }
    , []),
    v.useEffect( () => {
        var m, x;
        const c = ((m = e.teams) == null ? void 0 : m.ct.find(y => y.leader)) || ((x = e.teams) == null ? void 0 : x.tr.find(y => y.leader));
        console.log(JSON.stringify(e)),
        console.log(c == null ? void 0 : c.user_id, e.owner_id)
    }
    , [e]),
    i.jsxs("div", {
        className: "w-screen h-screen bg-back bg-cover bg-no-repeat bg-center flex flex-col items-center justify-center",
        children: [i.jsx(Ad, {
            title: e.name,
            subtitle: "SALA",
            type: "teams"
        }), i.jsxs("div", {
            className: "flex items-start gap-8",
            children: [i.jsxs("div", {
                className: "w-[24.5625rem] h-[44.375rem] bg-default-gradient rounded-[0.3125rem] flex flex-col items-center",
                children: [i.jsx("div", {
                    className: "w-[21.5625rem] h-[14.9375rem] rounded bg-white/[.08] flex-none p-1 mt-[1.56rem]",
                    children: i.jsx("div", {
                        className: "w-full h-full rounded-[.125rem] !bg-cover !bg-center !bg-no-repeat",
                        style: {
                            background: `url(${e == null ? void 0 : e.image})`
                        }
                    })
                }), i.jsxs("div", {
                    className: "flex flex-col gap-[.63rem] mt-6",
                    children: [i.jsx("h2", {
                        className: "text-white text-base font-medium w-[21.5625rem] h-[2.625rem] rounded bg-white/[.04] grid place-items-center",
                        children: e == null ? void 0 : e.name
                    }), i.jsxs("div", {
                        className: "flex flex-col gap-[.63rem]",
                        children: [i.jsxs("div", {
                            className: "flex items-center justify-between w-[21.5625rem] h-[3.75rem] rounded bg-white/[.04] px-[.67rem]",
                            children: [i.jsx("p", {
                                className: "text-white/35 text-base font-medium",
                                children: "Jogadores"
                            }), i.jsxs("p", {
                                className: "flex items-center gap-2 text-white text-base font-medium",
                                children: [(a = e == null ? void 0 : e.players) == null ? void 0 : a.current, "/", ((u = e == null ? void 0 : e.players) == null ? void 0 : u.max) / 2]
                            })]
                        }), i.jsxs("div", {
                            className: "flex items-center justify-between w-[21.5625rem] h-[3.75rem] rounded bg-white/[.04] px-[.67rem]",
                            children: [i.jsx("p", {
                                className: "text-white/35 text-base font-medium",
                                children: "Arma"
                            }), i.jsx("p", {
                                className: "flex items-center gap-2 text-white text-base font-medium",
                                children: e == null ? void 0 : e.weapon
                            })]
                        }), i.jsxs("div", {
                            className: "flex items-center justify-between w-[21.5625rem] h-[3.75rem] rounded bg-white/[.04] px-[.67rem]",
                            children: [i.jsx("p", {
                                className: "text-white/35 text-base font-medium",
                                children: "Quantidade de rodadas:"
                            }), i.jsx("p", {
                                className: "flex items-center gap-2 text-white text-base font-medium",
                                children: e == null ? void 0 : e.rounds
                            })]
                        }), i.jsxs("div", {
                            className: "flex items-center justify-between w-[21.5625rem] h-[3.75rem] rounded bg-white/[.04] px-[.67rem]",
                            children: [i.jsx("p", {
                                className: "text-white/35 text-base font-medium",
                                children: "Modo de jogo"
                            }), i.jsx("p", {
                                className: "uppercase flex items-center gap-2 text-white text-base font-medium",
                                children: e == null ? void 0 : e.mode
                            })]
                        }), (e == null ? void 0 : e.kills) && i.jsxs("div", {
                            className: "flex items-center justify-between w-[21.5625rem] h-[3.75rem] rounded bg-white/[.04] px-[.67rem]",
                            children: [i.jsx("p", {
                                className: "text-white/35 text-base font-medium",
                                children: "Kills para finalizar"
                            }), i.jsx("p", {
                                className: "flex items-center gap-2 text-white text-base font-medium",
                                children: e == null ? void 0 : e.kills
                            })]
                        })]
                    })]
                })]
            }), i.jsxs("div", {
                className: "w-[61.9375rem] h-[44.3125rem] p-6 rounded-[0.3125rem] bg-default-gradient flex flex-col",
                children: [i.jsxs("div", {
                    className: "flex items-center gap-3",
                    children: [i.jsx("div", {
                        className: "flex-1 h-[2.375rem] rounded border-[.0625rem] border-white/25 flex items-center justify-center text-white text-sm font-medium",
                        children: "Contra-terrorista"
                    }), i.jsx("div", {
                        onClick: r,
                        className: "w-[2.4375rem] h-[2.375rem] rounded border-[1px] border-white/25 grid place-items-center group hover:bg-primary-gradient hover:border-primary cursor-pointer",
                        children: i.jsx(Xh, {
                            className: "text-white/65 size-4 group-hover:text-white"
                        })
                    }), i.jsx("div", {
                        className: "flex-1 h-[2.375rem] rounded border-[.0625rem] border-white/25 flex items-center justify-center text-white text-sm font-medium",
                        children: "Terrorista"
                    })]
                }), i.jsxs("div", {
                    className: "w-full h-[34.4375rem] flex items-start gap-[.94rem] mt-3",
                    children: [i.jsx("div", {
                        className: "flex-1 flex flex-col gap-[.76rem]",
                        children: Array.from({
                            length: ((d = e.players) == null ? void 0 : d.max) / 2
                        }).map( (c, m) => {
                            var x, y, w, j, h, f, g;
                            return i.jsx("div", {
                                className: "w-full h-[5.11456rem] rounded border-[.0625rem] border-white/25 flex items-center justify-between px-4",
                                children: ((x = e.teams) == null ? void 0 : x.ct[m]) && i.jsxs(i.Fragment, {
                                    children: [i.jsxs("div", {
                                        className: "flex items-center gap-6",
                                        children: [i.jsx("img", {
                                            src: ((y = e.teams) == null ? void 0 : y.ct[m].elo) === "Bronze" ? tt : ((w = e.teams) == null ? void 0 : w.ct[m].elo) === "Ouro" ? et : nt,
                                            alt: "Bronze",
                                            className: "w-8"
                                        }), i.jsxs("p", {
                                            className: "text-white text-sm font-medium flex items-center gap-2",
                                            children: [(j = e.teams) == null ? void 0 : j.ct[m].name, ((h = e.teams) == null ? void 0 : h.ct[m].clan) && i.jsx("b", {
                                                className: "h-6 bg-primary px-[.38rem] rounded-[0.3125rem] flex items-center justify-center",
                                                children: (f = e.teams) == null ? void 0 : f.ct[m].clan
                                            })]
                                        })]
                                    }), ((g = e.teams) == null ? void 0 : g.ct[m].leader) && i.jsx("div", {
                                        className: "w-[2.625rem] h-[1.62169rem] rounded bg-white/15 grid place-items-center",
                                        children: i.jsx(ru, {
                                            className: "text-white w-4"
                                        })
                                    })]
                                })
                            }, m)
                        }
                        )
                    }), i.jsx("div", {
                        className: "flex-1 flex flex-col gap-[.76rem]",
                        children: Array.from({
                            length: ((p = e.players) == null ? void 0 : p.max) / 2
                        }).map( (c, m) => {
                            var x, y, w, j, h, f, g;
                            return i.jsx("div", {
                                className: "w-full h-[5.11456rem] rounded border-[.0625rem] border-white/25 flex items-center justify-between px-4",
                                children: ((x = e.teams) == null ? void 0 : x.tr[m]) && i.jsxs(i.Fragment, {
                                    children: [i.jsxs("div", {
                                        className: "flex items-center gap-6",
                                        children: [i.jsx("img", {
                                            src: ((y = e.teams) == null ? void 0 : y.tr[m].elo) === "Bronze" ? tt : ((w = e.teams) == null ? void 0 : w.tr[m].elo) === "Ouro" ? et : nt,
                                            alt: "Bronze",
                                            className: "w-8"
                                        }), i.jsxs("p", {
                                            className: "text-white text-sm font-medium flex items-center gap-2",
                                            children: [(j = e.teams) == null ? void 0 : j.tr[m].name, ((h = e.teams) == null ? void 0 : h.tr[m].clan) && i.jsx("b", {
                                                className: "h-6 bg-primary px-[.38rem] rounded-[0.3125rem] flex items-center justify-center",
                                                children: (f = e.teams) == null ? void 0 : f.tr[m].clan
                                            })]
                                        })]
                                    }), ((g = e.teams) == null ? void 0 : g.tr[m].leader) && i.jsx("div", {
                                        className: "w-[2.625rem] h-[1.62169rem] rounded bg-white/15 grid place-items-center",
                                        children: i.jsx(ru, {
                                            className: "text-white w-4"
                                        })
                                    })]
                                })
                            }, m)
                        }
                        )
                    })]
                }), i.jsx("button", {
                    onClick: l,
                    className: Ae((n == null ? void 0 : n.user_id) !== e.owner_id ? "opacity-50 cursor-not-allowed" : "", "w-full h-[3.125rem] rounded bg-primary-gradient border-[.0625rem] border-primary text-white text-base font-medium mt-[.62rem]"),
                    children: "INICIAR PARTIDA"
                })]
            })]
        })]
    })
}
const Md = zo(e => ({
    room: {},
    updateRoom: t => e({
        room: t
    })
}))
  , $d = zo(e => ({
    arenas: {
        highscore: [],
        rooms: []
    },
    updateArenas: t => e({
        arenas: t
    })
}))
  , Jh = "" + new URL("../icons/list/map.svg",import.meta.url).href
  , Ti = "" + new URL("../icons/list/eye.svg",import.meta.url).href
  , lu = "" + new URL("../icons/list/user.svg",import.meta.url).href
  , Zh = "" + new URL("../icons/list/lock.svg",import.meta.url).href
  , su = "" + new URL("../icons/list/round.svg",import.meta.url).href
  , qh = "" + new URL("../images/list/gold.png",import.meta.url).href
  , eg = "" + new URL("../images/list/silver.png",import.meta.url).href
  , tg = "" + new URL("../images/list/bronze.png",import.meta.url).href;
function ng({arenas: e, setOpenedPrivateModal: t, setOpenedCreateModal: n}) {
    var u, d;
    const {profile: r} = ls()
      , {room: l, updateRoom: s} = Md();
    function o(p) {
        if (p.players.current === p.players.max) {
            console.log("Sala cheia!");
            return
        }
        if (p.private) {
            t(!0);
            return
        }
        F("JOIN_ROOM", {
            room: p
        }, !0)
    }
    function a(p) {
        F("SPECTATE", {
            room: p
        })
    }
    return i.jsxs("div", {
        className: "flex items-center gap-8",
        children: [i.jsxs("div", {
            className: "w-[24.5625rem] h-[44.375rem] bg-default-gradient rounded-[0.3125rem] flex flex-col items-center",
            children: [i.jsx("div", {
                className: "w-[21.5625rem] h-[14.9375rem] rounded bg-white/[.08] flex-none p-1 mt-[1.56rem]",
                children: i.jsx("div", {
                    className: "w-full h-full rounded-[.125rem] !bg-cover !bg-center !bg-no-repeat",
                    style: {
                        background: `url(${l == null ? void 0 : l.image})`
                    }
                })
            }), i.jsxs("div", {
                className: "flex flex-col gap-[.63rem] mt-6",
                children: [i.jsx("h2", {
                    className: "text-white text-base font-medium w-[21.5625rem] h-[2.625rem] rounded bg-white/[.04] grid place-items-center",
                    children: l == null ? void 0 : l.name
                }), i.jsxs("div", {
                    className: "flex flex-col gap-[.63rem]",
                    children: [i.jsxs("div", {
                        className: "flex items-center justify-between w-[21.5625rem] h-[2.625rem] rounded bg-white/[.04] px-[.67rem]",
                        children: [i.jsx("p", {
                            className: "text-white/35 text-base font-medium",
                            children: "Jogadores"
                        }), i.jsxs("p", {
                            className: "flex items-center gap-2 text-white text-base font-medium",
                            children: [i.jsx("img", {
                                src: lu,
                                className: "w-[1.125rem]"
                            }), (u = l == null ? void 0 : l.players) == null ? void 0 : u.current, "/", (d = l == null ? void 0 : l.players) == null ? void 0 : d.max]
                        })]
                    }), i.jsxs("div", {
                        className: "flex items-center justify-between w-[21.5625rem] h-[2.625rem] rounded bg-white/[.04] px-[.67rem]",
                        children: [i.jsx("p", {
                            className: "text-white/35 text-base font-medium",
                            children: "Rodadas"
                        }), i.jsxs("p", {
                            className: "flex items-center gap-2 text-white text-base font-medium",
                            children: [i.jsx("img", {
                                src: su,
                                className: "w-[1.125rem]"
                            }), l == null ? void 0 : l.rounds]
                        })]
                    }), i.jsxs("div", {
                        className: "flex items-center justify-between w-[21.5625rem] h-[2.625rem] rounded bg-white/[.04] px-[.67rem]",
                        children: [i.jsx("p", {
                            className: "text-white/35 text-base font-medium",
                            children: "Arma"
                        }), i.jsxs("p", {
                            className: "flex items-center gap-2 text-white text-base font-medium",
                            children: [i.jsx("img", {
                                src: su,
                                className: "w-[1.125rem]"
                            }), l == null ? void 0 : l.weapon]
                        })]
                    })]
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-2 mt-4",
                children: [i.jsx("h2", {
                    className: "text-white text-base font-medium w-[21.5625rem] h-[2.625rem] rounded bg-white/[.04] grid place-items-center",
                    children: "TOP 3"
                }), i.jsxs("div", {
                    className: "flex flex-col gap-[.39rem]",
                    children: [i.jsxs("div", {
                        className: "w-[21.5625rem] h-[2.625rem] rounded bg-white/[.04] grid place-items-center relative",
                        children: [i.jsx("img", {
                            src: qh,
                            className: "absolute left-3 w-[3.07188rem] h-[3.76188rem]"
                        }), i.jsx("p", {
                            className: "text-white text-base font-bold uppercase",
                            children: e.highscore[0]
                        })]
                    }), i.jsxs("div", {
                        className: "w-[21.5625rem] h-[2.625rem] rounded bg-white/[.04] grid place-items-center relative",
                        children: [i.jsx("img", {
                            src: eg,
                            className: "absolute left-3 w-[3.07188rem] h-[3.76188rem]"
                        }), i.jsx("p", {
                            className: "text-white text-base font-bold uppercase",
                            children: e.highscore[1]
                        })]
                    }), i.jsxs("div", {
                        className: "w-[21.5625rem] h-[2.625rem] rounded bg-white/[.04] grid place-items-center relative",
                        children: [i.jsx("img", {
                            src: tg,
                            className: "absolute left-3 w-[3.07188rem] h-[3.76188rem]"
                        }), i.jsx("p", {
                            className: "text-white text-base font-bold uppercase",
                            children: e.highscore[2]
                        })]
                    })]
                })]
            })]
        }), i.jsxs("div", {
            className: "w-[61.9375rem] h-[44.3125rem] bg-default-gradient rounded-[0.3125rem] flex flex-col items-center p-6",
            children: [i.jsxs("div", {
                className: "pl-6 w-[58.9375rem] h-[2.625rem] rounded border border-white/[.08] flex items-center",
                children: [i.jsx("p", {
                    className: "text-white/45 text-sm font-medium uppercase w-[13.25rem] mr-[2.69rem]",
                    children: "NOME DA SALA"
                }), i.jsx("p", {
                    className: "text-white/45 text-sm font-medium text-center uppercase w-[9.0625rem] mr-[6.75rem]",
                    children: "MAPA"
                }), i.jsx("p", {
                    className: "text-white/45 text-sm font-medium text-center uppercase w-[10.5625rem] mr-[2.56rem]",
                    children: "JOGADORES"
                }), i.jsx("button", {
                    onClick: () => n(!0),
                    className: "w-[12.1875rem] h-[1.875rem] rounded-[0.1875rem] border border-primary bg-primary-gradient text-white text-sm font-medium",
                    children: "CRIAR SALA"
                })]
            }), i.jsx("div", {
                className: "flex flex-col gap-2 mt-3 max-h-[37.9375rem] overflow-auto",
                children: e.rooms && Object.keys(e.rooms).map(p => {
                    const c = e.rooms[p];
                    return i.jsxs("div", {
                        onClick: () => s(c),
                        className: `${(l == null ? void 0 : l.index) === c.index ? "bg-white/15" : "bg-white/[.04]"} cursor-pointer w-[58.9375rem] h-[2.625rem] rounded flex flex-none items-center pl-[1.5rem]`,
                        children: [i.jsx("p", {
                            className: "text-white text-sm font-medium w-[13.25rem] mr-[2.69rem]",
                            children: c.name
                        }), i.jsxs("p", {
                            className: "text-white text-sm font-medium flex items-center justify-center gap-2 w-[9.0625rem] mr-[6.75rem]",
                            children: [i.jsx("img", {
                                src: Jh,
                                className: "w-4"
                            }), c.map]
                        }), i.jsxs("p", {
                            className: "text-white text-sm font-medium flex items-center justify-center gap-2 w-[10.5625rem] mr-[.31rem]",
                            children: [i.jsx("img", {
                                src: lu,
                                className: "w-4"
                            }), c.players.current, "/", c.players.max]
                        }), i.jsxs("div", {
                            className: "flex items-center gap-[1.13rem]",
                            children: [r.staff && i.jsx("img", {
                                onClick: () => a(c),
                                src: Ti,
                                className: "w-4"
                            }), i.jsxs("button", {
                                onClick: () => o(c),
                                className: `${c.players.current === c.players.max ? "bg-default-gradient border-white/[.05] text-white/35" : "bg-primary-gradient"} w-[12.1875rem] h-[1.875rem] rounded-[0.1875rem] border border-primary text-white text-sm font-medium flex items-center justify-center gap-2`,
                                children: [c.private && c.players.current !== c.players.max && i.jsx("img", {
                                    src: Zh,
                                    className: "w-3"
                                }), c.players.current === c.players.max ? "SALA CHEIA" : "JUNTAR-SE"]
                            })]
                        })]
                    }, p)
                }
                )
            })]
        })]
    })
}
const Oi = "" + new URL("../icons/profile/close-outline.svg",import.meta.url).href;
var se = [];
for (var Os = 0; Os < 256; ++Os)
    se.push((Os + 256).toString(16).slice(1));
function rg(e, t=0) {
    return (se[e[t + 0]] + se[e[t + 1]] + se[e[t + 2]] + se[e[t + 3]] + "-" + se[e[t + 4]] + se[e[t + 5]] + "-" + se[e[t + 6]] + se[e[t + 7]] + "-" + se[e[t + 8]] + se[e[t + 9]] + "-" + se[e[t + 10]] + se[e[t + 11]] + se[e[t + 12]] + se[e[t + 13]] + se[e[t + 14]] + se[e[t + 15]]).toLowerCase()
}
var Wr, lg = new Uint8Array(16);
function sg() {
    if (!Wr && (Wr = typeof crypto < "u" && crypto.getRandomValues && crypto.getRandomValues.bind(crypto),
    !Wr))
        throw new Error("crypto.getRandomValues() not supported. See https://github.com/uuidjs/uuid#getrandomvalues-not-supported");
    return Wr(lg)
}
var ig = typeof crypto < "u" && crypto.randomUUID && crypto.randomUUID.bind(crypto);
const iu = {
    randomUUID: ig
};
function og(e, t, n) {
    if (iu.randomUUID && !t && !e)
        return iu.randomUUID();
    e = e || {};
    var r = e.random || (e.rng || sg)();
    return r[6] = r[6] & 15 | 64,
    r[8] = r[8] & 63 | 128,
    rg(r)
}
function ag({setOpenedCreateModal: e}) {
    var lt, _, z, T;
    const {type: t} = Cr()
      , {arenas: n, updateArenas: r} = $d()
      , [l,s] = v.useState("")
      , [o,a] = v.useState(0)
      , [u,d] = v.useState([])
      , [p,c] = v.useState(0)
      , [m,x] = v.useState("rifle")
      , [y,w] = v.useState(t === "teams" ? 2 : 0)
      , [j,h] = v.useState("")
      , [f,g] = v.useState([])
      , [N,E] = v.useState(0)
      , [b,k] = v.useState("")
      , [C,I] = v.useState(2)
      , [L,M] = v.useState(!1)
      , [K,je] = v.useState(!1);
    function We(R) {
        a(O => R === "left" ? O === 0 ? u.length - 1 : O - 1 : O === u.length - 1 ? 0 : O + 1)
    }
    function It() {
        const R = Date.now().toString(36)
          , O = og().split("-")[0];
        return `${R}-${O}`
    }
    function rt() {
        if (!l) {
            console.log("A sala necessita de um nome");
            return
        }
        let R = {
            index: It(),
            mode: t,
            map: u[o],
            name: l,
            players: y,
            password: j,
            private: L
        };
        t === "teams" ? R = {
            ...R,
            rounds: C,
            weapon: b
        } : t === "gungame" ? R = {
            ...R,
            minutes: N
        } : t === "ffa" && (R = {
            ...R,
            weapon: b,
            kills: p
        }),
        F("CREATE_ROOM", R, {
            id: 1,
            index: It(),
            kills: 20,
            mode: "ffa",
            private: !0,
            password: "abc",
            image: "https://images.panda.org/assets/images/pages/welcome/orangutan_1600x1000_279157.jpg",
            name: l,
            map: u[o].name,
            rounds: 10,
            weapon: b,
            players: {
                current: 12,
                max: 12
            }
        }).then(O => {
            O && r && r({
                ...n,
                rooms: [...n.rooms, O]
            }),
            e(!1)
        }
        )
    }
    return v.useEffect( () => {
        F("GET_OPTIONS", {
            category: m
        }, ["test"]).then(R => {
            g(R),
            k(R[0])
        }
        )
    }
    , [m]),
    v.useEffect( () => {
        F("GET_MAPS", null, [{
            image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsIosuXcz2ZRfiVPuTWFiXm1vP7itNAy4Atg&s",
            name: "dust"
        }, {
            image: "https://media.assettype.com/afkgaming%2F2022-08%2F1288abab-b398-4c85-a093-5e20865e1142%2FCover_Image___S1mple_And_B1t_Defend_CSGO_Map_Mirage_After_HObbit_Calls_It_Boring.jpg?auto=format%2Ccompress&dpr=1.0&w=1200",
            name: "mirage"
        }]).then(d)
    }
    , []),
    t === "teams" ? i.jsxs("div", {
        className: "absolute w-[30rem] p-8 rounded-[0.3125rem]",
        style: {
            background: "linear-gradient(163deg, rgba(255, 255, 255, 0.04) 0%, rgba(255, 255, 255, 0.02) 100%)"
        },
        children: [i.jsxs("div", {
            className: "flex items-center justify-between",
            children: [i.jsx("h4", {
                className: "text-white text-base font-medium",
                children: "Criar nova sala"
            }), i.jsx("img", {
                src: Oi,
                className: "w-[1.375rem] cursor-pointer",
                onClick: () => e(!1)
            })]
        }), i.jsx("div", {
            className: "w-[26rem] h-[8rem] px-6 py-3 rounded flex justify-center items-end my-4 bg-center bg-cover bg-no-repeat",
            style: {
                backgroundImage: `url(${(lt = u[o]) == null ? void 0 : lt.image})`
            },
            children: i.jsxs("div", {
                className: "flex items-center justify-between",
                children: [i.jsx("svg", {
                    onClick: () => We("left"),
                    className: "w-[1.125rem]",
                    viewBox: "0 0 18 18",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: i.jsx("path", {
                        d: "M14.2504 2.24994L14.2504 15.7499C14.25 15.8866 14.2123 16.0206 14.1414 16.1374C14.0705 16.2543 13.9691 16.3496 13.848 16.4131C13.727 16.4766 13.5909 16.5059 13.4545 16.4978C13.318 16.4897 13.1864 16.4445 13.0737 16.3672L3.3237 9.61719C2.91945 9.33744 2.91945 8.66394 3.3237 8.38344L13.0737 1.63344C13.1862 1.55531 13.3179 1.50949 13.4545 1.50097C13.5912 1.49244 13.7276 1.52153 13.8489 1.58508C13.9702 1.64862 14.0718 1.7442 14.1426 1.86141C14.2133 1.97863 14.2507 2.11301 14.2504 2.24994Z",
                        fill: "white"
                    })
                }), i.jsx("p", {
                    className: "text-white text-base font-bold w-[20.75rem] text-center",
                    children: (_ = u[o]) == null ? void 0 : _.name
                }), i.jsx("svg", {
                    onClick: () => We("right"),
                    className: "w-[1.125rem]",
                    viewBox: "0 0 18 18",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: i.jsx("path", {
                        d: "M3.74956 2.24994L3.74955 15.7499C3.74998 15.8866 3.78768 16.0206 3.85859 16.1374C3.9295 16.2543 4.03093 16.3496 4.15197 16.4131C4.27301 16.4766 4.40908 16.5059 4.54552 16.4978C4.68196 16.4897 4.81361 16.4445 4.92631 16.3672L14.6763 9.61719C15.0806 9.33744 15.0806 8.66394 14.6763 8.38344L4.92631 1.63344C4.81385 1.55531 4.68213 1.50949 4.54546 1.50097C4.40879 1.49244 4.2724 1.52153 4.1511 1.58508C4.0298 1.64862 3.92824 1.7442 3.85745 1.86141C3.78665 1.97863 3.74934 2.11301 3.74956 2.24994Z",
                        fill: "white"
                    })
                })]
            })
        }), i.jsxs("div", {
            className: "flex flex-col gap-3",
            children: [i.jsxs("div", {
                className: "flex flex-col gap-2",
                children: [i.jsxs("p", {
                    className: "text-white/45 text-sm font-medium",
                    children: [" Nome da sala ", i.jsx("b", {
                        className: "text-white/25",
                        children: "(máximo 10 caracteres)"
                    }), " "]
                }), i.jsx("input", {
                    type: "text",
                    value: l,
                    maxLength: 10,
                    placeholder: "han bixa",
                    onChange: R => s(R.target.value),
                    className: "w-full h-12 bg-transparent rounded border border-white/[.08] text-center text-white text-sm font-medium placeholder:text-white outline-none"
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-2",
                children: [i.jsx("p", {
                    className: "text-white/45 text-sm font-medium",
                    children: "Máximo de pessoas por time:"
                }), i.jsxs("div", {
                    className: "flex items-center gap-[.62rem]",
                    children: [i.jsx("div", {
                        onClick: () => w(2),
                        className: Ae(y === 2 ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]", "w-[4.7rem] h-12 grid place-items-center text-white text-sm font-medium rounded border-[.0625rem] cursor-pointer"),
                        children: "2"
                    }), i.jsx("div", {
                        onClick: () => w(3),
                        className: Ae(y === 3 ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]", "w-[4.7rem] h-12 grid place-items-center text-white text-sm font-medium rounded border-[.0625rem] cursor-pointer"),
                        children: "3"
                    }), i.jsx("div", {
                        onClick: () => w(4),
                        className: Ae(y === 4 ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]", "w-[4.7rem] h-12 grid place-items-center text-white text-sm font-medium rounded border-[.0625rem] cursor-pointer"),
                        children: "4"
                    }), i.jsx("div", {
                        onClick: () => w(5),
                        className: Ae(y === 5 ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]", "w-[4.7rem] h-12 grid place-items-center text-white text-sm font-medium rounded border-[.0625rem] cursor-pointer"),
                        children: "5"
                    }), i.jsx("div", {
                        onClick: () => w(6),
                        className: Ae(y === 6 ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]", "w-[4.7rem] h-12 grid place-items-center text-white text-sm font-medium rounded border-[.0625rem] cursor-pointer"),
                        children: "6"
                    })]
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-2",
                children: [i.jsx("p", {
                    className: "text-white/45 text-sm font-medium",
                    children: "Rounds:"
                }), i.jsxs("div", {
                    className: "flex items-center gap-[.62rem]",
                    children: [i.jsx("div", {
                        onClick: () => I(12),
                        className: Ae("flex-1 h-12 grid place-items-center text-white text-sm font-medium rounded border-[.0625rem] cursor-pointer", C === 12 ? "bg-primary-gradient border-primary" : "border-white/[.08]"),
                        children: "12"
                    }), i.jsx("div", {
                        onClick: () => I(24),
                        className: Ae("flex-1 h-12 grid place-items-center text-white text-sm font-medium rounded border-[.0625rem] cursor-pointer", C === 24 ? "bg-primary-gradient border-primary" : "border-white/[.08]"),
                        children: "24"
                    }), i.jsx("div", {
                        onClick: () => I(30),
                        className: Ae("flex-1 h-12 grid place-items-center text-white text-sm font-medium rounded border-[.0625rem] cursor-pointer", C === 30 ? "bg-primary-gradient border-primary" : "border-white/[.08]"),
                        children: "30"
                    })]
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-2",
                children: [i.jsxs("div", {
                    className: "flex items-center justify-between",
                    children: [i.jsx("p", {
                        className: "text-white/45 text-sm font-medium",
                        children: "Senha da sala"
                    }), i.jsxs("label", {
                        className: "relative inline-block w-12 h-7",
                        children: [i.jsx("input", {
                            type: "checkbox",
                            checked: L,
                            onChange: () => M(!L),
                            className: "opacity-0 w-0 h-0"
                        }), i.jsx("span", {
                            className: `absolute cursor-pointer top-0 left-0 right-0 bottom-0 bg-white/[.08]  rounded-full transition duration-300 ${L ? "bg-primary-gradient" : ""}`
                        }), i.jsx("span", {
                            className: `absolute left-1 top-1 bg-white w-5 h-5 rounded-full transition transform duration-300 ${L ? "translate-x-5" : ""}`
                        })]
                    })]
                }), i.jsxs("div", {
                    className: `${!L && "opacity-25 pointer-events-none"} relative w-full h-12 bg-transparent flex items-center rounded border border-white/[.08] text-center text-white text-sm font-medium placeholder:text-white outline-none`,
                    children: [i.jsx("input", {
                        onChange: R => h(R.target.value),
                        value: j,
                        type: K ? "text" : "password",
                        placeholder: "han",
                        className: "w-full h-full bg-transparent text-center text-white text-sm font-medium placeholder:text-white outline-none"
                    }), i.jsx("img", {
                        onClick: () => je(!K),
                        src: Ti,
                        className: "cursor-pointer w-6 absolute right-3"
                    })]
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-2",
                children: [i.jsx("p", {
                    className: "text-white/45 text-sm font-medium",
                    children: "Arma selecionada"
                }), i.jsxs("div", {
                    className: "flex items-center gap-[.62rem]",
                    children: [i.jsx("button", {
                        onClick: () => x("rifle"),
                        className: `${m === "rifle" ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]"} border  w-[6.03125rem] h-12 text-white text-sm font-normal rounded`,
                        children: "Rifle"
                    }), i.jsx("button", {
                        onClick: () => x("pistol"),
                        className: `${m === "pistol" ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]"} border w-[6.03125rem] h-12 text-white text-sm font-normal rounded`,
                        children: "Pistola"
                    }), i.jsx("button", {
                        onClick: () => x("sub"),
                        className: `${m === "sub" ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]"} border w-[6.03125rem] h-12 text-white text-sm font-normal rounded`,
                        children: "Sub"
                    }), i.jsx("button", {
                        onClick: () => x("shotgun"),
                        className: `${m === "shotgun" ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]"} border w-[6.03125rem] h-12 text-white text-sm font-normal rounded`,
                        children: "Doze"
                    })]
                })]
            }), i.jsx("select", {
                onChange: R => k(R.target.value),
                className: "bg-transparent border border-white/[.08] w-full h-12 text-white text-center text-sm font-normal rounded outline-none",
                children: f.map( (R, O) => i.jsx("option", {
                    value: R,
                    className: "bg-black/80 border-none",
                    children: R
                }, O))
            })]
        }), i.jsx("button", {
            onClick: rt,
            className: "w-full h-12 mt-6 border border-primary bg-primary-gradient rounded text-white text-base font-bold",
            children: "CRIAR SALA"
        })]
    }) : i.jsxs("div", {
        className: "absolute w-[30rem] p-8 rounded-[0.3125rem]",
        style: {
            background: "linear-gradient(163deg, rgba(255, 255, 255, 0.04) 0%, rgba(255, 255, 255, 0.02) 100%)"
        },
        children: [i.jsxs("div", {
            className: "flex items-center justify-between",
            children: [i.jsx("h4", {
                className: "text-white text-base font-medium",
                children: "Criar nova sala"
            }), i.jsx("img", {
                src: Oi,
                className: "w-[1.375rem] cursor-pointer",
                onClick: () => e(!1)
            })]
        }), i.jsx("div", {
            className: "w-[26rem] h-[8rem] px-6 py-3 rounded flex justify-center items-end my-4 bg-center bg-cover bg-no-repeat",
            style: {
                backgroundImage: `url(${(z = u[o]) == null ? void 0 : z.image})`
            },
            children: i.jsxs("div", {
                className: "flex items-center justify-between",
                children: [i.jsx("svg", {
                    onClick: () => We("left"),
                    className: "w-[1.125rem]",
                    viewBox: "0 0 18 18",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: i.jsx("path", {
                        d: "M14.2504 2.24994L14.2504 15.7499C14.25 15.8866 14.2123 16.0206 14.1414 16.1374C14.0705 16.2543 13.9691 16.3496 13.848 16.4131C13.727 16.4766 13.5909 16.5059 13.4545 16.4978C13.318 16.4897 13.1864 16.4445 13.0737 16.3672L3.3237 9.61719C2.91945 9.33744 2.91945 8.66394 3.3237 8.38344L13.0737 1.63344C13.1862 1.55531 13.3179 1.50949 13.4545 1.50097C13.5912 1.49244 13.7276 1.52153 13.8489 1.58508C13.9702 1.64862 14.0718 1.7442 14.1426 1.86141C14.2133 1.97863 14.2507 2.11301 14.2504 2.24994Z",
                        fill: "white"
                    })
                }), i.jsx("p", {
                    className: "text-white text-base font-bold w-[20.75rem] text-center",
                    children: (T = u[o]) == null ? void 0 : T.name
                }), i.jsx("svg", {
                    onClick: () => We("right"),
                    className: "w-[1.125rem]",
                    viewBox: "0 0 18 18",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: i.jsx("path", {
                        d: "M3.74956 2.24994L3.74955 15.7499C3.74998 15.8866 3.78768 16.0206 3.85859 16.1374C3.9295 16.2543 4.03093 16.3496 4.15197 16.4131C4.27301 16.4766 4.40908 16.5059 4.54552 16.4978C4.68196 16.4897 4.81361 16.4445 4.92631 16.3672L14.6763 9.61719C15.0806 9.33744 15.0806 8.66394 14.6763 8.38344L4.92631 1.63344C4.81385 1.55531 4.68213 1.50949 4.54546 1.50097C4.40879 1.49244 4.2724 1.52153 4.1511 1.58508C4.0298 1.64862 3.92824 1.7442 3.85745 1.86141C3.78665 1.97863 3.74934 2.11301 3.74956 2.24994Z",
                        fill: "white"
                    })
                })]
            })
        }), i.jsxs("div", {
            className: "flex flex-col gap-3",
            children: [i.jsxs("div", {
                className: "flex flex-col gap-2",
                children: [i.jsxs("p", {
                    className: "text-white/45 text-sm font-medium",
                    children: ["Nome da sala ", i.jsx("b", {
                        className: "text-white/25",
                        children: "(máximo 10 caracteres)"
                    })]
                }), i.jsx("input", {
                    onChange: R => s(R.target.value),
                    value: l,
                    maxLength: 10,
                    type: "text",
                    placeholder: "han bixa",
                    className: "w-full h-12 bg-transparent rounded border border-white/[.08] text-center text-white text-sm font-medium placeholder:text-white outline-none"
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-2",
                children: [i.jsx("p", {
                    className: "text-white/45 text-sm font-medium",
                    children: t === "ffa" ? " Quantidade de kills" : "Minutos para acabar"
                }), i.jsx("input", {
                    type: "number",
                    placeholder: "30",
                    value: t === "ffa" ? p : N,
                    onChange: R => t === "ffa" ? c(Number(R.target.value)) : E(Number(R.target.value)),
                    className: "w-full h-12 bg-transparent rounded border border-white/[.08] text-center text-white text-sm font-medium placeholder:text-white outline-none"
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-2",
                children: [i.jsx("p", {
                    className: "text-white/45 text-sm font-medium",
                    children: "Máximo de pessoas"
                }), i.jsx("input", {
                    onChange: R => {
                        const O = R.target.value.replace(/^0+/, "")
                          , st = Math.min(Number(O) || 0, 15);
                        w(st)
                    }
                    ,
                    value: y,
                    min: 2,
                    max: 15,
                    type: "number",
                    placeholder: "15",
                    className: "w-full h-12 bg-transparent rounded border border-white/[.08] text-center text-white text-sm font-medium placeholder:text-white outline-none"
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-2",
                children: [i.jsxs("div", {
                    className: "flex items-center justify-between",
                    children: [i.jsx("p", {
                        className: "text-white/45 text-sm font-medium",
                        children: "Senha da sala"
                    }), i.jsxs("label", {
                        className: "relative inline-block w-12 h-7",
                        children: [i.jsx("input", {
                            type: "checkbox",
                            checked: L,
                            onChange: () => M(!L),
                            className: "opacity-0 w-0 h-0"
                        }), i.jsx("span", {
                            className: `absolute cursor-pointer top-0 left-0 right-0 bottom-0 bg-white/[.08]  rounded-full transition duration-300 ${L ? "bg-primary-gradient" : ""}`
                        }), i.jsx("span", {
                            className: `absolute left-1 top-1 bg-white w-5 h-5 rounded-full transition transform duration-300 ${L ? "translate-x-5" : ""}`
                        })]
                    })]
                }), i.jsxs("div", {
                    className: `${!L && "opacity-25 pointer-events-none"} relative w-full h-12 bg-transparent flex items-center rounded border border-white/[.08] text-center text-white text-sm font-medium placeholder:text-white outline-none`,
                    children: [i.jsx("input", {
                        onChange: R => h(R.target.value),
                        value: j,
                        type: K ? "text" : "password",
                        placeholder: "han",
                        className: "w-full h-full bg-transparent text-center text-white text-sm font-medium placeholder:text-white outline-none"
                    }), i.jsx("img", {
                        onClick: () => je(!K),
                        src: Ti,
                        className: "cursor-pointer w-6 absolute right-3"
                    })]
                })]
            }), t === "ffa" && i.jsxs("div", {
                className: "flex flex-col gap-2",
                children: [i.jsx("p", {
                    className: "text-white/45 text-sm font-medium",
                    children: "Arma selecionada"
                }), i.jsxs("div", {
                    className: "flex items-center gap-[.62rem]",
                    children: [i.jsx("button", {
                        onClick: () => x("rifle"),
                        className: `${m === "rifle" ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]"} border  w-[6.03125rem] h-12 text-white text-sm font-normal rounded`,
                        children: "Rifle"
                    }), i.jsx("button", {
                        onClick: () => x("pistol"),
                        className: `${m === "pistol" ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]"} border w-[6.03125rem] h-12 text-white text-sm font-normal rounded`,
                        children: "Pistola"
                    }), i.jsx("button", {
                        onClick: () => x("sub"),
                        className: `${m === "sub" ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]"} border w-[6.03125rem] h-12 text-white text-sm font-normal rounded`,
                        children: "Sub"
                    }), i.jsx("button", {
                        onClick: () => x("shotgun"),
                        className: `${m === "shotgun" ? "bg-primary-gradient border-primary" : "bg-transparent border-white/[.08]"} border w-[6.03125rem] h-12 text-white text-sm font-normal rounded`,
                        children: "Doze"
                    })]
                })]
            }), t === "ffa" && i.jsx("select", {
                onChange: R => k(R.target.value),
                className: "bg-transparent border border-white/[.08] w-full h-12 text-white text-center text-sm font-normal rounded outline-none",
                children: f.map( (R, O) => i.jsx("option", {
                    value: R,
                    className: "bg-black/80 border-none",
                    children: R
                }, O))
            })]
        }), i.jsx("button", {
            onClick: rt,
            className: "w-full h-12 mt-6 border border-primary bg-primary-gradient rounded text-white text-base font-bold",
            children: "CRIAR SALA"
        })]
    })
}
function ug() {
    const {type: e} = Cr()
      , {room: t, updateRoom: n} = Md()
      , {arenas: r, updateArenas: l} = $d()
      , [s,o] = v.useState("")
      , [a,u] = v.useState(!1)
      , [d,p] = v.useState(!1);
    function c() {
        if (s !== t.password) {
            console.log("Senha incorreta!");
            return
        }
        F("JOIN_ROOM", {
            room: t
        }, !0)
    }
    return v.useEffect( () => {
        F("GET_ARENAS", {
            mode: e
        }, {
            highscore: ["pedro", "ruan", "flavio"],
            rooms: []
        }).then(m => {
            l && l(m),
            n(m.rooms[0])
        }
        )
    }
    , []),
    i.jsxs("div", {
        className: "w-screen h-screen bg-back bg-cover bg-no-repeat bg-center grid place-items-center",
        children: [i.jsxs("div", {
            className: `${(d || a) && "opacity-[.05] pointer-events-none"}`,
            children: [i.jsx(Ad, {
                title: `${e}`,
                subtitle: "ARENAS"
            }), i.jsx(ng, {
                arenas: r,
                setOpenedPrivateModal: p,
                setOpenedCreateModal: u
            })]
        }), d && i.jsxs("div", {
            className: "p-8 absolute w-[30rem] h-[15.75rem] rounded-[0.3125rem] border border-white/[.03]",
            style: {
                background: "linear-gradient(163deg, rgba(255, 255, 255, 0.04)0%, rgba(255, 255, 255, 0.02)100%)"
            },
            children: [i.jsxs("div", {
                className: "flex items-center justify-between",
                children: [i.jsx("p", {
                    className: "text-white text-base font-medium uppercase",
                    children: t.name
                }), i.jsx("img", {
                    onClick: () => p(!1),
                    src: sl,
                    className: "cursor-pointer w-[1.375rem]"
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-2 my-6",
                children: [i.jsx("label", {
                    className: "text-white/45 text-sm font-medium",
                    children: "Insira a senha da sala:"
                }), i.jsx("input", {
                    onChange: m => o(m.target.value),
                    type: "password",
                    placeholder: "****",
                    className: "text-center text-white text-sm font-medium w-full rounded border border-white/[.08] h-12 bg-transparent outline-none placeholder:text-white"
                })]
            }), i.jsx("button", {
                onClick: c,
                className: "w-full h-12 border border-primary bg-primary-gradient text-white text-base font-bold rounded=[0.1875rem]",
                children: "ENTRAR"
            })]
        }), a && i.jsx(ag, {
            setOpenedCreateModal: u
        })]
    })
}
const cg = "" + new URL("../icons/menu/gun.svg",import.meta.url).href
  , dg = "" + new URL("../icons/menu/user.svg",import.meta.url).href
  , mg = "" + new URL("../icons/menu/trophy.svg",import.meta.url).href
  , fg = "" + new URL("../icons/menu/team.svg",import.meta.url).href
  , pg = "" + new URL("../icons/menu/skull.svg",import.meta.url).href
  , hg = "" + new URL("../images/menu/ctf.png",import.meta.url).href
  , gg = "" + new URL("../images/menu/ffa.png",import.meta.url).href
  , xg = "" + new URL("../images/menu/teams.png",import.meta.url).href
  , vg = "" + new URL("../images/menu/gungame.png",import.meta.url).href;
function yg() {
    const e = tn()
      , {profile: t, updateProfile: n} = ls();
    return v.useEffect( () => {
        F("GET_PROFILE", {}, {
            id: 123,
            name: "Pedro Silva",
            color: "#BE38F3",
            elos: {
                solo: {
                    elo: "gold",
                    name: "Ouro I",
                    points: {
                        current: 223,
                        max: 500
                    }
                },
                squad: {
                    elo: "gold",
                    name: "Ouro I",
                    points: {
                        current: 223,
                        max: 500
                    }
                }
            },
            matchs: [{
                type: "ffa",
                win: !1
            }, {
                type: "ffa",
                win: !0
            }, {
                type: "ffa",
                win: !0
            }, {
                type: "ffa",
                win: !1
            }]
        }).then(n)
    }
    , []),
    i.jsx("div", {
        className: "w-screen h-screen bg-back bg-cover bg-no-repeat bg-center grid place-items-center",
        children: i.jsxs("div", {
            className: "flex flex-col gap-8 items-center justify-center",
            children: [i.jsxs("header", {
                className: "flex items-center justify-between w-[88.5rem]",
                children: [i.jsxs("div", {
                    children: [i.jsx("h3", {
                        className: "font-fugaz text-primary text-[2rem] font-normal",
                        style: {
                            letterSpacing: "-0.16rem"
                        },
                        children: "FIVE"
                    }), i.jsx("h1", {
                        className: "font-days text-white text-[4rem] font-normal leading-[2rem]",
                        children: "ARENA"
                    })]
                }), i.jsxs("div", {
                    onClick: () => F("OPEN_SKINS", {}, !0),
                    className: "w-[16.5rem] h-[2.75rem] bg-default-gradient rounded-[0.3125rem] flex items-center gap-[2.25rem] px-[.31rem] -ml-28 hover:bg-hover-gradient cursor-pointer",
                    children: [i.jsx("div", {
                        className: "w-[2.125rem] h-[2.125rem] bg-default-gradient rounded-[.17rem] grid place-items-center",
                        children: i.jsx("img", {
                            src: cg,
                            className: "w-5"
                        })
                    }), i.jsx("p", {
                        className: "text-white text-base font-fugaz font-normal",
                        style: {
                            letterSpacing: "-.08rem"
                        },
                        children: "SKINS DE ARMAS"
                    })]
                }), i.jsxs("div", {
                    className: "flex items-center gap-3",
                    children: [i.jsxs("div", {
                        children: [i.jsx("p", {
                            className: "text-white text-base font-days font-normal text-right",
                            children: t.name
                        }), i.jsxs("p", {
                            className: "text-white/45 text-sm font-medium text-right",
                            children: ["#", t.id]
                        })]
                    }), i.jsx("img", {
                        onClick: () => e({
                            pathname: "/profile"
                        }),
                        src: dg,
                        className: "w-[3.25rem] opacity-15 hover:opacity-100 cursor-pointer duration-300"
                    })]
                })]
            }), i.jsxs("main", {
                className: "flex items-center gap-8",
                children: [i.jsx("img", {
                    src: vg,
                    draggable: !1,
                    onClick: () => e({
                        pathname: "/rooms/gungame"
                    }),
                    className: "w-[20.625rem] h-[37.5rem] grayscale-[1] hover:grayscale-0 duration-200 cursor-pointer"
                }), i.jsx("img", {
                    src: gg,
                    draggable: !1,
                    onClick: () => e({
                        pathname: "/rooms/ffa"
                    }),
                    className: "w-[20.625rem] h-[37.5rem] grayscale-[1] hover:grayscale-0 duration-200 cursor-pointer"
                }), i.jsx("img", {
                    src: xg,
                    draggable: !1,
                    onClick: () => e({
                        pathname: "/rooms/teams"
                    }),
                    className: "w-[20.625rem] h-[37.5rem] grayscale-[1] hover:grayscale-0 duration-200 cursor-pointer"
                }), i.jsx("img", {
                    src: hg,
                    draggable: !1,
                    className: "w-[20.625rem] h-[37.5rem] grayscale-[1] hover:grayscale-0 duration-200 cursor-pointer pointer-events-none opacity-25"
                })]
            }), i.jsxs("footer", {
                className: "flex items-center gap-8",
                children: [i.jsxs("div", {
                    onClick: () => e({
                        pathname: "/ranking"
                    }),
                    className: "flex items-center gap-[.88rem] bg-default-gradient h-[4.875rem] w-[43.25rem] px-[.87rem] rounded-[0.375rem] hover:bg-hover-gradient cursor-pointer",
                    children: [i.jsx("div", {
                        className: "w-[3.125rem] h-[3.125rem] bg-default-gradient rounded flex items-center justify-center",
                        children: i.jsx("img", {
                            src: mg,
                            className: "w-8"
                        })
                    }), i.jsxs("div", {
                        children: [i.jsx("small", {
                            className: "text-white/45 text-sm font-normal font-fugaz",
                            children: "ACESSAR"
                        }), i.jsx("p", {
                            className: "text-white text-[2rem] font-fugaz font-normal leading-[2rem]",
                            children: "RANKING"
                        })]
                    })]
                }), i.jsxs("div", {
                    onClick: () => e({
                        pathname: "/x1"
                    }),
                    className: "flex items-center gap-[.88rem] bg-default-gradient h-[4.875rem] w-[20.625rem] px-[.87rem] rounded-[0.375rem] hover:bg-hover-gradient cursor-pointer",
                    children: [i.jsx("div", {
                        className: "w-[3.125rem] h-[3.125rem] bg-default-gradient rounded flex items-center justify-center",
                        children: i.jsx("img", {
                            src: pg,
                            className: "w-8"
                        })
                    }), i.jsxs("div", {
                        children: [i.jsx("small", {
                            className: "text-white/45 text-sm font-normal font-fugaz",
                            children: "ÁREA DE"
                        }), i.jsx("p", {
                            className: "text-white text-[2rem] font-fugaz font-normal leading-[2rem]",
                            children: "X1"
                        })]
                    })]
                }), i.jsxs("div", {
                    onClick: () => F("OPEN_SQUAD"),
                    className: "flex items-center gap-[.88rem] bg-default-gradient h-[4.875rem] w-[20.625rem] px-[.87rem] rounded-[0.375rem] hover:bg-hover-gradient cursor-pointer",
                    children: [i.jsx("div", {
                        className: "w-[3.125rem] h-[3.125rem] bg-default-gradient rounded flex items-center justify-center",
                        children: i.jsx("img", {
                            src: fg,
                            className: "w-8"
                        })
                    }), i.jsxs("div", {
                        children: [i.jsx("small", {
                            className: "text-white/45 text-sm font-normal font-fugaz",
                            children: "MEU"
                        }), i.jsx("p", {
                            className: "text-white text-[2rem] font-fugaz font-normal leading-[2rem]",
                            children: "SQUAD"
                        })]
                    })]
                })]
            })]
        })
    })
}
const wg = "" + new URL("../images/ranking/one.png",import.meta.url).href
  , Ng = "" + new URL("../images/ranking/two.png",import.meta.url).href
  , jg = "" + new URL("../images/ranking/three.png",import.meta.url).href
  , Sg = "" + new URL("../icons/ranking/arrow-up.svg",import.meta.url).href
  , kg = "" + new URL("../icons/ranking/arrow-down.svg",import.meta.url).href;
function Eg({name: e, clan: t, wins: n, kills: r, points: l, status: s, position: o}) {
    return i.jsxs("div", {
        className: "w-[61.3125rem] h-[2.625rem] rounded bg-default-gradient flex items-center pl-[.56rem] flex-none",
        children: [i.jsxs("div", {
            className: "flex items-center gap-[2.4rem] mr-[1.31rem]",
            children: [i.jsx("div", {
                children: o >= 3 ? i.jsxs("p", {
                    className: "w-[2.4375rem] text-white/65 text-base font-medium text-center",
                    children: [o + 1, "°"]
                }) : i.jsx("img", {
                    src: o === 0 ? wg : o === 1 ? Ng : jg,
                    className: "h-[2.92588rem]"
                })
            }), i.jsx("div", {
                children: i.jsx("img", {
                    src: s ? Sg : kg
                })
            })]
        }), i.jsxs("p", {
            className: "text-white text-sm font-medium w-[11.5rem] mr-[1.56rem] flex items-center gap-2",
            children: [e, " ", i.jsx("span", {
                className: "bg-primary font-bold h-[1.375rem] px-2 rounded py-1 flex items-center justify-center",
                children: t
            })]
        }), i.jsx("p", {
            className: "text-white text-sm font-medium w-[7.75rem] mr-[6.13rem] text-center",
            children: n
        }), i.jsxs("p", {
            className: "text-white text-sm font-medium w-[10.375rem] mr-[4.25rem] text-center",
            children: [r, " ", i.jsx("b", {
                className: "text-white/45",
                children: "kills"
            })]
        }), i.jsxs("p", {
            className: "text-white text-sm font-medium w-[11.125rem] text-center",
            children: [l, " ", i.jsx("b", {
                className: "text-white/45",
                children: "pontos"
            })]
        })]
    })
}
function Cg() {
    var x, y, w, j, h, f, g, N, E, b, k, C, I, L;
    const e = tn()
      , [t,n] = v.useState("bronze")
      , [r,l] = v.useState("solo")
      , [s,o] = v.useState([])
      , [a,u] = v.useState([])
      , [d,p] = v.useState({})
      , c = M => {
        F("GET_LIST", {
            type: M
        }, [{
            name: "asdsadg",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "gold"
        }, {
            name: "asdsadg",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "gold"
        }, {
            name: "asdsadd",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "diamond"
        }, {
            name: "asdsadd",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "diamond"
        }, {
            name: "asdsadb",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "bronze"
        }, {
            name: "asdsadb",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "bronze"
        }]).then(K => {
            u(K),
            o(K.filter(je => je.elo === t))
        }
        ),
        F("GET_PROFILE", {}, {
            id: 123123213,
            name: "Pedro Silva",
            color: "#BE38F3",
            elos: {
                solo: {
                    elo: "bronze",
                    name: "Diamate III",
                    points: {
                        current: 123123,
                        max: 123213
                    }
                },
                squad: {
                    elo: "gold",
                    name: "Ouro I",
                    points: {
                        current: 223,
                        max: 500
                    }
                }
            },
            matchs: []
        }).then(p),
        l(M)
    }
      , m = M => {
        n(M),
        o(a.filter(K => K.elo === M))
    }
    ;
    return v.useEffect( () => {
        F("GET_LIST", {
            type: r
        }, [{
            name: "asdsadg",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "gold"
        }, {
            name: "asdsadg",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "gold"
        }, {
            name: "asdsadd",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "diamond"
        }, {
            name: "asdsadd",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "diamond"
        }, {
            name: "asdsadb",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "bronze"
        }, {
            name: "asdsadb",
            clan: "asdsad",
            wins: 12312,
            kills: 12312,
            points: 12321,
            status: !0,
            elo: "bronze"
        }]).then(M => {
            u(M),
            o(M.filter(K => K.elo === "bronze"))
        }
        ),
        F("GET_PROFILE", {}, {
            id: 123123213,
            name: "Pedro Silva",
            color: "#BE38F3",
            elos: {
                solo: {
                    elo: "diamond",
                    name: "Diamate III",
                    points: {
                        current: 123123,
                        max: 123213
                    }
                },
                squad: {
                    elo: "gold",
                    name: "Ouro I",
                    points: {
                        current: 223,
                        max: 500
                    }
                }
            },
            matchs: []
        }).then(p)
    }
    , []),
    i.jsx("div", {
        className: "w-screen h-screen bg-back bg-cover bg-no-repeat bg-center grid place-items-center",
        children: i.jsxs("div", {
            className: "flex flex-col gap-8",
            children: [i.jsxs("div", {
                className: "flex items-center justify-between w-[88.5rem]",
                children: [i.jsxs("div", {
                    children: [i.jsx("h3", {
                        className: "font-fugaz text-primary text-[2rem] font-normal",
                        style: {
                            letterSpacing: "-0.16rem"
                        },
                        children: "FIVE ARENA"
                    }), i.jsx("h1", {
                        className: "font-days text-white text-[4rem] font-normal leading-[2rem]",
                        children: "RANKING"
                    })]
                }), i.jsx("img", {
                    onClick: () => e({
                        pathname: "/"
                    }),
                    src: ns,
                    className: "cursor-pointer hover:scale-125 duration-200"
                })]
            }), i.jsxs("div", {
                className: "w-[88.5rem] h-[44.3125rem] rounded-[0.3125rem] bg-default-gradient p-6 border border-white/[.075]",
                children: [i.jsxs("div", {
                    className: "flex items-center w-full gap-4 mb-4",
                    children: [i.jsx("button", {
                        onClick: () => c("solo"),
                        className: `flex-1 text-white text-base font-medium h-[2.875rem] rounded border ${r === "solo" ? "border-primary bg-hover-gradient" : "border-white/25"}`,
                        children: "Ranking Solo"
                    }), i.jsx("button", {
                        onClick: () => c("clans"),
                        className: `flex-1 text-white text-base font-medium h-[2.875rem] rounded border ${r === "clans" ? "border-primary bg-hover-gradient" : "border-white/25"}`,
                        children: "Ranking de Clãs"
                    })]
                }), i.jsxs("div", {
                    className: "flex items-center gap-4",
                    children: [i.jsxs("div", {
                        children: [i.jsxs("div", {
                            className: "flex items-center gap-[.63rem]",
                            children: [i.jsx("button", {
                                onClick: () => m("bronze"),
                                className: `${t === "bronze" ? "bg-bronze-gradient border-bronze text-white" : "border-white/[.08] text-white/45"} w-[20.02081rem] h-[2.1875rem] rounded border text-sm font-medium`,
                                children: "Bronze"
                            }), i.jsx("button", {
                                onClick: () => m("gold"),
                                className: `${t === "gold" ? "bg-gold-gradient border-gold text-white" : "border-white/[.08] text-white/45"} w-[20.02081rem] h-[2.1875rem] rounded border text-sm font-medium`,
                                children: "Ouro"
                            }), i.jsx("button", {
                                onClick: () => m("diamond"),
                                className: `${t === "diamond" ? "bg-diamond-gradient border-diamond text-white" : "border-white/[.08] text-white/45"} w-[20.02081rem] h-[2.1875rem] rounded border text-sm font-medium`,
                                children: "Diamante"
                            })]
                        }), i.jsxs("div", {
                            children: [i.jsxs("div", {
                                className: "flex items-center h-[2.125rem] w-[61.3125rem] rounded border border-white/[.08] pl-[.56rem] mt-[.63rem]",
                                children: [i.jsx("p", {
                                    className: "text-white/45 text-sm font-medium w-[2.4375rem] text-center mr-[4.81rem]",
                                    children: "#"
                                }), i.jsx("p", {
                                    className: "text-white/45 text-sm font-medium w-[11.5rem] mr-[1.56rem]",
                                    children: "Jogador"
                                }), i.jsx("p", {
                                    className: "text-white/45 text-sm font-medium w-[7.75rem] text-center mr-[6.13rem]",
                                    children: "Vitórias"
                                }), i.jsx("p", {
                                    className: "text-white/45 text-sm font-medium w-[10.375rem] text-center mr-[4.25rem]",
                                    children: "Kills"
                                }), i.jsx("p", {
                                    className: "text-white/45 text-sm font-medium w-[11.125rem] text-center",
                                    children: "Pontos"
                                })]
                            }), i.jsx("div", {
                                className: "h-[31.875rem] max-h-[31.875rem] flex flex-col gap-[.63rem] mt-[.62rem] overflow-auto",
                                children: s.map( (M, K) => i.jsx(Eg, {
                                    position: K,
                                    ...M
                                }, K))
                            })]
                        })]
                    }), i.jsxs("div", {
                        className: "border border-white/[.075] w-[23.1875rem] h-[37.4375rem] rounded-[0.3125rem] p-3 flex flex-col items-center",
                        style: {
                            background: "linear-gradient(163deg, rgba(255, 255, 255, 0.04) 0%, rgba(255, 255, 255, 0.02) 100%)"
                        },
                        children: [i.jsx("p", {
                            className: "w-full h-[2.75rem] rounded bg-white/[.03] text-white text-base flex items-center justify-center font-days font-normal",
                            children: r === "solo" ? "MEU ELO" : "ELO DO MEU CLÃ"
                        }), ((x = d.elos) == null ? void 0 : x[r === "solo" ? "solo" : "squad"]) && i.jsxs(i.Fragment, {
                            children: [i.jsx("h3", {
                                className: "text-white text-[1.75rem] font-bold mt-[3.38rem] mb-[1.38rem]",
                                children: (w = (y = d.elos) == null ? void 0 : y[r === "solo" ? "solo" : "squad"]) == null ? void 0 : w.name
                            }), i.jsx("img", {
                                src: ((h = (j = d.elos) == null ? void 0 : j[r === "solo" ? "solo" : "squad"]) == null ? void 0 : h.elo) === "bronze" ? tt : ((f = d.elos) == null ? void 0 : f[r === "solo" ? "solo" : "squad"].elo) === "gold" ? et : nt,
                                className: "w-[20.375rem] h-[20.375rem] mb-7"
                            }), i.jsxs("div", {
                                className: "flex items-center gap-2 mb-3",
                                children: [i.jsxs("h4", {
                                    className: "text-white text-[1.25rem] font-bold",
                                    children: [(g = d.elos) == null ? void 0 : g[r === "solo" ? "solo" : "squad"].points.current, i.jsxs("b", {
                                        className: "text-white/65",
                                        children: ["/", (N = d.elos) == null ? void 0 : N[r === "solo" ? "solo" : "squad"].points.max]
                                    })]
                                }), i.jsxs("p", {
                                    className: "text-base text-white/35 font-bold",
                                    children: [((E = d.elos) == null ? void 0 : E[r === "solo" ? "solo" : "squad"].points.max) - ((b = d.elos) == null ? void 0 : b[r === "solo" ? "solo" : "squad"].points.current), " ", "pontos pra subir"]
                                })]
                            }), i.jsx("div", {
                                className: "w-[20.25rem] h-[0.625rem] rounded-[.125rem] bg-white/[.04]",
                                children: i.jsx("div", {
                                    className: `h-full rounded-[.125rem] ${((k = d.elos) == null ? void 0 : k[r === "solo" ? "solo" : "squad"].elo) === "bronze" ? "bg-bronze-gradient" : ((C = d.elos) == null ? void 0 : C[r === "solo" ? "solo" : "squad"].elo) === "gold" ? "bg-gold-gradient" : "bg-diamond-gradient"}`,
                                    style: {
                                        width: `${((I = d.elos) == null ? void 0 : I[r === "solo" ? "solo" : "squad"].points.current) / ((L = d.elos) == null ? void 0 : L[r === "solo" ? "solo" : "squad"].points.max) * 100}%`
                                    }
                                })
                            })]
                        })]
                    })]
                })]
            })]
        })
    })
}
const Fs = "" + new URL("../icons/profile/close.svg",import.meta.url).href
  , Hr = "" + new URL("../icons/profile/check.svg",import.meta.url).href
  , Qr = "" + new URL("../icons/profile/refused.svg",import.meta.url).href
  , ss = "" + new URL("../images/five.png",import.meta.url).href;
function bg() {
    var y, w, j, h, f, g, N, E, b, k, C, I, L, M, K, je, We, It, rt, lt, _, z, T, R, O, st, He, nn, Qe, At, To, Oo;
    const e = tn()
      , {profile: t, updateProfile: n} = ls()
      , [r,l] = v.useState("")
      , [s,o] = v.useState("")
      , [a,u] = v.useState(!1)
      , [d,p] = v.useState(!1)
      , c = $ => {
        const Vd = $.target.value.replace(/[^a-zA-Z0-9]/g, "");
        l(Vd)
    }
      , m = () => {
        F("UPDATE_BANNER", {
            banner: s
        }, !0).then( () => n({
            ...t,
            banner: s
        })),
        p(!1)
    }
      , x = () => {
        r && (F("UPDATE_NAME", {
            name: r
        }, !0).then( () => n({
            ...t,
            name: r
        })),
        u(!1))
    }
    ;
    return i.jsxs("div", {
        className: "w-screen h-screen bg-back bg-cover bg-no-repeat bg-center grid place-items-center",
        children: [i.jsxs("div", {
            className: `flex flex-col gap-8 ${(d || a) && "opacity-[.05]"}`,
            children: [i.jsxs("div", {
                className: "flex items-center justify-between w-[88.5rem]",
                children: [i.jsxs("div", {
                    children: [i.jsx("h3", {
                        className: "font-fugaz text-primary text-[2rem] font-normal",
                        style: {
                            letterSpacing: "-0.16rem"
                        },
                        children: "MEU"
                    }), i.jsx("h1", {
                        className: "font-days text-white text-[4rem] font-normal leading-[2rem]",
                        children: "PERFIL"
                    })]
                }), i.jsx("img", {
                    onClick: () => e({
                        pathname: "/"
                    }),
                    src: ns,
                    className: "cursor-pointer hover:scale-125 duration-200"
                })]
            }), i.jsxs("div", {
                className: "w-[88.5rem] h-[44.375rem] rounded-[0.3125rem] bg-default-gradient flex flex-col items-center py-[.63rem] gap-8",
                children: [i.jsxs("div", {
                    className: "w-[87.25rem] h-[12.25rem] rounded flex items-center pl-8 !bg-center !bg-cover !bg-no-repeat relative before:absolute before:content-[''] before:w-full before:h-full before:bg-black/15 before:left-0 before:top-0",
                    style: {
                        background: t.banner ? t.banner : t.color
                    },
                    children: [i.jsxs("div", {
                        className: "z-20 flex items-center gap-6",
                        children: [i.jsx("div", {
                            className: "flex items-center justify-center w-[9.25rem] h-[9.25rem] rounded-full !bg-center !bg-cover !bg-no-repeat",
                            style: {
                                background: t.icon ? `url(${t.icon})` : t.color
                            },
                            children: !t.icon && i.jsx("img", {
                                src: ss,
                                className: "w-1/2"
                            })
                        }), i.jsxs("div", {
                            children: [i.jsxs("div", {
                                className: "flex items-center gap-3",
                                children: [i.jsxs("h4", {
                                    className: "text-white text-[1.375rem] font-days font-normal flex items-center gap-3 uppercase",
                                    children: [t.name, " ", t.clan && i.jsx("span", {
                                        className: "uppercase h-[1.75rem] text-white text-base font-bold bg-primary px-2 py-1 rounded flex items-center justify-center",
                                        children: t.clan
                                    })]
                                }), i.jsx("div", {
                                    onClick: () => u(!0),
                                    className: "w-[1.75rem] h-[1.75rem] bg-black/35 rounded flex items-center justify-center cursor-pointer",
                                    children: i.jsx("img", {
                                        src: zi
                                    })
                                })]
                            }), i.jsxs("p", {
                                className: "text-white/65 text-base font-bold",
                                children: ["#", t.id]
                            })]
                        })]
                    }), i.jsx("div", {
                        onClick: () => p(!0),
                        className: "z-20 absolute w-[1.75rem] h-[1.75rem] bg-black/35 rounded flex items-center justify-center cursor-pointer bottom-[1.13rem] right-[1.13rem]",
                        children: i.jsx("img", {
                            src: zi
                        })
                    })]
                }), i.jsxs("div", {
                    className: "w-[84.5rem] h-[27.5rem] rounded bg-white/[.03] p-5 flex items-center gap-5",
                    children: [i.jsxs("div", {
                        className: "flex flex-col gap-3",
                        children: [i.jsx("p", {
                            className: "w-[25rem] h-[2.75rem] rounded bg-white/[.03] text-white text-[1.125rem] font-normal font-days flex items-center justify-center",
                            children: "MEU ELO"
                        }), i.jsx("div", {
                            className: "flex flex-col items-center justify-center w-[25rem] h-[21.5rem] rounded bg-white/[.03] text-white text-[1.125rem] font-normal font-days",
                            children: !((y = t.elos) != null && y.solo) || typeof ((w = t.elos) == null ? void 0 : w.solo) == "boolean" ? i.jsxs(i.Fragment, {
                                children: [i.jsx("p", {
                                    className: "text-white text-xl font-bold",
                                    children: "Sem Elo"
                                }), i.jsx("img", {
                                    src: Fs,
                                    className: "opacity-5"
                                }), i.jsx("div", {
                                    className: "w-[20.25rem] h-[0.625rem] rounded-[.125rem] bg-white/[.04]"
                                })]
                            }) : i.jsxs(i.Fragment, {
                                children: [i.jsx("p", {
                                    className: "text-white text-xl font-bold",
                                    children: (j = t.elos) == null ? void 0 : j.solo.name
                                }), i.jsx("img", {
                                    src: ((h = t.elos) == null ? void 0 : h.solo.elo) === "bronze" ? tt : ((f = t.elos) == null ? void 0 : f.solo.elo) === "gold" ? et : nt,
                                    className: "h-[14.625rem]"
                                }), i.jsxs("p", {
                                    className: "text-white text-base font-bold",
                                    children: [(N = (g = t.elos) == null ? void 0 : g.solo.points.current) == null ? void 0 : N.toLocaleString("pt-br"), i.jsxs("b", {
                                        className: "text-white/65",
                                        children: ["/", (E = t.elos) == null ? void 0 : E.solo.points.max.toLocaleString("pt-br")]
                                    })]
                                }), i.jsx("div", {
                                    className: "w-[20.25rem] h-[0.625rem] rounded-[.125rem] bg-white/[.04]",
                                    children: i.jsx("div", {
                                        className: `h-full rounded-[.125rem] ${((b = t.elos) == null ? void 0 : b.solo.elo) === "bronze" ? "bg-bronze-gradient" : ((k = t.elos) == null ? void 0 : k.solo.elo) === "gold" ? "bg-gold-gradient" : ((C = t.elos) == null ? void 0 : C.solo.elo) === "diamond" ? "bg-diamond-gradient" : ""}`,
                                        style: {
                                            width: `${((L = (I = t.elos) == null ? void 0 : I.solo.points) == null ? void 0 : L.current) / ((K = (M = t.elos) == null ? void 0 : M.solo.points) == null ? void 0 : K.max) * 100}%`
                                        }
                                    })
                                })]
                            })
                        })]
                    }), i.jsxs("div", {
                        className: "flex flex-col gap-3",
                        children: [i.jsxs("p", {
                            className: "w-[25rem] h-[2.75rem] gap-2 rounded bg-white/[.03] text-white text-[1.125rem] font-normal font-days flex items-center justify-center",
                            children: ["ELO DO CLÃ", t.clan && i.jsx("span", {
                                className: "uppercase text-white text-base font-bold bg-primary px-2 rounded",
                                children: t.clan
                            })]
                        }), i.jsx("div", {
                            className: "flex flex-col items-center justify-center w-[25rem] h-[21.5rem] rounded bg-white/[.03] text-white text-[1.125rem] font-normal font-days",
                            children: !t.clan || !((je = t.elos) != null && je.squad) || typeof ((We = t.elos) == null ? void 0 : We.squad) == "boolean" ? i.jsxs(i.Fragment, {
                                children: [i.jsx("p", {
                                    className: "text-white text-xl font-bold text-center",
                                    children: t.clan ? `Clã: ${t.clan} sem ELO` : "Você não possui clã"
                                }), i.jsx("img", {
                                    src: Fs,
                                    className: "opacity-5 size-[14.625rem]"
                                }), i.jsx("div", {
                                    className: "w-[20.25rem] h-[0.625rem] rounded-[.125rem] bg-white/[.04] mt-6"
                                })]
                            }) : i.jsxs(i.Fragment, {
                                children: [i.jsx("p", {
                                    className: "text-white text-xl font-bold flex items-center gap-2",
                                    children: (It = t.elos) == null ? void 0 : It.squad.name
                                }), i.jsx("img", {
                                    src: ((rt = t.elos) == null ? void 0 : rt.squad.elo) === "bronze" ? tt : ((lt = t.elos) == null ? void 0 : lt.squad.elo) === "gold" ? et : nt,
                                    className: "h-[14.625rem]"
                                }), i.jsxs("p", {
                                    className: "text-white text-base font-bold",
                                    children: [(_ = t.elos) == null ? void 0 : _.squad.points.current.toLocaleString("pt-br"), i.jsxs("b", {
                                        className: "text-white/65",
                                        children: ["/", (z = t.elos) == null ? void 0 : z.squad.points.max.toLocaleString("pt-br")]
                                    })]
                                }), i.jsx("div", {
                                    className: "w-[20.25rem] h-[0.625rem] rounded-[.125rem] bg-white/[.04]",
                                    children: i.jsx("div", {
                                        className: `h-full rounded-[.125rem] ${((T = t.elos) == null ? void 0 : T.squad.elo) === "bronze" ? "bg-bronze-gradient" : ((R = t.elos) == null ? void 0 : R.squad.elo) === "gold" ? "bg-gold-gradient" : "bg-diamond-gradient"}`,
                                        style: {
                                            width: `${((st = (O = t.elos) == null ? void 0 : O.squad.points) == null ? void 0 : st.current) / ((nn = (He = t.elos) == null ? void 0 : He.squad.points) == null ? void 0 : nn.max) * 100}%`
                                        }
                                    })
                                })]
                            })
                        })]
                    }), i.jsxs("div", {
                        className: "flex flex-col gap-3",
                        children: [i.jsx("p", {
                            className: "w-[29.5rem] h-[2.75rem] rounded bg-white/[.03] text-white text-[1.125rem] font-normal font-days flex items-center justify-center",
                            children: "HISTÓRICO DE PARTIDAS"
                        }), i.jsxs("div", {
                            className: "w-[29.5rem] h-[21.5rem] rounded bg-white/[.03] text-white text-[1.125rem] font-normal font-days flex flex-col items-center justify-center gap-4",
                            children: [i.jsxs("div", {
                                className: "w-[27.5rem] h-[4.20313rem] rounded bg-white/[.03] flex items-center justify-between px-4",
                                children: [i.jsx("p", {
                                    className: "text-white text-xl font-days",
                                    children: "F.F.A"
                                }), i.jsx("div", {
                                    className: "flex items-center gap-2",
                                    children: (Qe = t == null ? void 0 : t.matchs) == null ? void 0 : Qe.filter($ => $.type === "ffa").map( ($, Ke) => i.jsx("div", {
                                        className: `w-[2.25rem] h-[2.25rem] rounded-[0.1875rem] ${$.win ? "bg-green-500/15" : "bg-red-500/15"} flex items-center justify-center`,
                                        children: i.jsx("img", {
                                            src: $.win ? Hr : Qr
                                        })
                                    }, Ke))
                                })]
                            }), i.jsxs("div", {
                                className: "w-[27.5rem] h-[4.20313rem] rounded bg-white/[.03] flex items-center justify-between px-4",
                                children: [i.jsx("p", {
                                    className: "text-white text-xl font-days",
                                    children: "EQUIPES"
                                }), i.jsx("div", {
                                    className: "flex items-center gap-2",
                                    children: (At = t == null ? void 0 : t.matchs) == null ? void 0 : At.filter($ => $.type === "teams").map( ($, Ke) => i.jsx("div", {
                                        className: `w-[2.25rem] h-[2.25rem] rounded-[0.1875rem] ${$.win ? "bg-green-500/15" : "bg-red-500/15"} flex items-center justify-center`,
                                        children: i.jsx("img", {
                                            src: $.win ? Hr : Qr
                                        })
                                    }, Ke))
                                })]
                            }), i.jsxs("div", {
                                className: "w-[27.5rem] h-[4.20313rem] rounded bg-white/[.03] flex items-center justify-between px-4",
                                children: [i.jsx("p", {
                                    className: "text-white text-xl font-days",
                                    children: "GUN GAME"
                                }), i.jsx("div", {
                                    className: "flex items-center gap-2",
                                    children: (To = t == null ? void 0 : t.matchs) == null ? void 0 : To.filter($ => $.type === "gungame").map( ($, Ke) => i.jsx("div", {
                                        className: `w-[2.25rem] h-[2.25rem] rounded-[0.1875rem] ${$.win ? "bg-green-500/15" : "bg-red-500/15"} flex items-center justify-center`,
                                        children: i.jsx("img", {
                                            src: $.win ? Hr : Qr
                                        })
                                    }, Ke))
                                })]
                            }), i.jsxs("div", {
                                className: "w-[27.5rem] h-[4.20313rem] rounded bg-white/[.03] flex items-center justify-between px-4",
                                children: [i.jsx("p", {
                                    className: "text-white text-xl font-days",
                                    children: "C. THE FLAG"
                                }), i.jsx("div", {
                                    className: "flex items-center gap-2",
                                    children: (Oo = t == null ? void 0 : t.matchs) == null ? void 0 : Oo.filter($ => $.type === "ctf").map( ($, Ke) => i.jsx("div", {
                                        className: `w-[2.25rem] h-[2.25rem] rounded-[0.1875rem] ${$.win ? "bg-green-500/15" : "bg-red-500/15"} flex items-center justify-center`,
                                        children: i.jsx("img", {
                                            src: $.win ? Hr : Qr
                                        })
                                    }, Ke))
                                })]
                            })]
                        })]
                    })]
                })]
            })]
        }), d && i.jsxs("div", {
            className: "w-screen h-screen absolute flex items-center justify-center gap-8 flex-col z-20",
            children: [i.jsx("img", {
                onClick: () => p(!1),
                src: Fs,
                className: "w-[2.9375rem] h-[2.9375rem] absolute right-[3.75rem] top-[3.75rem] opacity-50 cursor-pointer"
            }), i.jsxs("div", {
                className: "flex flex-col items-center",
                children: [i.jsx("p", {
                    className: "text-primary text-2xl font-normal font-fugaz",
                    children: "SELECIONE UM"
                }), i.jsx("h3", {
                    className: "text-white text-5xl font-normal font-days",
                    children: "BANNER"
                })]
            }), i.jsx("div", {
                className: "w-[99.5rem] h-[35.125rem] max-h-[35.125rem] flex flex-wrap gap-4 overflow-auto",
                children: ts.slice(15, 45).map( ($, Ke) => i.jsx("div", {
                    onClick: () => o($),
                    className: `w-[32.5rem] h-[9.25rem] rounded-lg bg-default-gradient flex items-center justify-center opacity-75 cursor-pointer ${$ === s && "!opacity-100 border-2 border-white"}`,
                    style: {
                        background: $
                    }
                }, Ke))
            }), i.jsx("button", {
                onClick: m,
                className: "w-[32.5rem] h-[3.25rem] rounded-[.1875rem] border border-primary bg-hover-gradient text-white text-lg font-bold",
                children: "SELECIONAR BANNER"
            })]
        }), a && i.jsxs("div", {
            className: "w-[30rem] h-[17.875rem] rounded-[0.3125rem] bg-default-gradient border border-white/[.05] absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 p-8",
            children: [i.jsx("h4", {
                className: "text-white text-base font-medium mb-3",
                children: "Editar nickname"
            }), i.jsxs("p", {
                className: "text-white/65 text-sm font-medium mb-4",
                children: ["Ao utilizar este item, você só poderá alterar seu nome ", i.jsx("br", {}), " ao comprar outro."]
            }), i.jsx("img", {
                onClick: () => u(!1),
                src: Oi,
                className: "absolute right-5 top-[1.88rem] cursor-pointer"
            }), i.jsxs("label", {
                className: "mb-2 text-white/45 text-sm font-medium",
                children: ["Novo nickname", " ", i.jsx("b", {
                    className: "text-white/25",
                    children: "(máximo 12 caracteres)"
                })]
            }), i.jsx("input", {
                onChange: $ => c($),
                value: r,
                type: "text",
                maxLength: 16,
                className: "mb-6 outline-none text-white text-sm font-medium rounded bg-transparent border border-white/[.08] w-[26rem] h-12 text-center",
                placeholder: "Nome"
            }), i.jsx("button", {
                onClick: x,
                className: "w-[26rem] h-12 border border-primary bg-hover-gradient text-white text-base font-bold",
                children: "ALTERAR NOME"
            })]
        })]
    })
}
function _g(e) {
    return es({
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
                d: "M12 3a9 9 0 0 0 0 18c.83 0 1.5-.67 1.5-1.5 0-.39-.15-.74-.39-1.01-.23-.26-.38-.61-.38-.99 0-.83.67-1.5 1.5-1.5H16c2.76 0 5-2.24 5-5 0-4.42-4.03-8-9-8zm-5.5 9c-.83 0-1.5-.67-1.5-1.5S5.67 9 6.5 9 8 9.67 8 10.5 7.33 12 6.5 12zm3-4C8.67 8 8 7.33 8 6.5S8.67 5 9.5 5s1.5.67 1.5 1.5S10.33 8 9.5 8zm5 0c-.83 0-1.5-.67-1.5-1.5S13.67 5 14.5 5s1.5.67 1.5 1.5S15.33 8 14.5 8zm3 4c-.83 0-1.5-.67-1.5-1.5S16.67 9 17.5 9s1.5.67 1.5 1.5-.67 1.5-1.5 1.5z"
            },
            child: []
        }]
    })(e)
}
function Pg() {
    const [e,t] = v.useState("")
      , [n,r] = v.useState("")
      , [l,s] = v.useState(!1)
      , [o,a] = v.useState(null)
      , u = () => {
        if (!e || !n || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(n)) {
            console.log("Informações inválidas, digite o nome e o email novamente.");
            return
        }
        F("REGISTER", {
            name: e,
            email: n,
            banner: o ?? "#FFFFFF14"
        }, !1).then(p => {
            p && F("CLOSE"),
            console.log("Conta não foi criada!")
        }
        )
    }
      , d = p => {
        const m = p.target.value.replace(/[^a-zA-Z0-9]/g, "");
        t(m)
    }
    ;
    return i.jsxs("div", {
        className: "w-screen h-screen bg-back bg-cover bg-no-repeat bg-center grid place-items-center",
        children: [i.jsxs("div", {
            className: "flex flex-col items-center gap-5",
            style: {
                opacity: l ? .05 : 1
            },
            children: [i.jsxs("div", {
                className: "flex flex-col items-center h-[6.375rem]",
                children: [i.jsx("h3", {
                    className: "font-fugaz text-primary text-[2rem] font-normal",
                    style: {
                        letterSpacing: "-0.16rem"
                    },
                    children: "FIVE"
                }), i.jsx("h1", {
                    className: "font-days text-white text-[4rem] font-normal leading-[2rem]",
                    children: "ARENA"
                })]
            }), i.jsx("p", {
                className: "text-white/55 text-sm font-medium",
                children: "Registre sua conta"
            }), i.jsxs("div", {
                className: "flex flex-col items-center gap-6",
                children: [i.jsx("p", {
                    className: "text-white/25 text-sm font-medium",
                    children: "Cor do perfil"
                }), i.jsx("div", {
                    onClick: () => s(!0),
                    className: "w-32 h-32 rounded-full flex items-center justify-center",
                    style: {
                        backgroundColor: o || "#FFFFFF14"
                    },
                    children: i.jsx(_g, {
                        size: 54,
                        className: `${o ? "text-white" : "text-white/25"}`
                    })
                })]
            }), i.jsxs("div", {
                className: "flex flex-col items-center gap-3",
                children: [i.jsx("label", {
                    className: "text-white/25 text-sm font-medium",
                    children: "Nickname da conta"
                }), i.jsxs("div", {
                    className: "w-[25rem] h-12 border border-white/15 flex items-center gap-4 px-4 rounded",
                    children: [i.jsx(Tl, {
                        size: 18,
                        className: "text-white/35"
                    }), i.jsx("input", {
                        type: "text",
                        value: e,
                        maxLength: 16,
                        onChange: p => d(p),
                        placeholder: "Nickname",
                        className: "flex-1 text-white text-sm font-medium bg-transparent outline-none placeholder:text-white"
                    })]
                })]
            }), i.jsxs("div", {
                className: "flex flex-col items-center gap-3",
                children: [i.jsx("label", {
                    className: "text-white/25 text-sm font-medium",
                    children: "E-mail da conta"
                }), i.jsxs("div", {
                    className: "w-[25rem] h-12 border border-white/15 flex items-center gap-4 px-4 rounded",
                    children: [i.jsx(Tl, {
                        size: 18,
                        className: "text-white/35"
                    }), i.jsx("input", {
                        type: "email",
                        onChange: p => r(p.target.value),
                        placeholder: "E-mail",
                        className: "flex-1 text-white text-sm font-medium bg-transparent outline-none placeholder:text-white"
                    })]
                })]
            }), i.jsxs("div", {
                className: "flex flex-col items-center gap-3",
                children: [i.jsx("p", {
                    className: "text-white/45 text-sm font-medium",
                    children: "Pré-visualização do banner do perfil"
                }), i.jsx("div", {
                    className: "w-[25rem] h-[8.25rem] rounded bg-white/[.08] flex items-center justify-center",
                    style: {
                        backgroundColor: o || "#FFFFFF14"
                    },
                    children: i.jsx("img", {
                        src: ss,
                        className: "h-[2.875rem]"
                    })
                })]
            }), i.jsx("button", {
                onClick: u,
                className: "w-[25rem] h-[3.25rem] bg-gradient-to-r from-primary to-primary/15 border border-primary rounded text-white text-lg font-bold",
                children: "CADASTRAR"
            })]
        }), l && i.jsxs("div", {
            className: "absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 flex flex-col items-center gap-8 ",
            children: [i.jsx("p", {
                className: "text-white/55 text-lg font-medium",
                children: "Selecione a cor do seu perfil"
            }), i.jsx("div", {
                className: "flex flex-wrap w-[22.375rem]",
                children: ts.map( (p, c) => i.jsx("div", {
                    onClick: () => a(p),
                    className: `w-[1.86456rem] h-[1.8625rem] rounded-[.05rem] cursor-pointer relative ${o === p && 'before:absolute before:top-1/2 before:-translate-y-1/2 before:left-1/2 before:-translate-x-1/2 before:content-[""] before:w-[104%] before:h-[104%] before:bg-transparent before:border-4 before:border-white before:rounded'}`,
                    style: {
                        backgroundColor: p
                    }
                }, c))
            }), i.jsx("button", {
                onClick: () => s(!1),
                className: "w-[22.375rem] h-[3.25rem] bg-gradient-to-r from-primary to-primary/15 border border-primary rounded text-white text-lg font-bold",
                children: "ALTERAR COR"
            })]
        })]
    })
}
const Rg = "" + new URL("../icons/x1/check.svg",import.meta.url).href;
function Lg() {
    const [e,t] = v.useState({});
    return B("hoverfy", t),
    e.visibled && i.jsxs("div", {
        className: "absolute left-1/2 -translate-x-1/2 bottom-[2.62rem] flex items-center gap-3",
        children: [i.jsx("div", {
            className: "text-white text-lg font-bold leading-none w-[4.125rem] h-[3.125rem] border-[.0625rem] border-primary bg-primary-gradient rounded-[0.3125rem] flex items-center justify-center",
            children: "E"
        }), i.jsxs("div", {
            children: [i.jsx("small", {
                className: "text-white/65 text-base font-bold",
                children: "Aperte para"
            }), i.jsx("p", {
                className: "text-white text-lg font-bold",
                children: "Acessar o PVP"
            })]
        })]
    })
}
const zg = "" + new URL("../icons/x1/gun.svg",import.meta.url).href
  , Tg = "" + new URL("../icons/x1/round.svg",import.meta.url).href
  , Og = "" + new URL("../images/x1/makapoints.png",import.meta.url).href;
function Fg() {
    const [e,t] = v.useState({});
    return B("request", n => {
        t(n),
        setTimeout( () => F("REQUEST_REFUSED", null, !0).then( () => t(r => ({
            ...r,
            visibled: !1
        }))), 10 * 1e3)
    }
    ),
    B("requestAccept", () => {
        F("REQUEST_ACCEPT", null, !0).then( () => t(n => ({
            ...n,
            visibled: !1
        })))
    }
    ),
    B("requestRefused", () => {
        F("REQUEST_REFUSED", null, !0).then( () => t(n => ({
            ...n,
            visibled: !1
        })))
    }
    ),
    v.useEffect( () => {
        const n = ({key: r}) => {
            r === "y" ? F("REQUEST_ACCEPT", null, !0).then( () => t(l => ({
                ...l,
                visibled: !1
            }))) : r === "u" && F("REQUEST_REFUSED", null, !0).then( () => t(l => ({
                ...l,
                visibled: !1
            })))
        }
        ;
        return window.addEventListener("keydown", n),
        () => window.removeEventListener("keydown", n)
    }
    ),
    e.visibled && i.jsxs("div", {
        className: "flex flex-col gap-4 items-center absolute top-1/2 -translate-y-1/2 left-8 ",
        children: [i.jsxs("div", {
            className: "w-[17rem] h-[15.75rem] px-5 pt-[2.44rem] flex flex-col items-center rounded-[0.3125rem]",
            style: {
                background: "linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
            },
            children: [i.jsx("div", {
                className: "absolute top-[-1rem] text-white text-[1.89619rem] font-days font-normal rounded-[0.3125rem] rotate-[-3.017deg] w-[9.5625rem] h-[2.8125rem] bg-primary-gradient border-[.0625rem] border-primary flex items-center justify-center ",
                children: "X1"
            }), i.jsx("h3", {
                className: "text-white text-[1.125rem] font-normal",
                children: e.name
            }), i.jsx("p", {
                className: "text-white/65 text-sm font-medium",
                children: "Te desafiou para um X1"
            }), i.jsxs("div", {
                className: "flex flex-col gap-[.63rem] w-full mt-[.88rem]",
                children: [i.jsxs("div", {
                    className: "w-full h-[2.375rem] rounded border-[.0625rem] border-white/[.06] flex items-center justify-center gap-2",
                    children: [i.jsx("img", {
                        src: zg,
                        className: "w-[1.125rem]"
                    }), i.jsx("p", {
                        className: "text-white text-sm font-medium",
                        children: e.weapon
                    })]
                }), i.jsxs("div", {
                    className: "w-full h-[2.375rem] rounded border-[.0625rem] border-white/[.06] flex items-center justify-center gap-2",
                    children: [i.jsx("img", {
                        src: Tg,
                        className: "w-[1.125rem]"
                    }), i.jsx("p", {
                        className: "text-white text-sm font-medium",
                        children: e.rounds
                    })]
                }), i.jsxs("div", {
                    className: "w-full h-[2.375rem] rounded border-[.0625rem] border-white/[.06] flex items-center justify-center gap-2",
                    children: [e.bet.makapoints && i.jsx("img", {
                        src: Og,
                        className: "w-[1.125rem]"
                    }), i.jsxs("p", {
                        className: "text-white text-sm font-medium",
                        children: [e.bet.value, i.jsx("b", {
                            className: "text-white/55 font-medium",
                            children: e.bet.makapoints ? " Makapoints" : " Dinheiro"
                        })]
                    })]
                })]
            })]
        }), i.jsxs("div", {
            className: "flex items-center gap-6",
            children: [i.jsxs("div", {
                className: "flex items-center gap-2",
                children: [i.jsx("div", {
                    style: {
                        background: "linear-gradient(135deg, #62DD67 0%, rgba(98, 221, 103, 0.15) 100%), linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
                    },
                    className: "w-[2.375rem] h-[2.3125rem] rounded-[0.3125rem] flex items-center justify-center text-white text-[1.0625rem] font-bold border-[.0875rem] border-[#62DD67]",
                    children: "Y"
                }), i.jsx("p", {
                    className: "text-white text-sm font-bold",
                    children: "Aceitar"
                })]
            }), i.jsxs("div", {
                className: "flex items-center gap-2",
                children: [i.jsx("div", {
                    style: {
                        background: "linear-gradient(135deg, #DD6262 0%, rgba(221, 98, 98, 0.15) 100%), linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
                    },
                    className: "w-[2.375rem] h-[2.3125rem] rounded-[0.3125rem] flex items-center justify-center text-white text-[1.0625rem] font-bold border-[.0875rem] border-[#DD6262]",
                    children: "U"
                }), i.jsx("p", {
                    className: "text-white text-sm font-bold",
                    children: "Negar"
                })]
            })]
        })]
    })
}
const Bd = v.createContext(null)
  , Dg = ({children: e}) => {
    const t = tn();
    ql();
    const [n,r] = v.useState(Li());
    return B("open", r),
    B("open:home", () => {
        t({
            pathname: "/"
        }),
        r(!0)
    }
    ),
    B("open:profile", () => {
        t({
            pathname: "/profile"
        }),
        r(!0)
    }
    ),
    B("open:room", l => {
        t({
            pathname: `/room/${l}`
        }),
        r(!0)
    }
    ),
    B("open:ranking", () => {
        t({
            pathname: "/ranking"
        }),
        r(!0)
    }
    ),
    B("open:register", () => {
        t({
            pathname: "/register"
        }),
        r(!0)
    }
    ),
    B("open:squad", () => {
        t({
            pathname: "/squad"
        }),
        r(!0)
    }
    ),
    B("open:notSquad", () => {
        t({
            pathname: "/notSquad"
        }),
        r(!0)
    }
    ),
    B("open:registerSquad", () => {
        t({
            pathname: "/registerSquad"
        }),
        r(!0)
    }
    ),
    B("open:hud", l => {
        t({
            pathname: `/hud/${l}`
        }),
        r(!0)
    }
    ),
    v.useEffect( () => {
        if (!n)
            return;
        const l = s => {
            s.key === "Escape" && (Li() ? r(!n) : F("CLOSE"))
        }
        ;
        return window.addEventListener("keydown", l),
        () => window.removeEventListener("keydown", l)
    }
    , [n]),
    i.jsxs(Bd.Provider, {
        value: {
            opened: n,
            setOpened: r
        },
        children: [i.jsx(Fg, {}), i.jsx(Lg, {}), n && e]
    })
}
  , Ig = () => v.useContext(Bd);
function Ag() {
    const [e,t] = v.useState(0)
      , [n,r] = v.useState(0)
      , [l,s] = v.useState(1)
      , [o,a] = v.useState(!1)
      , [u,d] = v.useState([])
      , [p,c] = v.useState("rifle")
      , [m,x] = v.useState("")
      , {setOpened: y} = Ig()
      , w = () => {
        !n || !l || F("X1_INVITE", {
            bet: e,
            user: n,
            rounds: l,
            makapoints: o,
            weapon: m
        }, !0).then( () => y(!1))
    }
    ;
    return v.useEffect( () => {
        F("GET_OPTIONS", {
            category: p
        }, ["test"]).then(j => {
            d(j),
            x(j[0])
        }
        )
    }
    , [p]),
    i.jsx("div", {
        className: "w-screen h-screen bg-back bg-center bg-cover flex items-center justify-center",
        children: i.jsxs("div", {
            children: [i.jsxs("div", {
                className: "flex flex-col items-center mb-8",
                children: [i.jsx("p", {
                    className: "text-primary text-[2rem] font-normal font-fugaz",
                    children: "DESAFIAR"
                }), i.jsx("h2", {
                    className: "text-white text-[4rem] font-normal font-days leading-[35%]",
                    children: "X1"
                })]
            }), i.jsxs("div", {
                className: "flex flex-col gap-6",
                children: [i.jsxs("fieldset", {
                    className: "flex flex-col items-center gap-3",
                    children: [i.jsx("label", {
                        className: "text-white/45 text-sm font-medium",
                        children: "Id do desafiado"
                    }), i.jsx("input", {
                        type: "text",
                        value: n || "",
                        placeholder: "Id",
                        onChange: j => r(Math.max(Number(j.target.value), 0)),
                        className: "w-[25rem] h-12 bg-transparent rounded border-[.0625rem] border-white/15 text-center text-white text-sm font-medium outline-none placeholder:text-white"
                    })]
                }), i.jsxs("fieldset", {
                    className: "flex flex-col items-center gap-3",
                    children: [i.jsx("label", {
                        className: "text-white/45 text-sm font-medium",
                        children: "Quantidade de rounds"
                    }), i.jsx("input", {
                        type: "number",
                        value: l,
                        placeholder: "16",
                        onChange: j => s(Math.min(Number(j.target.value), 16)),
                        className: "w-[25rem] h-12 bg-transparent rounded border-[.0625rem] border-white/15 text-center text-white text-sm font-medium outline-none placeholder:text-white"
                    })]
                }), i.jsxs("div", {
                    className: "flex flex-col items-center gap-3",
                    children: [i.jsxs("div", {
                        className: "flex flex-col items-center gap-3",
                        children: [i.jsx("p", {
                            className: "text-white/45 text-sm font-medium",
                            children: "Arma selecionada"
                        }), i.jsxs("div", {
                            className: "flex items-center gap-[.62rem]",
                            children: [i.jsx("button", {
                                onClick: () => c("rifle"),
                                className: `${p === "rifle" && "bg-primary-gradient !border-primary"} w-[5.78125rem] h-[3rem] bg-transparent border-[.0625rem] border-white/[.08] rounded text-white text-sm font-medium`,
                                children: "Rifle"
                            }), i.jsx("button", {
                                onClick: () => c("pistol"),
                                className: `${p === "pistol" && "bg-primary-gradient !border-primary"} w-[5.78125rem] h-[3rem] bg-transparent border-[.0625rem] border-white/[.08] rounded text-white text-sm font-medium`,
                                children: "Pistola"
                            }), i.jsx("button", {
                                onClick: () => c("sub"),
                                className: `${p === "sub" && "bg-primary-gradient !border-primary"} w-[5.78125rem] h-[3rem] bg-transparent border-[.0625rem] border-white/[.08] rounded text-white text-sm font-medium`,
                                children: "Sub"
                            }), i.jsx("button", {
                                onClick: () => c("shotgun"),
                                className: `${p === "shotgun" && "bg-primary-gradient !border-primary"} w-[5.78125rem] h-[3rem] bg-transparent border-[.0625rem] border-white/[.08] rounded text-white text-sm font-medium`,
                                children: "Doze"
                            })]
                        })]
                    }), i.jsx("select", {
                        onChange: j => x(j.target.value),
                        className: "bg-transparent border border-white/[.08] w-full h-12 text-white text-center text-sm font-normal rounded outline-none",
                        children: u.map( (j, h) => i.jsx("option", {
                            value: j,
                            className: "bg-black/80 border-none",
                            children: j
                        }, h))
                    })]
                }), i.jsxs("fieldset", {
                    className: "flex flex-col items-center gap-3",
                    children: [i.jsx("label", {
                        className: "text-white/45 text-sm font-medium",
                        children: "Preço da aposta"
                    }), i.jsx("input", {
                        type: "number",
                        value: e,
                        placeholder: "R$ 0",
                        onChange: j => t(Number(j.target.value)),
                        className: "w-[25rem] h-12 bg-transparent rounded border-[.0625rem] border-white/15 text-center text-white text-sm font-medium outline-none placeholder:text-white"
                    })]
                }), i.jsxs("div", {
                    className: "flex items-center justify-center gap-3",
                    children: [i.jsx("div", {
                        onClick: () => a(!o),
                        className: `w-7 h-7 rounded border-[.0625rem] border-white/[.08] cursor-pointer flex items-center justify-center ${o ? "bg-primary" : "bg-transparent"}`,
                        children: o && i.jsx("img", {
                            src: Rg,
                            className: "w-1/2"
                        })
                    }), i.jsxs("p", {
                        className: "text-white/45 text-sm font-medium",
                        children: ["Aposta em ", i.jsx("b", {
                            className: "text-white font-medium",
                            children: "Makapoints"
                        })]
                    })]
                }), i.jsx("button", {
                    onClick: w,
                    className: "w-[25rem] h-[3rem] border-primary border-[.0625rem] bg-primary-gradient text-white text-lg font-bold",
                    children: "DESAFIAR"
                })]
            })]
        })
    })
}
function Ug() {
    const [e,t] = v.useState([]);
    return B("NEW_KILL", n => {
        n.createdAt = Date.now(),
        t(r => [n, ...r])
    }
    ),
    v.useEffect( () => {
        const n = setInterval( () => {
            t(r => {
                const l = Date.now();
                return r.filter( ({createdAt: s}) => s + 3e3 > l)
            }
            )
        }
        , 1e3);
        return () => clearInterval(n)
    }
    , [e]),
    i.jsx("div", {
        className: "flex flex-col gap-2 items-end absolute right-8 top-8",
        children: e.map( (n, r) => i.jsxs("div", {
            className: "px-6 flex items-center gap-2 h-[2.3125rem] rounded-[0.3125rem]",
            style: {
                background: "linear-gradient(107deg, rgba(20, 20, 20, 0.90) 0%, rgba(0, 0, 0, 0.90) 100%)"
            },
            children: [i.jsx("p", {
                className: "text-sm font-bold text-red-500",
                children: n.killer
            }), i.jsx("img", {
                src: n.image,
                className: "h-1/2"
            }), i.jsx("p", {
                className: "text-sm font-bold text-cyan-500",
                children: n.victim
            })]
        }, r))
    })
}
const Fi = "" + new URL("../icons/hud/skull.svg",import.meta.url).href;
function Mg() {
    const {type: e} = Cr()
      , t = ql()
      , [n,r] = v.useState(0)
      , [l,s] = v.useState(0)
      , [o,a] = v.useState([])
      , [u,d] = v.useState({});
    B("UPDATE_TIME", r),
    B("UPDATE_KILLS", s),
    B("UPDATE_PLAYERS", a),
    B("UPDATE_POINTS", d);
    function p(c) {
        const m = Math.floor(c / 60)
          , x = c % 60;
        return `${m}:${x < 10 ? "0" : ""}${x}`
    }
    return v.useEffect( () => {
        const c = setInterval( () => {
            r(m => m > 0 ? m - 1 : 0)
        }
        , 1e3);
        return () => clearInterval(c)
    }
    , []),
    e === "teams" ? i.jsxs("div", {
        className: "flex items-center gap-3 absolute left-1/2 -translate-x-1/2 top-8  h-[3.25rem]",
        children: [i.jsx("div", {
            className: "h-full flex items-center gap-2",
            children: o.filter(c => c.team === "ct").map( (c, m) => i.jsx("div", {
                className: Ae("h-full w-[3.25rem] rounded bg-cover bg-center bg-no-repeat", c.alive ? "opacity-100" : "opacity-50"),
                style: {
                    backgroundImage: `url(${c.icon || "/images/five.png"})`
                }
            }, m))
        }), i.jsxs("div", {
            className: "flex items-center gap-3 h-full",
            children: [i.jsx("div", {
                className: "w-[2.6875rem] h-full rounded-[0.3125rem] grid place-items-center text-white text-base font-bold",
                style: {
                    background: "linear-gradient(107deg, rgba(255, 131, 131, 0.97) 0%, rgba(255, 79, 79, 0.50) 100%)"
                },
                children: u.ct
            }), i.jsx("div", {
                className: "w-[4.5625rem] h-full rounded-[0.3125rem] grid place-items-center text-white text-base font-bold",
                style: {
                    background: "linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
                },
                children: p(n)
            }), i.jsx("div", {
                className: "w-[2.6875rem] h-full rounded-[0.3125rem] grid place-items-center text-white text-base font-bold",
                style: {
                    background: "linear-gradient(107deg, rgba(95, 197, 255, 0.97) 0%, rgba(21, 78, 111, 0.97) 100%)"
                },
                children: u.tr
            })]
        }), i.jsx("div", {
            className: "h-full flex items-center gap-2",
            children: o.filter(c => c.team === "tr").map( (c, m) => i.jsx("div", {
                className: Ae("h-full w-[3.25rem] rounded bg-cover bg-center bg-no-repeat", c.alive ? "opacity-100" : "opacity-50"),
                style: {
                    backgroundImage: `url(${c.icon || "/images/five.png"})`
                }
            }, m))
        })]
    }) : i.jsxs("div", {
        className: "flex flex-col items-center justify-center gap-1 absolute left-1/2 -translate-x-1/2 top-8",
        children: [i.jsxs("div", {
            className: "flex items-center gap-3",
            children: [i.jsx("div", {
                className: "flex items-center gap-2",
                children: o.slice(0, Math.ceil(o.length / 2)).map( (c, m) => i.jsx("div", {
                    className: `${c.alive ? "opacity-100" : "opacity-50"} w-[3.25rem] h-[3.25rem] rounded bg-center bg-cover bg-no-repeat`,
                    style: {
                        backgroundImage: `url(${c.icon || "/images/five.png"})`
                    }
                }, m))
            }), i.jsxs("div", {
                className: "flex flex-col items-center justify-center w-[5.6875rem] h-[3.25rem] rounded-[.3125rem]",
                style: {
                    background: "linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
                },
                children: [t.pathname !== "/hud/ffa" && i.jsx("p", {
                    className: "text-white text-base font-bold",
                    children: p(n)
                }), i.jsxs("p", {
                    className: "flex items-center gap-[.38rem] text-white text-xs font-bold",
                    children: [i.jsx("img", {
                        src: Fi,
                        className: "w-4"
                    }), l, " ", i.jsx("b", {
                        className: "text-white/65",
                        children: "Kills"
                    })]
                })]
            }), i.jsx("div", {
                className: "flex items-center gap-2",
                children: o.slice(Math.ceil(o.length / 2)).map( (c, m) => i.jsx("div", {
                    className: `${c.alive ? "opacity-100" : "opacity-50"} w-[3.25rem] h-[3.25rem] rounded bg-center bg-cover bg-no-repeat`,
                    style: {
                        backgroundImage: `url(${c.icon || "/images/five.png"})`
                    }
                }, m))
            })]
        }), i.jsx("img", {
            src: ss,
            className: "w-[3.01338rem]"
        })]
    })
}
const $g = "" + new URL("../icons/hud/ping.svg",import.meta.url).href;
function Bg() {
    var r, l, s;
    const {type: e} = Cr()
      , [t,n] = v.useState({});
    return B("UPDATE_SCOREBOARD", n),
    e === "teams" && t.visibled ? i.jsxs("div", {
        className: "w-[55.75rem] absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 flex flex-col gap-6",
        children: [i.jsxs("div", {
            className: "w-full flex flex-col gap-4",
            children: [i.jsx("div", {
                className: "w-full h-14 rounded-lg border-[.0625rem] border-[#5FC5FF] flex items-center justify-center text-white font-days text-xl font-normal",
                style: {
                    background: "linear-gradient(90deg, #5FC5FF 0%, rgba(95, 197, 255, 0.15) 100%), linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
                },
                children: "CONTRA-TERRORISTAS"
            }), i.jsxs("div", {
                className: "rounded-[0.625rem] flex flex-col gap-4 w-full p-4 bg-default-gradient",
                style: {
                    background: "linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
                },
                children: [i.jsxs("div", {
                    className: "flex items-center ",
                    children: [i.jsx("p", {
                        className: "text-white/55 text-sm font-medium w-1/4",
                        children: "Jogador"
                    }), i.jsx("p", {
                        className: "text-white/55 text-sm font-medium w-1/4 text-center",
                        children: "Kills"
                    }), i.jsx("p", {
                        className: "text-white/55 text-sm font-medium w-1/4 text-center",
                        children: "Mortes"
                    }), i.jsx("p", {
                        className: "text-white/55 text-sm font-medium w-1/4 text-center",
                        children: "Ping"
                    })]
                }), i.jsx("div", {
                    className: "flex flex-col gap-2",
                    children: (r = t.players) == null ? void 0 : r.filter(o => o.team === "ct").map( (o, a) => i.jsxs("div", {
                        className: "h-12 w-full border-[.0625rem] border-white/[.12] rounded-md flex justify-between px-2 items-center",
                        children: [i.jsxs("div", {
                            className: "w-1/4 flex items-center gap-2",
                            children: [i.jsx("img", {
                                src: o.elo === "bronze" ? tt : o.elo === "gold" ? et : nt,
                                alt: o.elo,
                                className: "size-8"
                            }), i.jsx("p", {
                                className: "text-white text-sm font-bold",
                                children: o.name
                            })]
                        }), i.jsx("p", {
                            className: "w-1/4 text-white text-sm font-bold text-center",
                            children: o.kills
                        }), i.jsx("p", {
                            className: "w-1/4 text-white text-sm font-bold text-center",
                            children: o.deaths
                        }), i.jsxs("p", {
                            className: "w-1/4 text-white text-sm font-bold text-center",
                            children: [o.ping, " ms"]
                        })]
                    }, a))
                })]
            })]
        }), i.jsxs("div", {
            className: "w-full flex flex-col gap-4",
            children: [i.jsx("div", {
                className: "w-full h-14 rounded-lg border-[.0625rem] border-[#FF8383] flex items-center justify-center text-white font-days text-xl font-normal",
                style: {
                    background: "linear-gradient(90deg, #FF8383 0%, rgba(255, 131, 131, 0.15) 100%), linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
                },
                children: "TERRORISTAS"
            }), i.jsxs("div", {
                className: "rounded-[0.625rem] flex flex-col gap-4 w-full p-4 bg-default-gradient",
                style: {
                    background: "linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
                },
                children: [i.jsxs("div", {
                    className: "flex items-center ",
                    children: [i.jsx("p", {
                        className: "text-white/55 text-sm font-medium w-1/4",
                        children: "Jogador"
                    }), i.jsx("p", {
                        className: "text-white/55 text-sm font-medium w-1/4 text-center",
                        children: "Kills"
                    }), i.jsx("p", {
                        className: "text-white/55 text-sm font-medium w-1/4 text-center",
                        children: "Mortes"
                    }), i.jsx("p", {
                        className: "text-white/55 text-sm font-medium w-1/4 text-center",
                        children: "Ping"
                    })]
                }), i.jsx("div", {
                    className: "flex flex-col gap-2",
                    children: (l = t.players) == null ? void 0 : l.filter(o => o.team === "tr").map( (o, a) => i.jsxs("div", {
                        className: "h-12 w-full border-[.0625rem] border-white/[.12] rounded-md flex justify-between px-2 items-center",
                        children: [i.jsxs("div", {
                            className: "w-1/4 flex items-center gap-2",
                            children: [i.jsx("img", {
                                src: o.elo === "bronze" ? tt : o.elo === "gold" ? et : nt,
                                alt: o.elo,
                                className: "size-8"
                            }), i.jsx("p", {
                                className: "text-white text-sm font-bold",
                                children: o.name
                            })]
                        }), i.jsx("p", {
                            className: "w-1/4 text-white text-sm font-bold text-center",
                            children: o.kills
                        }), i.jsx("p", {
                            className: "w-1/4 text-white text-sm font-bold text-center",
                            children: o.deaths
                        }), i.jsxs("p", {
                            className: "w-1/4 text-white text-sm font-bold text-center",
                            children: [o.ping, " ms"]
                        })]
                    }, a))
                })]
            })]
        })]
    }) : t.visibled && i.jsxs("div", {
        className: "flex flex-col gap-4 absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2",
        children: [i.jsx("div", {
            className: "w-[55.75rem] h-[3.5rem] rounded-lg border-[.0625rem] border-primary text-white text-xl font-normal font-days flex items-center justify-center",
            style: {
                background: "linear-gradient(90deg, #9747FF 0%, rgba(151, 71, 255, 0.15) 100%), linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
            },
            children: "SCOREBOARD"
        }), i.jsxs("div", {
            className: "w-[55.75rem] p-4 rounded-[.625rem]",
            style: {
                background: "linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
            },
            children: [i.jsxs("div", {
                className: "flex items-center ",
                children: [i.jsx("p", {
                    className: "w-[25%] text-white/55 text-sm font-medium",
                    children: "Jogador"
                }), i.jsxs("div", {
                    className: "w-[25%] flex items-center justify-center gap-2",
                    children: [i.jsx("img", {
                        src: Fi,
                        className: "size-4 opacity-25"
                    }), i.jsx("p", {
                        className: "text-white/55 text-sm font-medium",
                        children: "Kills"
                    })]
                }), i.jsxs("div", {
                    className: "w-[25%] flex items-center justify-center gap-2",
                    children: [i.jsx("img", {
                        src: Fi,
                        className: "size-4 opacity-25"
                    }), i.jsx("p", {
                        className: "text-white/55 text-sm font-medium",
                        children: e === "gungame" ? "Arma atual" : "Mortes"
                    })]
                }), i.jsxs("div", {
                    className: "w-[25%] flex items-center justify-center gap-2",
                    children: [i.jsx("img", {
                        src: $g,
                        className: "size-4"
                    }), i.jsx("p", {
                        className: "text-white/55 text-sm font-medium",
                        children: "Ping"
                    })]
                })]
            }), i.jsx("div", {
                className: "w-full flex flex-col gap-[.62rem] mt-3",
                children: (s = t.players) == null ? void 0 : s.map( (o, a) => i.jsxs("div", {
                    className: "flex items-center h-[3rem] rounded-md border-[.0625rem] border-white/[.12]",
                    children: [i.jsxs("div", {
                        className: "w-[25%] pl-2 flex items-center gap-2",
                        children: [o.elo && i.jsx("img", {
                            src: o.elo === "bronze" ? tt : o.elo === "gold" ? et : nt,
                            className: "size-8"
                        }), i.jsx("p", {
                            className: " text-white text-sm font-medium",
                            children: o.name
                        })]
                    }), i.jsx("p", {
                        className: "w-[25%] text-white text-sm font-medium text-center",
                        children: o.kills
                    }), i.jsx("div", {
                        className: "w-[25%] flex items-center justify-center",
                        children: e === "gungame" ? i.jsx("img", {
                            src: o.weapon,
                            className: "h-7"
                        }) : i.jsx("p", {
                            className: "text-white text-sm font-medium text-center",
                            children: o.deaths
                        })
                    }), i.jsx("p", {
                        className: "w-[25%] text-white text-sm font-medium text-center",
                        children: o.ping
                    })]
                }, a))
            })]
        })]
    })
}
const Vg = "" + new URL("../icons/hud/heart.svg",import.meta.url).href
  , Wg = "" + new URL("../icons/hud/shield.svg",import.meta.url).href;
function Hg() {
    const [e,t] = v.useState({});
    return B("UPDATE_STATS", t),
    i.jsxs("div", {
        className: "flex items-center gap-1",
        children: [i.jsxs("div", {
            className: "flex flex-col gap-[.28rem]",
            children: [i.jsx("div", {
                className: "w-[13.75rem] h-[1.125rem] p-[.125rem] rounded-[.0625rem] bg-black",
                children: i.jsx("div", {
                    className: "h-full border-[.0625rem] border-primary rounded-[.0625rem] duration-200",
                    style: {
                        background: "linear-gradient(270deg, #8D42F5 0%, #6F24D8 100%)",
                        width: `${e.health}%`
                    }
                })
            }), i.jsxs("div", {
                className: "flex items-center gap-[.31rem]",
                children: [i.jsx("img", {
                    src: Wg,
                    className: "w-3"
                }), i.jsx("div", {
                    className: "w-[12.6875rem] h-[0.81275rem] p-[.125rem] rounded-[.0625rem]  bg-black",
                    children: i.jsx("div", {
                        className: "h-full bg-white duration-200",
                        style: {
                            width: `${e.armour}%`
                        }
                    })
                })]
            })]
        }), i.jsx("div", {
            className: "w-[2.25rem] h-[2.25rem] rounded-sm border-[.0625rem] border-primary flex items-center justify-center",
            style: {
                background: "linear-gradient(270deg, #8D42F5 0%, #6F24D8 100%)"
            },
            children: i.jsx("img", {
                src: Vg,
                className: "w-[1.0625rem]"
            })
        })]
    })
}
const Qg = "" + new URL("../icons/hud/bullets.svg",import.meta.url).href;
function Kg() {
    const [e,t] = v.useState({});
    return B("UPDATE_WEAPON", t),
    e.visibled && i.jsxs("div", {
        className: "w-[13.125rem] h-10 flex items-center gap-4 justify-end px-[.625rem] rounded-sm",
        style: {
            background: "linear-gradient(102deg, rgba(20, 20, 20, 0.00) 8.47%, rgba(0, 0, 0, 0.85) 91.53%)"
        },
        children: [i.jsxs("div", {
            className: "flex items-center gap-[.12rem]",
            children: [i.jsxs("p", {
                className: "text-white text-[1.375rem] font-normal",
                children: [e.munition.current, "/", i.jsx("b", {
                    className: "text-white/60 text-[0.75rem] font-medium",
                    children: e.munition.clip
                })]
            }), i.jsx("img", {
                src: Qg,
                className: "size-[0.875rem]"
            })]
        }), i.jsx("img", {
            src: e.image,
            className: "h-[1.25rem]"
        })]
    })
}
function Gg() {
    const [e,t] = v.useState({});
    return B("UPDATE_WEAPONS", t),
    e.visibled && i.jsxs("div", {
        className: "flex flex-col gap-[.69rem] items-center absolute right-[1.69rem] top-1/2 -translate-y-1/2",
        children: [i.jsxs("div", {
            className: "flex flex-col items-center gap-[.69rem]",
            children: [(e == null ? void 0 : e.list[4]) && i.jsx("img", {
                className: "w-fit h-[2.3125rem] opacity-50",
                src: e == null ? void 0 : e.list[4]
            }), (e == null ? void 0 : e.list[4]) && i.jsx("img", {
                className: "w-fit h-[2.3125rem] opacity-50",
                src: e == null ? void 0 : e.list[3]
            }), (e == null ? void 0 : e.list[2]) && i.jsx("img", {
                className: "w-fit h-[2.3125rem] opacity-50",
                src: e == null ? void 0 : e.list[2]
            }), (e == null ? void 0 : e.list[1]) && i.jsx("img", {
                className: "w-fit h-[2.3125rem] opacity-50",
                src: e == null ? void 0 : e.list[1]
            })]
        }), i.jsx("div", {
            children: i.jsx("img", {
                className: "h-[3.4375rem]",
                src: e == null ? void 0 : e.list[0]
            })
        })]
    })
}
const Xg = "" + new URL("../images/profile/1.png",import.meta.url).href
  , Yg = "" + new URL("../images/profile/2.png",import.meta.url).href;
function Jg() {
    const [e,t] = v.useState({
        timer: 0,
        player1: {
            icon: "",
            points: 0
        },
        player2: {
            icon: "",
            points: 0
        }
    })
      , n = r => {
        const l = Math.floor(r / 60)
          , s = r % 60;
        return `${l}:${s < 10 ? "0" : ""}${s}`
    }
    ;
    return B("updateScore", t),
    B("updatePlayer1", r => t(l => ({
        ...l,
        player1: {
            ...l.player1,
            points: r
        }
    }))),
    B("updatePlayer2", r => t(l => ({
        ...l,
        player2: {
            ...l.player2,
            points: r
        }
    }))),
    v.useEffect( () => {
        const r = setInterval( () => {
            t(l => ({
                ...l,
                timer: l.timer > 0 ? l.timer - 1 : 0
            }))
        }
        , 1e3);
        return () => clearInterval(r)
    }
    , []),
    i.jsxs("div", {
        className: "flex flex-col items-center gap-[.44rem] absolute left-1/2 -translate-x-1/2 top-8",
        children: [i.jsxs("div", {
            className: "flex items-center gap-3",
            children: [i.jsxs("div", {
                className: "flex items-center gap-3",
                children: [i.jsx("div", {
                    className: "size-[3.25rem] rounded bg-center bg-cover bg-no-repeat",
                    style: {
                        backgroundImage: `url(${e.player1.icon ? e.player1.icon : Xg})`
                    }
                }), i.jsx("div", {
                    className: "size-[3.25rem] flex items-center justify-center text-white text-base font-bold rounded-[0.3125rem]",
                    style: {
                        background: "linear-gradient(107deg, rgba(255, 131, 131, 0.97) 0%, rgba(255, 79, 79, 0.50) 100%)"
                    },
                    children: e.player1.points ?? 0
                })]
            }), i.jsx("div", {
                className: "text-white text-base font-bold h-[3.25rem] flex items-center justify-center w-[5rem] rounded-[0.3125rem]",
                style: {
                    background: "linear-gradient(107deg, rgba(20, 20, 20, 0.97) 0%, rgba(0, 0, 0, 0.97) 100%)"
                },
                children: n(e.timer)
            }), i.jsxs("div", {
                className: "flex items-center gap-3",
                children: [i.jsx("div", {
                    className: "size-[3.25rem] flex items-center justify-center text-white text-base font-bold rounded-[0.3125rem]",
                    style: {
                        background: "linear-gradient(107deg, rgba(95, 197, 255, 0.97) 0%, rgba(21, 78, 111, 0.97) 100%)"
                    },
                    children: e.player2.points ?? 0
                }), i.jsx("div", {
                    className: "size-[3.25rem] rounded bg-center bg-cover bg-no-repeat",
                    style: {
                        backgroundImage: `url(${e.player1.icon ? e.player1.icon : Yg})`
                    }
                })]
            })]
        }), i.jsx("img", {
            src: ss,
            className: "w-[3.01338rem] h-[2.8125rem]"
        })]
    })
}
function Zg() {
    const {type: e} = Cr();
    return i.jsxs("div", {
        children: [e === "x1" ? i.jsx(Jg, {}) : i.jsx(Mg, {}), i.jsx(Ug, {}), i.jsx(Bg, {}), i.jsx(Gg, {}), i.jsxs("div", {
            className: "absolute bottom-8 right-8 flex flex-col items-end gap-4",
            children: [i.jsx(Kg, {}), i.jsx(Hg, {})]
        })]
    })
}
function qg() {
    return i.jsxs(ih, {
        children: [i.jsx(Pe, {
            element: i.jsx(Zg, {}),
            path: "/hud/:type"
        }), i.jsx(Pe, {
            element: i.jsx(yg, {}),
            path: "*"
        }), i.jsx(Pe, {
            element: i.jsx(Yh, {}),
            path: "/room/:type"
        }), i.jsx(Pe, {
            element: i.jsx(Gh, {}),
            path: "/squad"
        }), i.jsx(Pe, {
            element: i.jsx(Cg, {}),
            path: "/ranking"
        }), i.jsx(Pe, {
            element: i.jsx(bg, {}),
            path: "/profile"
        }), i.jsx(Pe, {
            element: i.jsx(Pg, {}),
            path: "/register"
        }), i.jsx(Pe, {
            element: i.jsx(yh, {}),
            path: "/notSquad"
        }), i.jsx(Pe, {
            element: i.jsx(vh, {}),
            path: "/registerSquad"
        }), i.jsx(Pe, {
            element: i.jsx(ug, {}),
            path: "/rooms/:type"
        }), i.jsx(Pe, {
            element: i.jsx(Ag, {}),
            path: "/x1"
        })]
    })
}
Ds.createRoot(document.getElementById("root")).render(i.jsx(Je.StrictMode, {
    children: i.jsx(uh, {
        children: i.jsx(Dg, {
            children: i.jsx(qg, {})
        })
    })
}));
