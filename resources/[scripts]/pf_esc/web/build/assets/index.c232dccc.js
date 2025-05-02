(function() {
    const t = document.createElement("link").relList;
    if (t && t.supports && t.supports("modulepreload"))
        return;
    for (const i of document.querySelectorAll('link[rel="modulepreload"]'))
        r(i);
    new MutationObserver(i => {
        for (const o of i)
            if (o.type === "childList")
                for (const s of o.addedNodes)
                    s.tagName === "LINK" && s.rel === "modulepreload" && r(s)
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
function Am(e) {
    return e && e.__esModule && Object.prototype.hasOwnProperty.call(e, "default") ? e.default : e
}
var w = {
    exports: {}
}
  , I = {};
/**
 * @license React
 * react.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var ai = Symbol.for("react.element")
  , Nm = Symbol.for("react.portal")
  , Dm = Symbol.for("react.fragment")
  , Mm = Symbol.for("react.strict_mode")
  , Vm = Symbol.for("react.profiler")
  , Om = Symbol.for("react.provider")
  , Fm = Symbol.for("react.context")
  , Im = Symbol.for("react.forward_ref")
  , _m = Symbol.for("react.suspense")
  , Bm = Symbol.for("react.memo")
  , zm = Symbol.for("react.lazy")
  , Yu = Symbol.iterator;
function jm(e) {
    return e === null || typeof e != "object" ? null : (e = Yu && e[Yu] || e["@@iterator"],
    typeof e == "function" ? e : null)
}
var kd = {
    isMounted: function() {
        return !1
    },
    enqueueForceUpdate: function() {},
    enqueueReplaceState: function() {},
    enqueueSetState: function() {}
}
  , Ed = Object.assign
  , Td = {};
function rr(e, t, n) {
    this.props = e,
    this.context = t,
    this.refs = Td,
    this.updater = n || kd
}
rr.prototype.isReactComponent = {};
rr.prototype.setState = function(e, t) {
    if (typeof e != "object" && typeof e != "function" && e != null)
        throw Error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.");
    this.updater.enqueueSetState(this, e, t, "setState")
}
;
rr.prototype.forceUpdate = function(e) {
    this.updater.enqueueForceUpdate(this, e, "forceUpdate")
}
;
function Rd() {}
Rd.prototype = rr.prototype;
function ma(e, t, n) {
    this.props = e,
    this.context = t,
    this.refs = Td,
    this.updater = n || kd
}
var ga = ma.prototype = new Rd;
ga.constructor = ma;
Ed(ga, rr.prototype);
ga.isPureReactComponent = !0;
var Gu = Array.isArray
  , Ld = Object.prototype.hasOwnProperty
  , va = {
    current: null
}
  , Ad = {
    key: !0,
    ref: !0,
    __self: !0,
    __source: !0
};
function Nd(e, t, n) {
    var r, i = {}, o = null, s = null;
    if (t != null)
        for (r in t.ref !== void 0 && (s = t.ref),
        t.key !== void 0 && (o = "" + t.key),
        t)
            Ld.call(t, r) && !Ad.hasOwnProperty(r) && (i[r] = t[r]);
    var l = arguments.length - 2;
    if (l === 1)
        i.children = n;
    else if (1 < l) {
        for (var a = Array(l), u = 0; u < l; u++)
            a[u] = arguments[u + 2];
        i.children = a
    }
    if (e && e.defaultProps)
        for (r in l = e.defaultProps,
        l)
            i[r] === void 0 && (i[r] = l[r]);
    return {
        $$typeof: ai,
        type: e,
        key: o,
        ref: s,
        props: i,
        _owner: va.current
    }
}
function Um(e, t) {
    return {
        $$typeof: ai,
        type: e.type,
        key: t,
        ref: e.ref,
        props: e.props,
        _owner: e._owner
    }
}
function ya(e) {
    return typeof e == "object" && e !== null && e.$$typeof === ai
}
function Hm(e) {
    var t = {
        "=": "=0",
        ":": "=2"
    };
    return "$" + e.replace(/[=:]/g, function(n) {
        return t[n]
    })
}
var Zu = /\/+/g;
function hs(e, t) {
    return typeof e == "object" && e !== null && e.key != null ? Hm("" + e.key) : t.toString(36)
}
function $i(e, t, n, r, i) {
    var o = typeof e;
    (o === "undefined" || o === "boolean") && (e = null);
    var s = !1;
    if (e === null)
        s = !0;
    else
        switch (o) {
        case "string":
        case "number":
            s = !0;
            break;
        case "object":
            switch (e.$$typeof) {
            case ai:
            case Nm:
                s = !0
            }
        }
    if (s)
        return s = e,
        i = i(s),
        e = r === "" ? "." + hs(s, 0) : r,
        Gu(i) ? (n = "",
        e != null && (n = e.replace(Zu, "$&/") + "/"),
        $i(i, t, n, "", function(u) {
            return u
        })) : i != null && (ya(i) && (i = Um(i, n + (!i.key || s && s.key === i.key ? "" : ("" + i.key).replace(Zu, "$&/") + "/") + e)),
        t.push(i)),
        1;
    if (s = 0,
    r = r === "" ? "." : r + ":",
    Gu(e))
        for (var l = 0; l < e.length; l++) {
            o = e[l];
            var a = r + hs(o, l);
            s += $i(o, t, n, a, i)
        }
    else if (a = jm(e),
    typeof a == "function")
        for (e = a.call(e),
        l = 0; !(o = e.next()).done; )
            o = o.value,
            a = r + hs(o, l++),
            s += $i(o, t, n, a, i);
    else if (o === "object")
        throw t = String(e),
        Error("Objects are not valid as a React child (found: " + (t === "[object Object]" ? "object with keys {" + Object.keys(e).join(", ") + "}" : t) + "). If you meant to render a collection of children, use an array instead.");
    return s
}
function Pi(e, t, n) {
    if (e == null)
        return e;
    var r = []
      , i = 0;
    return $i(e, r, "", "", function(o) {
        return t.call(n, o, i++)
    }),
    r
}
function $m(e) {
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
var Se = {
    current: null
}
  , Wi = {
    transition: null
}
  , Wm = {
    ReactCurrentDispatcher: Se,
    ReactCurrentBatchConfig: Wi,
    ReactCurrentOwner: va
};
I.Children = {
    map: Pi,
    forEach: function(e, t, n) {
        Pi(e, function() {
            t.apply(this, arguments)
        }, n)
    },
    count: function(e) {
        var t = 0;
        return Pi(e, function() {
            t++
        }),
        t
    },
    toArray: function(e) {
        return Pi(e, function(t) {
            return t
        }) || []
    },
    only: function(e) {
        if (!ya(e))
            throw Error("React.Children.only expected to receive a single React element child.");
        return e
    }
};
I.Component = rr;
I.Fragment = Dm;
I.Profiler = Vm;
I.PureComponent = ma;
I.StrictMode = Mm;
I.Suspense = _m;
I.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = Wm;
I.cloneElement = function(e, t, n) {
    if (e == null)
        throw Error("React.cloneElement(...): The argument must be a React element, but you passed " + e + ".");
    var r = Ed({}, e.props)
      , i = e.key
      , o = e.ref
      , s = e._owner;
    if (t != null) {
        if (t.ref !== void 0 && (o = t.ref,
        s = va.current),
        t.key !== void 0 && (i = "" + t.key),
        e.type && e.type.defaultProps)
            var l = e.type.defaultProps;
        for (a in t)
            Ld.call(t, a) && !Ad.hasOwnProperty(a) && (r[a] = t[a] === void 0 && l !== void 0 ? l[a] : t[a])
    }
    var a = arguments.length - 2;
    if (a === 1)
        r.children = n;
    else if (1 < a) {
        l = Array(a);
        for (var u = 0; u < a; u++)
            l[u] = arguments[u + 2];
        r.children = l
    }
    return {
        $$typeof: ai,
        type: e.type,
        key: i,
        ref: o,
        props: r,
        _owner: s
    }
}
;
I.createContext = function(e) {
    return e = {
        $$typeof: Fm,
        _currentValue: e,
        _currentValue2: e,
        _threadCount: 0,
        Provider: null,
        Consumer: null,
        _defaultValue: null,
        _globalName: null
    },
    e.Provider = {
        $$typeof: Om,
        _context: e
    },
    e.Consumer = e
}
;
I.createElement = Nd;
I.createFactory = function(e) {
    var t = Nd.bind(null, e);
    return t.type = e,
    t
}
;
I.createRef = function() {
    return {
        current: null
    }
}
;
I.forwardRef = function(e) {
    return {
        $$typeof: Im,
        render: e
    }
}
;
I.isValidElement = ya;
I.lazy = function(e) {
    return {
        $$typeof: zm,
        _payload: {
            _status: -1,
            _result: e
        },
        _init: $m
    }
}
;
I.memo = function(e, t) {
    return {
        $$typeof: Bm,
        type: e,
        compare: t === void 0 ? null : t
    }
}
;
I.startTransition = function(e) {
    var t = Wi.transition;
    Wi.transition = {};
    try {
        e()
    } finally {
        Wi.transition = t
    }
}
;
I.unstable_act = function() {
    throw Error("act(...) is not supported in production builds of React.")
}
;
I.useCallback = function(e, t) {
    return Se.current.useCallback(e, t)
}
;
I.useContext = function(e) {
    return Se.current.useContext(e)
}
;
I.useDebugValue = function() {}
;
I.useDeferredValue = function(e) {
    return Se.current.useDeferredValue(e)
}
;
I.useEffect = function(e, t) {
    return Se.current.useEffect(e, t)
}
;
I.useId = function() {
    return Se.current.useId()
}
;
I.useImperativeHandle = function(e, t, n) {
    return Se.current.useImperativeHandle(e, t, n)
}
;
I.useInsertionEffect = function(e, t) {
    return Se.current.useInsertionEffect(e, t)
}
;
I.useLayoutEffect = function(e, t) {
    return Se.current.useLayoutEffect(e, t)
}
;
I.useMemo = function(e, t) {
    return Se.current.useMemo(e, t)
}
;
I.useReducer = function(e, t, n) {
    return Se.current.useReducer(e, t, n)
}
;
I.useRef = function(e) {
    return Se.current.useRef(e)
}
;
I.useState = function(e) {
    return Se.current.useState(e)
}
;
I.useSyncExternalStore = function(e, t, n) {
    return Se.current.useSyncExternalStore(e, t, n)
}
;
I.useTransition = function() {
    return Se.current.useTransition()
}
;
I.version = "18.2.0";
(function(e) {
    e.exports = I
}
)(w);
const so = Am(w.exports);
var rl = {}
  , Dd = {
    exports: {}
}
  , Oe = {}
  , Md = {
    exports: {}
}
  , Vd = {};
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
    function t(L, O) {
        var F = L.length;
        L.push(O);
        e: for (; 0 < F; ) {
            var J = F - 1 >>> 1
              , oe = L[J];
            if (0 < i(oe, O))
                L[J] = O,
                L[F] = oe,
                F = J;
            else
                break e
        }
    }
    function n(L) {
        return L.length === 0 ? null : L[0]
    }
    function r(L) {
        if (L.length === 0)
            return null;
        var O = L[0]
          , F = L.pop();
        if (F !== O) {
            L[0] = F;
            e: for (var J = 0, oe = L.length, Ci = oe >>> 1; J < Ci; ) {
                var qt = 2 * (J + 1) - 1
                  , ds = L[qt]
                  , en = qt + 1
                  , Si = L[en];
                if (0 > i(ds, F))
                    en < oe && 0 > i(Si, ds) ? (L[J] = Si,
                    L[en] = F,
                    J = en) : (L[J] = ds,
                    L[qt] = F,
                    J = qt);
                else if (en < oe && 0 > i(Si, F))
                    L[J] = Si,
                    L[en] = F,
                    J = en;
                else
                    break e
            }
        }
        return O
    }
    function i(L, O) {
        var F = L.sortIndex - O.sortIndex;
        return F !== 0 ? F : L.id - O.id
    }
    if (typeof performance == "object" && typeof performance.now == "function") {
        var o = performance;
        e.unstable_now = function() {
            return o.now()
        }
    } else {
        var s = Date
          , l = s.now();
        e.unstable_now = function() {
            return s.now() - l
        }
    }
    var a = []
      , u = []
      , c = 1
      , f = null
      , d = 3
      , g = !1
      , y = !1
      , v = !1
      , C = typeof setTimeout == "function" ? setTimeout : null
      , p = typeof clearTimeout == "function" ? clearTimeout : null
      , h = typeof setImmediate < "u" ? setImmediate : null;
    typeof navigator < "u" && navigator.scheduling !== void 0 && navigator.scheduling.isInputPending !== void 0 && navigator.scheduling.isInputPending.bind(navigator.scheduling);
    function m(L) {
        for (var O = n(u); O !== null; ) {
            if (O.callback === null)
                r(u);
            else if (O.startTime <= L)
                r(u),
                O.sortIndex = O.expirationTime,
                t(a, O);
            else
                break;
            O = n(u)
        }
    }
    function x(L) {
        if (v = !1,
        m(L),
        !y)
            if (n(a) !== null)
                y = !0,
                xi(S);
            else {
                var O = n(u);
                O !== null && ne(x, O.startTime - L)
            }
    }
    function S(L, O) {
        y = !1,
        v && (v = !1,
        p(k),
        k = -1),
        g = !0;
        var F = d;
        try {
            for (m(O),
            f = n(a); f !== null && (!(f.expirationTime > O) || L && !X()); ) {
                var J = f.callback;
                if (typeof J == "function") {
                    f.callback = null,
                    d = f.priorityLevel;
                    var oe = J(f.expirationTime <= O);
                    O = e.unstable_now(),
                    typeof oe == "function" ? f.callback = oe : f === n(a) && r(a),
                    m(O)
                } else
                    r(a);
                f = n(a)
            }
            if (f !== null)
                var Ci = !0;
            else {
                var qt = n(u);
                qt !== null && ne(x, qt.startTime - O),
                Ci = !1
            }
            return Ci
        } finally {
            f = null,
            d = F,
            g = !1
        }
    }
    var T = !1
      , R = null
      , k = -1
      , V = 5
      , D = -1;
    function X() {
        return !(e.unstable_now() - D < V)
    }
    function Et() {
        if (R !== null) {
            var L = e.unstable_now();
            D = L;
            var O = !0;
            try {
                O = R(!0, L)
            } finally {
                O ? Jt() : (T = !1,
                R = null)
            }
        } else
            T = !1
    }
    var Jt;
    if (typeof h == "function")
        Jt = function() {
            h(Et)
        }
        ;
    else if (typeof MessageChannel < "u") {
        var ur = new MessageChannel
          , Qu = ur.port2;
        ur.port1.onmessage = Et,
        Jt = function() {
            Qu.postMessage(null)
        }
    } else
        Jt = function() {
            C(Et, 0)
        }
        ;
    function xi(L) {
        R = L,
        T || (T = !0,
        Jt())
    }
    function ne(L, O) {
        k = C(function() {
            L(e.unstable_now())
        }, O)
    }
    e.unstable_IdlePriority = 5,
    e.unstable_ImmediatePriority = 1,
    e.unstable_LowPriority = 4,
    e.unstable_NormalPriority = 3,
    e.unstable_Profiling = null,
    e.unstable_UserBlockingPriority = 2,
    e.unstable_cancelCallback = function(L) {
        L.callback = null
    }
    ,
    e.unstable_continueExecution = function() {
        y || g || (y = !0,
        xi(S))
    }
    ,
    e.unstable_forceFrameRate = function(L) {
        0 > L || 125 < L ? console.error("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported") : V = 0 < L ? Math.floor(1e3 / L) : 5
    }
    ,
    e.unstable_getCurrentPriorityLevel = function() {
        return d
    }
    ,
    e.unstable_getFirstCallbackNode = function() {
        return n(a)
    }
    ,
    e.unstable_next = function(L) {
        switch (d) {
        case 1:
        case 2:
        case 3:
            var O = 3;
            break;
        default:
            O = d
        }
        var F = d;
        d = O;
        try {
            return L()
        } finally {
            d = F
        }
    }
    ,
    e.unstable_pauseExecution = function() {}
    ,
    e.unstable_requestPaint = function() {}
    ,
    e.unstable_runWithPriority = function(L, O) {
        switch (L) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            break;
        default:
            L = 3
        }
        var F = d;
        d = L;
        try {
            return O()
        } finally {
            d = F
        }
    }
    ,
    e.unstable_scheduleCallback = function(L, O, F) {
        var J = e.unstable_now();
        switch (typeof F == "object" && F !== null ? (F = F.delay,
        F = typeof F == "number" && 0 < F ? J + F : J) : F = J,
        L) {
        case 1:
            var oe = -1;
            break;
        case 2:
            oe = 250;
            break;
        case 5:
            oe = 1073741823;
            break;
        case 4:
            oe = 1e4;
            break;
        default:
            oe = 5e3
        }
        return oe = F + oe,
        L = {
            id: c++,
            callback: O,
            priorityLevel: L,
            startTime: F,
            expirationTime: oe,
            sortIndex: -1
        },
        F > J ? (L.sortIndex = F,
        t(u, L),
        n(a) === null && L === n(u) && (v ? (p(k),
        k = -1) : v = !0,
        ne(x, F - J))) : (L.sortIndex = oe,
        t(a, L),
        y || g || (y = !0,
        xi(S))),
        L
    }
    ,
    e.unstable_shouldYield = X,
    e.unstable_wrapCallback = function(L) {
        var O = d;
        return function() {
            var F = d;
            d = O;
            try {
                return L.apply(this, arguments)
            } finally {
                d = F
            }
        }
    }
}
)(Vd);
(function(e) {
    e.exports = Vd
}
)(Md);
/**
 * @license React
 * react-dom.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var Od = w.exports
  , Me = Md.exports;
function E(e) {
    for (var t = "https://reactjs.org/docs/error-decoder.html?invariant=" + e, n = 1; n < arguments.length; n++)
        t += "&args[]=" + encodeURIComponent(arguments[n]);
    return "Minified React error #" + e + "; visit " + t + " for the full message or use the non-minified dev environment for full errors and additional helpful warnings."
}
var Fd = new Set
  , jr = {};
function wn(e, t) {
    Qn(e, t),
    Qn(e + "Capture", t)
}
function Qn(e, t) {
    for (jr[e] = t,
    e = 0; e < t.length; e++)
        Fd.add(t[e])
}
var vt = !(typeof window > "u" || typeof window.document > "u" || typeof window.document.createElement > "u")
  , il = Object.prototype.hasOwnProperty
  , bm = /^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/
  , Xu = {}
  , Ju = {};
function Km(e) {
    return il.call(Ju, e) ? !0 : il.call(Xu, e) ? !1 : bm.test(e) ? Ju[e] = !0 : (Xu[e] = !0,
    !1)
}
function Qm(e, t, n, r) {
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
function Ym(e, t, n, r) {
    if (t === null || typeof t > "u" || Qm(e, t, n, r))
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
function Pe(e, t, n, r, i, o, s) {
    this.acceptsBooleans = t === 2 || t === 3 || t === 4,
    this.attributeName = r,
    this.attributeNamespace = i,
    this.mustUseProperty = n,
    this.propertyName = e,
    this.type = t,
    this.sanitizeURL = o,
    this.removeEmptyString = s
}
var de = {};
"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style".split(" ").forEach(function(e) {
    de[e] = new Pe(e,0,!1,e,null,!1,!1)
});
[["acceptCharset", "accept-charset"], ["className", "class"], ["htmlFor", "for"], ["httpEquiv", "http-equiv"]].forEach(function(e) {
    var t = e[0];
    de[t] = new Pe(t,1,!1,e[1],null,!1,!1)
});
["contentEditable", "draggable", "spellCheck", "value"].forEach(function(e) {
    de[e] = new Pe(e,2,!1,e.toLowerCase(),null,!1,!1)
});
["autoReverse", "externalResourcesRequired", "focusable", "preserveAlpha"].forEach(function(e) {
    de[e] = new Pe(e,2,!1,e,null,!1,!1)
});
"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope".split(" ").forEach(function(e) {
    de[e] = new Pe(e,3,!1,e.toLowerCase(),null,!1,!1)
});
["checked", "multiple", "muted", "selected"].forEach(function(e) {
    de[e] = new Pe(e,3,!0,e,null,!1,!1)
});
["capture", "download"].forEach(function(e) {
    de[e] = new Pe(e,4,!1,e,null,!1,!1)
});
["cols", "rows", "size", "span"].forEach(function(e) {
    de[e] = new Pe(e,6,!1,e,null,!1,!1)
});
["rowSpan", "start"].forEach(function(e) {
    de[e] = new Pe(e,5,!1,e.toLowerCase(),null,!1,!1)
});
var wa = /[\-:]([a-z])/g;
function xa(e) {
    return e[1].toUpperCase()
}
"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height".split(" ").forEach(function(e) {
    var t = e.replace(wa, xa);
    de[t] = new Pe(t,1,!1,e,null,!1,!1)
});
"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type".split(" ").forEach(function(e) {
    var t = e.replace(wa, xa);
    de[t] = new Pe(t,1,!1,e,"http://www.w3.org/1999/xlink",!1,!1)
});
["xml:base", "xml:lang", "xml:space"].forEach(function(e) {
    var t = e.replace(wa, xa);
    de[t] = new Pe(t,1,!1,e,"http://www.w3.org/XML/1998/namespace",!1,!1)
});
["tabIndex", "crossOrigin"].forEach(function(e) {
    de[e] = new Pe(e,1,!1,e.toLowerCase(),null,!1,!1)
});
de.xlinkHref = new Pe("xlinkHref",1,!1,"xlink:href","http://www.w3.org/1999/xlink",!0,!1);
["src", "href", "action", "formAction"].forEach(function(e) {
    de[e] = new Pe(e,1,!1,e.toLowerCase(),null,!0,!0)
});
function Ca(e, t, n, r) {
    var i = de.hasOwnProperty(t) ? de[t] : null;
    (i !== null ? i.type !== 0 : r || !(2 < t.length) || t[0] !== "o" && t[0] !== "O" || t[1] !== "n" && t[1] !== "N") && (Ym(t, n, i, r) && (n = null),
    r || i === null ? Km(t) && (n === null ? e.removeAttribute(t) : e.setAttribute(t, "" + n)) : i.mustUseProperty ? e[i.propertyName] = n === null ? i.type === 3 ? !1 : "" : n : (t = i.attributeName,
    r = i.attributeNamespace,
    n === null ? e.removeAttribute(t) : (i = i.type,
    n = i === 3 || i === 4 && n === !0 ? "" : "" + n,
    r ? e.setAttributeNS(r, t, n) : e.setAttribute(t, n))))
}
var Pt = Od.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED
  , ki = Symbol.for("react.element")
  , kn = Symbol.for("react.portal")
  , En = Symbol.for("react.fragment")
  , Sa = Symbol.for("react.strict_mode")
  , ol = Symbol.for("react.profiler")
  , Id = Symbol.for("react.provider")
  , _d = Symbol.for("react.context")
  , Pa = Symbol.for("react.forward_ref")
  , sl = Symbol.for("react.suspense")
  , ll = Symbol.for("react.suspense_list")
  , ka = Symbol.for("react.memo")
  , Lt = Symbol.for("react.lazy")
  , Bd = Symbol.for("react.offscreen")
  , qu = Symbol.iterator;
function cr(e) {
    return e === null || typeof e != "object" ? null : (e = qu && e[qu] || e["@@iterator"],
    typeof e == "function" ? e : null)
}
var Y = Object.assign, ps;
function Cr(e) {
    if (ps === void 0)
        try {
            throw Error()
        } catch (n) {
            var t = n.stack.trim().match(/\n( *(at )?)/);
            ps = t && t[1] || ""
        }
    return `
` + ps + e
}
var ms = !1;
function gs(e, t) {
    if (!e || ms)
        return "";
    ms = !0;
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
`), s = i.length - 1, l = o.length - 1; 1 <= s && 0 <= l && i[s] !== o[l]; )
                l--;
            for (; 1 <= s && 0 <= l; s--,
            l--)
                if (i[s] !== o[l]) {
                    if (s !== 1 || l !== 1)
                        do
                            if (s--,
                            l--,
                            0 > l || i[s] !== o[l]) {
                                var a = `
` + i[s].replace(" at new ", " at ");
                                return e.displayName && a.includes("<anonymous>") && (a = a.replace("<anonymous>", e.displayName)),
                                a
                            }
                        while (1 <= s && 0 <= l);
                    break
                }
        }
    } finally {
        ms = !1,
        Error.prepareStackTrace = n
    }
    return (e = e ? e.displayName || e.name : "") ? Cr(e) : ""
}
function Gm(e) {
    switch (e.tag) {
    case 5:
        return Cr(e.type);
    case 16:
        return Cr("Lazy");
    case 13:
        return Cr("Suspense");
    case 19:
        return Cr("SuspenseList");
    case 0:
    case 2:
    case 15:
        return e = gs(e.type, !1),
        e;
    case 11:
        return e = gs(e.type.render, !1),
        e;
    case 1:
        return e = gs(e.type, !0),
        e;
    default:
        return ""
    }
}
function al(e) {
    if (e == null)
        return null;
    if (typeof e == "function")
        return e.displayName || e.name || null;
    if (typeof e == "string")
        return e;
    switch (e) {
    case En:
        return "Fragment";
    case kn:
        return "Portal";
    case ol:
        return "Profiler";
    case Sa:
        return "StrictMode";
    case sl:
        return "Suspense";
    case ll:
        return "SuspenseList"
    }
    if (typeof e == "object")
        switch (e.$$typeof) {
        case _d:
            return (e.displayName || "Context") + ".Consumer";
        case Id:
            return (e._context.displayName || "Context") + ".Provider";
        case Pa:
            var t = e.render;
            return e = e.displayName,
            e || (e = t.displayName || t.name || "",
            e = e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef"),
            e;
        case ka:
            return t = e.displayName || null,
            t !== null ? t : al(e.type) || "Memo";
        case Lt:
            t = e._payload,
            e = e._init;
            try {
                return al(e(t))
            } catch {}
        }
    return null
}
function Zm(e) {
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
        return al(t);
    case 8:
        return t === Sa ? "StrictMode" : "Mode";
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
function Wt(e) {
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
function zd(e) {
    var t = e.type;
    return (e = e.nodeName) && e.toLowerCase() === "input" && (t === "checkbox" || t === "radio")
}
function Xm(e) {
    var t = zd(e) ? "checked" : "value"
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
            set: function(s) {
                r = "" + s,
                o.call(this, s)
            }
        }),
        Object.defineProperty(e, t, {
            enumerable: n.enumerable
        }),
        {
            getValue: function() {
                return r
            },
            setValue: function(s) {
                r = "" + s
            },
            stopTracking: function() {
                e._valueTracker = null,
                delete e[t]
            }
        }
    }
}
function Ei(e) {
    e._valueTracker || (e._valueTracker = Xm(e))
}
function jd(e) {
    if (!e)
        return !1;
    var t = e._valueTracker;
    if (!t)
        return !0;
    var n = t.getValue()
      , r = "";
    return e && (r = zd(e) ? e.checked ? "true" : "false" : e.value),
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
function ul(e, t) {
    var n = t.checked;
    return Y({}, t, {
        defaultChecked: void 0,
        defaultValue: void 0,
        value: void 0,
        checked: n != null ? n : e._wrapperState.initialChecked
    })
}
function ec(e, t) {
    var n = t.defaultValue == null ? "" : t.defaultValue
      , r = t.checked != null ? t.checked : t.defaultChecked;
    n = Wt(t.value != null ? t.value : n),
    e._wrapperState = {
        initialChecked: r,
        initialValue: n,
        controlled: t.type === "checkbox" || t.type === "radio" ? t.checked != null : t.value != null
    }
}
function Ud(e, t) {
    t = t.checked,
    t != null && Ca(e, "checked", t, !1)
}
function cl(e, t) {
    Ud(e, t);
    var n = Wt(t.value)
      , r = t.type;
    if (n != null)
        r === "number" ? (n === 0 && e.value === "" || e.value != n) && (e.value = "" + n) : e.value !== "" + n && (e.value = "" + n);
    else if (r === "submit" || r === "reset") {
        e.removeAttribute("value");
        return
    }
    t.hasOwnProperty("value") ? fl(e, t.type, n) : t.hasOwnProperty("defaultValue") && fl(e, t.type, Wt(t.defaultValue)),
    t.checked == null && t.defaultChecked != null && (e.defaultChecked = !!t.defaultChecked)
}
function tc(e, t, n) {
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
function fl(e, t, n) {
    (t !== "number" || lo(e.ownerDocument) !== e) && (n == null ? e.defaultValue = "" + e._wrapperState.initialValue : e.defaultValue !== "" + n && (e.defaultValue = "" + n))
}
var Sr = Array.isArray;
function Un(e, t, n, r) {
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
        for (n = "" + Wt(n),
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
function dl(e, t) {
    if (t.dangerouslySetInnerHTML != null)
        throw Error(E(91));
    return Y({}, t, {
        value: void 0,
        defaultValue: void 0,
        children: "" + e._wrapperState.initialValue
    })
}
function nc(e, t) {
    var n = t.value;
    if (n == null) {
        if (n = t.children,
        t = t.defaultValue,
        n != null) {
            if (t != null)
                throw Error(E(92));
            if (Sr(n)) {
                if (1 < n.length)
                    throw Error(E(93));
                n = n[0]
            }
            t = n
        }
        t == null && (t = ""),
        n = t
    }
    e._wrapperState = {
        initialValue: Wt(n)
    }
}
function Hd(e, t) {
    var n = Wt(t.value)
      , r = Wt(t.defaultValue);
    n != null && (n = "" + n,
    n !== e.value && (e.value = n),
    t.defaultValue == null && e.defaultValue !== n && (e.defaultValue = n)),
    r != null && (e.defaultValue = "" + r)
}
function rc(e) {
    var t = e.textContent;
    t === e._wrapperState.initialValue && t !== "" && t !== null && (e.value = t)
}
function $d(e) {
    switch (e) {
    case "svg":
        return "http://www.w3.org/2000/svg";
    case "math":
        return "http://www.w3.org/1998/Math/MathML";
    default:
        return "http://www.w3.org/1999/xhtml"
    }
}
function hl(e, t) {
    return e == null || e === "http://www.w3.org/1999/xhtml" ? $d(t) : e === "http://www.w3.org/2000/svg" && t === "foreignObject" ? "http://www.w3.org/1999/xhtml" : e
}
var Ti, Wd = function(e) {
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
        for (Ti = Ti || document.createElement("div"),
        Ti.innerHTML = "<svg>" + t.valueOf().toString() + "</svg>",
        t = Ti.firstChild; e.firstChild; )
            e.removeChild(e.firstChild);
        for (; t.firstChild; )
            e.appendChild(t.firstChild)
    }
});
function Ur(e, t) {
    if (t) {
        var n = e.firstChild;
        if (n && n === e.lastChild && n.nodeType === 3) {
            n.nodeValue = t;
            return
        }
    }
    e.textContent = t
}
var Lr = {
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
  , Jm = ["Webkit", "ms", "Moz", "O"];
Object.keys(Lr).forEach(function(e) {
    Jm.forEach(function(t) {
        t = t + e.charAt(0).toUpperCase() + e.substring(1),
        Lr[t] = Lr[e]
    })
});
function bd(e, t, n) {
    return t == null || typeof t == "boolean" || t === "" ? "" : n || typeof t != "number" || t === 0 || Lr.hasOwnProperty(e) && Lr[e] ? ("" + t).trim() : t + "px"
}
function Kd(e, t) {
    e = e.style;
    for (var n in t)
        if (t.hasOwnProperty(n)) {
            var r = n.indexOf("--") === 0
              , i = bd(n, t[n], r);
            n === "float" && (n = "cssFloat"),
            r ? e.setProperty(n, i) : e[n] = i
        }
}
var qm = Y({
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
function pl(e, t) {
    if (t) {
        if (qm[e] && (t.children != null || t.dangerouslySetInnerHTML != null))
            throw Error(E(137, e));
        if (t.dangerouslySetInnerHTML != null) {
            if (t.children != null)
                throw Error(E(60));
            if (typeof t.dangerouslySetInnerHTML != "object" || !("__html"in t.dangerouslySetInnerHTML))
                throw Error(E(61))
        }
        if (t.style != null && typeof t.style != "object")
            throw Error(E(62))
    }
}
function ml(e, t) {
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
var gl = null;
function Ea(e) {
    return e = e.target || e.srcElement || window,
    e.correspondingUseElement && (e = e.correspondingUseElement),
    e.nodeType === 3 ? e.parentNode : e
}
var vl = null
  , Hn = null
  , $n = null;
function ic(e) {
    if (e = fi(e)) {
        if (typeof vl != "function")
            throw Error(E(280));
        var t = e.stateNode;
        t && (t = bo(t),
        vl(e.stateNode, e.type, t))
    }
}
function Qd(e) {
    Hn ? $n ? $n.push(e) : $n = [e] : Hn = e
}
function Yd() {
    if (Hn) {
        var e = Hn
          , t = $n;
        if ($n = Hn = null,
        ic(e),
        t)
            for (e = 0; e < t.length; e++)
                ic(t[e])
    }
}
function Gd(e, t) {
    return e(t)
}
function Zd() {}
var vs = !1;
function Xd(e, t, n) {
    if (vs)
        return e(t, n);
    vs = !0;
    try {
        return Gd(e, t, n)
    } finally {
        vs = !1,
        (Hn !== null || $n !== null) && (Zd(),
        Yd())
    }
}
function Hr(e, t) {
    var n = e.stateNode;
    if (n === null)
        return null;
    var r = bo(n);
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
        throw Error(E(231, t, typeof n));
    return n
}
var yl = !1;
if (vt)
    try {
        var fr = {};
        Object.defineProperty(fr, "passive", {
            get: function() {
                yl = !0
            }
        }),
        window.addEventListener("test", fr, fr),
        window.removeEventListener("test", fr, fr)
    } catch {
        yl = !1
    }
function e0(e, t, n, r, i, o, s, l, a) {
    var u = Array.prototype.slice.call(arguments, 3);
    try {
        t.apply(n, u)
    } catch (c) {
        this.onError(c)
    }
}
var Ar = !1
  , ao = null
  , uo = !1
  , wl = null
  , t0 = {
    onError: function(e) {
        Ar = !0,
        ao = e
    }
};
function n0(e, t, n, r, i, o, s, l, a) {
    Ar = !1,
    ao = null,
    e0.apply(t0, arguments)
}
function r0(e, t, n, r, i, o, s, l, a) {
    if (n0.apply(this, arguments),
    Ar) {
        if (Ar) {
            var u = ao;
            Ar = !1,
            ao = null
        } else
            throw Error(E(198));
        uo || (uo = !0,
        wl = u)
    }
}
function xn(e) {
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
function Jd(e) {
    if (e.tag === 13) {
        var t = e.memoizedState;
        if (t === null && (e = e.alternate,
        e !== null && (t = e.memoizedState)),
        t !== null)
            return t.dehydrated
    }
    return null
}
function oc(e) {
    if (xn(e) !== e)
        throw Error(E(188))
}
function i0(e) {
    var t = e.alternate;
    if (!t) {
        if (t = xn(e),
        t === null)
            throw Error(E(188));
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
                    return oc(i),
                    e;
                if (o === r)
                    return oc(i),
                    t;
                o = o.sibling
            }
            throw Error(E(188))
        }
        if (n.return !== r.return)
            n = i,
            r = o;
        else {
            for (var s = !1, l = i.child; l; ) {
                if (l === n) {
                    s = !0,
                    n = i,
                    r = o;
                    break
                }
                if (l === r) {
                    s = !0,
                    r = i,
                    n = o;
                    break
                }
                l = l.sibling
            }
            if (!s) {
                for (l = o.child; l; ) {
                    if (l === n) {
                        s = !0,
                        n = o,
                        r = i;
                        break
                    }
                    if (l === r) {
                        s = !0,
                        r = o,
                        n = i;
                        break
                    }
                    l = l.sibling
                }
                if (!s)
                    throw Error(E(189))
            }
        }
        if (n.alternate !== r)
            throw Error(E(190))
    }
    if (n.tag !== 3)
        throw Error(E(188));
    return n.stateNode.current === n ? e : t
}
function qd(e) {
    return e = i0(e),
    e !== null ? eh(e) : null
}
function eh(e) {
    if (e.tag === 5 || e.tag === 6)
        return e;
    for (e = e.child; e !== null; ) {
        var t = eh(e);
        if (t !== null)
            return t;
        e = e.sibling
    }
    return null
}
var th = Me.unstable_scheduleCallback
  , sc = Me.unstable_cancelCallback
  , o0 = Me.unstable_shouldYield
  , s0 = Me.unstable_requestPaint
  , ee = Me.unstable_now
  , l0 = Me.unstable_getCurrentPriorityLevel
  , Ta = Me.unstable_ImmediatePriority
  , nh = Me.unstable_UserBlockingPriority
  , co = Me.unstable_NormalPriority
  , a0 = Me.unstable_LowPriority
  , rh = Me.unstable_IdlePriority
  , Uo = null
  , nt = null;
function u0(e) {
    if (nt && typeof nt.onCommitFiberRoot == "function")
        try {
            nt.onCommitFiberRoot(Uo, e, void 0, (e.current.flags & 128) === 128)
        } catch {}
}
var Ze = Math.clz32 ? Math.clz32 : d0
  , c0 = Math.log
  , f0 = Math.LN2;
function d0(e) {
    return e >>>= 0,
    e === 0 ? 32 : 31 - (c0(e) / f0 | 0) | 0
}
var Ri = 64
  , Li = 4194304;
function Pr(e) {
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
function fo(e, t) {
    var n = e.pendingLanes;
    if (n === 0)
        return 0;
    var r = 0
      , i = e.suspendedLanes
      , o = e.pingedLanes
      , s = n & 268435455;
    if (s !== 0) {
        var l = s & ~i;
        l !== 0 ? r = Pr(l) : (o &= s,
        o !== 0 && (r = Pr(o)))
    } else
        s = n & ~i,
        s !== 0 ? r = Pr(s) : o !== 0 && (r = Pr(o));
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
            n = 31 - Ze(t),
            i = 1 << n,
            r |= e[n],
            t &= ~i;
    return r
}
function h0(e, t) {
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
function p0(e, t) {
    for (var n = e.suspendedLanes, r = e.pingedLanes, i = e.expirationTimes, o = e.pendingLanes; 0 < o; ) {
        var s = 31 - Ze(o)
          , l = 1 << s
          , a = i[s];
        a === -1 ? ((l & n) === 0 || (l & r) !== 0) && (i[s] = h0(l, t)) : a <= t && (e.expiredLanes |= l),
        o &= ~l
    }
}
function xl(e) {
    return e = e.pendingLanes & -1073741825,
    e !== 0 ? e : e & 1073741824 ? 1073741824 : 0
}
function ih() {
    var e = Ri;
    return Ri <<= 1,
    (Ri & 4194240) === 0 && (Ri = 64),
    e
}
function ys(e) {
    for (var t = [], n = 0; 31 > n; n++)
        t.push(e);
    return t
}
function ui(e, t, n) {
    e.pendingLanes |= t,
    t !== 536870912 && (e.suspendedLanes = 0,
    e.pingedLanes = 0),
    e = e.eventTimes,
    t = 31 - Ze(t),
    e[t] = n
}
function m0(e, t) {
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
        var i = 31 - Ze(n)
          , o = 1 << i;
        t[i] = 0,
        r[i] = -1,
        e[i] = -1,
        n &= ~o
    }
}
function Ra(e, t) {
    var n = e.entangledLanes |= t;
    for (e = e.entanglements; n; ) {
        var r = 31 - Ze(n)
          , i = 1 << r;
        i & t | e[r] & t && (e[r] |= t),
        n &= ~i
    }
}
var B = 0;
function oh(e) {
    return e &= -e,
    1 < e ? 4 < e ? (e & 268435455) !== 0 ? 16 : 536870912 : 4 : 1
}
var sh, La, lh, ah, uh, Cl = !1, Ai = [], Ot = null, Ft = null, It = null, $r = new Map, Wr = new Map, Nt = [], g0 = "mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(" ");
function lc(e, t) {
    switch (e) {
    case "focusin":
    case "focusout":
        Ot = null;
        break;
    case "dragenter":
    case "dragleave":
        Ft = null;
        break;
    case "mouseover":
    case "mouseout":
        It = null;
        break;
    case "pointerover":
    case "pointerout":
        $r.delete(t.pointerId);
        break;
    case "gotpointercapture":
    case "lostpointercapture":
        Wr.delete(t.pointerId)
    }
}
function dr(e, t, n, r, i, o) {
    return e === null || e.nativeEvent !== o ? (e = {
        blockedOn: t,
        domEventName: n,
        eventSystemFlags: r,
        nativeEvent: o,
        targetContainers: [i]
    },
    t !== null && (t = fi(t),
    t !== null && La(t)),
    e) : (e.eventSystemFlags |= r,
    t = e.targetContainers,
    i !== null && t.indexOf(i) === -1 && t.push(i),
    e)
}
function v0(e, t, n, r, i) {
    switch (t) {
    case "focusin":
        return Ot = dr(Ot, e, t, n, r, i),
        !0;
    case "dragenter":
        return Ft = dr(Ft, e, t, n, r, i),
        !0;
    case "mouseover":
        return It = dr(It, e, t, n, r, i),
        !0;
    case "pointerover":
        var o = i.pointerId;
        return $r.set(o, dr($r.get(o) || null, e, t, n, r, i)),
        !0;
    case "gotpointercapture":
        return o = i.pointerId,
        Wr.set(o, dr(Wr.get(o) || null, e, t, n, r, i)),
        !0
    }
    return !1
}
function ch(e) {
    var t = ln(e.target);
    if (t !== null) {
        var n = xn(t);
        if (n !== null) {
            if (t = n.tag,
            t === 13) {
                if (t = Jd(n),
                t !== null) {
                    e.blockedOn = t,
                    uh(e.priority, function() {
                        lh(n)
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
function bi(e) {
    if (e.blockedOn !== null)
        return !1;
    for (var t = e.targetContainers; 0 < t.length; ) {
        var n = Sl(e.domEventName, e.eventSystemFlags, t[0], e.nativeEvent);
        if (n === null) {
            n = e.nativeEvent;
            var r = new n.constructor(n.type,n);
            gl = r,
            n.target.dispatchEvent(r),
            gl = null
        } else
            return t = fi(n),
            t !== null && La(t),
            e.blockedOn = n,
            !1;
        t.shift()
    }
    return !0
}
function ac(e, t, n) {
    bi(e) && n.delete(t)
}
function y0() {
    Cl = !1,
    Ot !== null && bi(Ot) && (Ot = null),
    Ft !== null && bi(Ft) && (Ft = null),
    It !== null && bi(It) && (It = null),
    $r.forEach(ac),
    Wr.forEach(ac)
}
function hr(e, t) {
    e.blockedOn === t && (e.blockedOn = null,
    Cl || (Cl = !0,
    Me.unstable_scheduleCallback(Me.unstable_NormalPriority, y0)))
}
function br(e) {
    function t(i) {
        return hr(i, e)
    }
    if (0 < Ai.length) {
        hr(Ai[0], e);
        for (var n = 1; n < Ai.length; n++) {
            var r = Ai[n];
            r.blockedOn === e && (r.blockedOn = null)
        }
    }
    for (Ot !== null && hr(Ot, e),
    Ft !== null && hr(Ft, e),
    It !== null && hr(It, e),
    $r.forEach(t),
    Wr.forEach(t),
    n = 0; n < Nt.length; n++)
        r = Nt[n],
        r.blockedOn === e && (r.blockedOn = null);
    for (; 0 < Nt.length && (n = Nt[0],
    n.blockedOn === null); )
        ch(n),
        n.blockedOn === null && Nt.shift()
}
var Wn = Pt.ReactCurrentBatchConfig
  , ho = !0;
function w0(e, t, n, r) {
    var i = B
      , o = Wn.transition;
    Wn.transition = null;
    try {
        B = 1,
        Aa(e, t, n, r)
    } finally {
        B = i,
        Wn.transition = o
    }
}
function x0(e, t, n, r) {
    var i = B
      , o = Wn.transition;
    Wn.transition = null;
    try {
        B = 4,
        Aa(e, t, n, r)
    } finally {
        B = i,
        Wn.transition = o
    }
}
function Aa(e, t, n, r) {
    if (ho) {
        var i = Sl(e, t, n, r);
        if (i === null)
            Ls(e, t, r, po, n),
            lc(e, r);
        else if (v0(i, e, t, n, r))
            r.stopPropagation();
        else if (lc(e, r),
        t & 4 && -1 < g0.indexOf(e)) {
            for (; i !== null; ) {
                var o = fi(i);
                if (o !== null && sh(o),
                o = Sl(e, t, n, r),
                o === null && Ls(e, t, r, po, n),
                o === i)
                    break;
                i = o
            }
            i !== null && r.stopPropagation()
        } else
            Ls(e, t, r, null, n)
    }
}
var po = null;
function Sl(e, t, n, r) {
    if (po = null,
    e = Ea(r),
    e = ln(e),
    e !== null)
        if (t = xn(e),
        t === null)
            e = null;
        else if (n = t.tag,
        n === 13) {
            if (e = Jd(t),
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
function fh(e) {
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
        switch (l0()) {
        case Ta:
            return 1;
        case nh:
            return 4;
        case co:
        case a0:
            return 16;
        case rh:
            return 536870912;
        default:
            return 16
        }
    default:
        return 16
    }
}
var Mt = null
  , Na = null
  , Ki = null;
function dh() {
    if (Ki)
        return Ki;
    var e, t = Na, n = t.length, r, i = "value"in Mt ? Mt.value : Mt.textContent, o = i.length;
    for (e = 0; e < n && t[e] === i[e]; e++)
        ;
    var s = n - e;
    for (r = 1; r <= s && t[n - r] === i[o - r]; r++)
        ;
    return Ki = i.slice(e, 1 < r ? 1 - r : void 0)
}
function Qi(e) {
    var t = e.keyCode;
    return "charCode"in e ? (e = e.charCode,
    e === 0 && t === 13 && (e = 13)) : e = t,
    e === 10 && (e = 13),
    32 <= e || e === 13 ? e : 0
}
function Ni() {
    return !0
}
function uc() {
    return !1
}
function Fe(e) {
    function t(n, r, i, o, s) {
        this._reactName = n,
        this._targetInst = i,
        this.type = r,
        this.nativeEvent = o,
        this.target = s,
        this.currentTarget = null;
        for (var l in e)
            e.hasOwnProperty(l) && (n = e[l],
            this[l] = n ? n(o) : o[l]);
        return this.isDefaultPrevented = (o.defaultPrevented != null ? o.defaultPrevented : o.returnValue === !1) ? Ni : uc,
        this.isPropagationStopped = uc,
        this
    }
    return Y(t.prototype, {
        preventDefault: function() {
            this.defaultPrevented = !0;
            var n = this.nativeEvent;
            n && (n.preventDefault ? n.preventDefault() : typeof n.returnValue != "unknown" && (n.returnValue = !1),
            this.isDefaultPrevented = Ni)
        },
        stopPropagation: function() {
            var n = this.nativeEvent;
            n && (n.stopPropagation ? n.stopPropagation() : typeof n.cancelBubble != "unknown" && (n.cancelBubble = !0),
            this.isPropagationStopped = Ni)
        },
        persist: function() {},
        isPersistent: Ni
    }),
    t
}
var ir = {
    eventPhase: 0,
    bubbles: 0,
    cancelable: 0,
    timeStamp: function(e) {
        return e.timeStamp || Date.now()
    },
    defaultPrevented: 0,
    isTrusted: 0
}, Da = Fe(ir), ci = Y({}, ir, {
    view: 0,
    detail: 0
}), C0 = Fe(ci), ws, xs, pr, Ho = Y({}, ci, {
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
    getModifierState: Ma,
    button: 0,
    buttons: 0,
    relatedTarget: function(e) {
        return e.relatedTarget === void 0 ? e.fromElement === e.srcElement ? e.toElement : e.fromElement : e.relatedTarget
    },
    movementX: function(e) {
        return "movementX"in e ? e.movementX : (e !== pr && (pr && e.type === "mousemove" ? (ws = e.screenX - pr.screenX,
        xs = e.screenY - pr.screenY) : xs = ws = 0,
        pr = e),
        ws)
    },
    movementY: function(e) {
        return "movementY"in e ? e.movementY : xs
    }
}), cc = Fe(Ho), S0 = Y({}, Ho, {
    dataTransfer: 0
}), P0 = Fe(S0), k0 = Y({}, ci, {
    relatedTarget: 0
}), Cs = Fe(k0), E0 = Y({}, ir, {
    animationName: 0,
    elapsedTime: 0,
    pseudoElement: 0
}), T0 = Fe(E0), R0 = Y({}, ir, {
    clipboardData: function(e) {
        return "clipboardData"in e ? e.clipboardData : window.clipboardData
    }
}), L0 = Fe(R0), A0 = Y({}, ir, {
    data: 0
}), fc = Fe(A0), N0 = {
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
}, D0 = {
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
}, M0 = {
    Alt: "altKey",
    Control: "ctrlKey",
    Meta: "metaKey",
    Shift: "shiftKey"
};
function V0(e) {
    var t = this.nativeEvent;
    return t.getModifierState ? t.getModifierState(e) : (e = M0[e]) ? !!t[e] : !1
}
function Ma() {
    return V0
}
var O0 = Y({}, ci, {
    key: function(e) {
        if (e.key) {
            var t = N0[e.key] || e.key;
            if (t !== "Unidentified")
                return t
        }
        return e.type === "keypress" ? (e = Qi(e),
        e === 13 ? "Enter" : String.fromCharCode(e)) : e.type === "keydown" || e.type === "keyup" ? D0[e.keyCode] || "Unidentified" : ""
    },
    code: 0,
    location: 0,
    ctrlKey: 0,
    shiftKey: 0,
    altKey: 0,
    metaKey: 0,
    repeat: 0,
    locale: 0,
    getModifierState: Ma,
    charCode: function(e) {
        return e.type === "keypress" ? Qi(e) : 0
    },
    keyCode: function(e) {
        return e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
    },
    which: function(e) {
        return e.type === "keypress" ? Qi(e) : e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
    }
})
  , F0 = Fe(O0)
  , I0 = Y({}, Ho, {
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
  , dc = Fe(I0)
  , _0 = Y({}, ci, {
    touches: 0,
    targetTouches: 0,
    changedTouches: 0,
    altKey: 0,
    metaKey: 0,
    ctrlKey: 0,
    shiftKey: 0,
    getModifierState: Ma
})
  , B0 = Fe(_0)
  , z0 = Y({}, ir, {
    propertyName: 0,
    elapsedTime: 0,
    pseudoElement: 0
})
  , j0 = Fe(z0)
  , U0 = Y({}, Ho, {
    deltaX: function(e) {
        return "deltaX"in e ? e.deltaX : "wheelDeltaX"in e ? -e.wheelDeltaX : 0
    },
    deltaY: function(e) {
        return "deltaY"in e ? e.deltaY : "wheelDeltaY"in e ? -e.wheelDeltaY : "wheelDelta"in e ? -e.wheelDelta : 0
    },
    deltaZ: 0,
    deltaMode: 0
})
  , H0 = Fe(U0)
  , $0 = [9, 13, 27, 32]
  , Va = vt && "CompositionEvent"in window
  , Nr = null;
vt && "documentMode"in document && (Nr = document.documentMode);
var W0 = vt && "TextEvent"in window && !Nr
  , hh = vt && (!Va || Nr && 8 < Nr && 11 >= Nr)
  , hc = String.fromCharCode(32)
  , pc = !1;
function ph(e, t) {
    switch (e) {
    case "keyup":
        return $0.indexOf(t.keyCode) !== -1;
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
function mh(e) {
    return e = e.detail,
    typeof e == "object" && "data"in e ? e.data : null
}
var Tn = !1;
function b0(e, t) {
    switch (e) {
    case "compositionend":
        return mh(t);
    case "keypress":
        return t.which !== 32 ? null : (pc = !0,
        hc);
    case "textInput":
        return e = t.data,
        e === hc && pc ? null : e;
    default:
        return null
    }
}
function K0(e, t) {
    if (Tn)
        return e === "compositionend" || !Va && ph(e, t) ? (e = dh(),
        Ki = Na = Mt = null,
        Tn = !1,
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
        return hh && t.locale !== "ko" ? null : t.data;
    default:
        return null
    }
}
var Q0 = {
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
function mc(e) {
    var t = e && e.nodeName && e.nodeName.toLowerCase();
    return t === "input" ? !!Q0[e.type] : t === "textarea"
}
function gh(e, t, n, r) {
    Qd(r),
    t = mo(t, "onChange"),
    0 < t.length && (n = new Da("onChange","change",null,n,r),
    e.push({
        event: n,
        listeners: t
    }))
}
var Dr = null
  , Kr = null;
function Y0(e) {
    Rh(e, 0)
}
function $o(e) {
    var t = An(e);
    if (jd(t))
        return e
}
function G0(e, t) {
    if (e === "change")
        return t
}
var vh = !1;
if (vt) {
    var Ss;
    if (vt) {
        var Ps = "oninput"in document;
        if (!Ps) {
            var gc = document.createElement("div");
            gc.setAttribute("oninput", "return;"),
            Ps = typeof gc.oninput == "function"
        }
        Ss = Ps
    } else
        Ss = !1;
    vh = Ss && (!document.documentMode || 9 < document.documentMode)
}
function vc() {
    Dr && (Dr.detachEvent("onpropertychange", yh),
    Kr = Dr = null)
}
function yh(e) {
    if (e.propertyName === "value" && $o(Kr)) {
        var t = [];
        gh(t, Kr, e, Ea(e)),
        Xd(Y0, t)
    }
}
function Z0(e, t, n) {
    e === "focusin" ? (vc(),
    Dr = t,
    Kr = n,
    Dr.attachEvent("onpropertychange", yh)) : e === "focusout" && vc()
}
function X0(e) {
    if (e === "selectionchange" || e === "keyup" || e === "keydown")
        return $o(Kr)
}
function J0(e, t) {
    if (e === "click")
        return $o(t)
}
function q0(e, t) {
    if (e === "input" || e === "change")
        return $o(t)
}
function e2(e, t) {
    return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var Je = typeof Object.is == "function" ? Object.is : e2;
function Qr(e, t) {
    if (Je(e, t))
        return !0;
    if (typeof e != "object" || e === null || typeof t != "object" || t === null)
        return !1;
    var n = Object.keys(e)
      , r = Object.keys(t);
    if (n.length !== r.length)
        return !1;
    for (r = 0; r < n.length; r++) {
        var i = n[r];
        if (!il.call(t, i) || !Je(e[i], t[i]))
            return !1
    }
    return !0
}
function yc(e) {
    for (; e && e.firstChild; )
        e = e.firstChild;
    return e
}
function wc(e, t) {
    var n = yc(e);
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
        n = yc(n)
    }
}
function wh(e, t) {
    return e && t ? e === t ? !0 : e && e.nodeType === 3 ? !1 : t && t.nodeType === 3 ? wh(e, t.parentNode) : "contains"in e ? e.contains(t) : e.compareDocumentPosition ? !!(e.compareDocumentPosition(t) & 16) : !1 : !1
}
function xh() {
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
function Oa(e) {
    var t = e && e.nodeName && e.nodeName.toLowerCase();
    return t && (t === "input" && (e.type === "text" || e.type === "search" || e.type === "tel" || e.type === "url" || e.type === "password") || t === "textarea" || e.contentEditable === "true")
}
function t2(e) {
    var t = xh()
      , n = e.focusedElem
      , r = e.selectionRange;
    if (t !== n && n && n.ownerDocument && wh(n.ownerDocument.documentElement, n)) {
        if (r !== null && Oa(n)) {
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
                i = wc(n, o);
                var s = wc(n, r);
                i && s && (e.rangeCount !== 1 || e.anchorNode !== i.node || e.anchorOffset !== i.offset || e.focusNode !== s.node || e.focusOffset !== s.offset) && (t = t.createRange(),
                t.setStart(i.node, i.offset),
                e.removeAllRanges(),
                o > r ? (e.addRange(t),
                e.extend(s.node, s.offset)) : (t.setEnd(s.node, s.offset),
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
var n2 = vt && "documentMode"in document && 11 >= document.documentMode
  , Rn = null
  , Pl = null
  , Mr = null
  , kl = !1;
function xc(e, t, n) {
    var r = n.window === n ? n.document : n.nodeType === 9 ? n : n.ownerDocument;
    kl || Rn == null || Rn !== lo(r) || (r = Rn,
    "selectionStart"in r && Oa(r) ? r = {
        start: r.selectionStart,
        end: r.selectionEnd
    } : (r = (r.ownerDocument && r.ownerDocument.defaultView || window).getSelection(),
    r = {
        anchorNode: r.anchorNode,
        anchorOffset: r.anchorOffset,
        focusNode: r.focusNode,
        focusOffset: r.focusOffset
    }),
    Mr && Qr(Mr, r) || (Mr = r,
    r = mo(Pl, "onSelect"),
    0 < r.length && (t = new Da("onSelect","select",null,t,n),
    e.push({
        event: t,
        listeners: r
    }),
    t.target = Rn)))
}
function Di(e, t) {
    var n = {};
    return n[e.toLowerCase()] = t.toLowerCase(),
    n["Webkit" + e] = "webkit" + t,
    n["Moz" + e] = "moz" + t,
    n
}
var Ln = {
    animationend: Di("Animation", "AnimationEnd"),
    animationiteration: Di("Animation", "AnimationIteration"),
    animationstart: Di("Animation", "AnimationStart"),
    transitionend: Di("Transition", "TransitionEnd")
}
  , ks = {}
  , Ch = {};
vt && (Ch = document.createElement("div").style,
"AnimationEvent"in window || (delete Ln.animationend.animation,
delete Ln.animationiteration.animation,
delete Ln.animationstart.animation),
"TransitionEvent"in window || delete Ln.transitionend.transition);
function Wo(e) {
    if (ks[e])
        return ks[e];
    if (!Ln[e])
        return e;
    var t = Ln[e], n;
    for (n in t)
        if (t.hasOwnProperty(n) && n in Ch)
            return ks[e] = t[n];
    return e
}
var Sh = Wo("animationend")
  , Ph = Wo("animationiteration")
  , kh = Wo("animationstart")
  , Eh = Wo("transitionend")
  , Th = new Map
  , Cc = "abort auxClick cancel canPlay canPlayThrough click close contextMenu copy cut drag dragEnd dragEnter dragExit dragLeave dragOver dragStart drop durationChange emptied encrypted ended error gotPointerCapture input invalid keyDown keyPress keyUp load loadedData loadedMetadata loadStart lostPointerCapture mouseDown mouseMove mouseOut mouseOver mouseUp paste pause play playing pointerCancel pointerDown pointerMove pointerOut pointerOver pointerUp progress rateChange reset resize seeked seeking stalled submit suspend timeUpdate touchCancel touchEnd touchStart volumeChange scroll toggle touchMove waiting wheel".split(" ");
function Yt(e, t) {
    Th.set(e, t),
    wn(t, [e])
}
for (var Es = 0; Es < Cc.length; Es++) {
    var Ts = Cc[Es]
      , r2 = Ts.toLowerCase()
      , i2 = Ts[0].toUpperCase() + Ts.slice(1);
    Yt(r2, "on" + i2)
}
Yt(Sh, "onAnimationEnd");
Yt(Ph, "onAnimationIteration");
Yt(kh, "onAnimationStart");
Yt("dblclick", "onDoubleClick");
Yt("focusin", "onFocus");
Yt("focusout", "onBlur");
Yt(Eh, "onTransitionEnd");
Qn("onMouseEnter", ["mouseout", "mouseover"]);
Qn("onMouseLeave", ["mouseout", "mouseover"]);
Qn("onPointerEnter", ["pointerout", "pointerover"]);
Qn("onPointerLeave", ["pointerout", "pointerover"]);
wn("onChange", "change click focusin focusout input keydown keyup selectionchange".split(" "));
wn("onSelect", "focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(" "));
wn("onBeforeInput", ["compositionend", "keypress", "textInput", "paste"]);
wn("onCompositionEnd", "compositionend focusout keydown keypress keyup mousedown".split(" "));
wn("onCompositionStart", "compositionstart focusout keydown keypress keyup mousedown".split(" "));
wn("onCompositionUpdate", "compositionupdate focusout keydown keypress keyup mousedown".split(" "));
var kr = "abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange resize seeked seeking stalled suspend timeupdate volumechange waiting".split(" ")
  , o2 = new Set("cancel close invalid load scroll toggle".split(" ").concat(kr));
function Sc(e, t, n) {
    var r = e.type || "unknown-event";
    e.currentTarget = n,
    r0(r, t, void 0, e),
    e.currentTarget = null
}
function Rh(e, t) {
    t = (t & 4) !== 0;
    for (var n = 0; n < e.length; n++) {
        var r = e[n]
          , i = r.event;
        r = r.listeners;
        e: {
            var o = void 0;
            if (t)
                for (var s = r.length - 1; 0 <= s; s--) {
                    var l = r[s]
                      , a = l.instance
                      , u = l.currentTarget;
                    if (l = l.listener,
                    a !== o && i.isPropagationStopped())
                        break e;
                    Sc(i, l, u),
                    o = a
                }
            else
                for (s = 0; s < r.length; s++) {
                    if (l = r[s],
                    a = l.instance,
                    u = l.currentTarget,
                    l = l.listener,
                    a !== o && i.isPropagationStopped())
                        break e;
                    Sc(i, l, u),
                    o = a
                }
        }
    }
    if (uo)
        throw e = wl,
        uo = !1,
        wl = null,
        e
}
function U(e, t) {
    var n = t[Al];
    n === void 0 && (n = t[Al] = new Set);
    var r = e + "__bubble";
    n.has(r) || (Lh(t, e, 2, !1),
    n.add(r))
}
function Rs(e, t, n) {
    var r = 0;
    t && (r |= 4),
    Lh(n, e, r, t)
}
var Mi = "_reactListening" + Math.random().toString(36).slice(2);
function Yr(e) {
    if (!e[Mi]) {
        e[Mi] = !0,
        Fd.forEach(function(n) {
            n !== "selectionchange" && (o2.has(n) || Rs(n, !1, e),
            Rs(n, !0, e))
        });
        var t = e.nodeType === 9 ? e : e.ownerDocument;
        t === null || t[Mi] || (t[Mi] = !0,
        Rs("selectionchange", !1, t))
    }
}
function Lh(e, t, n, r) {
    switch (fh(t)) {
    case 1:
        var i = w0;
        break;
    case 4:
        i = x0;
        break;
    default:
        i = Aa
    }
    n = i.bind(null, t, n, e),
    i = void 0,
    !yl || t !== "touchstart" && t !== "touchmove" && t !== "wheel" || (i = !0),
    r ? i !== void 0 ? e.addEventListener(t, n, {
        capture: !0,
        passive: i
    }) : e.addEventListener(t, n, !0) : i !== void 0 ? e.addEventListener(t, n, {
        passive: i
    }) : e.addEventListener(t, n, !1)
}
function Ls(e, t, n, r, i) {
    var o = r;
    if ((t & 1) === 0 && (t & 2) === 0 && r !== null)
        e: for (; ; ) {
            if (r === null)
                return;
            var s = r.tag;
            if (s === 3 || s === 4) {
                var l = r.stateNode.containerInfo;
                if (l === i || l.nodeType === 8 && l.parentNode === i)
                    break;
                if (s === 4)
                    for (s = r.return; s !== null; ) {
                        var a = s.tag;
                        if ((a === 3 || a === 4) && (a = s.stateNode.containerInfo,
                        a === i || a.nodeType === 8 && a.parentNode === i))
                            return;
                        s = s.return
                    }
                for (; l !== null; ) {
                    if (s = ln(l),
                    s === null)
                        return;
                    if (a = s.tag,
                    a === 5 || a === 6) {
                        r = o = s;
                        continue e
                    }
                    l = l.parentNode
                }
            }
            r = r.return
        }
    Xd(function() {
        var u = o
          , c = Ea(n)
          , f = [];
        e: {
            var d = Th.get(e);
            if (d !== void 0) {
                var g = Da
                  , y = e;
                switch (e) {
                case "keypress":
                    if (Qi(n) === 0)
                        break e;
                case "keydown":
                case "keyup":
                    g = F0;
                    break;
                case "focusin":
                    y = "focus",
                    g = Cs;
                    break;
                case "focusout":
                    y = "blur",
                    g = Cs;
                    break;
                case "beforeblur":
                case "afterblur":
                    g = Cs;
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
                    g = cc;
                    break;
                case "drag":
                case "dragend":
                case "dragenter":
                case "dragexit":
                case "dragleave":
                case "dragover":
                case "dragstart":
                case "drop":
                    g = P0;
                    break;
                case "touchcancel":
                case "touchend":
                case "touchmove":
                case "touchstart":
                    g = B0;
                    break;
                case Sh:
                case Ph:
                case kh:
                    g = T0;
                    break;
                case Eh:
                    g = j0;
                    break;
                case "scroll":
                    g = C0;
                    break;
                case "wheel":
                    g = H0;
                    break;
                case "copy":
                case "cut":
                case "paste":
                    g = L0;
                    break;
                case "gotpointercapture":
                case "lostpointercapture":
                case "pointercancel":
                case "pointerdown":
                case "pointermove":
                case "pointerout":
                case "pointerover":
                case "pointerup":
                    g = dc
                }
                var v = (t & 4) !== 0
                  , C = !v && e === "scroll"
                  , p = v ? d !== null ? d + "Capture" : null : d;
                v = [];
                for (var h = u, m; h !== null; ) {
                    m = h;
                    var x = m.stateNode;
                    if (m.tag === 5 && x !== null && (m = x,
                    p !== null && (x = Hr(h, p),
                    x != null && v.push(Gr(h, x, m)))),
                    C)
                        break;
                    h = h.return
                }
                0 < v.length && (d = new g(d,y,null,n,c),
                f.push({
                    event: d,
                    listeners: v
                }))
            }
        }
        if ((t & 7) === 0) {
            e: {
                if (d = e === "mouseover" || e === "pointerover",
                g = e === "mouseout" || e === "pointerout",
                d && n !== gl && (y = n.relatedTarget || n.fromElement) && (ln(y) || y[yt]))
                    break e;
                if ((g || d) && (d = c.window === c ? c : (d = c.ownerDocument) ? d.defaultView || d.parentWindow : window,
                g ? (y = n.relatedTarget || n.toElement,
                g = u,
                y = y ? ln(y) : null,
                y !== null && (C = xn(y),
                y !== C || y.tag !== 5 && y.tag !== 6) && (y = null)) : (g = null,
                y = u),
                g !== y)) {
                    if (v = cc,
                    x = "onMouseLeave",
                    p = "onMouseEnter",
                    h = "mouse",
                    (e === "pointerout" || e === "pointerover") && (v = dc,
                    x = "onPointerLeave",
                    p = "onPointerEnter",
                    h = "pointer"),
                    C = g == null ? d : An(g),
                    m = y == null ? d : An(y),
                    d = new v(x,h + "leave",g,n,c),
                    d.target = C,
                    d.relatedTarget = m,
                    x = null,
                    ln(c) === u && (v = new v(p,h + "enter",y,n,c),
                    v.target = m,
                    v.relatedTarget = C,
                    x = v),
                    C = x,
                    g && y)
                        t: {
                            for (v = g,
                            p = y,
                            h = 0,
                            m = v; m; m = Pn(m))
                                h++;
                            for (m = 0,
                            x = p; x; x = Pn(x))
                                m++;
                            for (; 0 < h - m; )
                                v = Pn(v),
                                h--;
                            for (; 0 < m - h; )
                                p = Pn(p),
                                m--;
                            for (; h--; ) {
                                if (v === p || p !== null && v === p.alternate)
                                    break t;
                                v = Pn(v),
                                p = Pn(p)
                            }
                            v = null
                        }
                    else
                        v = null;
                    g !== null && Pc(f, d, g, v, !1),
                    y !== null && C !== null && Pc(f, C, y, v, !0)
                }
            }
            e: {
                if (d = u ? An(u) : window,
                g = d.nodeName && d.nodeName.toLowerCase(),
                g === "select" || g === "input" && d.type === "file")
                    var S = G0;
                else if (mc(d))
                    if (vh)
                        S = q0;
                    else {
                        S = X0;
                        var T = Z0
                    }
                else
                    (g = d.nodeName) && g.toLowerCase() === "input" && (d.type === "checkbox" || d.type === "radio") && (S = J0);
                if (S && (S = S(e, u))) {
                    gh(f, S, n, c);
                    break e
                }
                T && T(e, d, u),
                e === "focusout" && (T = d._wrapperState) && T.controlled && d.type === "number" && fl(d, "number", d.value)
            }
            switch (T = u ? An(u) : window,
            e) {
            case "focusin":
                (mc(T) || T.contentEditable === "true") && (Rn = T,
                Pl = u,
                Mr = null);
                break;
            case "focusout":
                Mr = Pl = Rn = null;
                break;
            case "mousedown":
                kl = !0;
                break;
            case "contextmenu":
            case "mouseup":
            case "dragend":
                kl = !1,
                xc(f, n, c);
                break;
            case "selectionchange":
                if (n2)
                    break;
            case "keydown":
            case "keyup":
                xc(f, n, c)
            }
            var R;
            if (Va)
                e: {
                    switch (e) {
                    case "compositionstart":
                        var k = "onCompositionStart";
                        break e;
                    case "compositionend":
                        k = "onCompositionEnd";
                        break e;
                    case "compositionupdate":
                        k = "onCompositionUpdate";
                        break e
                    }
                    k = void 0
                }
            else
                Tn ? ph(e, n) && (k = "onCompositionEnd") : e === "keydown" && n.keyCode === 229 && (k = "onCompositionStart");
            k && (hh && n.locale !== "ko" && (Tn || k !== "onCompositionStart" ? k === "onCompositionEnd" && Tn && (R = dh()) : (Mt = c,
            Na = "value"in Mt ? Mt.value : Mt.textContent,
            Tn = !0)),
            T = mo(u, k),
            0 < T.length && (k = new fc(k,e,null,n,c),
            f.push({
                event: k,
                listeners: T
            }),
            R ? k.data = R : (R = mh(n),
            R !== null && (k.data = R)))),
            (R = W0 ? b0(e, n) : K0(e, n)) && (u = mo(u, "onBeforeInput"),
            0 < u.length && (c = new fc("onBeforeInput","beforeinput",null,n,c),
            f.push({
                event: c,
                listeners: u
            }),
            c.data = R))
        }
        Rh(f, t)
    })
}
function Gr(e, t, n) {
    return {
        instance: e,
        listener: t,
        currentTarget: n
    }
}
function mo(e, t) {
    for (var n = t + "Capture", r = []; e !== null; ) {
        var i = e
          , o = i.stateNode;
        i.tag === 5 && o !== null && (i = o,
        o = Hr(e, n),
        o != null && r.unshift(Gr(e, o, i)),
        o = Hr(e, t),
        o != null && r.push(Gr(e, o, i))),
        e = e.return
    }
    return r
}
function Pn(e) {
    if (e === null)
        return null;
    do
        e = e.return;
    while (e && e.tag !== 5);
    return e || null
}
function Pc(e, t, n, r, i) {
    for (var o = t._reactName, s = []; n !== null && n !== r; ) {
        var l = n
          , a = l.alternate
          , u = l.stateNode;
        if (a !== null && a === r)
            break;
        l.tag === 5 && u !== null && (l = u,
        i ? (a = Hr(n, o),
        a != null && s.unshift(Gr(n, a, l))) : i || (a = Hr(n, o),
        a != null && s.push(Gr(n, a, l)))),
        n = n.return
    }
    s.length !== 0 && e.push({
        event: t,
        listeners: s
    })
}
var s2 = /\r\n?/g
  , l2 = /\u0000|\uFFFD/g;
function kc(e) {
    return (typeof e == "string" ? e : "" + e).replace(s2, `
`).replace(l2, "")
}
function Vi(e, t, n) {
    if (t = kc(t),
    kc(e) !== t && n)
        throw Error(E(425))
}
function go() {}
var El = null
  , Tl = null;
function Rl(e, t) {
    return e === "textarea" || e === "noscript" || typeof t.children == "string" || typeof t.children == "number" || typeof t.dangerouslySetInnerHTML == "object" && t.dangerouslySetInnerHTML !== null && t.dangerouslySetInnerHTML.__html != null
}
var Ll = typeof setTimeout == "function" ? setTimeout : void 0
  , a2 = typeof clearTimeout == "function" ? clearTimeout : void 0
  , Ec = typeof Promise == "function" ? Promise : void 0
  , u2 = typeof queueMicrotask == "function" ? queueMicrotask : typeof Ec < "u" ? function(e) {
    return Ec.resolve(null).then(e).catch(c2)
}
: Ll;
function c2(e) {
    setTimeout(function() {
        throw e
    })
}
function As(e, t) {
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
                    br(t);
                    return
                }
                r--
            } else
                n !== "$" && n !== "$?" && n !== "$!" || r++;
        n = i
    } while (n);
    br(t)
}
function _t(e) {
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
function Tc(e) {
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
var or = Math.random().toString(36).slice(2)
  , tt = "__reactFiber$" + or
  , Zr = "__reactProps$" + or
  , yt = "__reactContainer$" + or
  , Al = "__reactEvents$" + or
  , f2 = "__reactListeners$" + or
  , d2 = "__reactHandles$" + or;
function ln(e) {
    var t = e[tt];
    if (t)
        return t;
    for (var n = e.parentNode; n; ) {
        if (t = n[yt] || n[tt]) {
            if (n = t.alternate,
            t.child !== null || n !== null && n.child !== null)
                for (e = Tc(e); e !== null; ) {
                    if (n = e[tt])
                        return n;
                    e = Tc(e)
                }
            return t
        }
        e = n,
        n = e.parentNode
    }
    return null
}
function fi(e) {
    return e = e[tt] || e[yt],
    !e || e.tag !== 5 && e.tag !== 6 && e.tag !== 13 && e.tag !== 3 ? null : e
}
function An(e) {
    if (e.tag === 5 || e.tag === 6)
        return e.stateNode;
    throw Error(E(33))
}
function bo(e) {
    return e[Zr] || null
}
var Nl = []
  , Nn = -1;
function Gt(e) {
    return {
        current: e
    }
}
function H(e) {
    0 > Nn || (e.current = Nl[Nn],
    Nl[Nn] = null,
    Nn--)
}
function j(e, t) {
    Nn++,
    Nl[Nn] = e.current,
    e.current = t
}
var bt = {}
  , we = Gt(bt)
  , Te = Gt(!1)
  , pn = bt;
function Yn(e, t) {
    var n = e.type.contextTypes;
    if (!n)
        return bt;
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
function Re(e) {
    return e = e.childContextTypes,
    e != null
}
function vo() {
    H(Te),
    H(we)
}
function Rc(e, t, n) {
    if (we.current !== bt)
        throw Error(E(168));
    j(we, t),
    j(Te, n)
}
function Ah(e, t, n) {
    var r = e.stateNode;
    if (t = t.childContextTypes,
    typeof r.getChildContext != "function")
        return n;
    r = r.getChildContext();
    for (var i in r)
        if (!(i in t))
            throw Error(E(108, Zm(e) || "Unknown", i));
    return Y({}, n, r)
}
function yo(e) {
    return e = (e = e.stateNode) && e.__reactInternalMemoizedMergedChildContext || bt,
    pn = we.current,
    j(we, e),
    j(Te, Te.current),
    !0
}
function Lc(e, t, n) {
    var r = e.stateNode;
    if (!r)
        throw Error(E(169));
    n ? (e = Ah(e, t, pn),
    r.__reactInternalMemoizedMergedChildContext = e,
    H(Te),
    H(we),
    j(we, e)) : H(Te),
    j(Te, n)
}
var ut = null
  , Ko = !1
  , Ns = !1;
function Nh(e) {
    ut === null ? ut = [e] : ut.push(e)
}
function h2(e) {
    Ko = !0,
    Nh(e)
}
function Zt() {
    if (!Ns && ut !== null) {
        Ns = !0;
        var e = 0
          , t = B;
        try {
            var n = ut;
            for (B = 1; e < n.length; e++) {
                var r = n[e];
                do
                    r = r(!0);
                while (r !== null)
            }
            ut = null,
            Ko = !1
        } catch (i) {
            throw ut !== null && (ut = ut.slice(e + 1)),
            th(Ta, Zt),
            i
        } finally {
            B = t,
            Ns = !1
        }
    }
    return null
}
var Dn = []
  , Mn = 0
  , wo = null
  , xo = 0
  , Be = []
  , ze = 0
  , mn = null
  , ct = 1
  , ft = "";
function nn(e, t) {
    Dn[Mn++] = xo,
    Dn[Mn++] = wo,
    wo = e,
    xo = t
}
function Dh(e, t, n) {
    Be[ze++] = ct,
    Be[ze++] = ft,
    Be[ze++] = mn,
    mn = e;
    var r = ct;
    e = ft;
    var i = 32 - Ze(r) - 1;
    r &= ~(1 << i),
    n += 1;
    var o = 32 - Ze(t) + i;
    if (30 < o) {
        var s = i - i % 5;
        o = (r & (1 << s) - 1).toString(32),
        r >>= s,
        i -= s,
        ct = 1 << 32 - Ze(t) + i | n << i | r,
        ft = o + e
    } else
        ct = 1 << o | n << i | r,
        ft = e
}
function Fa(e) {
    e.return !== null && (nn(e, 1),
    Dh(e, 1, 0))
}
function Ia(e) {
    for (; e === wo; )
        wo = Dn[--Mn],
        Dn[Mn] = null,
        xo = Dn[--Mn],
        Dn[Mn] = null;
    for (; e === mn; )
        mn = Be[--ze],
        Be[ze] = null,
        ft = Be[--ze],
        Be[ze] = null,
        ct = Be[--ze],
        Be[ze] = null
}
var De = null
  , Ne = null
  , $ = !1
  , Ge = null;
function Mh(e, t) {
    var n = Ue(5, null, null, 0);
    n.elementType = "DELETED",
    n.stateNode = t,
    n.return = e,
    t = e.deletions,
    t === null ? (e.deletions = [n],
    e.flags |= 16) : t.push(n)
}
function Ac(e, t) {
    switch (e.tag) {
    case 5:
        var n = e.type;
        return t = t.nodeType !== 1 || n.toLowerCase() !== t.nodeName.toLowerCase() ? null : t,
        t !== null ? (e.stateNode = t,
        De = e,
        Ne = _t(t.firstChild),
        !0) : !1;
    case 6:
        return t = e.pendingProps === "" || t.nodeType !== 3 ? null : t,
        t !== null ? (e.stateNode = t,
        De = e,
        Ne = null,
        !0) : !1;
    case 13:
        return t = t.nodeType !== 8 ? null : t,
        t !== null ? (n = mn !== null ? {
            id: ct,
            overflow: ft
        } : null,
        e.memoizedState = {
            dehydrated: t,
            treeContext: n,
            retryLane: 1073741824
        },
        n = Ue(18, null, null, 0),
        n.stateNode = t,
        n.return = e,
        e.child = n,
        De = e,
        Ne = null,
        !0) : !1;
    default:
        return !1
    }
}
function Dl(e) {
    return (e.mode & 1) !== 0 && (e.flags & 128) === 0
}
function Ml(e) {
    if ($) {
        var t = Ne;
        if (t) {
            var n = t;
            if (!Ac(e, t)) {
                if (Dl(e))
                    throw Error(E(418));
                t = _t(n.nextSibling);
                var r = De;
                t && Ac(e, t) ? Mh(r, n) : (e.flags = e.flags & -4097 | 2,
                $ = !1,
                De = e)
            }
        } else {
            if (Dl(e))
                throw Error(E(418));
            e.flags = e.flags & -4097 | 2,
            $ = !1,
            De = e
        }
    }
}
function Nc(e) {
    for (e = e.return; e !== null && e.tag !== 5 && e.tag !== 3 && e.tag !== 13; )
        e = e.return;
    De = e
}
function Oi(e) {
    if (e !== De)
        return !1;
    if (!$)
        return Nc(e),
        $ = !0,
        !1;
    var t;
    if ((t = e.tag !== 3) && !(t = e.tag !== 5) && (t = e.type,
    t = t !== "head" && t !== "body" && !Rl(e.type, e.memoizedProps)),
    t && (t = Ne)) {
        if (Dl(e))
            throw Vh(),
            Error(E(418));
        for (; t; )
            Mh(e, t),
            t = _t(t.nextSibling)
    }
    if (Nc(e),
    e.tag === 13) {
        if (e = e.memoizedState,
        e = e !== null ? e.dehydrated : null,
        !e)
            throw Error(E(317));
        e: {
            for (e = e.nextSibling,
            t = 0; e; ) {
                if (e.nodeType === 8) {
                    var n = e.data;
                    if (n === "/$") {
                        if (t === 0) {
                            Ne = _t(e.nextSibling);
                            break e
                        }
                        t--
                    } else
                        n !== "$" && n !== "$!" && n !== "$?" || t++
                }
                e = e.nextSibling
            }
            Ne = null
        }
    } else
        Ne = De ? _t(e.stateNode.nextSibling) : null;
    return !0
}
function Vh() {
    for (var e = Ne; e; )
        e = _t(e.nextSibling)
}
function Gn() {
    Ne = De = null,
    $ = !1
}
function _a(e) {
    Ge === null ? Ge = [e] : Ge.push(e)
}
var p2 = Pt.ReactCurrentBatchConfig;
function Qe(e, t) {
    if (e && e.defaultProps) {
        t = Y({}, t),
        e = e.defaultProps;
        for (var n in e)
            t[n] === void 0 && (t[n] = e[n]);
        return t
    }
    return t
}
var Co = Gt(null)
  , So = null
  , Vn = null
  , Ba = null;
function za() {
    Ba = Vn = So = null
}
function ja(e) {
    var t = Co.current;
    H(Co),
    e._currentValue = t
}
function Vl(e, t, n) {
    for (; e !== null; ) {
        var r = e.alternate;
        if ((e.childLanes & t) !== t ? (e.childLanes |= t,
        r !== null && (r.childLanes |= t)) : r !== null && (r.childLanes & t) !== t && (r.childLanes |= t),
        e === n)
            break;
        e = e.return
    }
}
function bn(e, t) {
    So = e,
    Ba = Vn = null,
    e = e.dependencies,
    e !== null && e.firstContext !== null && ((e.lanes & t) !== 0 && (Ee = !0),
    e.firstContext = null)
}
function $e(e) {
    var t = e._currentValue;
    if (Ba !== e)
        if (e = {
            context: e,
            memoizedValue: t,
            next: null
        },
        Vn === null) {
            if (So === null)
                throw Error(E(308));
            Vn = e,
            So.dependencies = {
                lanes: 0,
                firstContext: e
            }
        } else
            Vn = Vn.next = e;
    return t
}
var an = null;
function Ua(e) {
    an === null ? an = [e] : an.push(e)
}
function Oh(e, t, n, r) {
    var i = t.interleaved;
    return i === null ? (n.next = n,
    Ua(t)) : (n.next = i.next,
    i.next = n),
    t.interleaved = n,
    wt(e, r)
}
function wt(e, t) {
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
var At = !1;
function Ha(e) {
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
function Fh(e, t) {
    e = e.updateQueue,
    t.updateQueue === e && (t.updateQueue = {
        baseState: e.baseState,
        firstBaseUpdate: e.firstBaseUpdate,
        lastBaseUpdate: e.lastBaseUpdate,
        shared: e.shared,
        effects: e.effects
    })
}
function ht(e, t) {
    return {
        eventTime: e,
        lane: t,
        tag: 0,
        payload: null,
        callback: null,
        next: null
    }
}
function Bt(e, t, n) {
    var r = e.updateQueue;
    if (r === null)
        return null;
    if (r = r.shared,
    (_ & 2) !== 0) {
        var i = r.pending;
        return i === null ? t.next = t : (t.next = i.next,
        i.next = t),
        r.pending = t,
        wt(e, n)
    }
    return i = r.interleaved,
    i === null ? (t.next = t,
    Ua(r)) : (t.next = i.next,
    i.next = t),
    r.interleaved = t,
    wt(e, n)
}
function Yi(e, t, n) {
    if (t = t.updateQueue,
    t !== null && (t = t.shared,
    (n & 4194240) !== 0)) {
        var r = t.lanes;
        r &= e.pendingLanes,
        n |= r,
        t.lanes = n,
        Ra(e, n)
    }
}
function Dc(e, t) {
    var n = e.updateQueue
      , r = e.alternate;
    if (r !== null && (r = r.updateQueue,
    n === r)) {
        var i = null
          , o = null;
        if (n = n.firstBaseUpdate,
        n !== null) {
            do {
                var s = {
                    eventTime: n.eventTime,
                    lane: n.lane,
                    tag: n.tag,
                    payload: n.payload,
                    callback: n.callback,
                    next: null
                };
                o === null ? i = o = s : o = o.next = s,
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
function Po(e, t, n, r) {
    var i = e.updateQueue;
    At = !1;
    var o = i.firstBaseUpdate
      , s = i.lastBaseUpdate
      , l = i.shared.pending;
    if (l !== null) {
        i.shared.pending = null;
        var a = l
          , u = a.next;
        a.next = null,
        s === null ? o = u : s.next = u,
        s = a;
        var c = e.alternate;
        c !== null && (c = c.updateQueue,
        l = c.lastBaseUpdate,
        l !== s && (l === null ? c.firstBaseUpdate = u : l.next = u,
        c.lastBaseUpdate = a))
    }
    if (o !== null) {
        var f = i.baseState;
        s = 0,
        c = u = a = null,
        l = o;
        do {
            var d = l.lane
              , g = l.eventTime;
            if ((r & d) === d) {
                c !== null && (c = c.next = {
                    eventTime: g,
                    lane: 0,
                    tag: l.tag,
                    payload: l.payload,
                    callback: l.callback,
                    next: null
                });
                e: {
                    var y = e
                      , v = l;
                    switch (d = t,
                    g = n,
                    v.tag) {
                    case 1:
                        if (y = v.payload,
                        typeof y == "function") {
                            f = y.call(g, f, d);
                            break e
                        }
                        f = y;
                        break e;
                    case 3:
                        y.flags = y.flags & -65537 | 128;
                    case 0:
                        if (y = v.payload,
                        d = typeof y == "function" ? y.call(g, f, d) : y,
                        d == null)
                            break e;
                        f = Y({}, f, d);
                        break e;
                    case 2:
                        At = !0
                    }
                }
                l.callback !== null && l.lane !== 0 && (e.flags |= 64,
                d = i.effects,
                d === null ? i.effects = [l] : d.push(l))
            } else
                g = {
                    eventTime: g,
                    lane: d,
                    tag: l.tag,
                    payload: l.payload,
                    callback: l.callback,
                    next: null
                },
                c === null ? (u = c = g,
                a = f) : c = c.next = g,
                s |= d;
            if (l = l.next,
            l === null) {
                if (l = i.shared.pending,
                l === null)
                    break;
                d = l,
                l = d.next,
                d.next = null,
                i.lastBaseUpdate = d,
                i.shared.pending = null
            }
        } while (1);
        if (c === null && (a = f),
        i.baseState = a,
        i.firstBaseUpdate = u,
        i.lastBaseUpdate = c,
        t = i.shared.interleaved,
        t !== null) {
            i = t;
            do
                s |= i.lane,
                i = i.next;
            while (i !== t)
        } else
            o === null && (i.shared.lanes = 0);
        vn |= s,
        e.lanes = s,
        e.memoizedState = f
    }
}
function Mc(e, t, n) {
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
                    throw Error(E(191, i));
                i.call(r)
            }
        }
}
var Ih = new Od.Component().refs;
function Ol(e, t, n, r) {
    t = e.memoizedState,
    n = n(r, t),
    n = n == null ? t : Y({}, t, n),
    e.memoizedState = n,
    e.lanes === 0 && (e.updateQueue.baseState = n)
}
var Qo = {
    isMounted: function(e) {
        return (e = e._reactInternals) ? xn(e) === e : !1
    },
    enqueueSetState: function(e, t, n) {
        e = e._reactInternals;
        var r = Ce()
          , i = jt(e)
          , o = ht(r, i);
        o.payload = t,
        n != null && (o.callback = n),
        t = Bt(e, o, i),
        t !== null && (Xe(t, e, i, r),
        Yi(t, e, i))
    },
    enqueueReplaceState: function(e, t, n) {
        e = e._reactInternals;
        var r = Ce()
          , i = jt(e)
          , o = ht(r, i);
        o.tag = 1,
        o.payload = t,
        n != null && (o.callback = n),
        t = Bt(e, o, i),
        t !== null && (Xe(t, e, i, r),
        Yi(t, e, i))
    },
    enqueueForceUpdate: function(e, t) {
        e = e._reactInternals;
        var n = Ce()
          , r = jt(e)
          , i = ht(n, r);
        i.tag = 2,
        t != null && (i.callback = t),
        t = Bt(e, i, r),
        t !== null && (Xe(t, e, r, n),
        Yi(t, e, r))
    }
};
function Vc(e, t, n, r, i, o, s) {
    return e = e.stateNode,
    typeof e.shouldComponentUpdate == "function" ? e.shouldComponentUpdate(r, o, s) : t.prototype && t.prototype.isPureReactComponent ? !Qr(n, r) || !Qr(i, o) : !0
}
function _h(e, t, n) {
    var r = !1
      , i = bt
      , o = t.contextType;
    return typeof o == "object" && o !== null ? o = $e(o) : (i = Re(t) ? pn : we.current,
    r = t.contextTypes,
    o = (r = r != null) ? Yn(e, i) : bt),
    t = new t(n,o),
    e.memoizedState = t.state !== null && t.state !== void 0 ? t.state : null,
    t.updater = Qo,
    e.stateNode = t,
    t._reactInternals = e,
    r && (e = e.stateNode,
    e.__reactInternalMemoizedUnmaskedChildContext = i,
    e.__reactInternalMemoizedMaskedChildContext = o),
    t
}
function Oc(e, t, n, r) {
    e = t.state,
    typeof t.componentWillReceiveProps == "function" && t.componentWillReceiveProps(n, r),
    typeof t.UNSAFE_componentWillReceiveProps == "function" && t.UNSAFE_componentWillReceiveProps(n, r),
    t.state !== e && Qo.enqueueReplaceState(t, t.state, null)
}
function Fl(e, t, n, r) {
    var i = e.stateNode;
    i.props = n,
    i.state = e.memoizedState,
    i.refs = Ih,
    Ha(e);
    var o = t.contextType;
    typeof o == "object" && o !== null ? i.context = $e(o) : (o = Re(t) ? pn : we.current,
    i.context = Yn(e, o)),
    i.state = e.memoizedState,
    o = t.getDerivedStateFromProps,
    typeof o == "function" && (Ol(e, t, o, n),
    i.state = e.memoizedState),
    typeof t.getDerivedStateFromProps == "function" || typeof i.getSnapshotBeforeUpdate == "function" || typeof i.UNSAFE_componentWillMount != "function" && typeof i.componentWillMount != "function" || (t = i.state,
    typeof i.componentWillMount == "function" && i.componentWillMount(),
    typeof i.UNSAFE_componentWillMount == "function" && i.UNSAFE_componentWillMount(),
    t !== i.state && Qo.enqueueReplaceState(i, i.state, null),
    Po(e, n, i, r),
    i.state = e.memoizedState),
    typeof i.componentDidMount == "function" && (e.flags |= 4194308)
}
function mr(e, t, n) {
    if (e = n.ref,
    e !== null && typeof e != "function" && typeof e != "object") {
        if (n._owner) {
            if (n = n._owner,
            n) {
                if (n.tag !== 1)
                    throw Error(E(309));
                var r = n.stateNode
            }
            if (!r)
                throw Error(E(147, e));
            var i = r
              , o = "" + e;
            return t !== null && t.ref !== null && typeof t.ref == "function" && t.ref._stringRef === o ? t.ref : (t = function(s) {
                var l = i.refs;
                l === Ih && (l = i.refs = {}),
                s === null ? delete l[o] : l[o] = s
            }
            ,
            t._stringRef = o,
            t)
        }
        if (typeof e != "string")
            throw Error(E(284));
        if (!n._owner)
            throw Error(E(290, e))
    }
    return e
}
function Fi(e, t) {
    throw e = Object.prototype.toString.call(t),
    Error(E(31, e === "[object Object]" ? "object with keys {" + Object.keys(t).join(", ") + "}" : e))
}
function Fc(e) {
    var t = e._init;
    return t(e._payload)
}
function Bh(e) {
    function t(p, h) {
        if (e) {
            var m = p.deletions;
            m === null ? (p.deletions = [h],
            p.flags |= 16) : m.push(h)
        }
    }
    function n(p, h) {
        if (!e)
            return null;
        for (; h !== null; )
            t(p, h),
            h = h.sibling;
        return null
    }
    function r(p, h) {
        for (p = new Map; h !== null; )
            h.key !== null ? p.set(h.key, h) : p.set(h.index, h),
            h = h.sibling;
        return p
    }
    function i(p, h) {
        return p = Ut(p, h),
        p.index = 0,
        p.sibling = null,
        p
    }
    function o(p, h, m) {
        return p.index = m,
        e ? (m = p.alternate,
        m !== null ? (m = m.index,
        m < h ? (p.flags |= 2,
        h) : m) : (p.flags |= 2,
        h)) : (p.flags |= 1048576,
        h)
    }
    function s(p) {
        return e && p.alternate === null && (p.flags |= 2),
        p
    }
    function l(p, h, m, x) {
        return h === null || h.tag !== 6 ? (h = _s(m, p.mode, x),
        h.return = p,
        h) : (h = i(h, m),
        h.return = p,
        h)
    }
    function a(p, h, m, x) {
        var S = m.type;
        return S === En ? c(p, h, m.props.children, x, m.key) : h !== null && (h.elementType === S || typeof S == "object" && S !== null && S.$$typeof === Lt && Fc(S) === h.type) ? (x = i(h, m.props),
        x.ref = mr(p, h, m),
        x.return = p,
        x) : (x = eo(m.type, m.key, m.props, null, p.mode, x),
        x.ref = mr(p, h, m),
        x.return = p,
        x)
    }
    function u(p, h, m, x) {
        return h === null || h.tag !== 4 || h.stateNode.containerInfo !== m.containerInfo || h.stateNode.implementation !== m.implementation ? (h = Bs(m, p.mode, x),
        h.return = p,
        h) : (h = i(h, m.children || []),
        h.return = p,
        h)
    }
    function c(p, h, m, x, S) {
        return h === null || h.tag !== 7 ? (h = dn(m, p.mode, x, S),
        h.return = p,
        h) : (h = i(h, m),
        h.return = p,
        h)
    }
    function f(p, h, m) {
        if (typeof h == "string" && h !== "" || typeof h == "number")
            return h = _s("" + h, p.mode, m),
            h.return = p,
            h;
        if (typeof h == "object" && h !== null) {
            switch (h.$$typeof) {
            case ki:
                return m = eo(h.type, h.key, h.props, null, p.mode, m),
                m.ref = mr(p, null, h),
                m.return = p,
                m;
            case kn:
                return h = Bs(h, p.mode, m),
                h.return = p,
                h;
            case Lt:
                var x = h._init;
                return f(p, x(h._payload), m)
            }
            if (Sr(h) || cr(h))
                return h = dn(h, p.mode, m, null),
                h.return = p,
                h;
            Fi(p, h)
        }
        return null
    }
    function d(p, h, m, x) {
        var S = h !== null ? h.key : null;
        if (typeof m == "string" && m !== "" || typeof m == "number")
            return S !== null ? null : l(p, h, "" + m, x);
        if (typeof m == "object" && m !== null) {
            switch (m.$$typeof) {
            case ki:
                return m.key === S ? a(p, h, m, x) : null;
            case kn:
                return m.key === S ? u(p, h, m, x) : null;
            case Lt:
                return S = m._init,
                d(p, h, S(m._payload), x)
            }
            if (Sr(m) || cr(m))
                return S !== null ? null : c(p, h, m, x, null);
            Fi(p, m)
        }
        return null
    }
    function g(p, h, m, x, S) {
        if (typeof x == "string" && x !== "" || typeof x == "number")
            return p = p.get(m) || null,
            l(h, p, "" + x, S);
        if (typeof x == "object" && x !== null) {
            switch (x.$$typeof) {
            case ki:
                return p = p.get(x.key === null ? m : x.key) || null,
                a(h, p, x, S);
            case kn:
                return p = p.get(x.key === null ? m : x.key) || null,
                u(h, p, x, S);
            case Lt:
                var T = x._init;
                return g(p, h, m, T(x._payload), S)
            }
            if (Sr(x) || cr(x))
                return p = p.get(m) || null,
                c(h, p, x, S, null);
            Fi(h, x)
        }
        return null
    }
    function y(p, h, m, x) {
        for (var S = null, T = null, R = h, k = h = 0, V = null; R !== null && k < m.length; k++) {
            R.index > k ? (V = R,
            R = null) : V = R.sibling;
            var D = d(p, R, m[k], x);
            if (D === null) {
                R === null && (R = V);
                break
            }
            e && R && D.alternate === null && t(p, R),
            h = o(D, h, k),
            T === null ? S = D : T.sibling = D,
            T = D,
            R = V
        }
        if (k === m.length)
            return n(p, R),
            $ && nn(p, k),
            S;
        if (R === null) {
            for (; k < m.length; k++)
                R = f(p, m[k], x),
                R !== null && (h = o(R, h, k),
                T === null ? S = R : T.sibling = R,
                T = R);
            return $ && nn(p, k),
            S
        }
        for (R = r(p, R); k < m.length; k++)
            V = g(R, p, k, m[k], x),
            V !== null && (e && V.alternate !== null && R.delete(V.key === null ? k : V.key),
            h = o(V, h, k),
            T === null ? S = V : T.sibling = V,
            T = V);
        return e && R.forEach(function(X) {
            return t(p, X)
        }),
        $ && nn(p, k),
        S
    }
    function v(p, h, m, x) {
        var S = cr(m);
        if (typeof S != "function")
            throw Error(E(150));
        if (m = S.call(m),
        m == null)
            throw Error(E(151));
        for (var T = S = null, R = h, k = h = 0, V = null, D = m.next(); R !== null && !D.done; k++,
        D = m.next()) {
            R.index > k ? (V = R,
            R = null) : V = R.sibling;
            var X = d(p, R, D.value, x);
            if (X === null) {
                R === null && (R = V);
                break
            }
            e && R && X.alternate === null && t(p, R),
            h = o(X, h, k),
            T === null ? S = X : T.sibling = X,
            T = X,
            R = V
        }
        if (D.done)
            return n(p, R),
            $ && nn(p, k),
            S;
        if (R === null) {
            for (; !D.done; k++,
            D = m.next())
                D = f(p, D.value, x),
                D !== null && (h = o(D, h, k),
                T === null ? S = D : T.sibling = D,
                T = D);
            return $ && nn(p, k),
            S
        }
        for (R = r(p, R); !D.done; k++,
        D = m.next())
            D = g(R, p, k, D.value, x),
            D !== null && (e && D.alternate !== null && R.delete(D.key === null ? k : D.key),
            h = o(D, h, k),
            T === null ? S = D : T.sibling = D,
            T = D);
        return e && R.forEach(function(Et) {
            return t(p, Et)
        }),
        $ && nn(p, k),
        S
    }
    function C(p, h, m, x) {
        if (typeof m == "object" && m !== null && m.type === En && m.key === null && (m = m.props.children),
        typeof m == "object" && m !== null) {
            switch (m.$$typeof) {
            case ki:
                e: {
                    for (var S = m.key, T = h; T !== null; ) {
                        if (T.key === S) {
                            if (S = m.type,
                            S === En) {
                                if (T.tag === 7) {
                                    n(p, T.sibling),
                                    h = i(T, m.props.children),
                                    h.return = p,
                                    p = h;
                                    break e
                                }
                            } else if (T.elementType === S || typeof S == "object" && S !== null && S.$$typeof === Lt && Fc(S) === T.type) {
                                n(p, T.sibling),
                                h = i(T, m.props),
                                h.ref = mr(p, T, m),
                                h.return = p,
                                p = h;
                                break e
                            }
                            n(p, T);
                            break
                        } else
                            t(p, T);
                        T = T.sibling
                    }
                    m.type === En ? (h = dn(m.props.children, p.mode, x, m.key),
                    h.return = p,
                    p = h) : (x = eo(m.type, m.key, m.props, null, p.mode, x),
                    x.ref = mr(p, h, m),
                    x.return = p,
                    p = x)
                }
                return s(p);
            case kn:
                e: {
                    for (T = m.key; h !== null; ) {
                        if (h.key === T)
                            if (h.tag === 4 && h.stateNode.containerInfo === m.containerInfo && h.stateNode.implementation === m.implementation) {
                                n(p, h.sibling),
                                h = i(h, m.children || []),
                                h.return = p,
                                p = h;
                                break e
                            } else {
                                n(p, h);
                                break
                            }
                        else
                            t(p, h);
                        h = h.sibling
                    }
                    h = Bs(m, p.mode, x),
                    h.return = p,
                    p = h
                }
                return s(p);
            case Lt:
                return T = m._init,
                C(p, h, T(m._payload), x)
            }
            if (Sr(m))
                return y(p, h, m, x);
            if (cr(m))
                return v(p, h, m, x);
            Fi(p, m)
        }
        return typeof m == "string" && m !== "" || typeof m == "number" ? (m = "" + m,
        h !== null && h.tag === 6 ? (n(p, h.sibling),
        h = i(h, m),
        h.return = p,
        p = h) : (n(p, h),
        h = _s(m, p.mode, x),
        h.return = p,
        p = h),
        s(p)) : n(p, h)
    }
    return C
}
var Zn = Bh(!0)
  , zh = Bh(!1)
  , di = {}
  , rt = Gt(di)
  , Xr = Gt(di)
  , Jr = Gt(di);
function un(e) {
    if (e === di)
        throw Error(E(174));
    return e
}
function $a(e, t) {
    switch (j(Jr, t),
    j(Xr, e),
    j(rt, di),
    e = t.nodeType,
    e) {
    case 9:
    case 11:
        t = (t = t.documentElement) ? t.namespaceURI : hl(null, "");
        break;
    default:
        e = e === 8 ? t.parentNode : t,
        t = e.namespaceURI || null,
        e = e.tagName,
        t = hl(t, e)
    }
    H(rt),
    j(rt, t)
}
function Xn() {
    H(rt),
    H(Xr),
    H(Jr)
}
function jh(e) {
    un(Jr.current);
    var t = un(rt.current)
      , n = hl(t, e.type);
    t !== n && (j(Xr, e),
    j(rt, n))
}
function Wa(e) {
    Xr.current === e && (H(rt),
    H(Xr))
}
var W = Gt(0);
function ko(e) {
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
var Ds = [];
function ba() {
    for (var e = 0; e < Ds.length; e++)
        Ds[e]._workInProgressVersionPrimary = null;
    Ds.length = 0
}
var Gi = Pt.ReactCurrentDispatcher
  , Ms = Pt.ReactCurrentBatchConfig
  , gn = 0
  , K = null
  , re = null
  , se = null
  , Eo = !1
  , Vr = !1
  , qr = 0
  , m2 = 0;
function he() {
    throw Error(E(321))
}
function Ka(e, t) {
    if (t === null)
        return !1;
    for (var n = 0; n < t.length && n < e.length; n++)
        if (!Je(e[n], t[n]))
            return !1;
    return !0
}
function Qa(e, t, n, r, i, o) {
    if (gn = o,
    K = t,
    t.memoizedState = null,
    t.updateQueue = null,
    t.lanes = 0,
    Gi.current = e === null || e.memoizedState === null ? w2 : x2,
    e = n(r, i),
    Vr) {
        o = 0;
        do {
            if (Vr = !1,
            qr = 0,
            25 <= o)
                throw Error(E(301));
            o += 1,
            se = re = null,
            t.updateQueue = null,
            Gi.current = C2,
            e = n(r, i)
        } while (Vr)
    }
    if (Gi.current = To,
    t = re !== null && re.next !== null,
    gn = 0,
    se = re = K = null,
    Eo = !1,
    t)
        throw Error(E(300));
    return e
}
function Ya() {
    var e = qr !== 0;
    return qr = 0,
    e
}
function et() {
    var e = {
        memoizedState: null,
        baseState: null,
        baseQueue: null,
        queue: null,
        next: null
    };
    return se === null ? K.memoizedState = se = e : se = se.next = e,
    se
}
function We() {
    if (re === null) {
        var e = K.alternate;
        e = e !== null ? e.memoizedState : null
    } else
        e = re.next;
    var t = se === null ? K.memoizedState : se.next;
    if (t !== null)
        se = t,
        re = e;
    else {
        if (e === null)
            throw Error(E(310));
        re = e,
        e = {
            memoizedState: re.memoizedState,
            baseState: re.baseState,
            baseQueue: re.baseQueue,
            queue: re.queue,
            next: null
        },
        se === null ? K.memoizedState = se = e : se = se.next = e
    }
    return se
}
function ei(e, t) {
    return typeof t == "function" ? t(e) : t
}
function Vs(e) {
    var t = We()
      , n = t.queue;
    if (n === null)
        throw Error(E(311));
    n.lastRenderedReducer = e;
    var r = re
      , i = r.baseQueue
      , o = n.pending;
    if (o !== null) {
        if (i !== null) {
            var s = i.next;
            i.next = o.next,
            o.next = s
        }
        r.baseQueue = i = o,
        n.pending = null
    }
    if (i !== null) {
        o = i.next,
        r = r.baseState;
        var l = s = null
          , a = null
          , u = o;
        do {
            var c = u.lane;
            if ((gn & c) === c)
                a !== null && (a = a.next = {
                    lane: 0,
                    action: u.action,
                    hasEagerState: u.hasEagerState,
                    eagerState: u.eagerState,
                    next: null
                }),
                r = u.hasEagerState ? u.eagerState : e(r, u.action);
            else {
                var f = {
                    lane: c,
                    action: u.action,
                    hasEagerState: u.hasEagerState,
                    eagerState: u.eagerState,
                    next: null
                };
                a === null ? (l = a = f,
                s = r) : a = a.next = f,
                K.lanes |= c,
                vn |= c
            }
            u = u.next
        } while (u !== null && u !== o);
        a === null ? s = r : a.next = l,
        Je(r, t.memoizedState) || (Ee = !0),
        t.memoizedState = r,
        t.baseState = s,
        t.baseQueue = a,
        n.lastRenderedState = r
    }
    if (e = n.interleaved,
    e !== null) {
        i = e;
        do
            o = i.lane,
            K.lanes |= o,
            vn |= o,
            i = i.next;
        while (i !== e)
    } else
        i === null && (n.lanes = 0);
    return [t.memoizedState, n.dispatch]
}
function Os(e) {
    var t = We()
      , n = t.queue;
    if (n === null)
        throw Error(E(311));
    n.lastRenderedReducer = e;
    var r = n.dispatch
      , i = n.pending
      , o = t.memoizedState;
    if (i !== null) {
        n.pending = null;
        var s = i = i.next;
        do
            o = e(o, s.action),
            s = s.next;
        while (s !== i);
        Je(o, t.memoizedState) || (Ee = !0),
        t.memoizedState = o,
        t.baseQueue === null && (t.baseState = o),
        n.lastRenderedState = o
    }
    return [o, r]
}
function Uh() {}
function Hh(e, t) {
    var n = K
      , r = We()
      , i = t()
      , o = !Je(r.memoizedState, i);
    if (o && (r.memoizedState = i,
    Ee = !0),
    r = r.queue,
    Ga(bh.bind(null, n, r, e), [e]),
    r.getSnapshot !== t || o || se !== null && se.memoizedState.tag & 1) {
        if (n.flags |= 2048,
        ti(9, Wh.bind(null, n, r, i, t), void 0, null),
        le === null)
            throw Error(E(349));
        (gn & 30) !== 0 || $h(n, t, i)
    }
    return i
}
function $h(e, t, n) {
    e.flags |= 16384,
    e = {
        getSnapshot: t,
        value: n
    },
    t = K.updateQueue,
    t === null ? (t = {
        lastEffect: null,
        stores: null
    },
    K.updateQueue = t,
    t.stores = [e]) : (n = t.stores,
    n === null ? t.stores = [e] : n.push(e))
}
function Wh(e, t, n, r) {
    t.value = n,
    t.getSnapshot = r,
    Kh(t) && Qh(e)
}
function bh(e, t, n) {
    return n(function() {
        Kh(t) && Qh(e)
    })
}
function Kh(e) {
    var t = e.getSnapshot;
    e = e.value;
    try {
        var n = t();
        return !Je(e, n)
    } catch {
        return !0
    }
}
function Qh(e) {
    var t = wt(e, 1);
    t !== null && Xe(t, e, 1, -1)
}
function Ic(e) {
    var t = et();
    return typeof e == "function" && (e = e()),
    t.memoizedState = t.baseState = e,
    e = {
        pending: null,
        interleaved: null,
        lanes: 0,
        dispatch: null,
        lastRenderedReducer: ei,
        lastRenderedState: e
    },
    t.queue = e,
    e = e.dispatch = y2.bind(null, K, e),
    [t.memoizedState, e]
}
function ti(e, t, n, r) {
    return e = {
        tag: e,
        create: t,
        destroy: n,
        deps: r,
        next: null
    },
    t = K.updateQueue,
    t === null ? (t = {
        lastEffect: null,
        stores: null
    },
    K.updateQueue = t,
    t.lastEffect = e.next = e) : (n = t.lastEffect,
    n === null ? t.lastEffect = e.next = e : (r = n.next,
    n.next = e,
    e.next = r,
    t.lastEffect = e)),
    e
}
function Yh() {
    return We().memoizedState
}
function Zi(e, t, n, r) {
    var i = et();
    K.flags |= e,
    i.memoizedState = ti(1 | t, n, void 0, r === void 0 ? null : r)
}
function Yo(e, t, n, r) {
    var i = We();
    r = r === void 0 ? null : r;
    var o = void 0;
    if (re !== null) {
        var s = re.memoizedState;
        if (o = s.destroy,
        r !== null && Ka(r, s.deps)) {
            i.memoizedState = ti(t, n, o, r);
            return
        }
    }
    K.flags |= e,
    i.memoizedState = ti(1 | t, n, o, r)
}
function _c(e, t) {
    return Zi(8390656, 8, e, t)
}
function Ga(e, t) {
    return Yo(2048, 8, e, t)
}
function Gh(e, t) {
    return Yo(4, 2, e, t)
}
function Zh(e, t) {
    return Yo(4, 4, e, t)
}
function Xh(e, t) {
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
function Jh(e, t, n) {
    return n = n != null ? n.concat([e]) : null,
    Yo(4, 4, Xh.bind(null, t, e), n)
}
function Za() {}
function qh(e, t) {
    var n = We();
    t = t === void 0 ? null : t;
    var r = n.memoizedState;
    return r !== null && t !== null && Ka(t, r[1]) ? r[0] : (n.memoizedState = [e, t],
    e)
}
function ep(e, t) {
    var n = We();
    t = t === void 0 ? null : t;
    var r = n.memoizedState;
    return r !== null && t !== null && Ka(t, r[1]) ? r[0] : (e = e(),
    n.memoizedState = [e, t],
    e)
}
function tp(e, t, n) {
    return (gn & 21) === 0 ? (e.baseState && (e.baseState = !1,
    Ee = !0),
    e.memoizedState = n) : (Je(n, t) || (n = ih(),
    K.lanes |= n,
    vn |= n,
    e.baseState = !0),
    t)
}
function g2(e, t) {
    var n = B;
    B = n !== 0 && 4 > n ? n : 4,
    e(!0);
    var r = Ms.transition;
    Ms.transition = {};
    try {
        e(!1),
        t()
    } finally {
        B = n,
        Ms.transition = r
    }
}
function np() {
    return We().memoizedState
}
function v2(e, t, n) {
    var r = jt(e);
    if (n = {
        lane: r,
        action: n,
        hasEagerState: !1,
        eagerState: null,
        next: null
    },
    rp(e))
        ip(t, n);
    else if (n = Oh(e, t, n, r),
    n !== null) {
        var i = Ce();
        Xe(n, e, r, i),
        op(n, t, r)
    }
}
function y2(e, t, n) {
    var r = jt(e)
      , i = {
        lane: r,
        action: n,
        hasEagerState: !1,
        eagerState: null,
        next: null
    };
    if (rp(e))
        ip(t, i);
    else {
        var o = e.alternate;
        if (e.lanes === 0 && (o === null || o.lanes === 0) && (o = t.lastRenderedReducer,
        o !== null))
            try {
                var s = t.lastRenderedState
                  , l = o(s, n);
                if (i.hasEagerState = !0,
                i.eagerState = l,
                Je(l, s)) {
                    var a = t.interleaved;
                    a === null ? (i.next = i,
                    Ua(t)) : (i.next = a.next,
                    a.next = i),
                    t.interleaved = i;
                    return
                }
            } catch {} finally {}
        n = Oh(e, t, i, r),
        n !== null && (i = Ce(),
        Xe(n, e, r, i),
        op(n, t, r))
    }
}
function rp(e) {
    var t = e.alternate;
    return e === K || t !== null && t === K
}
function ip(e, t) {
    Vr = Eo = !0;
    var n = e.pending;
    n === null ? t.next = t : (t.next = n.next,
    n.next = t),
    e.pending = t
}
function op(e, t, n) {
    if ((n & 4194240) !== 0) {
        var r = t.lanes;
        r &= e.pendingLanes,
        n |= r,
        t.lanes = n,
        Ra(e, n)
    }
}
var To = {
    readContext: $e,
    useCallback: he,
    useContext: he,
    useEffect: he,
    useImperativeHandle: he,
    useInsertionEffect: he,
    useLayoutEffect: he,
    useMemo: he,
    useReducer: he,
    useRef: he,
    useState: he,
    useDebugValue: he,
    useDeferredValue: he,
    useTransition: he,
    useMutableSource: he,
    useSyncExternalStore: he,
    useId: he,
    unstable_isNewReconciler: !1
}
  , w2 = {
    readContext: $e,
    useCallback: function(e, t) {
        return et().memoizedState = [e, t === void 0 ? null : t],
        e
    },
    useContext: $e,
    useEffect: _c,
    useImperativeHandle: function(e, t, n) {
        return n = n != null ? n.concat([e]) : null,
        Zi(4194308, 4, Xh.bind(null, t, e), n)
    },
    useLayoutEffect: function(e, t) {
        return Zi(4194308, 4, e, t)
    },
    useInsertionEffect: function(e, t) {
        return Zi(4, 2, e, t)
    },
    useMemo: function(e, t) {
        var n = et();
        return t = t === void 0 ? null : t,
        e = e(),
        n.memoizedState = [e, t],
        e
    },
    useReducer: function(e, t, n) {
        var r = et();
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
        e = e.dispatch = v2.bind(null, K, e),
        [r.memoizedState, e]
    },
    useRef: function(e) {
        var t = et();
        return e = {
            current: e
        },
        t.memoizedState = e
    },
    useState: Ic,
    useDebugValue: Za,
    useDeferredValue: function(e) {
        return et().memoizedState = e
    },
    useTransition: function() {
        var e = Ic(!1)
          , t = e[0];
        return e = g2.bind(null, e[1]),
        et().memoizedState = e,
        [t, e]
    },
    useMutableSource: function() {},
    useSyncExternalStore: function(e, t, n) {
        var r = K
          , i = et();
        if ($) {
            if (n === void 0)
                throw Error(E(407));
            n = n()
        } else {
            if (n = t(),
            le === null)
                throw Error(E(349));
            (gn & 30) !== 0 || $h(r, t, n)
        }
        i.memoizedState = n;
        var o = {
            value: n,
            getSnapshot: t
        };
        return i.queue = o,
        _c(bh.bind(null, r, o, e), [e]),
        r.flags |= 2048,
        ti(9, Wh.bind(null, r, o, n, t), void 0, null),
        n
    },
    useId: function() {
        var e = et()
          , t = le.identifierPrefix;
        if ($) {
            var n = ft
              , r = ct;
            n = (r & ~(1 << 32 - Ze(r) - 1)).toString(32) + n,
            t = ":" + t + "R" + n,
            n = qr++,
            0 < n && (t += "H" + n.toString(32)),
            t += ":"
        } else
            n = m2++,
            t = ":" + t + "r" + n.toString(32) + ":";
        return e.memoizedState = t
    },
    unstable_isNewReconciler: !1
}
  , x2 = {
    readContext: $e,
    useCallback: qh,
    useContext: $e,
    useEffect: Ga,
    useImperativeHandle: Jh,
    useInsertionEffect: Gh,
    useLayoutEffect: Zh,
    useMemo: ep,
    useReducer: Vs,
    useRef: Yh,
    useState: function() {
        return Vs(ei)
    },
    useDebugValue: Za,
    useDeferredValue: function(e) {
        var t = We();
        return tp(t, re.memoizedState, e)
    },
    useTransition: function() {
        var e = Vs(ei)[0]
          , t = We().memoizedState;
        return [e, t]
    },
    useMutableSource: Uh,
    useSyncExternalStore: Hh,
    useId: np,
    unstable_isNewReconciler: !1
}
  , C2 = {
    readContext: $e,
    useCallback: qh,
    useContext: $e,
    useEffect: Ga,
    useImperativeHandle: Jh,
    useInsertionEffect: Gh,
    useLayoutEffect: Zh,
    useMemo: ep,
    useReducer: Os,
    useRef: Yh,
    useState: function() {
        return Os(ei)
    },
    useDebugValue: Za,
    useDeferredValue: function(e) {
        var t = We();
        return re === null ? t.memoizedState = e : tp(t, re.memoizedState, e)
    },
    useTransition: function() {
        var e = Os(ei)[0]
          , t = We().memoizedState;
        return [e, t]
    },
    useMutableSource: Uh,
    useSyncExternalStore: Hh,
    useId: np,
    unstable_isNewReconciler: !1
};
function Jn(e, t) {
    try {
        var n = ""
          , r = t;
        do
            n += Gm(r),
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
function Fs(e, t, n) {
    return {
        value: e,
        source: null,
        stack: n != null ? n : null,
        digest: t != null ? t : null
    }
}
function Il(e, t) {
    try {
        console.error(t.value)
    } catch (n) {
        setTimeout(function() {
            throw n
        })
    }
}
var S2 = typeof WeakMap == "function" ? WeakMap : Map;
function sp(e, t, n) {
    n = ht(-1, n),
    n.tag = 3,
    n.payload = {
        element: null
    };
    var r = t.value;
    return n.callback = function() {
        Lo || (Lo = !0,
        Kl = r),
        Il(e, t)
    }
    ,
    n
}
function lp(e, t, n) {
    n = ht(-1, n),
    n.tag = 3;
    var r = e.type.getDerivedStateFromError;
    if (typeof r == "function") {
        var i = t.value;
        n.payload = function() {
            return r(i)
        }
        ,
        n.callback = function() {
            Il(e, t)
        }
    }
    var o = e.stateNode;
    return o !== null && typeof o.componentDidCatch == "function" && (n.callback = function() {
        Il(e, t),
        typeof r != "function" && (zt === null ? zt = new Set([this]) : zt.add(this));
        var s = t.stack;
        this.componentDidCatch(t.value, {
            componentStack: s !== null ? s : ""
        })
    }
    ),
    n
}
function Bc(e, t, n) {
    var r = e.pingCache;
    if (r === null) {
        r = e.pingCache = new S2;
        var i = new Set;
        r.set(t, i)
    } else
        i = r.get(t),
        i === void 0 && (i = new Set,
        r.set(t, i));
    i.has(n) || (i.add(n),
    e = I2.bind(null, e, t, n),
    t.then(e, e))
}
function zc(e) {
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
function jc(e, t, n, r, i) {
    return (e.mode & 1) === 0 ? (e === t ? e.flags |= 65536 : (e.flags |= 128,
    n.flags |= 131072,
    n.flags &= -52805,
    n.tag === 1 && (n.alternate === null ? n.tag = 17 : (t = ht(-1, 1),
    t.tag = 2,
    Bt(n, t, 1))),
    n.lanes |= 1),
    e) : (e.flags |= 65536,
    e.lanes = i,
    e)
}
var P2 = Pt.ReactCurrentOwner
  , Ee = !1;
function xe(e, t, n, r) {
    t.child = e === null ? zh(t, null, n, r) : Zn(t, e.child, n, r)
}
function Uc(e, t, n, r, i) {
    n = n.render;
    var o = t.ref;
    return bn(t, i),
    r = Qa(e, t, n, r, o, i),
    n = Ya(),
    e !== null && !Ee ? (t.updateQueue = e.updateQueue,
    t.flags &= -2053,
    e.lanes &= ~i,
    xt(e, t, i)) : ($ && n && Fa(t),
    t.flags |= 1,
    xe(e, t, r, i),
    t.child)
}
function Hc(e, t, n, r, i) {
    if (e === null) {
        var o = n.type;
        return typeof o == "function" && !iu(o) && o.defaultProps === void 0 && n.compare === null && n.defaultProps === void 0 ? (t.tag = 15,
        t.type = o,
        ap(e, t, o, r, i)) : (e = eo(n.type, null, r, t, t.mode, i),
        e.ref = t.ref,
        e.return = t,
        t.child = e)
    }
    if (o = e.child,
    (e.lanes & i) === 0) {
        var s = o.memoizedProps;
        if (n = n.compare,
        n = n !== null ? n : Qr,
        n(s, r) && e.ref === t.ref)
            return xt(e, t, i)
    }
    return t.flags |= 1,
    e = Ut(o, r),
    e.ref = t.ref,
    e.return = t,
    t.child = e
}
function ap(e, t, n, r, i) {
    if (e !== null) {
        var o = e.memoizedProps;
        if (Qr(o, r) && e.ref === t.ref)
            if (Ee = !1,
            t.pendingProps = r = o,
            (e.lanes & i) !== 0)
                (e.flags & 131072) !== 0 && (Ee = !0);
            else
                return t.lanes = e.lanes,
                xt(e, t, i)
    }
    return _l(e, t, n, r, i)
}
function up(e, t, n) {
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
            j(Fn, Ae),
            Ae |= n;
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
                j(Fn, Ae),
                Ae |= e,
                null;
            t.memoizedState = {
                baseLanes: 0,
                cachePool: null,
                transitions: null
            },
            r = o !== null ? o.baseLanes : n,
            j(Fn, Ae),
            Ae |= r
        }
    else
        o !== null ? (r = o.baseLanes | n,
        t.memoizedState = null) : r = n,
        j(Fn, Ae),
        Ae |= r;
    return xe(e, t, i, n),
    t.child
}
function cp(e, t) {
    var n = t.ref;
    (e === null && n !== null || e !== null && e.ref !== n) && (t.flags |= 512,
    t.flags |= 2097152)
}
function _l(e, t, n, r, i) {
    var o = Re(n) ? pn : we.current;
    return o = Yn(t, o),
    bn(t, i),
    n = Qa(e, t, n, r, o, i),
    r = Ya(),
    e !== null && !Ee ? (t.updateQueue = e.updateQueue,
    t.flags &= -2053,
    e.lanes &= ~i,
    xt(e, t, i)) : ($ && r && Fa(t),
    t.flags |= 1,
    xe(e, t, n, i),
    t.child)
}
function $c(e, t, n, r, i) {
    if (Re(n)) {
        var o = !0;
        yo(t)
    } else
        o = !1;
    if (bn(t, i),
    t.stateNode === null)
        Xi(e, t),
        _h(t, n, r),
        Fl(t, n, r, i),
        r = !0;
    else if (e === null) {
        var s = t.stateNode
          , l = t.memoizedProps;
        s.props = l;
        var a = s.context
          , u = n.contextType;
        typeof u == "object" && u !== null ? u = $e(u) : (u = Re(n) ? pn : we.current,
        u = Yn(t, u));
        var c = n.getDerivedStateFromProps
          , f = typeof c == "function" || typeof s.getSnapshotBeforeUpdate == "function";
        f || typeof s.UNSAFE_componentWillReceiveProps != "function" && typeof s.componentWillReceiveProps != "function" || (l !== r || a !== u) && Oc(t, s, r, u),
        At = !1;
        var d = t.memoizedState;
        s.state = d,
        Po(t, r, s, i),
        a = t.memoizedState,
        l !== r || d !== a || Te.current || At ? (typeof c == "function" && (Ol(t, n, c, r),
        a = t.memoizedState),
        (l = At || Vc(t, n, l, r, d, a, u)) ? (f || typeof s.UNSAFE_componentWillMount != "function" && typeof s.componentWillMount != "function" || (typeof s.componentWillMount == "function" && s.componentWillMount(),
        typeof s.UNSAFE_componentWillMount == "function" && s.UNSAFE_componentWillMount()),
        typeof s.componentDidMount == "function" && (t.flags |= 4194308)) : (typeof s.componentDidMount == "function" && (t.flags |= 4194308),
        t.memoizedProps = r,
        t.memoizedState = a),
        s.props = r,
        s.state = a,
        s.context = u,
        r = l) : (typeof s.componentDidMount == "function" && (t.flags |= 4194308),
        r = !1)
    } else {
        s = t.stateNode,
        Fh(e, t),
        l = t.memoizedProps,
        u = t.type === t.elementType ? l : Qe(t.type, l),
        s.props = u,
        f = t.pendingProps,
        d = s.context,
        a = n.contextType,
        typeof a == "object" && a !== null ? a = $e(a) : (a = Re(n) ? pn : we.current,
        a = Yn(t, a));
        var g = n.getDerivedStateFromProps;
        (c = typeof g == "function" || typeof s.getSnapshotBeforeUpdate == "function") || typeof s.UNSAFE_componentWillReceiveProps != "function" && typeof s.componentWillReceiveProps != "function" || (l !== f || d !== a) && Oc(t, s, r, a),
        At = !1,
        d = t.memoizedState,
        s.state = d,
        Po(t, r, s, i);
        var y = t.memoizedState;
        l !== f || d !== y || Te.current || At ? (typeof g == "function" && (Ol(t, n, g, r),
        y = t.memoizedState),
        (u = At || Vc(t, n, u, r, d, y, a) || !1) ? (c || typeof s.UNSAFE_componentWillUpdate != "function" && typeof s.componentWillUpdate != "function" || (typeof s.componentWillUpdate == "function" && s.componentWillUpdate(r, y, a),
        typeof s.UNSAFE_componentWillUpdate == "function" && s.UNSAFE_componentWillUpdate(r, y, a)),
        typeof s.componentDidUpdate == "function" && (t.flags |= 4),
        typeof s.getSnapshotBeforeUpdate == "function" && (t.flags |= 1024)) : (typeof s.componentDidUpdate != "function" || l === e.memoizedProps && d === e.memoizedState || (t.flags |= 4),
        typeof s.getSnapshotBeforeUpdate != "function" || l === e.memoizedProps && d === e.memoizedState || (t.flags |= 1024),
        t.memoizedProps = r,
        t.memoizedState = y),
        s.props = r,
        s.state = y,
        s.context = a,
        r = u) : (typeof s.componentDidUpdate != "function" || l === e.memoizedProps && d === e.memoizedState || (t.flags |= 4),
        typeof s.getSnapshotBeforeUpdate != "function" || l === e.memoizedProps && d === e.memoizedState || (t.flags |= 1024),
        r = !1)
    }
    return Bl(e, t, n, r, o, i)
}
function Bl(e, t, n, r, i, o) {
    cp(e, t);
    var s = (t.flags & 128) !== 0;
    if (!r && !s)
        return i && Lc(t, n, !1),
        xt(e, t, o);
    r = t.stateNode,
    P2.current = t;
    var l = s && typeof n.getDerivedStateFromError != "function" ? null : r.render();
    return t.flags |= 1,
    e !== null && s ? (t.child = Zn(t, e.child, null, o),
    t.child = Zn(t, null, l, o)) : xe(e, t, l, o),
    t.memoizedState = r.state,
    i && Lc(t, n, !0),
    t.child
}
function fp(e) {
    var t = e.stateNode;
    t.pendingContext ? Rc(e, t.pendingContext, t.pendingContext !== t.context) : t.context && Rc(e, t.context, !1),
    $a(e, t.containerInfo)
}
function Wc(e, t, n, r, i) {
    return Gn(),
    _a(i),
    t.flags |= 256,
    xe(e, t, n, r),
    t.child
}
var zl = {
    dehydrated: null,
    treeContext: null,
    retryLane: 0
};
function jl(e) {
    return {
        baseLanes: e,
        cachePool: null,
        transitions: null
    }
}
function dp(e, t, n) {
    var r = t.pendingProps, i = W.current, o = !1, s = (t.flags & 128) !== 0, l;
    if ((l = s) || (l = e !== null && e.memoizedState === null ? !1 : (i & 2) !== 0),
    l ? (o = !0,
    t.flags &= -129) : (e === null || e.memoizedState !== null) && (i |= 1),
    j(W, i & 1),
    e === null)
        return Ml(t),
        e = t.memoizedState,
        e !== null && (e = e.dehydrated,
        e !== null) ? ((t.mode & 1) === 0 ? t.lanes = 1 : e.data === "$!" ? t.lanes = 8 : t.lanes = 1073741824,
        null) : (s = r.children,
        e = r.fallback,
        o ? (r = t.mode,
        o = t.child,
        s = {
            mode: "hidden",
            children: s
        },
        (r & 1) === 0 && o !== null ? (o.childLanes = 0,
        o.pendingProps = s) : o = Xo(s, r, 0, null),
        e = dn(e, r, n, null),
        o.return = t,
        e.return = t,
        o.sibling = e,
        t.child = o,
        t.child.memoizedState = jl(n),
        t.memoizedState = zl,
        e) : Xa(t, s));
    if (i = e.memoizedState,
    i !== null && (l = i.dehydrated,
    l !== null))
        return k2(e, t, s, r, l, i, n);
    if (o) {
        o = r.fallback,
        s = t.mode,
        i = e.child,
        l = i.sibling;
        var a = {
            mode: "hidden",
            children: r.children
        };
        return (s & 1) === 0 && t.child !== i ? (r = t.child,
        r.childLanes = 0,
        r.pendingProps = a,
        t.deletions = null) : (r = Ut(i, a),
        r.subtreeFlags = i.subtreeFlags & 14680064),
        l !== null ? o = Ut(l, o) : (o = dn(o, s, n, null),
        o.flags |= 2),
        o.return = t,
        r.return = t,
        r.sibling = o,
        t.child = r,
        r = o,
        o = t.child,
        s = e.child.memoizedState,
        s = s === null ? jl(n) : {
            baseLanes: s.baseLanes | n,
            cachePool: null,
            transitions: s.transitions
        },
        o.memoizedState = s,
        o.childLanes = e.childLanes & ~n,
        t.memoizedState = zl,
        r
    }
    return o = e.child,
    e = o.sibling,
    r = Ut(o, {
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
function Xa(e, t) {
    return t = Xo({
        mode: "visible",
        children: t
    }, e.mode, 0, null),
    t.return = e,
    e.child = t
}
function Ii(e, t, n, r) {
    return r !== null && _a(r),
    Zn(t, e.child, null, n),
    e = Xa(t, t.pendingProps.children),
    e.flags |= 2,
    t.memoizedState = null,
    e
}
function k2(e, t, n, r, i, o, s) {
    if (n)
        return t.flags & 256 ? (t.flags &= -257,
        r = Fs(Error(E(422))),
        Ii(e, t, s, r)) : t.memoizedState !== null ? (t.child = e.child,
        t.flags |= 128,
        null) : (o = r.fallback,
        i = t.mode,
        r = Xo({
            mode: "visible",
            children: r.children
        }, i, 0, null),
        o = dn(o, i, s, null),
        o.flags |= 2,
        r.return = t,
        o.return = t,
        r.sibling = o,
        t.child = r,
        (t.mode & 1) !== 0 && Zn(t, e.child, null, s),
        t.child.memoizedState = jl(s),
        t.memoizedState = zl,
        o);
    if ((t.mode & 1) === 0)
        return Ii(e, t, s, null);
    if (i.data === "$!") {
        if (r = i.nextSibling && i.nextSibling.dataset,
        r)
            var l = r.dgst;
        return r = l,
        o = Error(E(419)),
        r = Fs(o, r, void 0),
        Ii(e, t, s, r)
    }
    if (l = (s & e.childLanes) !== 0,
    Ee || l) {
        if (r = le,
        r !== null) {
            switch (s & -s) {
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
            i = (i & (r.suspendedLanes | s)) !== 0 ? 0 : i,
            i !== 0 && i !== o.retryLane && (o.retryLane = i,
            wt(e, i),
            Xe(r, e, i, -1))
        }
        return ru(),
        r = Fs(Error(E(421))),
        Ii(e, t, s, r)
    }
    return i.data === "$?" ? (t.flags |= 128,
    t.child = e.child,
    t = _2.bind(null, e),
    i._reactRetry = t,
    null) : (e = o.treeContext,
    Ne = _t(i.nextSibling),
    De = t,
    $ = !0,
    Ge = null,
    e !== null && (Be[ze++] = ct,
    Be[ze++] = ft,
    Be[ze++] = mn,
    ct = e.id,
    ft = e.overflow,
    mn = t),
    t = Xa(t, r.children),
    t.flags |= 4096,
    t)
}
function bc(e, t, n) {
    e.lanes |= t;
    var r = e.alternate;
    r !== null && (r.lanes |= t),
    Vl(e.return, t, n)
}
function Is(e, t, n, r, i) {
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
function hp(e, t, n) {
    var r = t.pendingProps
      , i = r.revealOrder
      , o = r.tail;
    if (xe(e, t, r.children, n),
    r = W.current,
    (r & 2) !== 0)
        r = r & 1 | 2,
        t.flags |= 128;
    else {
        if (e !== null && (e.flags & 128) !== 0)
            e: for (e = t.child; e !== null; ) {
                if (e.tag === 13)
                    e.memoizedState !== null && bc(e, n, t);
                else if (e.tag === 19)
                    bc(e, n, t);
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
    if (j(W, r),
    (t.mode & 1) === 0)
        t.memoizedState = null;
    else
        switch (i) {
        case "forwards":
            for (n = t.child,
            i = null; n !== null; )
                e = n.alternate,
                e !== null && ko(e) === null && (i = n),
                n = n.sibling;
            n = i,
            n === null ? (i = t.child,
            t.child = null) : (i = n.sibling,
            n.sibling = null),
            Is(t, !1, i, n, o);
            break;
        case "backwards":
            for (n = null,
            i = t.child,
            t.child = null; i !== null; ) {
                if (e = i.alternate,
                e !== null && ko(e) === null) {
                    t.child = i;
                    break
                }
                e = i.sibling,
                i.sibling = n,
                n = i,
                i = e
            }
            Is(t, !0, n, null, o);
            break;
        case "together":
            Is(t, !1, null, null, void 0);
            break;
        default:
            t.memoizedState = null
        }
    return t.child
}
function Xi(e, t) {
    (t.mode & 1) === 0 && e !== null && (e.alternate = null,
    t.alternate = null,
    t.flags |= 2)
}
function xt(e, t, n) {
    if (e !== null && (t.dependencies = e.dependencies),
    vn |= t.lanes,
    (n & t.childLanes) === 0)
        return null;
    if (e !== null && t.child !== e.child)
        throw Error(E(153));
    if (t.child !== null) {
        for (e = t.child,
        n = Ut(e, e.pendingProps),
        t.child = n,
        n.return = t; e.sibling !== null; )
            e = e.sibling,
            n = n.sibling = Ut(e, e.pendingProps),
            n.return = t;
        n.sibling = null
    }
    return t.child
}
function E2(e, t, n) {
    switch (t.tag) {
    case 3:
        fp(t),
        Gn();
        break;
    case 5:
        jh(t);
        break;
    case 1:
        Re(t.type) && yo(t);
        break;
    case 4:
        $a(t, t.stateNode.containerInfo);
        break;
    case 10:
        var r = t.type._context
          , i = t.memoizedProps.value;
        j(Co, r._currentValue),
        r._currentValue = i;
        break;
    case 13:
        if (r = t.memoizedState,
        r !== null)
            return r.dehydrated !== null ? (j(W, W.current & 1),
            t.flags |= 128,
            null) : (n & t.child.childLanes) !== 0 ? dp(e, t, n) : (j(W, W.current & 1),
            e = xt(e, t, n),
            e !== null ? e.sibling : null);
        j(W, W.current & 1);
        break;
    case 19:
        if (r = (n & t.childLanes) !== 0,
        (e.flags & 128) !== 0) {
            if (r)
                return hp(e, t, n);
            t.flags |= 128
        }
        if (i = t.memoizedState,
        i !== null && (i.rendering = null,
        i.tail = null,
        i.lastEffect = null),
        j(W, W.current),
        r)
            break;
        return null;
    case 22:
    case 23:
        return t.lanes = 0,
        up(e, t, n)
    }
    return xt(e, t, n)
}
var pp, Ul, mp, gp;
pp = function(e, t) {
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
Ul = function() {}
;
mp = function(e, t, n, r) {
    var i = e.memoizedProps;
    if (i !== r) {
        e = t.stateNode,
        un(rt.current);
        var o = null;
        switch (n) {
        case "input":
            i = ul(e, i),
            r = ul(e, r),
            o = [];
            break;
        case "select":
            i = Y({}, i, {
                value: void 0
            }),
            r = Y({}, r, {
                value: void 0
            }),
            o = [];
            break;
        case "textarea":
            i = dl(e, i),
            r = dl(e, r),
            o = [];
            break;
        default:
            typeof i.onClick != "function" && typeof r.onClick == "function" && (e.onclick = go)
        }
        pl(n, r);
        var s;
        n = null;
        for (u in i)
            if (!r.hasOwnProperty(u) && i.hasOwnProperty(u) && i[u] != null)
                if (u === "style") {
                    var l = i[u];
                    for (s in l)
                        l.hasOwnProperty(s) && (n || (n = {}),
                        n[s] = "")
                } else
                    u !== "dangerouslySetInnerHTML" && u !== "children" && u !== "suppressContentEditableWarning" && u !== "suppressHydrationWarning" && u !== "autoFocus" && (jr.hasOwnProperty(u) ? o || (o = []) : (o = o || []).push(u, null));
        for (u in r) {
            var a = r[u];
            if (l = i != null ? i[u] : void 0,
            r.hasOwnProperty(u) && a !== l && (a != null || l != null))
                if (u === "style")
                    if (l) {
                        for (s in l)
                            !l.hasOwnProperty(s) || a && a.hasOwnProperty(s) || (n || (n = {}),
                            n[s] = "");
                        for (s in a)
                            a.hasOwnProperty(s) && l[s] !== a[s] && (n || (n = {}),
                            n[s] = a[s])
                    } else
                        n || (o || (o = []),
                        o.push(u, n)),
                        n = a;
                else
                    u === "dangerouslySetInnerHTML" ? (a = a ? a.__html : void 0,
                    l = l ? l.__html : void 0,
                    a != null && l !== a && (o = o || []).push(u, a)) : u === "children" ? typeof a != "string" && typeof a != "number" || (o = o || []).push(u, "" + a) : u !== "suppressContentEditableWarning" && u !== "suppressHydrationWarning" && (jr.hasOwnProperty(u) ? (a != null && u === "onScroll" && U("scroll", e),
                    o || l === a || (o = [])) : (o = o || []).push(u, a))
        }
        n && (o = o || []).push("style", n);
        var u = o;
        (t.updateQueue = u) && (t.flags |= 4)
    }
}
;
gp = function(e, t, n, r) {
    n !== r && (t.flags |= 4)
}
;
function gr(e, t) {
    if (!$)
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
function pe(e) {
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
function T2(e, t, n) {
    var r = t.pendingProps;
    switch (Ia(t),
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
        return pe(t),
        null;
    case 1:
        return Re(t.type) && vo(),
        pe(t),
        null;
    case 3:
        return r = t.stateNode,
        Xn(),
        H(Te),
        H(we),
        ba(),
        r.pendingContext && (r.context = r.pendingContext,
        r.pendingContext = null),
        (e === null || e.child === null) && (Oi(t) ? t.flags |= 4 : e === null || e.memoizedState.isDehydrated && (t.flags & 256) === 0 || (t.flags |= 1024,
        Ge !== null && (Gl(Ge),
        Ge = null))),
        Ul(e, t),
        pe(t),
        null;
    case 5:
        Wa(t);
        var i = un(Jr.current);
        if (n = t.type,
        e !== null && t.stateNode != null)
            mp(e, t, n, r, i),
            e.ref !== t.ref && (t.flags |= 512,
            t.flags |= 2097152);
        else {
            if (!r) {
                if (t.stateNode === null)
                    throw Error(E(166));
                return pe(t),
                null
            }
            if (e = un(rt.current),
            Oi(t)) {
                r = t.stateNode,
                n = t.type;
                var o = t.memoizedProps;
                switch (r[tt] = t,
                r[Zr] = o,
                e = (t.mode & 1) !== 0,
                n) {
                case "dialog":
                    U("cancel", r),
                    U("close", r);
                    break;
                case "iframe":
                case "object":
                case "embed":
                    U("load", r);
                    break;
                case "video":
                case "audio":
                    for (i = 0; i < kr.length; i++)
                        U(kr[i], r);
                    break;
                case "source":
                    U("error", r);
                    break;
                case "img":
                case "image":
                case "link":
                    U("error", r),
                    U("load", r);
                    break;
                case "details":
                    U("toggle", r);
                    break;
                case "input":
                    ec(r, o),
                    U("invalid", r);
                    break;
                case "select":
                    r._wrapperState = {
                        wasMultiple: !!o.multiple
                    },
                    U("invalid", r);
                    break;
                case "textarea":
                    nc(r, o),
                    U("invalid", r)
                }
                pl(n, o),
                i = null;
                for (var s in o)
                    if (o.hasOwnProperty(s)) {
                        var l = o[s];
                        s === "children" ? typeof l == "string" ? r.textContent !== l && (o.suppressHydrationWarning !== !0 && Vi(r.textContent, l, e),
                        i = ["children", l]) : typeof l == "number" && r.textContent !== "" + l && (o.suppressHydrationWarning !== !0 && Vi(r.textContent, l, e),
                        i = ["children", "" + l]) : jr.hasOwnProperty(s) && l != null && s === "onScroll" && U("scroll", r)
                    }
                switch (n) {
                case "input":
                    Ei(r),
                    tc(r, o, !0);
                    break;
                case "textarea":
                    Ei(r),
                    rc(r);
                    break;
                case "select":
                case "option":
                    break;
                default:
                    typeof o.onClick == "function" && (r.onclick = go)
                }
                r = i,
                t.updateQueue = r,
                r !== null && (t.flags |= 4)
            } else {
                s = i.nodeType === 9 ? i : i.ownerDocument,
                e === "http://www.w3.org/1999/xhtml" && (e = $d(n)),
                e === "http://www.w3.org/1999/xhtml" ? n === "script" ? (e = s.createElement("div"),
                e.innerHTML = "<script><\/script>",
                e = e.removeChild(e.firstChild)) : typeof r.is == "string" ? e = s.createElement(n, {
                    is: r.is
                }) : (e = s.createElement(n),
                n === "select" && (s = e,
                r.multiple ? s.multiple = !0 : r.size && (s.size = r.size))) : e = s.createElementNS(e, n),
                e[tt] = t,
                e[Zr] = r,
                pp(e, t, !1, !1),
                t.stateNode = e;
                e: {
                    switch (s = ml(n, r),
                    n) {
                    case "dialog":
                        U("cancel", e),
                        U("close", e),
                        i = r;
                        break;
                    case "iframe":
                    case "object":
                    case "embed":
                        U("load", e),
                        i = r;
                        break;
                    case "video":
                    case "audio":
                        for (i = 0; i < kr.length; i++)
                            U(kr[i], e);
                        i = r;
                        break;
                    case "source":
                        U("error", e),
                        i = r;
                        break;
                    case "img":
                    case "image":
                    case "link":
                        U("error", e),
                        U("load", e),
                        i = r;
                        break;
                    case "details":
                        U("toggle", e),
                        i = r;
                        break;
                    case "input":
                        ec(e, r),
                        i = ul(e, r),
                        U("invalid", e);
                        break;
                    case "option":
                        i = r;
                        break;
                    case "select":
                        e._wrapperState = {
                            wasMultiple: !!r.multiple
                        },
                        i = Y({}, r, {
                            value: void 0
                        }),
                        U("invalid", e);
                        break;
                    case "textarea":
                        nc(e, r),
                        i = dl(e, r),
                        U("invalid", e);
                        break;
                    default:
                        i = r
                    }
                    pl(n, i),
                    l = i;
                    for (o in l)
                        if (l.hasOwnProperty(o)) {
                            var a = l[o];
                            o === "style" ? Kd(e, a) : o === "dangerouslySetInnerHTML" ? (a = a ? a.__html : void 0,
                            a != null && Wd(e, a)) : o === "children" ? typeof a == "string" ? (n !== "textarea" || a !== "") && Ur(e, a) : typeof a == "number" && Ur(e, "" + a) : o !== "suppressContentEditableWarning" && o !== "suppressHydrationWarning" && o !== "autoFocus" && (jr.hasOwnProperty(o) ? a != null && o === "onScroll" && U("scroll", e) : a != null && Ca(e, o, a, s))
                        }
                    switch (n) {
                    case "input":
                        Ei(e),
                        tc(e, r, !1);
                        break;
                    case "textarea":
                        Ei(e),
                        rc(e);
                        break;
                    case "option":
                        r.value != null && e.setAttribute("value", "" + Wt(r.value));
                        break;
                    case "select":
                        e.multiple = !!r.multiple,
                        o = r.value,
                        o != null ? Un(e, !!r.multiple, o, !1) : r.defaultValue != null && Un(e, !!r.multiple, r.defaultValue, !0);
                        break;
                    default:
                        typeof i.onClick == "function" && (e.onclick = go)
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
        return pe(t),
        null;
    case 6:
        if (e && t.stateNode != null)
            gp(e, t, e.memoizedProps, r);
        else {
            if (typeof r != "string" && t.stateNode === null)
                throw Error(E(166));
            if (n = un(Jr.current),
            un(rt.current),
            Oi(t)) {
                if (r = t.stateNode,
                n = t.memoizedProps,
                r[tt] = t,
                (o = r.nodeValue !== n) && (e = De,
                e !== null))
                    switch (e.tag) {
                    case 3:
                        Vi(r.nodeValue, n, (e.mode & 1) !== 0);
                        break;
                    case 5:
                        e.memoizedProps.suppressHydrationWarning !== !0 && Vi(r.nodeValue, n, (e.mode & 1) !== 0)
                    }
                o && (t.flags |= 4)
            } else
                r = (n.nodeType === 9 ? n : n.ownerDocument).createTextNode(r),
                r[tt] = t,
                t.stateNode = r
        }
        return pe(t),
        null;
    case 13:
        if (H(W),
        r = t.memoizedState,
        e === null || e.memoizedState !== null && e.memoizedState.dehydrated !== null) {
            if ($ && Ne !== null && (t.mode & 1) !== 0 && (t.flags & 128) === 0)
                Vh(),
                Gn(),
                t.flags |= 98560,
                o = !1;
            else if (o = Oi(t),
            r !== null && r.dehydrated !== null) {
                if (e === null) {
                    if (!o)
                        throw Error(E(318));
                    if (o = t.memoizedState,
                    o = o !== null ? o.dehydrated : null,
                    !o)
                        throw Error(E(317));
                    o[tt] = t
                } else
                    Gn(),
                    (t.flags & 128) === 0 && (t.memoizedState = null),
                    t.flags |= 4;
                pe(t),
                o = !1
            } else
                Ge !== null && (Gl(Ge),
                Ge = null),
                o = !0;
            if (!o)
                return t.flags & 65536 ? t : null
        }
        return (t.flags & 128) !== 0 ? (t.lanes = n,
        t) : (r = r !== null,
        r !== (e !== null && e.memoizedState !== null) && r && (t.child.flags |= 8192,
        (t.mode & 1) !== 0 && (e === null || (W.current & 1) !== 0 ? ie === 0 && (ie = 3) : ru())),
        t.updateQueue !== null && (t.flags |= 4),
        pe(t),
        null);
    case 4:
        return Xn(),
        Ul(e, t),
        e === null && Yr(t.stateNode.containerInfo),
        pe(t),
        null;
    case 10:
        return ja(t.type._context),
        pe(t),
        null;
    case 17:
        return Re(t.type) && vo(),
        pe(t),
        null;
    case 19:
        if (H(W),
        o = t.memoizedState,
        o === null)
            return pe(t),
            null;
        if (r = (t.flags & 128) !== 0,
        s = o.rendering,
        s === null)
            if (r)
                gr(o, !1);
            else {
                if (ie !== 0 || e !== null && (e.flags & 128) !== 0)
                    for (e = t.child; e !== null; ) {
                        if (s = ko(e),
                        s !== null) {
                            for (t.flags |= 128,
                            gr(o, !1),
                            r = s.updateQueue,
                            r !== null && (t.updateQueue = r,
                            t.flags |= 4),
                            t.subtreeFlags = 0,
                            r = n,
                            n = t.child; n !== null; )
                                o = n,
                                e = r,
                                o.flags &= 14680066,
                                s = o.alternate,
                                s === null ? (o.childLanes = 0,
                                o.lanes = e,
                                o.child = null,
                                o.subtreeFlags = 0,
                                o.memoizedProps = null,
                                o.memoizedState = null,
                                o.updateQueue = null,
                                o.dependencies = null,
                                o.stateNode = null) : (o.childLanes = s.childLanes,
                                o.lanes = s.lanes,
                                o.child = s.child,
                                o.subtreeFlags = 0,
                                o.deletions = null,
                                o.memoizedProps = s.memoizedProps,
                                o.memoizedState = s.memoizedState,
                                o.updateQueue = s.updateQueue,
                                o.type = s.type,
                                e = s.dependencies,
                                o.dependencies = e === null ? null : {
                                    lanes: e.lanes,
                                    firstContext: e.firstContext
                                }),
                                n = n.sibling;
                            return j(W, W.current & 1 | 2),
                            t.child
                        }
                        e = e.sibling
                    }
                o.tail !== null && ee() > qn && (t.flags |= 128,
                r = !0,
                gr(o, !1),
                t.lanes = 4194304)
            }
        else {
            if (!r)
                if (e = ko(s),
                e !== null) {
                    if (t.flags |= 128,
                    r = !0,
                    n = e.updateQueue,
                    n !== null && (t.updateQueue = n,
                    t.flags |= 4),
                    gr(o, !0),
                    o.tail === null && o.tailMode === "hidden" && !s.alternate && !$)
                        return pe(t),
                        null
                } else
                    2 * ee() - o.renderingStartTime > qn && n !== 1073741824 && (t.flags |= 128,
                    r = !0,
                    gr(o, !1),
                    t.lanes = 4194304);
            o.isBackwards ? (s.sibling = t.child,
            t.child = s) : (n = o.last,
            n !== null ? n.sibling = s : t.child = s,
            o.last = s)
        }
        return o.tail !== null ? (t = o.tail,
        o.rendering = t,
        o.tail = t.sibling,
        o.renderingStartTime = ee(),
        t.sibling = null,
        n = W.current,
        j(W, r ? n & 1 | 2 : n & 1),
        t) : (pe(t),
        null);
    case 22:
    case 23:
        return nu(),
        r = t.memoizedState !== null,
        e !== null && e.memoizedState !== null !== r && (t.flags |= 8192),
        r && (t.mode & 1) !== 0 ? (Ae & 1073741824) !== 0 && (pe(t),
        t.subtreeFlags & 6 && (t.flags |= 8192)) : pe(t),
        null;
    case 24:
        return null;
    case 25:
        return null
    }
    throw Error(E(156, t.tag))
}
function R2(e, t) {
    switch (Ia(t),
    t.tag) {
    case 1:
        return Re(t.type) && vo(),
        e = t.flags,
        e & 65536 ? (t.flags = e & -65537 | 128,
        t) : null;
    case 3:
        return Xn(),
        H(Te),
        H(we),
        ba(),
        e = t.flags,
        (e & 65536) !== 0 && (e & 128) === 0 ? (t.flags = e & -65537 | 128,
        t) : null;
    case 5:
        return Wa(t),
        null;
    case 13:
        if (H(W),
        e = t.memoizedState,
        e !== null && e.dehydrated !== null) {
            if (t.alternate === null)
                throw Error(E(340));
            Gn()
        }
        return e = t.flags,
        e & 65536 ? (t.flags = e & -65537 | 128,
        t) : null;
    case 19:
        return H(W),
        null;
    case 4:
        return Xn(),
        null;
    case 10:
        return ja(t.type._context),
        null;
    case 22:
    case 23:
        return nu(),
        null;
    case 24:
        return null;
    default:
        return null
    }
}
var _i = !1
  , ge = !1
  , L2 = typeof WeakSet == "function" ? WeakSet : Set
  , N = null;
function On(e, t) {
    var n = e.ref;
    if (n !== null)
        if (typeof n == "function")
            try {
                n(null)
            } catch (r) {
                Z(e, t, r)
            }
        else
            n.current = null
}
function Hl(e, t, n) {
    try {
        n()
    } catch (r) {
        Z(e, t, r)
    }
}
var Kc = !1;
function A2(e, t) {
    if (El = ho,
    e = xh(),
    Oa(e)) {
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
                    var s = 0
                      , l = -1
                      , a = -1
                      , u = 0
                      , c = 0
                      , f = e
                      , d = null;
                    t: for (; ; ) {
                        for (var g; f !== n || i !== 0 && f.nodeType !== 3 || (l = s + i),
                        f !== o || r !== 0 && f.nodeType !== 3 || (a = s + r),
                        f.nodeType === 3 && (s += f.nodeValue.length),
                        (g = f.firstChild) !== null; )
                            d = f,
                            f = g;
                        for (; ; ) {
                            if (f === e)
                                break t;
                            if (d === n && ++u === i && (l = s),
                            d === o && ++c === r && (a = s),
                            (g = f.nextSibling) !== null)
                                break;
                            f = d,
                            d = f.parentNode
                        }
                        f = g
                    }
                    n = l === -1 || a === -1 ? null : {
                        start: l,
                        end: a
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
    for (Tl = {
        focusedElem: e,
        selectionRange: n
    },
    ho = !1,
    N = t; N !== null; )
        if (t = N,
        e = t.child,
        (t.subtreeFlags & 1028) !== 0 && e !== null)
            e.return = t,
            N = e;
        else
            for (; N !== null; ) {
                t = N;
                try {
                    var y = t.alternate;
                    if ((t.flags & 1024) !== 0)
                        switch (t.tag) {
                        case 0:
                        case 11:
                        case 15:
                            break;
                        case 1:
                            if (y !== null) {
                                var v = y.memoizedProps
                                  , C = y.memoizedState
                                  , p = t.stateNode
                                  , h = p.getSnapshotBeforeUpdate(t.elementType === t.type ? v : Qe(t.type, v), C);
                                p.__reactInternalSnapshotBeforeUpdate = h
                            }
                            break;
                        case 3:
                            var m = t.stateNode.containerInfo;
                            m.nodeType === 1 ? m.textContent = "" : m.nodeType === 9 && m.documentElement && m.removeChild(m.documentElement);
                            break;
                        case 5:
                        case 6:
                        case 4:
                        case 17:
                            break;
                        default:
                            throw Error(E(163))
                        }
                } catch (x) {
                    Z(t, t.return, x)
                }
                if (e = t.sibling,
                e !== null) {
                    e.return = t.return,
                    N = e;
                    break
                }
                N = t.return
            }
    return y = Kc,
    Kc = !1,
    y
}
function Or(e, t, n) {
    var r = t.updateQueue;
    if (r = r !== null ? r.lastEffect : null,
    r !== null) {
        var i = r = r.next;
        do {
            if ((i.tag & e) === e) {
                var o = i.destroy;
                i.destroy = void 0,
                o !== void 0 && Hl(t, n, o)
            }
            i = i.next
        } while (i !== r)
    }
}
function Go(e, t) {
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
function $l(e) {
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
function vp(e) {
    var t = e.alternate;
    t !== null && (e.alternate = null,
    vp(t)),
    e.child = null,
    e.deletions = null,
    e.sibling = null,
    e.tag === 5 && (t = e.stateNode,
    t !== null && (delete t[tt],
    delete t[Zr],
    delete t[Al],
    delete t[f2],
    delete t[d2])),
    e.stateNode = null,
    e.return = null,
    e.dependencies = null,
    e.memoizedProps = null,
    e.memoizedState = null,
    e.pendingProps = null,
    e.stateNode = null,
    e.updateQueue = null
}
function yp(e) {
    return e.tag === 5 || e.tag === 3 || e.tag === 4
}
function Qc(e) {
    e: for (; ; ) {
        for (; e.sibling === null; ) {
            if (e.return === null || yp(e.return))
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
function Wl(e, t, n) {
    var r = e.tag;
    if (r === 5 || r === 6)
        e = e.stateNode,
        t ? n.nodeType === 8 ? n.parentNode.insertBefore(e, t) : n.insertBefore(e, t) : (n.nodeType === 8 ? (t = n.parentNode,
        t.insertBefore(e, n)) : (t = n,
        t.appendChild(e)),
        n = n._reactRootContainer,
        n != null || t.onclick !== null || (t.onclick = go));
    else if (r !== 4 && (e = e.child,
    e !== null))
        for (Wl(e, t, n),
        e = e.sibling; e !== null; )
            Wl(e, t, n),
            e = e.sibling
}
function bl(e, t, n) {
    var r = e.tag;
    if (r === 5 || r === 6)
        e = e.stateNode,
        t ? n.insertBefore(e, t) : n.appendChild(e);
    else if (r !== 4 && (e = e.child,
    e !== null))
        for (bl(e, t, n),
        e = e.sibling; e !== null; )
            bl(e, t, n),
            e = e.sibling
}
var ue = null
  , Ye = !1;
function Tt(e, t, n) {
    for (n = n.child; n !== null; )
        wp(e, t, n),
        n = n.sibling
}
function wp(e, t, n) {
    if (nt && typeof nt.onCommitFiberUnmount == "function")
        try {
            nt.onCommitFiberUnmount(Uo, n)
        } catch {}
    switch (n.tag) {
    case 5:
        ge || On(n, t);
    case 6:
        var r = ue
          , i = Ye;
        ue = null,
        Tt(e, t, n),
        ue = r,
        Ye = i,
        ue !== null && (Ye ? (e = ue,
        n = n.stateNode,
        e.nodeType === 8 ? e.parentNode.removeChild(n) : e.removeChild(n)) : ue.removeChild(n.stateNode));
        break;
    case 18:
        ue !== null && (Ye ? (e = ue,
        n = n.stateNode,
        e.nodeType === 8 ? As(e.parentNode, n) : e.nodeType === 1 && As(e, n),
        br(e)) : As(ue, n.stateNode));
        break;
    case 4:
        r = ue,
        i = Ye,
        ue = n.stateNode.containerInfo,
        Ye = !0,
        Tt(e, t, n),
        ue = r,
        Ye = i;
        break;
    case 0:
    case 11:
    case 14:
    case 15:
        if (!ge && (r = n.updateQueue,
        r !== null && (r = r.lastEffect,
        r !== null))) {
            i = r = r.next;
            do {
                var o = i
                  , s = o.destroy;
                o = o.tag,
                s !== void 0 && ((o & 2) !== 0 || (o & 4) !== 0) && Hl(n, t, s),
                i = i.next
            } while (i !== r)
        }
        Tt(e, t, n);
        break;
    case 1:
        if (!ge && (On(n, t),
        r = n.stateNode,
        typeof r.componentWillUnmount == "function"))
            try {
                r.props = n.memoizedProps,
                r.state = n.memoizedState,
                r.componentWillUnmount()
            } catch (l) {
                Z(n, t, l)
            }
        Tt(e, t, n);
        break;
    case 21:
        Tt(e, t, n);
        break;
    case 22:
        n.mode & 1 ? (ge = (r = ge) || n.memoizedState !== null,
        Tt(e, t, n),
        ge = r) : Tt(e, t, n);
        break;
    default:
        Tt(e, t, n)
    }
}
function Yc(e) {
    var t = e.updateQueue;
    if (t !== null) {
        e.updateQueue = null;
        var n = e.stateNode;
        n === null && (n = e.stateNode = new L2),
        t.forEach(function(r) {
            var i = B2.bind(null, e, r);
            n.has(r) || (n.add(r),
            r.then(i, i))
        })
    }
}
function be(e, t) {
    var n = t.deletions;
    if (n !== null)
        for (var r = 0; r < n.length; r++) {
            var i = n[r];
            try {
                var o = e
                  , s = t
                  , l = s;
                e: for (; l !== null; ) {
                    switch (l.tag) {
                    case 5:
                        ue = l.stateNode,
                        Ye = !1;
                        break e;
                    case 3:
                        ue = l.stateNode.containerInfo,
                        Ye = !0;
                        break e;
                    case 4:
                        ue = l.stateNode.containerInfo,
                        Ye = !0;
                        break e
                    }
                    l = l.return
                }
                if (ue === null)
                    throw Error(E(160));
                wp(o, s, i),
                ue = null,
                Ye = !1;
                var a = i.alternate;
                a !== null && (a.return = null),
                i.return = null
            } catch (u) {
                Z(i, t, u)
            }
        }
    if (t.subtreeFlags & 12854)
        for (t = t.child; t !== null; )
            xp(t, e),
            t = t.sibling
}
function xp(e, t) {
    var n = e.alternate
      , r = e.flags;
    switch (e.tag) {
    case 0:
    case 11:
    case 14:
    case 15:
        if (be(t, e),
        qe(e),
        r & 4) {
            try {
                Or(3, e, e.return),
                Go(3, e)
            } catch (v) {
                Z(e, e.return, v)
            }
            try {
                Or(5, e, e.return)
            } catch (v) {
                Z(e, e.return, v)
            }
        }
        break;
    case 1:
        be(t, e),
        qe(e),
        r & 512 && n !== null && On(n, n.return);
        break;
    case 5:
        if (be(t, e),
        qe(e),
        r & 512 && n !== null && On(n, n.return),
        e.flags & 32) {
            var i = e.stateNode;
            try {
                Ur(i, "")
            } catch (v) {
                Z(e, e.return, v)
            }
        }
        if (r & 4 && (i = e.stateNode,
        i != null)) {
            var o = e.memoizedProps
              , s = n !== null ? n.memoizedProps : o
              , l = e.type
              , a = e.updateQueue;
            if (e.updateQueue = null,
            a !== null)
                try {
                    l === "input" && o.type === "radio" && o.name != null && Ud(i, o),
                    ml(l, s);
                    var u = ml(l, o);
                    for (s = 0; s < a.length; s += 2) {
                        var c = a[s]
                          , f = a[s + 1];
                        c === "style" ? Kd(i, f) : c === "dangerouslySetInnerHTML" ? Wd(i, f) : c === "children" ? Ur(i, f) : Ca(i, c, f, u)
                    }
                    switch (l) {
                    case "input":
                        cl(i, o);
                        break;
                    case "textarea":
                        Hd(i, o);
                        break;
                    case "select":
                        var d = i._wrapperState.wasMultiple;
                        i._wrapperState.wasMultiple = !!o.multiple;
                        var g = o.value;
                        g != null ? Un(i, !!o.multiple, g, !1) : d !== !!o.multiple && (o.defaultValue != null ? Un(i, !!o.multiple, o.defaultValue, !0) : Un(i, !!o.multiple, o.multiple ? [] : "", !1))
                    }
                    i[Zr] = o
                } catch (v) {
                    Z(e, e.return, v)
                }
        }
        break;
    case 6:
        if (be(t, e),
        qe(e),
        r & 4) {
            if (e.stateNode === null)
                throw Error(E(162));
            i = e.stateNode,
            o = e.memoizedProps;
            try {
                i.nodeValue = o
            } catch (v) {
                Z(e, e.return, v)
            }
        }
        break;
    case 3:
        if (be(t, e),
        qe(e),
        r & 4 && n !== null && n.memoizedState.isDehydrated)
            try {
                br(t.containerInfo)
            } catch (v) {
                Z(e, e.return, v)
            }
        break;
    case 4:
        be(t, e),
        qe(e);
        break;
    case 13:
        be(t, e),
        qe(e),
        i = e.child,
        i.flags & 8192 && (o = i.memoizedState !== null,
        i.stateNode.isHidden = o,
        !o || i.alternate !== null && i.alternate.memoizedState !== null || (eu = ee())),
        r & 4 && Yc(e);
        break;
    case 22:
        if (c = n !== null && n.memoizedState !== null,
        e.mode & 1 ? (ge = (u = ge) || c,
        be(t, e),
        ge = u) : be(t, e),
        qe(e),
        r & 8192) {
            if (u = e.memoizedState !== null,
            (e.stateNode.isHidden = u) && !c && (e.mode & 1) !== 0)
                for (N = e,
                c = e.child; c !== null; ) {
                    for (f = N = c; N !== null; ) {
                        switch (d = N,
                        g = d.child,
                        d.tag) {
                        case 0:
                        case 11:
                        case 14:
                        case 15:
                            Or(4, d, d.return);
                            break;
                        case 1:
                            On(d, d.return);
                            var y = d.stateNode;
                            if (typeof y.componentWillUnmount == "function") {
                                r = d,
                                n = d.return;
                                try {
                                    t = r,
                                    y.props = t.memoizedProps,
                                    y.state = t.memoizedState,
                                    y.componentWillUnmount()
                                } catch (v) {
                                    Z(r, n, v)
                                }
                            }
                            break;
                        case 5:
                            On(d, d.return);
                            break;
                        case 22:
                            if (d.memoizedState !== null) {
                                Zc(f);
                                continue
                            }
                        }
                        g !== null ? (g.return = d,
                        N = g) : Zc(f)
                    }
                    c = c.sibling
                }
            e: for (c = null,
            f = e; ; ) {
                if (f.tag === 5) {
                    if (c === null) {
                        c = f;
                        try {
                            i = f.stateNode,
                            u ? (o = i.style,
                            typeof o.setProperty == "function" ? o.setProperty("display", "none", "important") : o.display = "none") : (l = f.stateNode,
                            a = f.memoizedProps.style,
                            s = a != null && a.hasOwnProperty("display") ? a.display : null,
                            l.style.display = bd("display", s))
                        } catch (v) {
                            Z(e, e.return, v)
                        }
                    }
                } else if (f.tag === 6) {
                    if (c === null)
                        try {
                            f.stateNode.nodeValue = u ? "" : f.memoizedProps
                        } catch (v) {
                            Z(e, e.return, v)
                        }
                } else if ((f.tag !== 22 && f.tag !== 23 || f.memoizedState === null || f === e) && f.child !== null) {
                    f.child.return = f,
                    f = f.child;
                    continue
                }
                if (f === e)
                    break e;
                for (; f.sibling === null; ) {
                    if (f.return === null || f.return === e)
                        break e;
                    c === f && (c = null),
                    f = f.return
                }
                c === f && (c = null),
                f.sibling.return = f.return,
                f = f.sibling
            }
        }
        break;
    case 19:
        be(t, e),
        qe(e),
        r & 4 && Yc(e);
        break;
    case 21:
        break;
    default:
        be(t, e),
        qe(e)
    }
}
function qe(e) {
    var t = e.flags;
    if (t & 2) {
        try {
            e: {
                for (var n = e.return; n !== null; ) {
                    if (yp(n)) {
                        var r = n;
                        break e
                    }
                    n = n.return
                }
                throw Error(E(160))
            }
            switch (r.tag) {
            case 5:
                var i = r.stateNode;
                r.flags & 32 && (Ur(i, ""),
                r.flags &= -33);
                var o = Qc(e);
                bl(e, o, i);
                break;
            case 3:
            case 4:
                var s = r.stateNode.containerInfo
                  , l = Qc(e);
                Wl(e, l, s);
                break;
            default:
                throw Error(E(161))
            }
        } catch (a) {
            Z(e, e.return, a)
        }
        e.flags &= -3
    }
    t & 4096 && (e.flags &= -4097)
}
function N2(e, t, n) {
    N = e,
    Cp(e)
}
function Cp(e, t, n) {
    for (var r = (e.mode & 1) !== 0; N !== null; ) {
        var i = N
          , o = i.child;
        if (i.tag === 22 && r) {
            var s = i.memoizedState !== null || _i;
            if (!s) {
                var l = i.alternate
                  , a = l !== null && l.memoizedState !== null || ge;
                l = _i;
                var u = ge;
                if (_i = s,
                (ge = a) && !u)
                    for (N = i; N !== null; )
                        s = N,
                        a = s.child,
                        s.tag === 22 && s.memoizedState !== null ? Xc(i) : a !== null ? (a.return = s,
                        N = a) : Xc(i);
                for (; o !== null; )
                    N = o,
                    Cp(o),
                    o = o.sibling;
                N = i,
                _i = l,
                ge = u
            }
            Gc(e)
        } else
            (i.subtreeFlags & 8772) !== 0 && o !== null ? (o.return = i,
            N = o) : Gc(e)
    }
}
function Gc(e) {
    for (; N !== null; ) {
        var t = N;
        if ((t.flags & 8772) !== 0) {
            var n = t.alternate;
            try {
                if ((t.flags & 8772) !== 0)
                    switch (t.tag) {
                    case 0:
                    case 11:
                    case 15:
                        ge || Go(5, t);
                        break;
                    case 1:
                        var r = t.stateNode;
                        if (t.flags & 4 && !ge)
                            if (n === null)
                                r.componentDidMount();
                            else {
                                var i = t.elementType === t.type ? n.memoizedProps : Qe(t.type, n.memoizedProps);
                                r.componentDidUpdate(i, n.memoizedState, r.__reactInternalSnapshotBeforeUpdate)
                            }
                        var o = t.updateQueue;
                        o !== null && Mc(t, o, r);
                        break;
                    case 3:
                        var s = t.updateQueue;
                        if (s !== null) {
                            if (n = null,
                            t.child !== null)
                                switch (t.child.tag) {
                                case 5:
                                    n = t.child.stateNode;
                                    break;
                                case 1:
                                    n = t.child.stateNode
                                }
                            Mc(t, s, n)
                        }
                        break;
                    case 5:
                        var l = t.stateNode;
                        if (n === null && t.flags & 4) {
                            n = l;
                            var a = t.memoizedProps;
                            switch (t.type) {
                            case "button":
                            case "input":
                            case "select":
                            case "textarea":
                                a.autoFocus && n.focus();
                                break;
                            case "img":
                                a.src && (n.src = a.src)
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
                                var c = u.memoizedState;
                                if (c !== null) {
                                    var f = c.dehydrated;
                                    f !== null && br(f)
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
                        throw Error(E(163))
                    }
                ge || t.flags & 512 && $l(t)
            } catch (d) {
                Z(t, t.return, d)
            }
        }
        if (t === e) {
            N = null;
            break
        }
        if (n = t.sibling,
        n !== null) {
            n.return = t.return,
            N = n;
            break
        }
        N = t.return
    }
}
function Zc(e) {
    for (; N !== null; ) {
        var t = N;
        if (t === e) {
            N = null;
            break
        }
        var n = t.sibling;
        if (n !== null) {
            n.return = t.return,
            N = n;
            break
        }
        N = t.return
    }
}
function Xc(e) {
    for (; N !== null; ) {
        var t = N;
        try {
            switch (t.tag) {
            case 0:
            case 11:
            case 15:
                var n = t.return;
                try {
                    Go(4, t)
                } catch (a) {
                    Z(t, n, a)
                }
                break;
            case 1:
                var r = t.stateNode;
                if (typeof r.componentDidMount == "function") {
                    var i = t.return;
                    try {
                        r.componentDidMount()
                    } catch (a) {
                        Z(t, i, a)
                    }
                }
                var o = t.return;
                try {
                    $l(t)
                } catch (a) {
                    Z(t, o, a)
                }
                break;
            case 5:
                var s = t.return;
                try {
                    $l(t)
                } catch (a) {
                    Z(t, s, a)
                }
            }
        } catch (a) {
            Z(t, t.return, a)
        }
        if (t === e) {
            N = null;
            break
        }
        var l = t.sibling;
        if (l !== null) {
            l.return = t.return,
            N = l;
            break
        }
        N = t.return
    }
}
var D2 = Math.ceil
  , Ro = Pt.ReactCurrentDispatcher
  , Ja = Pt.ReactCurrentOwner
  , He = Pt.ReactCurrentBatchConfig
  , _ = 0
  , le = null
  , te = null
  , fe = 0
  , Ae = 0
  , Fn = Gt(0)
  , ie = 0
  , ni = null
  , vn = 0
  , Zo = 0
  , qa = 0
  , Fr = null
  , ke = null
  , eu = 0
  , qn = 1 / 0
  , at = null
  , Lo = !1
  , Kl = null
  , zt = null
  , Bi = !1
  , Vt = null
  , Ao = 0
  , Ir = 0
  , Ql = null
  , Ji = -1
  , qi = 0;
function Ce() {
    return (_ & 6) !== 0 ? ee() : Ji !== -1 ? Ji : Ji = ee()
}
function jt(e) {
    return (e.mode & 1) === 0 ? 1 : (_ & 2) !== 0 && fe !== 0 ? fe & -fe : p2.transition !== null ? (qi === 0 && (qi = ih()),
    qi) : (e = B,
    e !== 0 || (e = window.event,
    e = e === void 0 ? 16 : fh(e.type)),
    e)
}
function Xe(e, t, n, r) {
    if (50 < Ir)
        throw Ir = 0,
        Ql = null,
        Error(E(185));
    ui(e, n, r),
    ((_ & 2) === 0 || e !== le) && (e === le && ((_ & 2) === 0 && (Zo |= n),
    ie === 4 && Dt(e, fe)),
    Le(e, r),
    n === 1 && _ === 0 && (t.mode & 1) === 0 && (qn = ee() + 500,
    Ko && Zt()))
}
function Le(e, t) {
    var n = e.callbackNode;
    p0(e, t);
    var r = fo(e, e === le ? fe : 0);
    if (r === 0)
        n !== null && sc(n),
        e.callbackNode = null,
        e.callbackPriority = 0;
    else if (t = r & -r,
    e.callbackPriority !== t) {
        if (n != null && sc(n),
        t === 1)
            e.tag === 0 ? h2(Jc.bind(null, e)) : Nh(Jc.bind(null, e)),
            u2(function() {
                (_ & 6) === 0 && Zt()
            }),
            n = null;
        else {
            switch (oh(r)) {
            case 1:
                n = Ta;
                break;
            case 4:
                n = nh;
                break;
            case 16:
                n = co;
                break;
            case 536870912:
                n = rh;
                break;
            default:
                n = co
            }
            n = Ap(n, Sp.bind(null, e))
        }
        e.callbackPriority = t,
        e.callbackNode = n
    }
}
function Sp(e, t) {
    if (Ji = -1,
    qi = 0,
    (_ & 6) !== 0)
        throw Error(E(327));
    var n = e.callbackNode;
    if (Kn() && e.callbackNode !== n)
        return null;
    var r = fo(e, e === le ? fe : 0);
    if (r === 0)
        return null;
    if ((r & 30) !== 0 || (r & e.expiredLanes) !== 0 || t)
        t = No(e, r);
    else {
        t = r;
        var i = _;
        _ |= 2;
        var o = kp();
        (le !== e || fe !== t) && (at = null,
        qn = ee() + 500,
        fn(e, t));
        do
            try {
                O2();
                break
            } catch (l) {
                Pp(e, l)
            }
        while (1);
        za(),
        Ro.current = o,
        _ = i,
        te !== null ? t = 0 : (le = null,
        fe = 0,
        t = ie)
    }
    if (t !== 0) {
        if (t === 2 && (i = xl(e),
        i !== 0 && (r = i,
        t = Yl(e, i))),
        t === 1)
            throw n = ni,
            fn(e, 0),
            Dt(e, r),
            Le(e, ee()),
            n;
        if (t === 6)
            Dt(e, r);
        else {
            if (i = e.current.alternate,
            (r & 30) === 0 && !M2(i) && (t = No(e, r),
            t === 2 && (o = xl(e),
            o !== 0 && (r = o,
            t = Yl(e, o))),
            t === 1))
                throw n = ni,
                fn(e, 0),
                Dt(e, r),
                Le(e, ee()),
                n;
            switch (e.finishedWork = i,
            e.finishedLanes = r,
            t) {
            case 0:
            case 1:
                throw Error(E(345));
            case 2:
                rn(e, ke, at);
                break;
            case 3:
                if (Dt(e, r),
                (r & 130023424) === r && (t = eu + 500 - ee(),
                10 < t)) {
                    if (fo(e, 0) !== 0)
                        break;
                    if (i = e.suspendedLanes,
                    (i & r) !== r) {
                        Ce(),
                        e.pingedLanes |= e.suspendedLanes & i;
                        break
                    }
                    e.timeoutHandle = Ll(rn.bind(null, e, ke, at), t);
                    break
                }
                rn(e, ke, at);
                break;
            case 4:
                if (Dt(e, r),
                (r & 4194240) === r)
                    break;
                for (t = e.eventTimes,
                i = -1; 0 < r; ) {
                    var s = 31 - Ze(r);
                    o = 1 << s,
                    s = t[s],
                    s > i && (i = s),
                    r &= ~o
                }
                if (r = i,
                r = ee() - r,
                r = (120 > r ? 120 : 480 > r ? 480 : 1080 > r ? 1080 : 1920 > r ? 1920 : 3e3 > r ? 3e3 : 4320 > r ? 4320 : 1960 * D2(r / 1960)) - r,
                10 < r) {
                    e.timeoutHandle = Ll(rn.bind(null, e, ke, at), r);
                    break
                }
                rn(e, ke, at);
                break;
            case 5:
                rn(e, ke, at);
                break;
            default:
                throw Error(E(329))
            }
        }
    }
    return Le(e, ee()),
    e.callbackNode === n ? Sp.bind(null, e) : null
}
function Yl(e, t) {
    var n = Fr;
    return e.current.memoizedState.isDehydrated && (fn(e, t).flags |= 256),
    e = No(e, t),
    e !== 2 && (t = ke,
    ke = n,
    t !== null && Gl(t)),
    e
}
function Gl(e) {
    ke === null ? ke = e : ke.push.apply(ke, e)
}
function M2(e) {
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
                        if (!Je(o(), i))
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
    for (t &= ~qa,
    t &= ~Zo,
    e.suspendedLanes |= t,
    e.pingedLanes &= ~t,
    e = e.expirationTimes; 0 < t; ) {
        var n = 31 - Ze(t)
          , r = 1 << n;
        e[n] = -1,
        t &= ~r
    }
}
function Jc(e) {
    if ((_ & 6) !== 0)
        throw Error(E(327));
    Kn();
    var t = fo(e, 0);
    if ((t & 1) === 0)
        return Le(e, ee()),
        null;
    var n = No(e, t);
    if (e.tag !== 0 && n === 2) {
        var r = xl(e);
        r !== 0 && (t = r,
        n = Yl(e, r))
    }
    if (n === 1)
        throw n = ni,
        fn(e, 0),
        Dt(e, t),
        Le(e, ee()),
        n;
    if (n === 6)
        throw Error(E(345));
    return e.finishedWork = e.current.alternate,
    e.finishedLanes = t,
    rn(e, ke, at),
    Le(e, ee()),
    null
}
function tu(e, t) {
    var n = _;
    _ |= 1;
    try {
        return e(t)
    } finally {
        _ = n,
        _ === 0 && (qn = ee() + 500,
        Ko && Zt())
    }
}
function yn(e) {
    Vt !== null && Vt.tag === 0 && (_ & 6) === 0 && Kn();
    var t = _;
    _ |= 1;
    var n = He.transition
      , r = B;
    try {
        if (He.transition = null,
        B = 1,
        e)
            return e()
    } finally {
        B = r,
        He.transition = n,
        _ = t,
        (_ & 6) === 0 && Zt()
    }
}
function nu() {
    Ae = Fn.current,
    H(Fn)
}
function fn(e, t) {
    e.finishedWork = null,
    e.finishedLanes = 0;
    var n = e.timeoutHandle;
    if (n !== -1 && (e.timeoutHandle = -1,
    a2(n)),
    te !== null)
        for (n = te.return; n !== null; ) {
            var r = n;
            switch (Ia(r),
            r.tag) {
            case 1:
                r = r.type.childContextTypes,
                r != null && vo();
                break;
            case 3:
                Xn(),
                H(Te),
                H(we),
                ba();
                break;
            case 5:
                Wa(r);
                break;
            case 4:
                Xn();
                break;
            case 13:
                H(W);
                break;
            case 19:
                H(W);
                break;
            case 10:
                ja(r.type._context);
                break;
            case 22:
            case 23:
                nu()
            }
            n = n.return
        }
    if (le = e,
    te = e = Ut(e.current, null),
    fe = Ae = t,
    ie = 0,
    ni = null,
    qa = Zo = vn = 0,
    ke = Fr = null,
    an !== null) {
        for (t = 0; t < an.length; t++)
            if (n = an[t],
            r = n.interleaved,
            r !== null) {
                n.interleaved = null;
                var i = r.next
                  , o = n.pending;
                if (o !== null) {
                    var s = o.next;
                    o.next = i,
                    r.next = s
                }
                n.pending = r
            }
        an = null
    }
    return e
}
function Pp(e, t) {
    do {
        var n = te;
        try {
            if (za(),
            Gi.current = To,
            Eo) {
                for (var r = K.memoizedState; r !== null; ) {
                    var i = r.queue;
                    i !== null && (i.pending = null),
                    r = r.next
                }
                Eo = !1
            }
            if (gn = 0,
            se = re = K = null,
            Vr = !1,
            qr = 0,
            Ja.current = null,
            n === null || n.return === null) {
                ie = 1,
                ni = t,
                te = null;
                break
            }
            e: {
                var o = e
                  , s = n.return
                  , l = n
                  , a = t;
                if (t = fe,
                l.flags |= 32768,
                a !== null && typeof a == "object" && typeof a.then == "function") {
                    var u = a
                      , c = l
                      , f = c.tag;
                    if ((c.mode & 1) === 0 && (f === 0 || f === 11 || f === 15)) {
                        var d = c.alternate;
                        d ? (c.updateQueue = d.updateQueue,
                        c.memoizedState = d.memoizedState,
                        c.lanes = d.lanes) : (c.updateQueue = null,
                        c.memoizedState = null)
                    }
                    var g = zc(s);
                    if (g !== null) {
                        g.flags &= -257,
                        jc(g, s, l, o, t),
                        g.mode & 1 && Bc(o, u, t),
                        t = g,
                        a = u;
                        var y = t.updateQueue;
                        if (y === null) {
                            var v = new Set;
                            v.add(a),
                            t.updateQueue = v
                        } else
                            y.add(a);
                        break e
                    } else {
                        if ((t & 1) === 0) {
                            Bc(o, u, t),
                            ru();
                            break e
                        }
                        a = Error(E(426))
                    }
                } else if ($ && l.mode & 1) {
                    var C = zc(s);
                    if (C !== null) {
                        (C.flags & 65536) === 0 && (C.flags |= 256),
                        jc(C, s, l, o, t),
                        _a(Jn(a, l));
                        break e
                    }
                }
                o = a = Jn(a, l),
                ie !== 4 && (ie = 2),
                Fr === null ? Fr = [o] : Fr.push(o),
                o = s;
                do {
                    switch (o.tag) {
                    case 3:
                        o.flags |= 65536,
                        t &= -t,
                        o.lanes |= t;
                        var p = sp(o, a, t);
                        Dc(o, p);
                        break e;
                    case 1:
                        l = a;
                        var h = o.type
                          , m = o.stateNode;
                        if ((o.flags & 128) === 0 && (typeof h.getDerivedStateFromError == "function" || m !== null && typeof m.componentDidCatch == "function" && (zt === null || !zt.has(m)))) {
                            o.flags |= 65536,
                            t &= -t,
                            o.lanes |= t;
                            var x = lp(o, l, t);
                            Dc(o, x);
                            break e
                        }
                    }
                    o = o.return
                } while (o !== null)
            }
            Tp(n)
        } catch (S) {
            t = S,
            te === n && n !== null && (te = n = n.return);
            continue
        }
        break
    } while (1)
}
function kp() {
    var e = Ro.current;
    return Ro.current = To,
    e === null ? To : e
}
function ru() {
    (ie === 0 || ie === 3 || ie === 2) && (ie = 4),
    le === null || (vn & 268435455) === 0 && (Zo & 268435455) === 0 || Dt(le, fe)
}
function No(e, t) {
    var n = _;
    _ |= 2;
    var r = kp();
    (le !== e || fe !== t) && (at = null,
    fn(e, t));
    do
        try {
            V2();
            break
        } catch (i) {
            Pp(e, i)
        }
    while (1);
    if (za(),
    _ = n,
    Ro.current = r,
    te !== null)
        throw Error(E(261));
    return le = null,
    fe = 0,
    ie
}
function V2() {
    for (; te !== null; )
        Ep(te)
}
function O2() {
    for (; te !== null && !o0(); )
        Ep(te)
}
function Ep(e) {
    var t = Lp(e.alternate, e, Ae);
    e.memoizedProps = e.pendingProps,
    t === null ? Tp(e) : te = t,
    Ja.current = null
}
function Tp(e) {
    var t = e;
    do {
        var n = t.alternate;
        if (e = t.return,
        (t.flags & 32768) === 0) {
            if (n = T2(n, t, Ae),
            n !== null) {
                te = n;
                return
            }
        } else {
            if (n = R2(n, t),
            n !== null) {
                n.flags &= 32767,
                te = n;
                return
            }
            if (e !== null)
                e.flags |= 32768,
                e.subtreeFlags = 0,
                e.deletions = null;
            else {
                ie = 6,
                te = null;
                return
            }
        }
        if (t = t.sibling,
        t !== null) {
            te = t;
            return
        }
        te = t = e
    } while (t !== null);
    ie === 0 && (ie = 5)
}
function rn(e, t, n) {
    var r = B
      , i = He.transition;
    try {
        He.transition = null,
        B = 1,
        F2(e, t, n, r)
    } finally {
        He.transition = i,
        B = r
    }
    return null
}
function F2(e, t, n, r) {
    do
        Kn();
    while (Vt !== null);
    if ((_ & 6) !== 0)
        throw Error(E(327));
    n = e.finishedWork;
    var i = e.finishedLanes;
    if (n === null)
        return null;
    if (e.finishedWork = null,
    e.finishedLanes = 0,
    n === e.current)
        throw Error(E(177));
    e.callbackNode = null,
    e.callbackPriority = 0;
    var o = n.lanes | n.childLanes;
    if (m0(e, o),
    e === le && (te = le = null,
    fe = 0),
    (n.subtreeFlags & 2064) === 0 && (n.flags & 2064) === 0 || Bi || (Bi = !0,
    Ap(co, function() {
        return Kn(),
        null
    })),
    o = (n.flags & 15990) !== 0,
    (n.subtreeFlags & 15990) !== 0 || o) {
        o = He.transition,
        He.transition = null;
        var s = B;
        B = 1;
        var l = _;
        _ |= 4,
        Ja.current = null,
        A2(e, n),
        xp(n, e),
        t2(Tl),
        ho = !!El,
        Tl = El = null,
        e.current = n,
        N2(n),
        s0(),
        _ = l,
        B = s,
        He.transition = o
    } else
        e.current = n;
    if (Bi && (Bi = !1,
    Vt = e,
    Ao = i),
    o = e.pendingLanes,
    o === 0 && (zt = null),
    u0(n.stateNode),
    Le(e, ee()),
    t !== null)
        for (r = e.onRecoverableError,
        n = 0; n < t.length; n++)
            i = t[n],
            r(i.value, {
                componentStack: i.stack,
                digest: i.digest
            });
    if (Lo)
        throw Lo = !1,
        e = Kl,
        Kl = null,
        e;
    return (Ao & 1) !== 0 && e.tag !== 0 && Kn(),
    o = e.pendingLanes,
    (o & 1) !== 0 ? e === Ql ? Ir++ : (Ir = 0,
    Ql = e) : Ir = 0,
    Zt(),
    null
}
function Kn() {
    if (Vt !== null) {
        var e = oh(Ao)
          , t = He.transition
          , n = B;
        try {
            if (He.transition = null,
            B = 16 > e ? 16 : e,
            Vt === null)
                var r = !1;
            else {
                if (e = Vt,
                Vt = null,
                Ao = 0,
                (_ & 6) !== 0)
                    throw Error(E(331));
                var i = _;
                for (_ |= 4,
                N = e.current; N !== null; ) {
                    var o = N
                      , s = o.child;
                    if ((N.flags & 16) !== 0) {
                        var l = o.deletions;
                        if (l !== null) {
                            for (var a = 0; a < l.length; a++) {
                                var u = l[a];
                                for (N = u; N !== null; ) {
                                    var c = N;
                                    switch (c.tag) {
                                    case 0:
                                    case 11:
                                    case 15:
                                        Or(8, c, o)
                                    }
                                    var f = c.child;
                                    if (f !== null)
                                        f.return = c,
                                        N = f;
                                    else
                                        for (; N !== null; ) {
                                            c = N;
                                            var d = c.sibling
                                              , g = c.return;
                                            if (vp(c),
                                            c === u) {
                                                N = null;
                                                break
                                            }
                                            if (d !== null) {
                                                d.return = g,
                                                N = d;
                                                break
                                            }
                                            N = g
                                        }
                                }
                            }
                            var y = o.alternate;
                            if (y !== null) {
                                var v = y.child;
                                if (v !== null) {
                                    y.child = null;
                                    do {
                                        var C = v.sibling;
                                        v.sibling = null,
                                        v = C
                                    } while (v !== null)
                                }
                            }
                            N = o
                        }
                    }
                    if ((o.subtreeFlags & 2064) !== 0 && s !== null)
                        s.return = o,
                        N = s;
                    else
                        e: for (; N !== null; ) {
                            if (o = N,
                            (o.flags & 2048) !== 0)
                                switch (o.tag) {
                                case 0:
                                case 11:
                                case 15:
                                    Or(9, o, o.return)
                                }
                            var p = o.sibling;
                            if (p !== null) {
                                p.return = o.return,
                                N = p;
                                break e
                            }
                            N = o.return
                        }
                }
                var h = e.current;
                for (N = h; N !== null; ) {
                    s = N;
                    var m = s.child;
                    if ((s.subtreeFlags & 2064) !== 0 && m !== null)
                        m.return = s,
                        N = m;
                    else
                        e: for (s = h; N !== null; ) {
                            if (l = N,
                            (l.flags & 2048) !== 0)
                                try {
                                    switch (l.tag) {
                                    case 0:
                                    case 11:
                                    case 15:
                                        Go(9, l)
                                    }
                                } catch (S) {
                                    Z(l, l.return, S)
                                }
                            if (l === s) {
                                N = null;
                                break e
                            }
                            var x = l.sibling;
                            if (x !== null) {
                                x.return = l.return,
                                N = x;
                                break e
                            }
                            N = l.return
                        }
                }
                if (_ = i,
                Zt(),
                nt && typeof nt.onPostCommitFiberRoot == "function")
                    try {
                        nt.onPostCommitFiberRoot(Uo, e)
                    } catch {}
                r = !0
            }
            return r
        } finally {
            B = n,
            He.transition = t
        }
    }
    return !1
}
function qc(e, t, n) {
    t = Jn(n, t),
    t = sp(e, t, 1),
    e = Bt(e, t, 1),
    t = Ce(),
    e !== null && (ui(e, 1, t),
    Le(e, t))
}
function Z(e, t, n) {
    if (e.tag === 3)
        qc(e, e, n);
    else
        for (; t !== null; ) {
            if (t.tag === 3) {
                qc(t, e, n);
                break
            } else if (t.tag === 1) {
                var r = t.stateNode;
                if (typeof t.type.getDerivedStateFromError == "function" || typeof r.componentDidCatch == "function" && (zt === null || !zt.has(r))) {
                    e = Jn(n, e),
                    e = lp(t, e, 1),
                    t = Bt(t, e, 1),
                    e = Ce(),
                    t !== null && (ui(t, 1, e),
                    Le(t, e));
                    break
                }
            }
            t = t.return
        }
}
function I2(e, t, n) {
    var r = e.pingCache;
    r !== null && r.delete(t),
    t = Ce(),
    e.pingedLanes |= e.suspendedLanes & n,
    le === e && (fe & n) === n && (ie === 4 || ie === 3 && (fe & 130023424) === fe && 500 > ee() - eu ? fn(e, 0) : qa |= n),
    Le(e, t)
}
function Rp(e, t) {
    t === 0 && ((e.mode & 1) === 0 ? t = 1 : (t = Li,
    Li <<= 1,
    (Li & 130023424) === 0 && (Li = 4194304)));
    var n = Ce();
    e = wt(e, t),
    e !== null && (ui(e, t, n),
    Le(e, n))
}
function _2(e) {
    var t = e.memoizedState
      , n = 0;
    t !== null && (n = t.retryLane),
    Rp(e, n)
}
function B2(e, t) {
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
        throw Error(E(314))
    }
    r !== null && r.delete(t),
    Rp(e, n)
}
var Lp;
Lp = function(e, t, n) {
    if (e !== null)
        if (e.memoizedProps !== t.pendingProps || Te.current)
            Ee = !0;
        else {
            if ((e.lanes & n) === 0 && (t.flags & 128) === 0)
                return Ee = !1,
                E2(e, t, n);
            Ee = (e.flags & 131072) !== 0
        }
    else
        Ee = !1,
        $ && (t.flags & 1048576) !== 0 && Dh(t, xo, t.index);
    switch (t.lanes = 0,
    t.tag) {
    case 2:
        var r = t.type;
        Xi(e, t),
        e = t.pendingProps;
        var i = Yn(t, we.current);
        bn(t, n),
        i = Qa(null, t, r, e, i, n);
        var o = Ya();
        return t.flags |= 1,
        typeof i == "object" && i !== null && typeof i.render == "function" && i.$$typeof === void 0 ? (t.tag = 1,
        t.memoizedState = null,
        t.updateQueue = null,
        Re(r) ? (o = !0,
        yo(t)) : o = !1,
        t.memoizedState = i.state !== null && i.state !== void 0 ? i.state : null,
        Ha(t),
        i.updater = Qo,
        t.stateNode = i,
        i._reactInternals = t,
        Fl(t, r, e, n),
        t = Bl(null, t, r, !0, o, n)) : (t.tag = 0,
        $ && o && Fa(t),
        xe(null, t, i, n),
        t = t.child),
        t;
    case 16:
        r = t.elementType;
        e: {
            switch (Xi(e, t),
            e = t.pendingProps,
            i = r._init,
            r = i(r._payload),
            t.type = r,
            i = t.tag = j2(r),
            e = Qe(r, e),
            i) {
            case 0:
                t = _l(null, t, r, e, n);
                break e;
            case 1:
                t = $c(null, t, r, e, n);
                break e;
            case 11:
                t = Uc(null, t, r, e, n);
                break e;
            case 14:
                t = Hc(null, t, r, Qe(r.type, e), n);
                break e
            }
            throw Error(E(306, r, ""))
        }
        return t;
    case 0:
        return r = t.type,
        i = t.pendingProps,
        i = t.elementType === r ? i : Qe(r, i),
        _l(e, t, r, i, n);
    case 1:
        return r = t.type,
        i = t.pendingProps,
        i = t.elementType === r ? i : Qe(r, i),
        $c(e, t, r, i, n);
    case 3:
        e: {
            if (fp(t),
            e === null)
                throw Error(E(387));
            r = t.pendingProps,
            o = t.memoizedState,
            i = o.element,
            Fh(e, t),
            Po(t, r, null, n);
            var s = t.memoizedState;
            if (r = s.element,
            o.isDehydrated)
                if (o = {
                    element: r,
                    isDehydrated: !1,
                    cache: s.cache,
                    pendingSuspenseBoundaries: s.pendingSuspenseBoundaries,
                    transitions: s.transitions
                },
                t.updateQueue.baseState = o,
                t.memoizedState = o,
                t.flags & 256) {
                    i = Jn(Error(E(423)), t),
                    t = Wc(e, t, r, n, i);
                    break e
                } else if (r !== i) {
                    i = Jn(Error(E(424)), t),
                    t = Wc(e, t, r, n, i);
                    break e
                } else
                    for (Ne = _t(t.stateNode.containerInfo.firstChild),
                    De = t,
                    $ = !0,
                    Ge = null,
                    n = zh(t, null, r, n),
                    t.child = n; n; )
                        n.flags = n.flags & -3 | 4096,
                        n = n.sibling;
            else {
                if (Gn(),
                r === i) {
                    t = xt(e, t, n);
                    break e
                }
                xe(e, t, r, n)
            }
            t = t.child
        }
        return t;
    case 5:
        return jh(t),
        e === null && Ml(t),
        r = t.type,
        i = t.pendingProps,
        o = e !== null ? e.memoizedProps : null,
        s = i.children,
        Rl(r, i) ? s = null : o !== null && Rl(r, o) && (t.flags |= 32),
        cp(e, t),
        xe(e, t, s, n),
        t.child;
    case 6:
        return e === null && Ml(t),
        null;
    case 13:
        return dp(e, t, n);
    case 4:
        return $a(t, t.stateNode.containerInfo),
        r = t.pendingProps,
        e === null ? t.child = Zn(t, null, r, n) : xe(e, t, r, n),
        t.child;
    case 11:
        return r = t.type,
        i = t.pendingProps,
        i = t.elementType === r ? i : Qe(r, i),
        Uc(e, t, r, i, n);
    case 7:
        return xe(e, t, t.pendingProps, n),
        t.child;
    case 8:
        return xe(e, t, t.pendingProps.children, n),
        t.child;
    case 12:
        return xe(e, t, t.pendingProps.children, n),
        t.child;
    case 10:
        e: {
            if (r = t.type._context,
            i = t.pendingProps,
            o = t.memoizedProps,
            s = i.value,
            j(Co, r._currentValue),
            r._currentValue = s,
            o !== null)
                if (Je(o.value, s)) {
                    if (o.children === i.children && !Te.current) {
                        t = xt(e, t, n);
                        break e
                    }
                } else
                    for (o = t.child,
                    o !== null && (o.return = t); o !== null; ) {
                        var l = o.dependencies;
                        if (l !== null) {
                            s = o.child;
                            for (var a = l.firstContext; a !== null; ) {
                                if (a.context === r) {
                                    if (o.tag === 1) {
                                        a = ht(-1, n & -n),
                                        a.tag = 2;
                                        var u = o.updateQueue;
                                        if (u !== null) {
                                            u = u.shared;
                                            var c = u.pending;
                                            c === null ? a.next = a : (a.next = c.next,
                                            c.next = a),
                                            u.pending = a
                                        }
                                    }
                                    o.lanes |= n,
                                    a = o.alternate,
                                    a !== null && (a.lanes |= n),
                                    Vl(o.return, n, t),
                                    l.lanes |= n;
                                    break
                                }
                                a = a.next
                            }
                        } else if (o.tag === 10)
                            s = o.type === t.type ? null : o.child;
                        else if (o.tag === 18) {
                            if (s = o.return,
                            s === null)
                                throw Error(E(341));
                            s.lanes |= n,
                            l = s.alternate,
                            l !== null && (l.lanes |= n),
                            Vl(s, n, t),
                            s = o.sibling
                        } else
                            s = o.child;
                        if (s !== null)
                            s.return = o;
                        else
                            for (s = o; s !== null; ) {
                                if (s === t) {
                                    s = null;
                                    break
                                }
                                if (o = s.sibling,
                                o !== null) {
                                    o.return = s.return,
                                    s = o;
                                    break
                                }
                                s = s.return
                            }
                        o = s
                    }
            xe(e, t, i.children, n),
            t = t.child
        }
        return t;
    case 9:
        return i = t.type,
        r = t.pendingProps.children,
        bn(t, n),
        i = $e(i),
        r = r(i),
        t.flags |= 1,
        xe(e, t, r, n),
        t.child;
    case 14:
        return r = t.type,
        i = Qe(r, t.pendingProps),
        i = Qe(r.type, i),
        Hc(e, t, r, i, n);
    case 15:
        return ap(e, t, t.type, t.pendingProps, n);
    case 17:
        return r = t.type,
        i = t.pendingProps,
        i = t.elementType === r ? i : Qe(r, i),
        Xi(e, t),
        t.tag = 1,
        Re(r) ? (e = !0,
        yo(t)) : e = !1,
        bn(t, n),
        _h(t, r, i),
        Fl(t, r, i, n),
        Bl(null, t, r, !0, e, n);
    case 19:
        return hp(e, t, n);
    case 22:
        return up(e, t, n)
    }
    throw Error(E(156, t.tag))
}
;
function Ap(e, t) {
    return th(e, t)
}
function z2(e, t, n, r) {
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
function Ue(e, t, n, r) {
    return new z2(e,t,n,r)
}
function iu(e) {
    return e = e.prototype,
    !(!e || !e.isReactComponent)
}
function j2(e) {
    if (typeof e == "function")
        return iu(e) ? 1 : 0;
    if (e != null) {
        if (e = e.$$typeof,
        e === Pa)
            return 11;
        if (e === ka)
            return 14
    }
    return 2
}
function Ut(e, t) {
    var n = e.alternate;
    return n === null ? (n = Ue(e.tag, t, e.key, e.mode),
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
function eo(e, t, n, r, i, o) {
    var s = 2;
    if (r = e,
    typeof e == "function")
        iu(e) && (s = 1);
    else if (typeof e == "string")
        s = 5;
    else
        e: switch (e) {
        case En:
            return dn(n.children, i, o, t);
        case Sa:
            s = 8,
            i |= 8;
            break;
        case ol:
            return e = Ue(12, n, t, i | 2),
            e.elementType = ol,
            e.lanes = o,
            e;
        case sl:
            return e = Ue(13, n, t, i),
            e.elementType = sl,
            e.lanes = o,
            e;
        case ll:
            return e = Ue(19, n, t, i),
            e.elementType = ll,
            e.lanes = o,
            e;
        case Bd:
            return Xo(n, i, o, t);
        default:
            if (typeof e == "object" && e !== null)
                switch (e.$$typeof) {
                case Id:
                    s = 10;
                    break e;
                case _d:
                    s = 9;
                    break e;
                case Pa:
                    s = 11;
                    break e;
                case ka:
                    s = 14;
                    break e;
                case Lt:
                    s = 16,
                    r = null;
                    break e
                }
            throw Error(E(130, e == null ? e : typeof e, ""))
        }
    return t = Ue(s, n, t, i),
    t.elementType = e,
    t.type = r,
    t.lanes = o,
    t
}
function dn(e, t, n, r) {
    return e = Ue(7, e, r, t),
    e.lanes = n,
    e
}
function Xo(e, t, n, r) {
    return e = Ue(22, e, r, t),
    e.elementType = Bd,
    e.lanes = n,
    e.stateNode = {
        isHidden: !1
    },
    e
}
function _s(e, t, n) {
    return e = Ue(6, e, null, t),
    e.lanes = n,
    e
}
function Bs(e, t, n) {
    return t = Ue(4, e.children !== null ? e.children : [], e.key, t),
    t.lanes = n,
    t.stateNode = {
        containerInfo: e.containerInfo,
        pendingChildren: null,
        implementation: e.implementation
    },
    t
}
function U2(e, t, n, r, i) {
    this.tag = t,
    this.containerInfo = e,
    this.finishedWork = this.pingCache = this.current = this.pendingChildren = null,
    this.timeoutHandle = -1,
    this.callbackNode = this.pendingContext = this.context = null,
    this.callbackPriority = 0,
    this.eventTimes = ys(0),
    this.expirationTimes = ys(-1),
    this.entangledLanes = this.finishedLanes = this.mutableReadLanes = this.expiredLanes = this.pingedLanes = this.suspendedLanes = this.pendingLanes = 0,
    this.entanglements = ys(0),
    this.identifierPrefix = r,
    this.onRecoverableError = i,
    this.mutableSourceEagerHydrationData = null
}
function ou(e, t, n, r, i, o, s, l, a) {
    return e = new U2(e,t,n,l,a),
    t === 1 ? (t = 1,
    o === !0 && (t |= 8)) : t = 0,
    o = Ue(3, null, null, t),
    e.current = o,
    o.stateNode = e,
    o.memoizedState = {
        element: r,
        isDehydrated: n,
        cache: null,
        transitions: null,
        pendingSuspenseBoundaries: null
    },
    Ha(o),
    e
}
function H2(e, t, n) {
    var r = 3 < arguments.length && arguments[3] !== void 0 ? arguments[3] : null;
    return {
        $$typeof: kn,
        key: r == null ? null : "" + r,
        children: e,
        containerInfo: t,
        implementation: n
    }
}
function Np(e) {
    if (!e)
        return bt;
    e = e._reactInternals;
    e: {
        if (xn(e) !== e || e.tag !== 1)
            throw Error(E(170));
        var t = e;
        do {
            switch (t.tag) {
            case 3:
                t = t.stateNode.context;
                break e;
            case 1:
                if (Re(t.type)) {
                    t = t.stateNode.__reactInternalMemoizedMergedChildContext;
                    break e
                }
            }
            t = t.return
        } while (t !== null);
        throw Error(E(171))
    }
    if (e.tag === 1) {
        var n = e.type;
        if (Re(n))
            return Ah(e, n, t)
    }
    return t
}
function Dp(e, t, n, r, i, o, s, l, a) {
    return e = ou(n, r, !0, e, i, o, s, l, a),
    e.context = Np(null),
    n = e.current,
    r = Ce(),
    i = jt(n),
    o = ht(r, i),
    o.callback = t != null ? t : null,
    Bt(n, o, i),
    e.current.lanes = i,
    ui(e, i, r),
    Le(e, r),
    e
}
function Jo(e, t, n, r) {
    var i = t.current
      , o = Ce()
      , s = jt(i);
    return n = Np(n),
    t.context === null ? t.context = n : t.pendingContext = n,
    t = ht(o, s),
    t.payload = {
        element: e
    },
    r = r === void 0 ? null : r,
    r !== null && (t.callback = r),
    e = Bt(i, t, s),
    e !== null && (Xe(e, i, s, o),
    Yi(e, i, s)),
    s
}
function Do(e) {
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
function ef(e, t) {
    if (e = e.memoizedState,
    e !== null && e.dehydrated !== null) {
        var n = e.retryLane;
        e.retryLane = n !== 0 && n < t ? n : t
    }
}
function su(e, t) {
    ef(e, t),
    (e = e.alternate) && ef(e, t)
}
function $2() {
    return null
}
var Mp = typeof reportError == "function" ? reportError : function(e) {
    console.error(e)
}
;
function lu(e) {
    this._internalRoot = e
}
qo.prototype.render = lu.prototype.render = function(e) {
    var t = this._internalRoot;
    if (t === null)
        throw Error(E(409));
    Jo(e, t, null, null)
}
;
qo.prototype.unmount = lu.prototype.unmount = function() {
    var e = this._internalRoot;
    if (e !== null) {
        this._internalRoot = null;
        var t = e.containerInfo;
        yn(function() {
            Jo(null, e, null, null)
        }),
        t[yt] = null
    }
}
;
function qo(e) {
    this._internalRoot = e
}
qo.prototype.unstable_scheduleHydration = function(e) {
    if (e) {
        var t = ah();
        e = {
            blockedOn: null,
            target: e,
            priority: t
        };
        for (var n = 0; n < Nt.length && t !== 0 && t < Nt[n].priority; n++)
            ;
        Nt.splice(n, 0, e),
        n === 0 && ch(e)
    }
}
;
function au(e) {
    return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11)
}
function es(e) {
    return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11 && (e.nodeType !== 8 || e.nodeValue !== " react-mount-point-unstable "))
}
function tf() {}
function W2(e, t, n, r, i) {
    if (i) {
        if (typeof r == "function") {
            var o = r;
            r = function() {
                var u = Do(s);
                o.call(u)
            }
        }
        var s = Dp(t, r, e, 0, null, !1, !1, "", tf);
        return e._reactRootContainer = s,
        e[yt] = s.current,
        Yr(e.nodeType === 8 ? e.parentNode : e),
        yn(),
        s
    }
    for (; i = e.lastChild; )
        e.removeChild(i);
    if (typeof r == "function") {
        var l = r;
        r = function() {
            var u = Do(a);
            l.call(u)
        }
    }
    var a = ou(e, 0, !1, null, null, !1, !1, "", tf);
    return e._reactRootContainer = a,
    e[yt] = a.current,
    Yr(e.nodeType === 8 ? e.parentNode : e),
    yn(function() {
        Jo(t, a, n, r)
    }),
    a
}
function ts(e, t, n, r, i) {
    var o = n._reactRootContainer;
    if (o) {
        var s = o;
        if (typeof i == "function") {
            var l = i;
            i = function() {
                var a = Do(s);
                l.call(a)
            }
        }
        Jo(t, s, e, i)
    } else
        s = W2(n, t, e, i, r);
    return Do(s)
}
sh = function(e) {
    switch (e.tag) {
    case 3:
        var t = e.stateNode;
        if (t.current.memoizedState.isDehydrated) {
            var n = Pr(t.pendingLanes);
            n !== 0 && (Ra(t, n | 1),
            Le(t, ee()),
            (_ & 6) === 0 && (qn = ee() + 500,
            Zt()))
        }
        break;
    case 13:
        yn(function() {
            var r = wt(e, 1);
            if (r !== null) {
                var i = Ce();
                Xe(r, e, 1, i)
            }
        }),
        su(e, 1)
    }
}
;
La = function(e) {
    if (e.tag === 13) {
        var t = wt(e, 134217728);
        if (t !== null) {
            var n = Ce();
            Xe(t, e, 134217728, n)
        }
        su(e, 134217728)
    }
}
;
lh = function(e) {
    if (e.tag === 13) {
        var t = jt(e)
          , n = wt(e, t);
        if (n !== null) {
            var r = Ce();
            Xe(n, e, t, r)
        }
        su(e, t)
    }
}
;
ah = function() {
    return B
}
;
uh = function(e, t) {
    var n = B;
    try {
        return B = e,
        t()
    } finally {
        B = n
    }
}
;
vl = function(e, t, n) {
    switch (t) {
    case "input":
        if (cl(e, n),
        t = n.name,
        n.type === "radio" && t != null) {
            for (n = e; n.parentNode; )
                n = n.parentNode;
            for (n = n.querySelectorAll("input[name=" + JSON.stringify("" + t) + '][type="radio"]'),
            t = 0; t < n.length; t++) {
                var r = n[t];
                if (r !== e && r.form === e.form) {
                    var i = bo(r);
                    if (!i)
                        throw Error(E(90));
                    jd(r),
                    cl(r, i)
                }
            }
        }
        break;
    case "textarea":
        Hd(e, n);
        break;
    case "select":
        t = n.value,
        t != null && Un(e, !!n.multiple, t, !1)
    }
}
;
Gd = tu;
Zd = yn;
var b2 = {
    usingClientEntryPoint: !1,
    Events: [fi, An, bo, Qd, Yd, tu]
}
  , vr = {
    findFiberByHostInstance: ln,
    bundleType: 0,
    version: "18.2.0",
    rendererPackageName: "react-dom"
}
  , K2 = {
    bundleType: vr.bundleType,
    version: vr.version,
    rendererPackageName: vr.rendererPackageName,
    rendererConfig: vr.rendererConfig,
    overrideHookState: null,
    overrideHookStateDeletePath: null,
    overrideHookStateRenamePath: null,
    overrideProps: null,
    overridePropsDeletePath: null,
    overridePropsRenamePath: null,
    setErrorHandler: null,
    setSuspenseHandler: null,
    scheduleUpdate: null,
    currentDispatcherRef: Pt.ReactCurrentDispatcher,
    findHostInstanceByFiber: function(e) {
        return e = qd(e),
        e === null ? null : e.stateNode
    },
    findFiberByHostInstance: vr.findFiberByHostInstance || $2,
    findHostInstancesForRefresh: null,
    scheduleRefresh: null,
    scheduleRoot: null,
    setRefreshHandler: null,
    getCurrentFiber: null,
    reconcilerVersion: "18.2.0-next-9e3b772b8-20220608"
};
if (typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ < "u") {
    var zi = __REACT_DEVTOOLS_GLOBAL_HOOK__;
    if (!zi.isDisabled && zi.supportsFiber)
        try {
            Uo = zi.inject(K2),
            nt = zi
        } catch {}
}
Oe.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = b2;
Oe.createPortal = function(e, t) {
    var n = 2 < arguments.length && arguments[2] !== void 0 ? arguments[2] : null;
    if (!au(t))
        throw Error(E(200));
    return H2(e, t, null, n)
}
;
Oe.createRoot = function(e, t) {
    if (!au(e))
        throw Error(E(299));
    var n = !1
      , r = ""
      , i = Mp;
    return t != null && (t.unstable_strictMode === !0 && (n = !0),
    t.identifierPrefix !== void 0 && (r = t.identifierPrefix),
    t.onRecoverableError !== void 0 && (i = t.onRecoverableError)),
    t = ou(e, 1, !1, null, null, n, !1, r, i),
    e[yt] = t.current,
    Yr(e.nodeType === 8 ? e.parentNode : e),
    new lu(t)
}
;
Oe.findDOMNode = function(e) {
    if (e == null)
        return null;
    if (e.nodeType === 1)
        return e;
    var t = e._reactInternals;
    if (t === void 0)
        throw typeof e.render == "function" ? Error(E(188)) : (e = Object.keys(e).join(","),
        Error(E(268, e)));
    return e = qd(t),
    e = e === null ? null : e.stateNode,
    e
}
;
Oe.flushSync = function(e) {
    return yn(e)
}
;
Oe.hydrate = function(e, t, n) {
    if (!es(t))
        throw Error(E(200));
    return ts(null, e, t, !0, n)
}
;
Oe.hydrateRoot = function(e, t, n) {
    if (!au(e))
        throw Error(E(405));
    var r = n != null && n.hydratedSources || null
      , i = !1
      , o = ""
      , s = Mp;
    if (n != null && (n.unstable_strictMode === !0 && (i = !0),
    n.identifierPrefix !== void 0 && (o = n.identifierPrefix),
    n.onRecoverableError !== void 0 && (s = n.onRecoverableError)),
    t = Dp(t, null, e, 1, n != null ? n : null, i, !1, o, s),
    e[yt] = t.current,
    Yr(e),
    r)
        for (e = 0; e < r.length; e++)
            n = r[e],
            i = n._getVersion,
            i = i(n._source),
            t.mutableSourceEagerHydrationData == null ? t.mutableSourceEagerHydrationData = [n, i] : t.mutableSourceEagerHydrationData.push(n, i);
    return new qo(t)
}
;
Oe.render = function(e, t, n) {
    if (!es(t))
        throw Error(E(200));
    return ts(null, e, t, !1, n)
}
;
Oe.unmountComponentAtNode = function(e) {
    if (!es(e))
        throw Error(E(40));
    return e._reactRootContainer ? (yn(function() {
        ts(null, null, e, !1, function() {
            e._reactRootContainer = null,
            e[yt] = null
        })
    }),
    !0) : !1
}
;
Oe.unstable_batchedUpdates = tu;
Oe.unstable_renderSubtreeIntoContainer = function(e, t, n, r) {
    if (!es(n))
        throw Error(E(200));
    if (e == null || e._reactInternals === void 0)
        throw Error(E(38));
    return ts(e, t, n, !1, r)
}
;
Oe.version = "18.2.0-next-9e3b772b8-20220608";
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
    e.exports = Oe
}
)(Dd);
var nf = Dd.exports;
rl.createRoot = nf.createRoot,
rl.hydrateRoot = nf.hydrateRoot;
const Q2 = "modulepreload"
  , Y2 = function(e, t) {
    return new URL(e,t).href
}
  , rf = {}
  , G2 = function(t, n, r) {
    if (!n || n.length === 0)
        return t();
    const i = document.getElementsByTagName("link");
    return Promise.all(n.map(o => {
        if (o = Y2(o, r),
        o in rf)
            return;
        rf[o] = !0;
        const s = o.endsWith(".css")
          , l = s ? '[rel="stylesheet"]' : "";
        if (!!r)
            for (let c = i.length - 1; c >= 0; c--) {
                const f = i[c];
                if (f.href === o && (!s || f.rel === "stylesheet"))
                    return
            }
        else if (document.querySelector(`link[href="${o}"]${l}`))
            return;
        const u = document.createElement("link");
        if (u.rel = s ? "stylesheet" : Q2,
        s || (u.as = "script",
        u.crossOrigin = ""),
        u.href = o,
        document.head.appendChild(u),
        s)
            return new Promise( (c, f) => {
                u.addEventListener("load", c),
                u.addEventListener("error", () => f(new Error(`Unable to preload CSS for ${o}`)))
            }
            )
    }
    )).then( () => t())
};
var uu = {};
Object.defineProperty(uu, "__esModule", {
    value: !0
});
uu.parse = ng;
uu.serialize = rg;
const Z2 = /^[\u0021-\u003A\u003C\u003E-\u007E]+$/
  , X2 = /^[\u0021-\u003A\u003C-\u007E]*$/
  , J2 = /^([.]?[a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?)([.][a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?)*$/i
  , q2 = /^[\u0020-\u003A\u003D-\u007E]*$/
  , eg = Object.prototype.toString
  , tg = ( () => {
    const e = function() {};
    return e.prototype = Object.create(null),
    e
}
)();
function ng(e, t) {
    const n = new tg
      , r = e.length;
    if (r < 2)
        return n;
    const i = (t == null ? void 0 : t.decode) || ig;
    let o = 0;
    do {
        const s = e.indexOf("=", o);
        if (s === -1)
            break;
        const l = e.indexOf(";", o)
          , a = l === -1 ? r : l;
        if (s > a) {
            o = e.lastIndexOf(";", s - 1) + 1;
            continue
        }
        const u = of(e, o, s)
          , c = sf(e, s, u)
          , f = e.slice(u, c);
        if (n[f] === void 0) {
            let d = of(e, s + 1, a)
              , g = sf(e, a, d);
            const y = i(e.slice(d, g));
            n[f] = y
        }
        o = a + 1
    } while (o < r);
    return n
}
function of(e, t, n) {
    do {
        const r = e.charCodeAt(t);
        if (r !== 32 && r !== 9)
            return t
    } while (++t < n);
    return n
}
function sf(e, t, n) {
    for (; t > n; ) {
        const r = e.charCodeAt(--t);
        if (r !== 32 && r !== 9)
            return t + 1
    }
    return n
}
function rg(e, t, n) {
    const r = (n == null ? void 0 : n.encode) || encodeURIComponent;
    if (!Z2.test(e))
        throw new TypeError(`argument name is invalid: ${e}`);
    const i = r(t);
    if (!X2.test(i))
        throw new TypeError(`argument val is invalid: ${t}`);
    let o = e + "=" + i;
    if (!n)
        return o;
    if (n.maxAge !== void 0) {
        if (!Number.isInteger(n.maxAge))
            throw new TypeError(`option maxAge is invalid: ${n.maxAge}`);
        o += "; Max-Age=" + n.maxAge
    }
    if (n.domain) {
        if (!J2.test(n.domain))
            throw new TypeError(`option domain is invalid: ${n.domain}`);
        o += "; Domain=" + n.domain
    }
    if (n.path) {
        if (!q2.test(n.path))
            throw new TypeError(`option path is invalid: ${n.path}`);
        o += "; Path=" + n.path
    }
    if (n.expires) {
        if (!og(n.expires) || !Number.isFinite(n.expires.valueOf()))
            throw new TypeError(`option expires is invalid: ${n.expires}`);
        o += "; Expires=" + n.expires.toUTCString()
    }
    if (n.httpOnly && (o += "; HttpOnly"),
    n.secure && (o += "; Secure"),
    n.partitioned && (o += "; Partitioned"),
    n.priority)
        switch (typeof n.priority == "string" ? n.priority.toLowerCase() : void 0) {
        case "low":
            o += "; Priority=Low";
            break;
        case "medium":
            o += "; Priority=Medium";
            break;
        case "high":
            o += "; Priority=High";
            break;
        default:
            throw new TypeError(`option priority is invalid: ${n.priority}`)
        }
    if (n.sameSite)
        switch (typeof n.sameSite == "string" ? n.sameSite.toLowerCase() : n.sameSite) {
        case !0:
        case "strict":
            o += "; SameSite=Strict";
            break;
        case "lax":
            o += "; SameSite=Lax";
            break;
        case "none":
            o += "; SameSite=None";
            break;
        default:
            throw new TypeError(`option sameSite is invalid: ${n.sameSite}`)
        }
    return o
}
function ig(e) {
    if (e.indexOf("%") === -1)
        return e;
    try {
        return decodeURIComponent(e)
    } catch {
        return e
    }
}
function og(e) {
    return eg.call(e) === "[object Date]"
}
var ns = {
    exports: {}
}
  , rs = {};
/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var sg = w.exports
  , lg = Symbol.for("react.element")
  , ag = Symbol.for("react.fragment")
  , ug = Object.prototype.hasOwnProperty
  , cg = sg.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner
  , fg = {
    key: !0,
    ref: !0,
    __self: !0,
    __source: !0
};
function Vp(e, t, n) {
    var r, i = {}, o = null, s = null;
    n !== void 0 && (o = "" + n),
    t.key !== void 0 && (o = "" + t.key),
    t.ref !== void 0 && (s = t.ref);
    for (r in t)
        ug.call(t, r) && !fg.hasOwnProperty(r) && (i[r] = t[r]);
    if (e && e.defaultProps)
        for (r in t = e.defaultProps,
        t)
            i[r] === void 0 && (i[r] = t[r]);
    return {
        $$typeof: lg,
        type: e,
        key: o,
        ref: s,
        props: i,
        _owner: cg.current
    }
}
rs.Fragment = ag;
rs.jsx = Vp;
rs.jsxs = Vp;
(function(e) {
    e.exports = rs
}
)(ns);
const dg = ns.exports.Fragment
  , P = ns.exports.jsx
  , A = ns.exports.jsxs;
var lf = "popstate";
function hg(e={}) {
    function t(r, i) {
        let {pathname: o, search: s, hash: l} = r.location;
        return Zl("", {
            pathname: o,
            search: s,
            hash: l
        }, i.state && i.state.usr || null, i.state && i.state.key || "default")
    }
    function n(r, i) {
        return typeof i == "string" ? i : ri(i)
    }
    return mg(t, n, null, e)
}
function Q(e, t) {
    if (e === !1 || e === null || typeof e > "u")
        throw new Error(t)
}
function st(e, t) {
    if (!e) {
        typeof console < "u" && console.warn(t);
        try {
            throw new Error(t)
        } catch {}
    }
}
function pg() {
    return Math.random().toString(36).substring(2, 10)
}
function af(e, t) {
    return {
        usr: e.state,
        key: e.key,
        idx: t
    }
}
function Zl(e, t, n=null, r) {
    return {
        pathname: typeof e == "string" ? e : e.pathname,
        search: "",
        hash: "",
        ...typeof t == "string" ? sr(t) : t,
        state: n,
        key: t && t.key || r || pg()
    }
}
function ri({pathname: e="/", search: t="", hash: n=""}) {
    return t && t !== "?" && (e += t.charAt(0) === "?" ? t : "?" + t),
    n && n !== "#" && (e += n.charAt(0) === "#" ? n : "#" + n),
    e
}
function sr(e) {
    let t = {};
    if (e) {
        let n = e.indexOf("#");
        n >= 0 && (t.hash = e.substring(n),
        e = e.substring(0, n));
        let r = e.indexOf("?");
        r >= 0 && (t.search = e.substring(r),
        e = e.substring(0, r)),
        e && (t.pathname = e)
    }
    return t
}
function mg(e, t, n, r={}) {
    let {window: i=document.defaultView, v5Compat: o=!1} = r
      , s = i.history
      , l = "POP"
      , a = null
      , u = c();
    u == null && (u = 0,
    s.replaceState({
        ...s.state,
        idx: u
    }, ""));
    function c() {
        return (s.state || {
            idx: null
        }).idx
    }
    function f() {
        l = "POP";
        let C = c()
          , p = C == null ? null : C - u;
        u = C,
        a && a({
            action: l,
            location: v.location,
            delta: p
        })
    }
    function d(C, p) {
        l = "PUSH";
        let h = Zl(v.location, C, p);
        n && n(h, C),
        u = c() + 1;
        let m = af(h, u)
          , x = v.createHref(h);
        try {
            s.pushState(m, "", x)
        } catch (S) {
            if (S instanceof DOMException && S.name === "DataCloneError")
                throw S;
            i.location.assign(x)
        }
        o && a && a({
            action: l,
            location: v.location,
            delta: 1
        })
    }
    function g(C, p) {
        l = "REPLACE";
        let h = Zl(v.location, C, p);
        n && n(h, C),
        u = c();
        let m = af(h, u)
          , x = v.createHref(h);
        s.replaceState(m, "", x),
        o && a && a({
            action: l,
            location: v.location,
            delta: 0
        })
    }
    function y(C) {
        let p = i.location.origin !== "null" ? i.location.origin : i.location.href
          , h = typeof C == "string" ? C : ri(C);
        return h = h.replace(/ $/, "%20"),
        Q(p, `No window.location.(origin|href) available to create URL for href: ${h}`),
        new URL(h,p)
    }
    let v = {
        get action() {
            return l
        },
        get location() {
            return e(i, s)
        },
        listen(C) {
            if (a)
                throw new Error("A history only accepts one active listener");
            return i.addEventListener(lf, f),
            a = C,
            () => {
                i.removeEventListener(lf, f),
                a = null
            }
        },
        createHref(C) {
            return t(i, C)
        },
        createURL: y,
        encodeLocation(C) {
            let p = y(C);
            return {
                pathname: p.pathname,
                search: p.search,
                hash: p.hash
            }
        },
        push: d,
        replace: g,
        go(C) {
            return s.go(C)
        }
    };
    return v
}
function Op(e, t, n="/") {
    return gg(e, t, n, !1)
}
function gg(e, t, n, r) {
    let i = typeof t == "string" ? sr(t) : t
      , o = Kt(i.pathname || "/", n);
    if (o == null)
        return null;
    let s = Fp(e);
    vg(s);
    let l = null;
    for (let a = 0; l == null && a < s.length; ++a) {
        let u = Lg(o);
        l = Tg(s[a], u, r)
    }
    return l
}
function Fp(e, t=[], n=[], r="") {
    let i = (o, s, l) => {
        let a = {
            relativePath: l === void 0 ? o.path || "" : l,
            caseSensitive: o.caseSensitive === !0,
            childrenIndex: s,
            route: o
        };
        a.relativePath.startsWith("/") && (Q(a.relativePath.startsWith(r), `Absolute route path "${a.relativePath}" nested under path "${r}" is not valid. An absolute child route path must start with the combined path of all its parent routes.`),
        a.relativePath = a.relativePath.slice(r.length));
        let u = pt([r, a.relativePath])
          , c = n.concat(a);
        o.children && o.children.length > 0 && (Q(o.index !== !0, `Index routes must not have child routes. Please remove all child routes from route path "${u}".`),
        Fp(o.children, t, c, u)),
        !(o.path == null && !o.index) && t.push({
            path: u,
            score: kg(u, o.index),
            routesMeta: c
        })
    }
    ;
    return e.forEach( (o, s) => {
        var l;
        if (o.path === "" || !((l = o.path) != null && l.includes("?")))
            i(o, s);
        else
            for (let a of Ip(o.path))
                i(o, s, a)
    }
    ),
    t
}
function Ip(e) {
    let t = e.split("/");
    if (t.length === 0)
        return [];
    let[n,...r] = t
      , i = n.endsWith("?")
      , o = n.replace(/\?$/, "");
    if (r.length === 0)
        return i ? [o, ""] : [o];
    let s = Ip(r.join("/"))
      , l = [];
    return l.push(...s.map(a => a === "" ? o : [o, a].join("/"))),
    i && l.push(...s),
    l.map(a => e.startsWith("/") && a === "" ? "/" : a)
}
function vg(e) {
    e.sort( (t, n) => t.score !== n.score ? n.score - t.score : Eg(t.routesMeta.map(r => r.childrenIndex), n.routesMeta.map(r => r.childrenIndex)))
}
var yg = /^:[\w-]+$/
  , wg = 3
  , xg = 2
  , Cg = 1
  , Sg = 10
  , Pg = -2
  , uf = e => e === "*";
function kg(e, t) {
    let n = e.split("/")
      , r = n.length;
    return n.some(uf) && (r += Pg),
    t && (r += xg),
    n.filter(i => !uf(i)).reduce( (i, o) => i + (yg.test(o) ? wg : o === "" ? Cg : Sg), r)
}
function Eg(e, t) {
    return e.length === t.length && e.slice(0, -1).every( (r, i) => r === t[i]) ? e[e.length - 1] - t[t.length - 1] : 0
}
function Tg(e, t, n=!1) {
    let {routesMeta: r} = e
      , i = {}
      , o = "/"
      , s = [];
    for (let l = 0; l < r.length; ++l) {
        let a = r[l]
          , u = l === r.length - 1
          , c = o === "/" ? t : t.slice(o.length) || "/"
          , f = Mo({
            path: a.relativePath,
            caseSensitive: a.caseSensitive,
            end: u
        }, c)
          , d = a.route;
        if (!f && u && n && !r[r.length - 1].route.index && (f = Mo({
            path: a.relativePath,
            caseSensitive: a.caseSensitive,
            end: !1
        }, c)),
        !f)
            return null;
        Object.assign(i, f.params),
        s.push({
            params: i,
            pathname: pt([o, f.pathname]),
            pathnameBase: Mg(pt([o, f.pathnameBase])),
            route: d
        }),
        f.pathnameBase !== "/" && (o = pt([o, f.pathnameBase]))
    }
    return s
}
function Mo(e, t) {
    typeof e == "string" && (e = {
        path: e,
        caseSensitive: !1,
        end: !0
    });
    let[n,r] = Rg(e.path, e.caseSensitive, e.end)
      , i = t.match(n);
    if (!i)
        return null;
    let o = i[0]
      , s = o.replace(/(.)\/+$/, "$1")
      , l = i.slice(1);
    return {
        params: r.reduce( (u, {paramName: c, isOptional: f}, d) => {
            if (c === "*") {
                let y = l[d] || "";
                s = o.slice(0, o.length - y.length).replace(/(.)\/+$/, "$1")
            }
            const g = l[d];
            return f && !g ? u[c] = void 0 : u[c] = (g || "").replace(/%2F/g, "/"),
            u
        }
        , {}),
        pathname: o,
        pathnameBase: s,
        pattern: e
    }
}
function Rg(e, t=!1, n=!0) {
    st(e === "*" || !e.endsWith("*") || e.endsWith("/*"), `Route path "${e}" will be treated as if it were "${e.replace(/\*$/, "/*")}" because the \`*\` character must always follow a \`/\` in the pattern. To get rid of this warning, please change the route path to "${e.replace(/\*$/, "/*")}".`);
    let r = []
      , i = "^" + e.replace(/\/*\*?$/, "").replace(/^\/*/, "/").replace(/[\\.*+^${}|()[\]]/g, "\\$&").replace(/\/:([\w-]+)(\?)?/g, (s, l, a) => (r.push({
        paramName: l,
        isOptional: a != null
    }),
    a ? "/?([^\\/]+)?" : "/([^\\/]+)"));
    return e.endsWith("*") ? (r.push({
        paramName: "*"
    }),
    i += e === "*" || e === "/*" ? "(.*)$" : "(?:\\/(.+)|\\/*)$") : n ? i += "\\/*$" : e !== "" && e !== "/" && (i += "(?:(?=\\/|$))"),
    [new RegExp(i,t ? void 0 : "i"), r]
}
function Lg(e) {
    try {
        return e.split("/").map(t => decodeURIComponent(t).replace(/\//g, "%2F")).join("/")
    } catch (t) {
        return st(!1, `The URL path "${e}" could not be decoded because it is is a malformed URL segment. This is probably due to a bad percent encoding (${t}).`),
        e
    }
}
function Kt(e, t) {
    if (t === "/")
        return e;
    if (!e.toLowerCase().startsWith(t.toLowerCase()))
        return null;
    let n = t.endsWith("/") ? t.length - 1 : t.length
      , r = e.charAt(n);
    return r && r !== "/" ? null : e.slice(n) || "/"
}
function Ag(e, t="/") {
    let {pathname: n, search: r="", hash: i=""} = typeof e == "string" ? sr(e) : e;
    return {
        pathname: n ? n.startsWith("/") ? n : Ng(n, t) : t,
        search: Vg(r),
        hash: Og(i)
    }
}
function Ng(e, t) {
    let n = t.replace(/\/+$/, "").split("/");
    return e.split("/").forEach(i => {
        i === ".." ? n.length > 1 && n.pop() : i !== "." && n.push(i)
    }
    ),
    n.length > 1 ? n.join("/") : "/"
}
function zs(e, t, n, r) {
    return `Cannot include a '${e}' character in a manually specified \`to.${t}\` field [${JSON.stringify(r)}].  Please separate it out to the \`to.${n}\` field. Alternatively you may provide the full path as a string in <Link to="..."> and the router will parse it for you.`
}
function Dg(e) {
    return e.filter( (t, n) => n === 0 || t.route.path && t.route.path.length > 0)
}
function _p(e) {
    let t = Dg(e);
    return t.map( (n, r) => r === t.length - 1 ? n.pathname : n.pathnameBase)
}
function Bp(e, t, n, r=!1) {
    let i;
    typeof e == "string" ? i = sr(e) : (i = {
        ...e
    },
    Q(!i.pathname || !i.pathname.includes("?"), zs("?", "pathname", "search", i)),
    Q(!i.pathname || !i.pathname.includes("#"), zs("#", "pathname", "hash", i)),
    Q(!i.search || !i.search.includes("#"), zs("#", "search", "hash", i)));
    let o = e === "" || i.pathname === "", s = o ? "/" : i.pathname, l;
    if (s == null)
        l = n;
    else {
        let f = t.length - 1;
        if (!r && s.startsWith("..")) {
            let d = s.split("/");
            for (; d[0] === ".."; )
                d.shift(),
                f -= 1;
            i.pathname = d.join("/")
        }
        l = f >= 0 ? t[f] : "/"
    }
    let a = Ag(i, l)
      , u = s && s !== "/" && s.endsWith("/")
      , c = (o || s === ".") && n.endsWith("/");
    return !a.pathname.endsWith("/") && (u || c) && (a.pathname += "/"),
    a
}
var pt = e => e.join("/").replace(/\/\/+/g, "/")
  , Mg = e => e.replace(/\/+$/, "").replace(/^\/*/, "/")
  , Vg = e => !e || e === "?" ? "" : e.startsWith("?") ? e : "?" + e
  , Og = e => !e || e === "#" ? "" : e.startsWith("#") ? e : "#" + e;
function Fg(e) {
    return e != null && typeof e.status == "number" && typeof e.statusText == "string" && typeof e.internal == "boolean" && "data"in e
}
var Ig = ["POST", "PUT", "PATCH", "DELETE"];
[...Ig];
var lr = w.exports.createContext(null);
lr.displayName = "DataRouter";
var is = w.exports.createContext(null);
is.displayName = "DataRouterState";
var zp = w.exports.createContext({
    isTransitioning: !1
});
zp.displayName = "ViewTransition";
var _g = w.exports.createContext(new Map);
_g.displayName = "Fetchers";
var Bg = w.exports.createContext(null);
Bg.displayName = "Await";
var lt = w.exports.createContext(null);
lt.displayName = "Navigation";
var hi = w.exports.createContext(null);
hi.displayName = "Location";
var kt = w.exports.createContext({
    outlet: null,
    matches: [],
    isDataRoute: !1
});
kt.displayName = "Route";
var cu = w.exports.createContext(null);
cu.displayName = "RouteError";
function zg(e, {relative: t}={}) {
    Q(pi(), "useHref() may be used only in the context of a <Router> component.");
    let {basename: n, navigator: r} = w.exports.useContext(lt)
      , {hash: i, pathname: o, search: s} = mi(e, {
        relative: t
    })
      , l = o;
    return n !== "/" && (l = o === "/" ? n : pt([n, o])),
    r.createHref({
        pathname: l,
        search: s,
        hash: i
    })
}
function pi() {
    return w.exports.useContext(hi) != null
}
function Cn() {
    return Q(pi(), "useLocation() may be used only in the context of a <Router> component."),
    w.exports.useContext(hi).location
}
var jp = "You should call navigate() in a React.useEffect(), not when your component is first rendered.";
function Up(e) {
    w.exports.useContext(lt).static || w.exports.useLayoutEffect(e)
}
function os() {
    let {isDataRoute: e} = w.exports.useContext(kt);
    return e ? Jg() : jg()
}
function jg() {
    Q(pi(), "useNavigate() may be used only in the context of a <Router> component.");
    let e = w.exports.useContext(lr)
      , {basename: t, navigator: n} = w.exports.useContext(lt)
      , {matches: r} = w.exports.useContext(kt)
      , {pathname: i} = Cn()
      , o = JSON.stringify(_p(r))
      , s = w.exports.useRef(!1);
    return Up( () => {
        s.current = !0
    }
    ),
    w.exports.useCallback( (a, u={}) => {
        if (st(s.current, jp),
        !s.current)
            return;
        if (typeof a == "number") {
            n.go(a);
            return
        }
        let c = Bp(a, JSON.parse(o), i, u.relative === "path");
        e == null && t !== "/" && (c.pathname = c.pathname === "/" ? t : pt([t, c.pathname])),
        (u.replace ? n.replace : n.push)(c, u.state, u)
    }
    , [t, n, o, i, e])
}
w.exports.createContext(null);
function mi(e, {relative: t}={}) {
    let {matches: n} = w.exports.useContext(kt)
      , {pathname: r} = Cn()
      , i = JSON.stringify(_p(n));
    return w.exports.useMemo( () => Bp(e, JSON.parse(i), r, t === "path"), [e, i, r, t])
}
function Ug(e, t) {
    return Hp(e, t)
}
function Hp(e, t, n, r) {
    var p;
    Q(pi(), "useRoutes() may be used only in the context of a <Router> component.");
    let {navigator: i} = w.exports.useContext(lt)
      , {matches: o} = w.exports.useContext(kt)
      , s = o[o.length - 1]
      , l = s ? s.params : {}
      , a = s ? s.pathname : "/"
      , u = s ? s.pathnameBase : "/"
      , c = s && s.route;
    {
        let h = c && c.path || "";
        $p(a, !c || h.endsWith("*") || h.endsWith("*?"), `You rendered descendant <Routes> (or called \`useRoutes()\`) at "${a}" (under <Route path="${h}">) but the parent route path has no trailing "*". This means if you navigate deeper, the parent won't match anymore and therefore the child routes will never render.

Please change the parent <Route path="${h}"> to <Route path="${h === "/" ? "*" : `${h}/*`}">.`)
    }
    let f = Cn(), d;
    if (t) {
        let h = typeof t == "string" ? sr(t) : t;
        Q(u === "/" || ((p = h.pathname) == null ? void 0 : p.startsWith(u)), `When overriding the location using \`<Routes location>\` or \`useRoutes(routes, location)\`, the location pathname must begin with the portion of the URL pathname that was matched by all parent routes. The current pathname base is "${u}" but pathname "${h.pathname}" was given in the \`location\` prop.`),
        d = h
    } else
        d = f;
    let g = d.pathname || "/"
      , y = g;
    if (u !== "/") {
        let h = u.replace(/^\//, "").split("/");
        y = "/" + g.replace(/^\//, "").split("/").slice(h.length).join("/")
    }
    let v = Op(e, {
        pathname: y
    });
    st(c || v != null, `No routes matched location "${d.pathname}${d.search}${d.hash}" `),
    st(v == null || v[v.length - 1].route.element !== void 0 || v[v.length - 1].route.Component !== void 0 || v[v.length - 1].route.lazy !== void 0, `Matched leaf route at location "${d.pathname}${d.search}${d.hash}" does not have an element or Component. This means it will render an <Outlet /> with a null value by default resulting in an "empty" page.`);
    let C = Kg(v && v.map(h => Object.assign({}, h, {
        params: Object.assign({}, l, h.params),
        pathname: pt([u, i.encodeLocation ? i.encodeLocation(h.pathname).pathname : h.pathname]),
        pathnameBase: h.pathnameBase === "/" ? u : pt([u, i.encodeLocation ? i.encodeLocation(h.pathnameBase).pathname : h.pathnameBase])
    })), o, n, r);
    return t && C ? w.exports.createElement(hi.Provider, {
        value: {
            location: {
                pathname: "/",
                search: "",
                hash: "",
                state: null,
                key: "default",
                ...d
            },
            navigationType: "POP"
        }
    }, C) : C
}
function Hg() {
    let e = Xg()
      , t = Fg(e) ? `${e.status} ${e.statusText}` : e instanceof Error ? e.message : JSON.stringify(e)
      , n = e instanceof Error ? e.stack : null
      , r = "rgba(200,200,200, 0.5)"
      , i = {
        padding: "0.5rem",
        backgroundColor: r
    }
      , o = {
        padding: "2px 4px",
        backgroundColor: r
    }
      , s = null;
    return console.error("Error handled by React Router default ErrorBoundary:", e),
    s = w.exports.createElement(w.exports.Fragment, null, w.exports.createElement("p", null, "\u{1F4BF} Hey developer \u{1F44B}"), w.exports.createElement("p", null, "You can provide a way better UX than this when your app throws errors by providing your own ", w.exports.createElement("code", {
        style: o
    }, "ErrorBoundary"), " or", " ", w.exports.createElement("code", {
        style: o
    }, "errorElement"), " prop on your route.")),
    w.exports.createElement(w.exports.Fragment, null, w.exports.createElement("h2", null, "Unexpected Application Error!"), w.exports.createElement("h3", {
        style: {
            fontStyle: "italic"
        }
    }, t), n ? w.exports.createElement("pre", {
        style: i
    }, n) : null, s)
}
var $g = w.exports.createElement(Hg, null)
  , Wg = class extends w.exports.Component {
    constructor(e) {
        super(e),
        this.state = {
            location: e.location,
            revalidation: e.revalidation,
            error: e.error
        }
    }
    static getDerivedStateFromError(e) {
        return {
            error: e
        }
    }
    static getDerivedStateFromProps(e, t) {
        return t.location !== e.location || t.revalidation !== "idle" && e.revalidation === "idle" ? {
            error: e.error,
            location: e.location,
            revalidation: e.revalidation
        } : {
            error: e.error !== void 0 ? e.error : t.error,
            location: t.location,
            revalidation: e.revalidation || t.revalidation
        }
    }
    componentDidCatch(e, t) {
        console.error("React Router caught the following error during render", e, t)
    }
    render() {
        return this.state.error !== void 0 ? w.exports.createElement(kt.Provider, {
            value: this.props.routeContext
        }, w.exports.createElement(cu.Provider, {
            value: this.state.error,
            children: this.props.component
        })) : this.props.children
    }
}
;
function bg({routeContext: e, match: t, children: n}) {
    let r = w.exports.useContext(lr);
    return r && r.static && r.staticContext && (t.route.errorElement || t.route.ErrorBoundary) && (r.staticContext._deepestRenderedBoundaryId = t.route.id),
    w.exports.createElement(kt.Provider, {
        value: e
    }, n)
}
function Kg(e, t=[], n=null, r=null) {
    if (e == null) {
        if (!n)
            return null;
        if (n.errors)
            e = n.matches;
        else if (t.length === 0 && !n.initialized && n.matches.length > 0)
            e = n.matches;
        else
            return null
    }
    let i = e
      , o = n == null ? void 0 : n.errors;
    if (o != null) {
        let a = i.findIndex(u => u.route.id && (o == null ? void 0 : o[u.route.id]) !== void 0);
        Q(a >= 0, `Could not find a matching route for errors on route IDs: ${Object.keys(o).join(",")}`),
        i = i.slice(0, Math.min(i.length, a + 1))
    }
    let s = !1
      , l = -1;
    if (n)
        for (let a = 0; a < i.length; a++) {
            let u = i[a];
            if ((u.route.HydrateFallback || u.route.hydrateFallbackElement) && (l = a),
            u.route.id) {
                let {loaderData: c, errors: f} = n
                  , d = u.route.loader && !c.hasOwnProperty(u.route.id) && (!f || f[u.route.id] === void 0);
                if (u.route.lazy || d) {
                    s = !0,
                    l >= 0 ? i = i.slice(0, l + 1) : i = [i[0]];
                    break
                }
            }
        }
    return i.reduceRight( (a, u, c) => {
        let f, d = !1, g = null, y = null;
        n && (f = o && u.route.id ? o[u.route.id] : void 0,
        g = u.route.errorElement || $g,
        s && (l < 0 && c === 0 ? ($p("route-fallback", !1, "No `HydrateFallback` element provided to render during initial hydration"),
        d = !0,
        y = null) : l === c && (d = !0,
        y = u.route.hydrateFallbackElement || null)));
        let v = t.concat(i.slice(0, c + 1))
          , C = () => {
            let p;
            return f ? p = g : d ? p = y : u.route.Component ? p = w.exports.createElement(u.route.Component, null) : u.route.element ? p = u.route.element : p = a,
            w.exports.createElement(bg, {
                match: u,
                routeContext: {
                    outlet: a,
                    matches: v,
                    isDataRoute: n != null
                },
                children: p
            })
        }
        ;
        return n && (u.route.ErrorBoundary || u.route.errorElement || c === 0) ? w.exports.createElement(Wg, {
            location: n.location,
            revalidation: n.revalidation,
            component: g,
            error: f,
            children: C(),
            routeContext: {
                outlet: null,
                matches: v,
                isDataRoute: !0
            }
        }) : C()
    }
    , null)
}
function fu(e) {
    return `${e} must be used within a data router.  See https://reactrouter.com/en/main/routers/picking-a-router.`
}
function Qg(e) {
    let t = w.exports.useContext(lr);
    return Q(t, fu(e)),
    t
}
function Yg(e) {
    let t = w.exports.useContext(is);
    return Q(t, fu(e)),
    t
}
function Gg(e) {
    let t = w.exports.useContext(kt);
    return Q(t, fu(e)),
    t
}
function du(e) {
    let t = Gg(e)
      , n = t.matches[t.matches.length - 1];
    return Q(n.route.id, `${e} can only be used on routes that contain a unique "id"`),
    n.route.id
}
function Zg() {
    return du("useRouteId")
}
function Xg() {
    var r;
    let e = w.exports.useContext(cu)
      , t = Yg("useRouteError")
      , n = du("useRouteError");
    return e !== void 0 ? e : (r = t.errors) == null ? void 0 : r[n]
}
function Jg() {
    let {router: e} = Qg("useNavigate")
      , t = du("useNavigate")
      , n = w.exports.useRef(!1);
    return Up( () => {
        n.current = !0
    }
    ),
    w.exports.useCallback(async (i, o={}) => {
        st(n.current, jp),
        n.current && (typeof i == "number" ? e.navigate(i) : await e.navigate(i, {
            fromRouteId: t,
            ...o
        }))
    }
    , [e, t])
}
var cf = {};
function $p(e, t, n) {
    !t && !cf[e] && (cf[e] = !0,
    st(!1, n))
}
w.exports.memo(qg);
function qg({routes: e, future: t, state: n}) {
    return Hp(e, void 0, n, t)
}
function Xl(e) {
    Q(!1, "A <Route> is only ever to be used as the child of <Routes> element, never rendered directly. Please wrap your <Route> in a <Routes>.")
}
function ev({basename: e="/", children: t=null, location: n, navigationType: r="POP", navigator: i, static: o=!1}) {
    Q(!pi(), "You cannot render a <Router> inside another <Router>. You should never have more than one in your app.");
    let s = e.replace(/^\/*/, "/")
      , l = w.exports.useMemo( () => ({
        basename: s,
        navigator: i,
        static: o,
        future: {}
    }), [s, i, o]);
    typeof n == "string" && (n = sr(n));
    let {pathname: a="/", search: u="", hash: c="", state: f=null, key: d="default"} = n
      , g = w.exports.useMemo( () => {
        let y = Kt(a, s);
        return y == null ? null : {
            location: {
                pathname: y,
                search: u,
                hash: c,
                state: f,
                key: d
            },
            navigationType: r
        }
    }
    , [s, a, u, c, f, d, r]);
    return st(g != null, `<Router basename="${s}"> is not able to match the URL "${a}${u}${c}" because it does not start with the basename, so the <Router> won't render anything.`),
    g == null ? null : P(lt.Provider, {
        value: l,
        children: P(hi.Provider, {
            children: t,
            value: g
        })
    })
}
function tv({children: e, location: t}) {
    return Ug(Jl(e), t)
}
function Jl(e, t=[]) {
    let n = [];
    return w.exports.Children.forEach(e, (r, i) => {
        if (!w.exports.isValidElement(r))
            return;
        let o = [...t, i];
        if (r.type === w.exports.Fragment) {
            n.push.apply(n, Jl(r.props.children, o));
            return
        }
        Q(r.type === Xl, `[${typeof r.type == "string" ? r.type : r.type.name}] is not a <Route> component. All component children of <Routes> must be a <Route> or <React.Fragment>`),
        Q(!r.props.index || !r.props.children, "An index route cannot have child routes.");
        let s = {
            id: r.props.id || o.join("-"),
            caseSensitive: r.props.caseSensitive,
            element: r.props.element,
            Component: r.props.Component,
            index: r.props.index,
            path: r.props.path,
            loader: r.props.loader,
            action: r.props.action,
            hydrateFallbackElement: r.props.hydrateFallbackElement,
            HydrateFallback: r.props.HydrateFallback,
            errorElement: r.props.errorElement,
            ErrorBoundary: r.props.ErrorBoundary,
            hasErrorBoundary: r.props.hasErrorBoundary === !0 || r.props.ErrorBoundary != null || r.props.errorElement != null,
            shouldRevalidate: r.props.shouldRevalidate,
            handle: r.props.handle,
            lazy: r.props.lazy
        };
        r.props.children && (s.children = Jl(r.props.children, o)),
        n.push(s)
    }
    ),
    n
}
var to = "get"
  , no = "application/x-www-form-urlencoded";
function ss(e) {
    return e != null && typeof e.tagName == "string"
}
function nv(e) {
    return ss(e) && e.tagName.toLowerCase() === "button"
}
function rv(e) {
    return ss(e) && e.tagName.toLowerCase() === "form"
}
function iv(e) {
    return ss(e) && e.tagName.toLowerCase() === "input"
}
function ov(e) {
    return !!(e.metaKey || e.altKey || e.ctrlKey || e.shiftKey)
}
function sv(e, t) {
    return e.button === 0 && (!t || t === "_self") && !ov(e)
}
var ji = null;
function lv() {
    if (ji === null)
        try {
            new FormData(document.createElement("form"),0),
            ji = !1
        } catch {
            ji = !0
        }
    return ji
}
var av = new Set(["application/x-www-form-urlencoded", "multipart/form-data", "text/plain"]);
function js(e) {
    return e != null && !av.has(e) ? (st(!1, `"${e}" is not a valid \`encType\` for \`<Form>\`/\`<fetcher.Form>\` and will default to "${no}"`),
    null) : e
}
function uv(e, t) {
    let n, r, i, o, s;
    if (rv(e)) {
        let l = e.getAttribute("action");
        r = l ? Kt(l, t) : null,
        n = e.getAttribute("method") || to,
        i = js(e.getAttribute("enctype")) || no,
        o = new FormData(e)
    } else if (nv(e) || iv(e) && (e.type === "submit" || e.type === "image")) {
        let l = e.form;
        if (l == null)
            throw new Error('Cannot submit a <button> or <input type="submit"> without a <form>');
        let a = e.getAttribute("formaction") || l.getAttribute("action");
        if (r = a ? Kt(a, t) : null,
        n = e.getAttribute("formmethod") || l.getAttribute("method") || to,
        i = js(e.getAttribute("formenctype")) || js(l.getAttribute("enctype")) || no,
        o = new FormData(l,e),
        !lv()) {
            let {name: u, type: c, value: f} = e;
            if (c === "image") {
                let d = u ? `${u}.` : "";
                o.append(`${d}x`, "0"),
                o.append(`${d}y`, "0")
            } else
                u && o.append(u, f)
        }
    } else {
        if (ss(e))
            throw new Error('Cannot submit element that is not <form>, <button>, or <input type="submit|image">');
        n = to,
        r = null,
        i = no,
        s = e
    }
    return o && i === "text/plain" && (s = o,
    o = void 0),
    {
        action: r,
        method: n.toLowerCase(),
        encType: i,
        formData: o,
        body: s
    }
}
function hu(e, t) {
    if (e === !1 || e === null || typeof e > "u")
        throw new Error(t)
}
async function cv(e, t) {
    if (e.id in t)
        return t[e.id];
    try {
        let n = await G2( () => import(e.module), [], import.meta.url);
        return t[e.id] = n,
        n
    } catch (n) {
        return console.error(`Error loading route module \`${e.module}\`, reloading page...`),
        console.error(n),
        window.__reactRouterContext && window.__reactRouterContext.isSpaMode,
        window.location.reload(),
        new Promise( () => {}
        )
    }
}
function fv(e) {
    return e != null && typeof e.page == "string"
}
function dv(e) {
    return e == null ? !1 : e.href == null ? e.rel === "preload" && typeof e.imageSrcSet == "string" && typeof e.imageSizes == "string" : typeof e.rel == "string" && typeof e.href == "string"
}
async function hv(e, t, n) {
    let r = await Promise.all(e.map(async i => {
        let o = t.routes[i.route.id];
        if (o) {
            let s = await cv(o, n);
            return s.links ? s.links() : []
        }
        return []
    }
    ));
    return vv(r.flat(1).filter(dv).filter(i => i.rel === "stylesheet" || i.rel === "preload").map(i => i.rel === "stylesheet" ? {
        ...i,
        rel: "prefetch",
        as: "style"
    } : {
        ...i,
        rel: "prefetch"
    }))
}
function ff(e, t, n, r, i, o) {
    let s = (a, u) => n[u] ? a.route.id !== n[u].route.id : !0
      , l = (a, u) => {
        var c;
        return n[u].pathname !== a.pathname || ((c = n[u].route.path) == null ? void 0 : c.endsWith("*")) && n[u].params["*"] !== a.params["*"]
    }
    ;
    return o === "assets" ? t.filter( (a, u) => s(a, u) || l(a, u)) : o === "data" ? t.filter( (a, u) => {
        var f;
        let c = r.routes[a.route.id];
        if (!c || !c.hasLoader)
            return !1;
        if (s(a, u) || l(a, u))
            return !0;
        if (a.route.shouldRevalidate) {
            let d = a.route.shouldRevalidate({
                currentUrl: new URL(i.pathname + i.search + i.hash,window.origin),
                currentParams: ((f = n[0]) == null ? void 0 : f.params) || {},
                nextUrl: new URL(e,window.origin),
                nextParams: a.params,
                defaultShouldRevalidate: !0
            });
            if (typeof d == "boolean")
                return d
        }
        return !0
    }
    ) : []
}
function pv(e, t) {
    return mv(e.map(n => {
        let r = t.routes[n.route.id];
        if (!r)
            return [];
        let i = [r.module];
        return r.imports && (i = i.concat(r.imports)),
        i
    }
    ).flat(1))
}
function mv(e) {
    return [...new Set(e)]
}
function gv(e) {
    let t = {}
      , n = Object.keys(e).sort();
    for (let r of n)
        t[r] = e[r];
    return t
}
function vv(e, t) {
    let n = new Set
      , r = new Set(t);
    return e.reduce( (i, o) => {
        if (t && !fv(o) && o.as === "script" && o.href && r.has(o.href))
            return i;
        let l = JSON.stringify(gv(o));
        return n.has(l) || (n.add(l),
        i.push({
            key: l,
            link: o
        })),
        i
    }
    , [])
}
function yv(e) {
    let t = typeof e == "string" ? new URL(e,typeof window > "u" ? "server://singlefetch/" : window.location.origin) : e;
    return t.pathname === "/" ? t.pathname = "_root.data" : t.pathname = `${t.pathname.replace(/\/$/, "")}.data`,
    t
}
function wv() {
    let e = w.exports.useContext(lr);
    return hu(e, "You must render this element inside a <DataRouterContext.Provider> element"),
    e
}
function xv() {
    let e = w.exports.useContext(is);
    return hu(e, "You must render this element inside a <DataRouterStateContext.Provider> element"),
    e
}
var pu = w.exports.createContext(void 0);
pu.displayName = "FrameworkContext";
function Wp() {
    let e = w.exports.useContext(pu);
    return hu(e, "You must render this element inside a <HydratedRouter> element"),
    e
}
function Cv(e, t) {
    let n = w.exports.useContext(pu)
      , [r,i] = w.exports.useState(!1)
      , [o,s] = w.exports.useState(!1)
      , {onFocus: l, onBlur: a, onMouseEnter: u, onMouseLeave: c, onTouchStart: f} = t
      , d = w.exports.useRef(null);
    w.exports.useEffect( () => {
        if (e === "render" && s(!0),
        e === "viewport") {
            let v = p => {
                p.forEach(h => {
                    s(h.isIntersecting)
                }
                )
            }
              , C = new IntersectionObserver(v,{
                threshold: .5
            });
            return d.current && C.observe(d.current),
            () => {
                C.disconnect()
            }
        }
    }
    , [e]),
    w.exports.useEffect( () => {
        if (r) {
            let v = setTimeout( () => {
                s(!0)
            }
            , 100);
            return () => {
                clearTimeout(v)
            }
        }
    }
    , [r]);
    let g = () => {
        i(!0)
    }
      , y = () => {
        i(!1),
        s(!1)
    }
    ;
    return n ? e !== "intent" ? [o, d, {}] : [o, d, {
        onFocus: yr(l, g),
        onBlur: yr(a, y),
        onMouseEnter: yr(u, g),
        onMouseLeave: yr(c, y),
        onTouchStart: yr(f, g)
    }] : [!1, d, {}]
}
function yr(e, t) {
    return n => {
        e && e(n),
        n.defaultPrevented || t(n)
    }
}
function Sv({page: e, ...t}) {
    let {router: n} = wv()
      , r = w.exports.useMemo( () => Op(n.routes, e, n.basename), [n.routes, e, n.basename]);
    return r ? w.exports.createElement(kv, {
        page: e,
        matches: r,
        ...t
    }) : (console.warn(`Tried to prefetch ${e} but no routes matched.`),
    null)
}
function Pv(e) {
    let {manifest: t, routeModules: n} = Wp()
      , [r,i] = w.exports.useState([]);
    return w.exports.useEffect( () => {
        let o = !1;
        return hv(e, t, n).then(s => {
            o || i(s)
        }
        ),
        () => {
            o = !0
        }
    }
    , [e, t, n]),
    r
}
function kv({page: e, matches: t, ...n}) {
    let r = Cn()
      , {manifest: i, routeModules: o} = Wp()
      , {loaderData: s, matches: l} = xv()
      , a = w.exports.useMemo( () => ff(e, t, l, i, r, "data"), [e, t, l, i, r])
      , u = w.exports.useMemo( () => ff(e, t, l, i, r, "assets"), [e, t, l, i, r])
      , c = w.exports.useMemo( () => {
        if (e === r.pathname + r.search + r.hash)
            return [];
        let g = new Set
          , y = !1;
        if (t.forEach(C => {
            var h;
            let p = i.routes[C.route.id];
            !p || !p.hasLoader || (!a.some(m => m.route.id === C.route.id) && C.route.id in s && ((h = o[C.route.id]) == null ? void 0 : h.shouldRevalidate) || p.hasClientLoader ? y = !0 : g.add(C.route.id))
        }
        ),
        g.size === 0)
            return [];
        let v = yv(e);
        return y && g.size > 0 && v.searchParams.set("_routes", t.filter(C => g.has(C.route.id)).map(C => C.route.id).join(",")),
        [v.pathname + v.search]
    }
    , [s, r, i, a, t, e, o])
      , f = w.exports.useMemo( () => pv(u, i), [u, i])
      , d = Pv(u);
    return w.exports.createElement(w.exports.Fragment, null, c.map(g => w.exports.createElement("link", {
        key: g,
        rel: "prefetch",
        as: "fetch",
        href: g,
        ...n
    })), f.map(g => w.exports.createElement("link", {
        key: g,
        rel: "modulepreload",
        href: g,
        ...n
    })), d.map( ({key: g, link: y}) => w.exports.createElement("link", {
        key: g,
        ...y
    })))
}
function Ev(...e) {
    return t => {
        e.forEach(n => {
            typeof n == "function" ? n(t) : n != null && (n.current = t)
        }
        )
    }
}
var bp = typeof window < "u" && typeof window.document < "u" && typeof window.document.createElement < "u";
try {
    bp && (window.__reactRouterVersion = "7.0.2")
} catch {}
function Tv({basename: e, children: t, window: n}) {
    let r = w.exports.useRef();
    r.current == null && (r.current = hg({
        window: n,
        v5Compat: !0
    }));
    let i = r.current
      , [o,s] = w.exports.useState({
        action: i.action,
        location: i.location
    })
      , l = w.exports.useCallback(a => {
        w.exports.startTransition( () => s(a))
    }
    , [s]);
    return w.exports.useLayoutEffect( () => i.listen(l), [i, l]),
    w.exports.createElement(ev, {
        basename: e,
        children: t,
        location: o.location,
        navigationType: o.action,
        navigator: i
    })
}
var Kp = /^(?:[a-z][a-z0-9+.-]*:|\/\/)/i
  , Qp = w.exports.forwardRef(function({onClick: t, discover: n="render", prefetch: r="none", relative: i, reloadDocument: o, replace: s, state: l, target: a, to: u, preventScrollReset: c, viewTransition: f, ...d}, g) {
    let {basename: y} = w.exports.useContext(lt), v = typeof u == "string" && Kp.test(u), C, p = !1;
    if (typeof u == "string" && v && (C = u,
    bp))
        try {
            let V = new URL(window.location.href)
              , D = u.startsWith("//") ? new URL(V.protocol + u) : new URL(u)
              , X = Kt(D.pathname, y);
            D.origin === V.origin && X != null ? u = X + D.search + D.hash : p = !0
        } catch {
            st(!1, `<Link to="${u}"> contains an invalid URL which will probably break when clicked - please update to a valid URL path.`)
        }
    let h = zg(u, {
        relative: i
    })
      , [m,x,S] = Cv(r, d)
      , T = Nv(u, {
        replace: s,
        state: l,
        target: a,
        preventScrollReset: c,
        relative: i,
        viewTransition: f
    });
    function R(V) {
        t && t(V),
        V.defaultPrevented || T(V)
    }
    let k = w.exports.createElement("a", {
        ...d,
        ...S,
        href: C || h,
        onClick: p || o ? t : R,
        ref: Ev(g, x),
        target: a,
        "data-discover": !v && n === "render" ? "true" : void 0
    });
    return m && !v ? w.exports.createElement(w.exports.Fragment, null, k, w.exports.createElement(Sv, {
        page: h
    })) : k
});
Qp.displayName = "Link";
var Rv = w.exports.forwardRef(function({"aria-current": t="page", caseSensitive: n=!1, className: r="", end: i=!1, style: o, to: s, viewTransition: l, children: a, ...u}, c) {
    let f = mi(s, {
        relative: u.relative
    })
      , d = Cn()
      , g = w.exports.useContext(is)
      , {navigator: y, basename: v} = w.exports.useContext(lt)
      , C = g != null && Fv(f) && l === !0
      , p = y.encodeLocation ? y.encodeLocation(f).pathname : f.pathname
      , h = d.pathname
      , m = g && g.navigation && g.navigation.location ? g.navigation.location.pathname : null;
    n || (h = h.toLowerCase(),
    m = m ? m.toLowerCase() : null,
    p = p.toLowerCase()),
    m && v && (m = Kt(m, v) || m);
    const x = p !== "/" && p.endsWith("/") ? p.length - 1 : p.length;
    let S = h === p || !i && h.startsWith(p) && h.charAt(x) === "/", T = m != null && (m === p || !i && m.startsWith(p) && m.charAt(p.length) === "/"), R = {
        isActive: S,
        isPending: T,
        isTransitioning: C
    }, k = S ? t : void 0, V;
    typeof r == "function" ? V = r(R) : V = [r, S ? "active" : null, T ? "pending" : null, C ? "transitioning" : null].filter(Boolean).join(" ");
    let D = typeof o == "function" ? o(R) : o;
    return w.exports.createElement(Qp, {
        ...u,
        "aria-current": k,
        className: V,
        ref: c,
        style: D,
        to: s,
        viewTransition: l
    }, typeof a == "function" ? a(R) : a)
});
Rv.displayName = "NavLink";
var Lv = w.exports.forwardRef( ({discover: e="render", fetcherKey: t, navigate: n, reloadDocument: r, replace: i, state: o, method: s=to, action: l, onSubmit: a, relative: u, preventScrollReset: c, viewTransition: f, ...d}, g) => {
    let y = Vv()
      , v = Ov(l, {
        relative: u
    })
      , C = s.toLowerCase() === "get" ? "get" : "post"
      , p = typeof l == "string" && Kp.test(l)
      , h = m => {
        if (a && a(m),
        m.defaultPrevented)
            return;
        m.preventDefault();
        let x = m.nativeEvent.submitter
          , S = (x == null ? void 0 : x.getAttribute("formmethod")) || s;
        y(x || m.currentTarget, {
            fetcherKey: t,
            method: S,
            navigate: n,
            replace: i,
            state: o,
            relative: u,
            preventScrollReset: c,
            viewTransition: f
        })
    }
    ;
    return w.exports.createElement("form", {
        ref: g,
        method: C,
        action: v,
        onSubmit: r ? a : h,
        ...d,
        "data-discover": !p && e === "render" ? "true" : void 0
    })
}
);
Lv.displayName = "Form";
function Av(e) {
    return `${e} must be used within a data router.  See https://reactrouter.com/en/main/routers/picking-a-router.`
}
function Yp(e) {
    let t = w.exports.useContext(lr);
    return Q(t, Av(e)),
    t
}
function Nv(e, {target: t, replace: n, state: r, preventScrollReset: i, relative: o, viewTransition: s}={}) {
    let l = os()
      , a = Cn()
      , u = mi(e, {
        relative: o
    });
    return w.exports.useCallback(c => {
        if (sv(c, t)) {
            c.preventDefault();
            let f = n !== void 0 ? n : ri(a) === ri(u);
            l(e, {
                replace: f,
                state: r,
                preventScrollReset: i,
                relative: o,
                viewTransition: s
            })
        }
    }
    , [a, l, u, n, r, t, e, i, o, s])
}
var Dv = 0
  , Mv = () => `__${String(++Dv)}__`;
function Vv() {
    let {router: e} = Yp("useSubmit")
      , {basename: t} = w.exports.useContext(lt)
      , n = Zg();
    return w.exports.useCallback(async (r, i={}) => {
        let {action: o, method: s, encType: l, formData: a, body: u} = uv(r, t);
        if (i.navigate === !1) {
            let c = i.fetcherKey || Mv();
            await e.fetch(c, n, i.action || o, {
                preventScrollReset: i.preventScrollReset,
                formData: a,
                body: u,
                formMethod: i.method || s,
                formEncType: i.encType || l,
                flushSync: i.flushSync
            })
        } else
            await e.navigate(i.action || o, {
                preventScrollReset: i.preventScrollReset,
                formData: a,
                body: u,
                formMethod: i.method || s,
                formEncType: i.encType || l,
                replace: i.replace,
                state: i.state,
                fromRouteId: n,
                flushSync: i.flushSync,
                viewTransition: i.viewTransition
            })
    }
    , [e, t, n])
}
function Ov(e, {relative: t}={}) {
    let {basename: n} = w.exports.useContext(lt)
      , r = w.exports.useContext(kt);
    Q(r, "useFormAction must be used inside a RouteContext");
    let[i] = r.matches.slice(-1)
      , o = {
        ...mi(e || ".", {
            relative: t
        })
    }
      , s = Cn();
    if (e == null) {
        o.search = s.search;
        let l = new URLSearchParams(o.search)
          , a = l.getAll("index");
        if (a.some(c => c === "")) {
            l.delete("index"),
            a.filter(f => f).forEach(f => l.append("index", f));
            let c = l.toString();
            o.search = c ? `?${c}` : ""
        }
    }
    return (!e || e === ".") && i.route.index && (o.search = o.search ? o.search.replace(/^\?/, "?index&") : "?index"),
    n !== "/" && (o.pathname = o.pathname === "/" ? n : pt([n, o.pathname])),
    ri(o)
}
function Fv(e, t={}) {
    let n = w.exports.useContext(zp);
    Q(n != null, "`useViewTransitionState` must be used within `react-router-dom`'s `RouterProvider`.  Did you accidentally import `RouterProvider` from `react-router`?");
    let {basename: r} = Yp("useViewTransitionState")
      , i = mi(e, {
        relative: t.relative
    });
    if (!n.isTransitioning)
        return !1;
    let o = Kt(n.currentLocation.pathname, r) || n.currentLocation.pathname
      , s = Kt(n.nextLocation.pathname, r) || n.nextLocation.pathname;
    return Mo(i.pathname, s) != null || Mo(i.pathname, o) != null
}
new TextEncoder;
const Gp = () => !window.invokeNative
  , Iv = () => {}
  , _v = (e, t) => {
    const n = w.exports.useRef(Iv);
    w.exports.useEffect( () => {
        n.current = t
    }
    , [t]),
    w.exports.useEffect( () => {
        const r = i => {
            const {action: o, data: s} = i.data;
            n.current && o === e && n.current(s)
        }
        ;
        return window.addEventListener("message", r),
        () => window.removeEventListener("message", r)
    }
    , [e])
}
;
async function je(e, t, n) {
    const r = {
        method: "post",
        headers: {
            "Content-Type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify(t)
    };
    if (Gp() && n)
        return n;
    const i = window.GetParentResourceName ? window.GetParentResourceName() : "nui-frame-app";
    return await (await fetch(`https://${i}/${e}`, r)).json()
}
const Bv = "" + new URL("background.038f1db2.svg",import.meta.url).href
  , Zp = w.exports.createContext(null)
  , zv = ({children: e}) => {
    const t = os()
      , [n,r] = w.exports.useState(!1)
      , [i,o] = w.exports.useState();
    return _v("setVisible", s => {
        t("*"),
        r(s),
        je("requestInfos", {}, {
            id: 1337,
            age: 20,
            name: "han kalashinikov",
            phone: "123-456",
            org: "Lider [PCC]",
            status: "Namorando",
            avatar: "https://media.discordapp.net/attachments/852964597103329322/1313284255865901159/image.png?ex=674f92c6&is=674e4146&hm=b52ba90f6d8fe53755a9d67285216da58c14f5a625be871271d51e7e25f58e04&=&format=webp&quality=lossless",
            vips: ["vip1", "vip2", "vip3", "vip3", "vip3", "vip3", "vip3", "vip3", "vip3"],
            rankings: {
                online: [{
                    name: "Pedrao",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }],
                famous: [{
                    name: "Psdedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }],
                richs: [{
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }],
                factions: [{
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }, {
                    name: "Pedro",
                    value: "test"
                }]
            }
        }).then(l => o(l))
    }
    ),
    w.exports.useEffect( () => {
        if (!n)
            return;
        const s = l => {
            ["Escape"].includes(l.code) && (Gp() ? r(!1) : je("hideFrame"))
        }
        ;
        return window.addEventListener("keydown", s),
        () => window.removeEventListener("keydown", s)
    }
    , [n, t]),
    P(Zp.Provider, {
        value: {
            data: i,
            visible: n,
            setVisible: r
        },
        children: n && A("div", {
            className: "w-full h-full",
            children: [P("img", {
                src: Bv,
                alt: "",
                className: "absolute top-0 left-0 w-full h-full object-cover"
            }), P(dg, {
                children: e
            })]
        })
    })
}
  , Xp = () => w.exports.useContext(Zp);
var Jp = {
    color: void 0,
    size: void 0,
    className: void 0,
    style: void 0,
    attr: void 0
}
  , df = so.createContext && so.createContext(Jp)
  , jv = ["attr", "size", "title"];
function Uv(e, t) {
    if (e == null)
        return {};
    var n = Hv(e, t), r, i;
    if (Object.getOwnPropertySymbols) {
        var o = Object.getOwnPropertySymbols(e);
        for (i = 0; i < o.length; i++)
            r = o[i],
            !(t.indexOf(r) >= 0) && (!Object.prototype.propertyIsEnumerable.call(e, r) || (n[r] = e[r]))
    }
    return n
}
function Hv(e, t) {
    if (e == null)
        return {};
    var n = {}, r = Object.keys(e), i, o;
    for (o = 0; o < r.length; o++)
        i = r[o],
        !(t.indexOf(i) >= 0) && (n[i] = e[i]);
    return n
}
function hf(e, t) {
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
        t % 2 ? hf(Object(n), !0).forEach(function(r) {
            $v(e, r, n[r])
        }) : Object.getOwnPropertyDescriptors ? Object.defineProperties(e, Object.getOwnPropertyDescriptors(n)) : hf(Object(n)).forEach(function(r) {
            Object.defineProperty(e, r, Object.getOwnPropertyDescriptor(n, r))
        })
    }
    return e
}
function $v(e, t, n) {
    return t = Wv(t),
    t in e ? Object.defineProperty(e, t, {
        value: n,
        enumerable: !0,
        configurable: !0,
        writable: !0
    }) : e[t] = n,
    e
}
function Wv(e) {
    var t = bv(e, "string");
    return typeof t == "symbol" ? t : String(t)
}
function bv(e, t) {
    if (typeof e != "object" || e === null)
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
function qp(e) {
    return e && e.map( (t, n) => so.createElement(t.tag, Vo({
        key: n
    }, t.attr), qp(t.child)))
}
function mu(e) {
    return t => P(Kv, {
        attr: Vo({}, e.attr),
        ...t,
        children: qp(e.child)
    })
}
function Kv(e) {
    var t = n => {
        var {attr: r, size: i, title: o} = e, s = Uv(e, jv), l = i || n.size || "1em", a;
        return n.className && (a = n.className),
        e.className && (a = (a ? a + " " : "") + e.className),
        A("svg", {
            stroke: "currentColor",
            fill: "currentColor",
            strokeWidth: "0",
            ...n.attr,
            ...r,
            ...s,
            className: a,
            style: Vo(Vo({
                color: e.color || n.color
            }, n.style), e.style),
            height: l,
            width: l,
            xmlns: "http://www.w3.org/2000/svg",
            children: [o && P("title", {
                children: o
            }), e.children]
        })
    }
    ;
    return df !== void 0 ? P(df.Consumer, {
        children: n => t(n)
    }) : t(Jp)
}
function Qv(e) {
    return mu({
        tag: "svg",
        attr: {
            viewBox: "0 0 24 24"
        },
        child: [{
            tag: "path",
            attr: {
                d: "M8.52062 13.8456C7.48059 13.8456 6.63159 12.9011 6.63159 11.7444 6.63159 10.5876 7.45936 9.64307 8.52062 9.64307 9.57123 9.64307 10.4308 10.5876 10.4096 11.7444 10.4096 12.9011 9.57123 13.8456 8.52062 13.8456ZM15.4941 13.8456C14.454 13.8456 13.604 12.9011 13.604 11.7444 13.604 10.5876 14.4328 9.64307 15.4941 9.64307 16.5447 9.64307 17.4043 10.5876 17.3831 11.7444 17.3831 12.9011 16.5553 13.8456 15.4941 13.8456ZM10.1253 4.32272 9.81655 3.75977 9.18323 3.86532C7.71915 4.10934 6.32658 4.54652 5.02544 5.1458L4.79651 5.25124 4.65507 5.45985C2.0418 9.31417 1.3258 13.1084 1.68032 16.836L1.71897 17.2423 2.04912 17.4822C3.78851 18.7463 5.47417 19.5186 7.12727 20.0254L7.91657 20.2674 9.03013 17.5504C10.9397 18.0224 13.0592 18.0225 14.969 17.5508L16.0757 20.2681 16.8668 20.0254C18.5173 19.5191 20.2137 18.7469 21.9466 17.4809L22.2726 17.2428 22.3131 16.8412C22.7491 12.521 21.616 8.75749 19.3547 5.45628L19.2128 5.2492 18.9846 5.1448C17.6767 4.5466 16.2852 4.10957 14.8309 3.86549L14.2132 3.76182 13.8987 4.30344C13.8112 4.4542 13.7215 4.6244 13.6364 4.79662 12.5441 4.68445 11.456 4.68421 10.3726 4.79627 10.2882 4.62711 10.2025 4.46356 10.1253 4.32272ZM6.71436 16.61C6.91235 16.724 7.11973 16.8356 7.32557 16.9378L6.8764 18.0338C5.75585 17.6256 4.61837 17.0635 3.4476 16.2555 3.22313 13.1175 3.86092 9.95075 6.01196 6.68602 6.90962 6.29099 7.8535 5.98255 8.83606 5.77271 8.89631 5.89807 8.95235 6.02042 8.99839 6.12892L9.27128 6.77213 9.96259 6.67074C11.3152 6.47235 12.6772 6.47209 14.0523 6.671L14.7424 6.77082 15.0147 6.12892C15.0621 6.01719 15.1167 5.89523 15.1743 5.77298 16.1525 5.98301 17.098 6.29188 18.0029 6.68787 19.8781 9.50833 20.8241 12.6541 20.5486 16.255 19.3837 17.0623 18.2422 17.6246 17.1193 18.0333L16.6735 16.9387C16.8799 16.8362 17.0879 16.7243 17.2865 16.61 17.7763 16.3277 18.3039 15.9757 18.6402 15.6395L17.3606 14.36C17.1969 14.5237 16.837 14.7805 16.3831 15.0421 15.9388 15.2981 15.498 15.5049 15.2164 15.598 13.2126 16.2606 10.7883 16.2606 8.78443 15.598 8.50285 15.5049 8.06205 15.2981 7.61772 15.0421 7.16383 14.7805 6.80392 14.5237 6.64017 14.36L5.36065 15.6395C5.6969 15.9757 6.2245 16.3277 6.71436 16.61Z"
            },
            child: []
        }]
    })(e)
}
function Yv(e) {
    return mu({
        tag: "svg",
        attr: {
            viewBox: "0 0 256 256",
            fill: "currentColor"
        },
        child: [{
            tag: "path",
            attr: {
                d: "M128,80a48,48,0,1,0,48,48A48.05,48.05,0,0,0,128,80Zm0,80a32,32,0,1,1,32-32A32,32,0,0,1,128,160ZM176,24H80A56.06,56.06,0,0,0,24,80v96a56.06,56.06,0,0,0,56,56h96a56.06,56.06,0,0,0,56-56V80A56.06,56.06,0,0,0,176,24Zm40,152a40,40,0,0,1-40,40H80a40,40,0,0,1-40-40V80A40,40,0,0,1,80,40h96a40,40,0,0,1,40,40ZM192,76a12,12,0,1,1-12-12A12,12,0,0,1,192,76Z"
            },
            child: []
        }]
    })(e)
}
function Gv(e) {
    return mu({
        tag: "svg",
        attr: {
            viewBox: "0 0 256 256",
            fill: "currentColor"
        },
        child: [{
            tag: "path",
            attr: {
                d: "M224,72a48.05,48.05,0,0,1-48-48,8,8,0,0,0-8-8H128a8,8,0,0,0-8,8V156a20,20,0,1,1-28.57-18.08A8,8,0,0,0,96,130.69V88a8,8,0,0,0-9.4-7.88C50.91,86.48,24,119.1,24,156a76,76,0,0,0,152,0V116.29A103.25,103.25,0,0,0,224,128a8,8,0,0,0,8-8V80A8,8,0,0,0,224,72Zm-8,39.64a87.19,87.19,0,0,1-43.33-16.15A8,8,0,0,0,160,102v54a60,60,0,0,1-120,0c0-25.9,16.64-49.13,40-57.6v27.67A36,36,0,1,0,136,156V32h24.5A64.14,64.14,0,0,0,216,87.5Z"
            },
            child: []
        }]
    })(e)
}
const Zv = "" + new URL("header-background.0bf6dc1b.svg",import.meta.url).href
  , Xv = "" + new URL("logo.4ace7d4c.png",import.meta.url).href;
function e1() {
    const e = os();
    function t() {
        je("OpenCrosshair", null, !0)
    }
    function n() {
        je("OpenTip", null, !0)
    }
    return A("header", {
        className: "relative w-full h-[3.125rem]",
        children: [P("img", {
            src: Xv,
            alt: "Logo",
            className: "absolute left-5 top-1/2 -translate-y-1/2 max-h-[5.625rem]"
        }), A("ul", {
            className: "h-[3.125rem] ml-[13.125rem] flex items-center z-10",
            children: [A("li", {
                onClick: () => e("/"),
                className: "h-full flex items-center justify-center text-white px-[1.12rem] gap-2 cursor-pointer hover:bg-primary border border-transparent hover:border-white/[.15] font-bold text-[.9375rem] leading-[1]",
                children: [P("svg", {
                    width: "18",
                    height: "18",
                    viewBox: "0 0 18 18",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: P("path", {
                        d: "M8.10225 2.19565C8.35553 1.98837 8.67272 1.87512 9 1.87512C9.32728 1.87512 9.64448 1.98837 9.89775 2.19565L14.8384 6.2239C15.0065 6.36173 15.1419 6.53521 15.2347 6.73179C15.3275 6.92837 15.3754 7.14313 15.375 7.36052V14.6674C15.375 15.4725 14.733 16.125 13.9406 16.125H11.9344C11.142 16.125 10.5 15.4725 10.5 14.6674V11.2076C10.5 10.9391 10.2863 10.7216 10.0219 10.7216H7.97813C7.71413 10.7216 7.5 10.9391 7.5 11.2076V14.6674C7.5 15.4725 6.858 16.125 6.06563 16.125H4.05938C3.26738 16.125 2.625 15.4725 2.625 14.6674V7.36052C2.6246 7.14313 2.67253 6.92837 2.76534 6.73179C2.85815 6.53521 2.99352 6.36173 3.16163 6.2239L8.10225 2.19565ZM9.29925 2.95352C9.21483 2.88443 9.1091 2.84668 9 2.84668C8.89091 2.84668 8.78518 2.88443 8.70075 2.95352L3.76013 6.9814C3.70399 7.02731 3.6588 7.08517 3.62786 7.15075C3.59691 7.21634 3.58099 7.288 3.58125 7.36052V14.6674C3.58125 14.9359 3.795 15.1534 4.05938 15.1534H6.06563C6.32963 15.1534 6.54375 14.9359 6.54375 14.6674V11.2076C6.54375 10.4025 7.18613 9.75002 7.97813 9.75002H10.0219C10.8139 9.75002 11.4563 10.4025 11.4563 11.2076V14.6674C11.4563 14.9359 11.67 15.1534 11.9344 15.1534H13.9406C14.2046 15.1534 14.4188 14.9359 14.4188 14.6674V7.36052C14.419 7.28807 14.403 7.21647 14.3721 7.15096C14.3411 7.08544 14.296 7.02764 14.2399 6.98177L9.29925 2.95352Z",
                        fill: "white"
                    })
                }), "IN\xCDCIO"]
            }), A("li", {
                onClick: () => je("action", {
                    action: "map"
                }),
                className: "h-full flex items-center justify-center text-white px-[1.12rem] gap-2 cursor-pointer hover:bg-primary border border-transparent hover:border-white/[.15] font-bold text-[.9375rem] leading-[1]",
                children: [P("svg", {
                    width: "18",
                    height: "18",
                    viewBox: "0 0 18 18",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: P("path", {
                        "fill-rule": "evenodd",
                        "clip-rule": "evenodd",
                        d: "M11.2133 3.00002C11.1634 3.00043 11.1143 3.01098 11.0691 3.03095L6.78324 4.92708L2.49742 3.03108C2.44409 3.0075 2.38538 2.99708 2.32671 3.00081C2.26805 3.00454 2.21131 3.02228 2.16174 3.0524C2.11217 3.08252 2.07137 3.12405 2.0431 3.17315C2.01483 3.22225 2.00001 3.27735 2 3.33335V12.7053C2.00001 12.7689 2.01909 12.8311 2.05498 12.8846C2.09087 12.9382 2.14208 12.9808 2.20258 13.0076L6.63582 14.9689C6.68303 14.9898 6.73454 15.0004 6.7866 15C6.83652 14.9996 6.88579 14.9891 6.93108 14.9691L11.2169 13.0729L15.5027 14.9689C15.556 14.9925 15.6147 15.0029 15.6734 14.9991C15.732 14.9954 15.7888 14.9776 15.8383 14.9475C15.8878 14.9174 15.9286 14.8759 15.9569 14.8268C15.9852 14.7777 16 14.7226 16 14.6667V5.29468C16 5.23115 15.9809 5.16894 15.945 5.11539C15.9091 5.06184 15.8579 5.01917 15.7974 4.99241L11.3642 3.03108C11.3169 3.01016 11.2654 2.99954 11.2133 3.00002ZM11.3731 3.77001L15.3 5.50734V14.1443L11.4251 12.43L11.3731 3.77001ZM10.9534 3.81721L11.0052 12.4312L6.99044 14.2076L6.93878 5.59348L10.9534 3.81721ZM2.7 3.85575L6.5185 5.54508L6.57044 14.2051L2.7 12.4923V3.85575Z",
                        fill: "white"
                    })
                }), "MAPA"]
            }), A("li", {
                onClick: () => je("action", {
                    action: "settings"
                }),
                className: "h-full flex items-center justify-center text-white px-[1.12rem] gap-2 cursor-pointer hover:bg-primary border border-transparent hover:border-white/[.15] font-bold text-[.9375rem] leading-[1]",
                children: [A("svg", {
                    width: "18",
                    height: "18",
                    viewBox: "0 0 18 18",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: [P("g", {
                        "clip-path": "url(#clip0_330_14)",
                        children: P("path", {
                            d: "M14.6533 7.34987L16.7088 7.68587C16.7902 7.69928 16.8642 7.74118 16.9175 7.8041C16.9708 7.86702 17.0001 7.94685 17 8.02933V9.94187C17 10.0237 16.9711 10.1029 16.9184 10.1655C16.8657 10.2282 16.7926 10.2702 16.712 10.2843L14.6533 10.6459C14.5346 11.0597 14.3714 11.4548 14.1637 11.8309L15.3808 13.5205C15.4293 13.5876 15.4523 13.6698 15.4457 13.7523C15.439 13.8348 15.4032 13.9122 15.3445 13.9707L13.992 15.3232C13.9342 15.3812 13.8578 15.417 13.7763 15.4242C13.6947 15.4314 13.6132 15.4096 13.5461 15.3627L11.8395 14.1648C11.4616 14.3746 11.0616 14.542 10.6469 14.664L10.2843 16.7131C10.27 16.7937 10.2277 16.8666 10.1648 16.9191C10.102 16.9716 10.0227 17.0003 9.9408 17H8.02933C7.94713 17.0001 7.86757 16.971 7.80485 16.9178C7.74213 16.8647 7.70034 16.791 7.68693 16.7099L7.34667 14.6715C6.93028 14.5509 6.52854 14.3845 6.1488 14.1755L4.45493 15.3627C4.38786 15.4096 4.30637 15.4314 4.22481 15.4242C4.14324 15.417 4.06684 15.3812 4.00907 15.3232L2.65547 13.9707C2.59798 13.9121 2.56278 13.8352 2.55597 13.7534C2.54915 13.6716 2.57114 13.59 2.61813 13.5227L3.816 11.848C3.60464 11.4665 3.43649 11.0625 3.31467 10.6437L1.28693 10.2843C1.20651 10.27 1.13368 10.2278 1.08121 10.1652C1.02875 10.1026 0.999995 10.0235 1 9.94187V8.02933C1 7.85867 1.12267 7.7136 1.2912 7.68587L3.31893 7.34773C3.44196 6.92818 3.60907 6.52711 3.82027 6.14453L2.63627 4.4528C2.58958 4.38582 2.56795 4.30455 2.57517 4.22323C2.58238 4.1419 2.61799 4.06571 2.67573 4.008L4.02933 2.65653C4.08751 2.59829 4.16445 2.56257 4.24649 2.55574C4.32852 2.5489 4.41032 2.57139 4.47733 2.6192L6.15733 3.8192C6.53636 3.61156 6.93493 3.448 7.35307 3.32853L7.68587 1.2912C7.69928 1.20981 7.74118 1.13584 7.8041 1.0825C7.86702 1.02915 7.94685 0.999915 8.02933 1H9.94187C10.1115 1 10.2555 1.1216 10.2853 1.288L10.6437 3.336C11.0597 3.45618 11.458 3.62151 11.8384 3.832L13.5216 2.62133C13.5885 2.57268 13.6707 2.54949 13.7532 2.55594C13.8357 2.56239 13.9132 2.59806 13.9717 2.65653L15.3243 4.00907C15.3821 4.06698 15.4177 4.14344 15.4247 4.225C15.4317 4.30656 15.4098 4.38798 15.3627 4.45493L14.1627 6.1648C14.3689 6.54169 14.5324 6.93635 14.6533 7.3488V7.34987ZM6.56373 9C6.56373 9.64585 6.8203 10.2653 7.27699 10.7219C7.73368 11.1786 8.35308 11.4352 8.99893 11.4352C9.64479 11.4352 10.2642 11.1786 10.7209 10.7219C11.1776 10.2653 11.4341 9.64585 11.4341 9C11.4341 8.35414 11.1776 7.73474 10.7209 7.27805C10.2642 6.82136 9.64479 6.5648 8.99893 6.5648C8.35308 6.5648 7.73368 6.82136 7.27699 7.27805C6.8203 7.73474 6.56373 8.35414 6.56373 9Z",
                            stroke: "white",
                            "stroke-width": "0.8"
                        })
                    }), P("defs", {
                        children: P("clipPath", {
                            id: "clip0_330_14",
                            children: P("rect", {
                                width: "18",
                                height: "18",
                                fill: "white"
                            })
                        })
                    })]
                }), "CONFIGURA\xC7\xD5ES"]
            }), A("li", {
                onClick: t,
                className: "h-full flex items-center justify-center text-white px-[1.12rem] gap-2 cursor-pointer hover:bg-primary border border-transparent hover:border-white/[.15] font-bold text-[.9375rem] leading-[1]",
                children: [P("svg", {
                    width: "18",
                    height: "18",
                    viewBox: "0 0 18 18",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: P("path", {
                        d: "M9 1.6875C7.55373 1.6875 6.13993 2.11637 4.9374 2.91988C3.73486 3.72339 2.7976 4.86544 2.24413 6.20163C1.69067 7.53781 1.54586 9.00811 1.82801 10.4266C2.11017 11.8451 2.80661 13.148 3.82928 14.1707C4.85196 15.1934 6.15492 15.8898 7.57341 16.172C8.99189 16.4541 10.4622 16.3093 11.7984 15.7559C13.1346 15.2024 14.2766 14.2651 15.0801 13.0626C15.8836 11.8601 16.3125 10.4463 16.3125 9C16.3105 7.06123 15.5394 5.20246 14.1685 3.83154C12.7975 2.46063 10.9388 1.68955 9 1.6875ZM9.5625 15.1615V12.9375C9.5625 12.7883 9.50324 12.6452 9.39775 12.5398C9.29226 12.4343 9.14919 12.375 9 12.375C8.85082 12.375 8.70775 12.4343 8.60226 12.5398C8.49677 12.6452 8.4375 12.7883 8.4375 12.9375V15.1615C6.99758 15.0282 5.64962 14.3955 4.62708 13.3729C3.60455 12.3504 2.97183 11.0024 2.83852 9.5625H5.0625C5.21169 9.5625 5.35476 9.50324 5.46025 9.39775C5.56574 9.29226 5.625 9.14918 5.625 9C5.625 8.85082 5.56574 8.70774 5.46025 8.60225C5.35476 8.49676 5.21169 8.4375 5.0625 8.4375H2.83852C2.97183 6.99757 3.60455 5.64962 4.62708 4.62708C5.64962 3.60455 6.99758 2.97183 8.4375 2.83852V5.0625C8.4375 5.21168 8.49677 5.35476 8.60226 5.46025C8.70775 5.56574 8.85082 5.625 9 5.625C9.14919 5.625 9.29226 5.56574 9.39775 5.46025C9.50324 5.35476 9.5625 5.21168 9.5625 5.0625V2.83852C11.0024 2.97183 12.3504 3.60455 13.3729 4.62708C14.3955 5.64962 15.0282 6.99757 15.1615 8.4375H12.9375C12.7883 8.4375 12.6452 8.49676 12.5398 8.60225C12.4343 8.70774 12.375 8.85082 12.375 9C12.375 9.14918 12.4343 9.29226 12.5398 9.39775C12.6452 9.50324 12.7883 9.5625 12.9375 9.5625H15.1615C15.0282 11.0024 14.3955 12.3504 13.3729 13.3729C12.3504 14.3955 11.0024 15.0282 9.5625 15.1615Z",
                        fill: "white"
                    })
                }), "MIRA"]
            }), A("li", {
                onClick: n,
                className: "h-full flex items-center justify-center text-white px-[1.12rem] gap-2 cursor-pointer hover:bg-primary border border-transparent hover:border-white/[.15] font-bold text-[.9375rem] leading-[1]",
                children: [A("svg", {
                    width: "18",
                    height: "18",
                    viewBox: "0 0 18 18",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: [P("path", {
                        d: "M12.75 8.10378C12.75 7.84428 12.75 7.71453 12.789 7.59903C12.9022 7.26303 13.2015 7.13328 13.5015 6.99678C13.8375 6.84303 14.0055 6.76653 14.1727 6.75303C14.3617 6.73803 14.5515 6.77853 14.7135 6.86928C14.928 6.98928 15.078 7.21878 15.231 7.40478C15.9382 8.26428 16.2922 8.69403 16.4212 9.16728C16.5262 9.54978 16.5262 9.95028 16.4212 10.332C16.233 11.0235 15.6367 11.6025 15.195 12.1395C14.9692 12.4133 14.856 12.5505 14.7135 12.6308C14.5487 12.7222 14.3605 12.7626 14.1727 12.747C14.0055 12.7335 13.8375 12.657 13.5007 12.5033C13.2007 12.3668 12.9022 12.237 12.789 11.901C12.75 11.7855 12.75 11.6558 12.75 11.3963V8.10378ZM5.24999 8.10378C5.24999 7.77678 5.24099 7.48353 4.97699 7.25403C4.88099 7.17078 4.75349 7.11303 4.49924 6.99678C4.16249 6.84378 3.99449 6.76653 3.82724 6.75303C3.32699 6.71253 3.05774 7.05453 2.76974 7.40553C2.06174 8.26428 1.70774 8.69403 1.57799 9.16803C1.4736 9.54926 1.4736 9.95155 1.57799 10.3328C1.76699 11.0235 2.36399 11.6033 2.80499 12.1395C3.08324 12.477 3.34949 12.7853 3.82724 12.747C3.99449 12.7335 4.16249 12.657 4.49924 12.5033C4.75424 12.3878 4.88099 12.3293 4.97699 12.246C5.24099 12.0165 5.24999 11.7233 5.24999 11.397V8.10378Z",
                        stroke: "white",
                        "stroke-width": "1.125",
                        "stroke-linecap": "round",
                        "stroke-linejoin": "round"
                    }), P("path", {
                        d: "M3.75 6.75C3.75 4.2645 6.1005 2.25 9 2.25C11.8995 2.25 14.25 4.2645 14.25 6.75M14.25 12.75V13.35C14.25 14.6752 12.9075 15.75 11.25 15.75H9.75",
                        stroke: "white",
                        "stroke-width": "1.125",
                        "stroke-linecap": "round",
                        "stroke-linejoin": "round"
                    })]
                }), "AJUDA"]
            })]
        }), P("img", {
            src: Zv,
            alt: "Header Background",
            className: "absolute top-0 left-0 -z-10 w-full h-[3.125rem]"
        }), A("div", {
            className: "flex items-center gap-6 absolute right-6 top-1/2 -translate-y-1/2",
            children: [P("button", {
                className: "text-white hover:text-primary",
              //  onClick: () => window.invokeNative("openUrl", "https://www.instagram.com/zero11rp/"),
                children: P(Yv, {
                    size: 26,
                    color: "currentColor"
                })
            }), P("button", {
                className: "text-white hover:text-primary",
             //   onClick: () => window.invokeNative("openUrl", "https://www.tiktok.com/@nova"),
                children: P(Gv, {
                    size: 26,
                    color: "currentColor"
                })
            }), P("button", {
                className: "text-white hover:text-primary",
                onClick: () => window.invokeNative("openUrl", "https://discord.gg/uXXZQ43Pqz"),
                children: P(Qv, {
                    size: 26,
                    color: "currentColor"
                })
            })]
        })]
    })
}
const Jv = "" + new URL("banner-online.1d84feaf.png",import.meta.url).href
  , qv = "" + new URL("banner-richs.e1aaffd3.png",import.meta.url).href
  , ey = "" + new URL("banner-factions.1749b952.png",import.meta.url).href
  , Us = "" + new URL("top1.da88b8b5.png",import.meta.url).href
  , Hs = "data:image/png;base64,UklGRmgLAABXRUJQVlA4TFwLAAAvNwAREE0obNu2gZJu5f+H0yMi+j8B9DEyP35CAYwD6BgLsgaADkUdo9pCQds2jPnzbncQxID3fwL4rEEliuxa27ZMsvJVVeu4bnd3F9ydI2AR2WFwABC6u4bu7u7u2tubnu4ea6uqoHpm157FAdwR7t5EDn/Wg7xZoR/umfdaaPShDzKF+6DbQ6wWkTs96I+7e+Q9If4tIl2Qatt61uz7sXDAQgYKUMEMkgyrgkRAFPZxs5DRX25Q2rbNsO0831dVvXp5nXNiO5nZtm3rD9i2nYxsOxnbmZ09y5XRsY3W6qpvAhzhemvRLs5xzs7OLl2sz07UWdBkvbPOmXHmOvPmmaKJc16XYzqcMU1vlthhOlMqAsdSP06oJ1NkEy2Z6i/nO+fbeaHouG7nbOOyVvkOphQZIGUgRIapjiwtn2rZsv52Ht6pbt3r7es4+JrKPiaQDHkJEAyno+kaBs6Dzi47xUOcm1rcfjVFDwPhQQg0nCHDwoR0JZuv7dBblu/Ws/14RXOmaYACQJOFMXyOr+PbKeDEpaU20zZ1hzhsQlnMFtttN8NZtTIVXdfiiWvI8kyoykRhnHwrnWuQq+C6oP9lsTw2FKeaXsXmnUWWmM3P29mZlKVWMJaFEJggjNW7hHAhzAKjMAkfnAygBR/9Pnx7DezVtNXGTq1ZTGZL7brOvuUwSzIkxmZuBYOzCXfmjltgDWmSerrYJe6Mz9F6MpZvENr5S3KXxq4cHGuqBsyCWd54xznrQhKSHOqwpOxy/FnIrv85IFtZtYOmXeuRQICfKEyQbyc/HT76n1myCXwwM8va4MzsCOcXQlLLkFjgOkkXmnEQrKpoUfUxgTz9STTTpfQuLz892tBCxwqOxDSGcfz8uZo/3tIYo4U6clXw7UNqW22eIaJqBWRIjiFATJU16/+HXa1mweppk4XPmItnZP369GA5EvtgthwK0jY2P0oyXyR4qABSFSGaaD0zmw3SJNTG86P8MBej/D5ZNlQL1sS+bZYTJZ96AQIvoIIQVLulvDhi/+kWDUsnK5335uC8O9VSi3FohvaDtjXSWgCE8ICE8KmnApU0LdJ/sxSbprUQv7+0/57Rn3Pd9raJnpnajST7dy+fJiUVBIjRXJ/UJZkkU1VUgjWQv3xrZGntIrMC28ahznH99bj/uqYWyWi+PQ0t9F4hSSQTOFZBS8l7aa1guoOpByQgSZJm7jrctzZAqyKmsUXV64F+HrSDbQI00P1ItNDFSbAgEwLx/7G6MxiT6HY297GKqVokjgEWWErnXLCNpVqwPGt12M9KnGs7xUSMF759UTTKLSYxEXgEWkJnOidvTWKbugICQQg0knadNqyGBydJ+M/dSjoc9ToLdMjsjHSyLEks1CRkwn8sq9PLEE2YruqWvImKzGJKXFp+GmJTdM1ih7bL2cCnZ9k+QW+5kN7l0KoTbCiJSZENZhhCLKPfybwGqxrLtlEKkCeYheT7l9HdClcQ7hcstDuyaAKf6ZGMsPjqOCVdTjcJIYTEBK/bczS/YBb5uRBqRKPUaTpTfBRIMSaEMMXgTLgsJslijJ1a51jIO7aLRXwb145TC4tjTCwx6ugY/l7fz5PbdpOfA8MCa2JfelK1S/zWnwNmOZLe58T81qjnLdjOzn4OdNspiNjF2SrYOYgExXv0kJ+rKoSoIKhUsdpYXF2BB7HgYgZf7+YT/KJeO0PRzgE9cVswVVIcTj1h4Xh5HgIJ4RGCiqCRbGsTiOpgDu3GtNKgOFSwL+SNI5X73cGeEJQowmxM0h0BUSKBPAjapbyyBNFlZB1kz0eJHiNuXQmqpY+zBpZGPEhtdHWdKI9AIIEQ08Tt1FPZcMowqNEQvt/NxCKwNPB9s9fVBFQMpnGryVJKvBAI0cuuqZooIWRCdYaGmQFYiPz8YwxFj6gJerE9t46wZ4lAVQ16dEXVZAmBRyhnaBYTr+/jzNvTwI9YH7WUiE+8+Hk7v7YgEAgk6nAZ1WRRJpCqg77P0EZkkSwFZ30ETYTNIGOVCCoAvkCXlleEqJYgWhT1EFUhIF7HgPHs+gHqzIMGC4LZ65ZkNpaMllKLZrWKiUZugkwIBBXzJNsqHoWIinhG0W1gzWJITc0WQp2ZDE1iXI7xm5UlYmlVskb+18xBoCx2UPYwD6pJUWOFrTEyRfowGk2dubBbIyGEjDgB/14HPw+lQozhxsh8CeqHTvWTUSViAbVzj1sXs6TU1MDvBs53DSSJvH5jzMRo0sfSNM3AEIwTRvEC8Q0SBOrUzBQ9AsTCi1Jbiz03EN7i/ArPaLAwWKysKl0LebI8QghZkpo8E2RNHDBNupq2W6pM5FblGqlHz+0wRXgUNFG4BiZhLe22GvBNvgdo8H4ScrAJ4jTSgankUSFaEKKTribkSJt0TW1RmszqwVPayBeX5ibQ+7eomhkoAkNX5t/4sOnamnh6g+9LPjaaJnFo0RTaiZc91ZEYU/D0YBvSTcZJkxHAw3O3I700x5aSfkN1cNhERjgHbO/iSyxotEUfK9mt0R/BLBmPv76xQC1YQCAPQiAALxCR+MVzyN64P+Q1QQyN8+f8Eh7U42hCsHtfC01YgSmGCEZIo/D9COSBYN3SioxLYJwQczA92LmP/oseXJSmaZa0kud+rAFkEH00zECUeBBClsQVMdKNbi5JBvX9eu8zR2eXPkcTzL6/PQAzIjG1OGySTKDqoJfJ7GNduAp+Y8EYa5Hz1pxwrv19NLM7YWaLBy0aliKAYYFk4sGPm29/beBijHzReYi5zTtOFmPAmD+FLIECi6RmJQINAwXYKP4y3HwbGQrBLGn0GnNdy9gZM0tphF3/Y0vTBiYsCvACgb7fyp+XXAsjS7KCFGOWxKFxFjlvzB0/K5jEaMG+sTq7Kvn3TeYvQz8GCASOERvo9vRc5FpgRYxhDIUQ5J1r2NFmpMWoixQiTWQ02S50hdfsgN7oc1as9cFJoNhDWiPXJpcKHYWVyj4xZWP5ocWhmbhMNEuyMMro7Jdfvu6ddhrMVwFr3HL5Ly79yrV/KBZYEgugG12lPRQDrFi+t2SYPSiiOLzILW0dGWth1onOvDJQK/bnnmnn/CpQBFhuMPOflj+u/c2/tsO/gQV3XwlTsVpxg94gBsiywfrKKL/l3PAMyupMrt6vll9O6FuAt/JWmXIhZEKmfMCVBQOV6xdig46BTDStMn33rnM95V7HHYdwy2E7e/IcCsV0O8FbgYHbDfBWF27HQKYGyuHKh/IYj2vOe7zL+ahs67rtbhzC5LDdasqSvRXe2g8CgYBsaNvXx7tdefLzOnam7Ou6xbkCOLbd92by1vwCb4UikAkEVqud4rT8cC+LHg0Ly7eOmzIuokg4sj32byvgrW+VQGClA48+8c3CIzwtBAqD8q3jxqxzHIEj2me/tjYBjy5GMk2P5je/2ZkBHs3AyS7zD/88b+DR+PJlJKcWsajtlYQVSFqvqdN6Ul+kvbICzTAZOO2vka/uBEU18NpekUHq1Y3qL5GChwLXJ/ToAM60qAJ8+b6RUQMF0x4xJzYom1V4SPEppV26s/QtY/qOLKHAKP+XCqqQOoPXNlvVrKR/n9JvkzXMMtjNybI2+fQb5fM3zti+YEneKwfxg3MqQIqH1JP61Kd+lJWH8vra1mYckTUs2uDL91tnVa97nRlu6pSkHkgBPCmlC513qXdsn8NysvI5LwDc1KnoP12Y0r9PnQjOr87T7MRPeBqpL3mB87+z8wuekOIBvs88+H2nwTvq098+w3nb+RfnUOeqxXuQ4vHzwhNumuJf6fzlfOMsptTZ3rn83U8Dvj8v3PSmC1/p/OJ8y5yd55zt/uIc6GyYN/wLnN+cz5lrZ4nzzH3+cp95wvnT+ZQd/ZOR+1BG"
  , $s = "" + new URL("top3.a14ddead.png",import.meta.url).href;
function ty() {
    var t, n, r;
    const {data: e} = Xp();
    return P("div", {
        className: "w-[80.8125rem] h-[52.125rem] absolute left-1/2 -translate-x-1/2 top-1/2 -translate-y-1/2 flex flex-col gap-3",
        children: A("div", {
            className: "flex flex-col gap-4 max-[800px]:scale-[0.5] max-[1100px]:scale-[0.7] max-[1440px]:scale-[0.8] max-[1600px]:scale-[0.9] max-[1920px]:scale-[1]",
            children: [P(e1, {}), A("div", {
                className: "flex items-center gap-[.94rem]",
                children: [A("div", {
                    className: "w-[27.3125rem] h-[46.875rem] bg-cover bg-no-repeat bg-center bg-online relative",
                    children: [P("img", {
                        src: Jv,
                        alt: "",
                        className: "absolute right-0 bottom-0 -z-10"
                    }), P("div", {
                        className: "flex flex-col gap-4 absolute left-1/2 -translate-x-1/2 top-80",
                        children: (t = e == null ? void 0 : e.rankings) == null ? void 0 : t.online.map( (i, o) => {
                            if (!(o >= 5))
                                return A("div", {
                                    className: "w-[21.4375rem] h-[3.25rem] bg-black/60 flex items-center justify-center relative rounded-[.3125rem]",
                                    children: [o === 0 ? P("img", {
                                        src: Us,
                                        className: "absolute left-[.69rem] w-[3rem]"
                                    }) : o === 1 ? P("img", {
                                        src: Hs,
                                        className: "absolute left-[.69rem] w-[3rem]"
                                    }) : o === 2 ? P("img", {
                                        src: $s,
                                        className: "absolute left-[.69rem] w-[3rem]"
                                    }) : A("span", {
                                        className: "text-white text-base font-normal bg-white/[.08] rounded-[.25rem] w-[2.875rem] h-[1.875rem] flex items-center justify-center absolute left-[.69rem]",
                                        children: [o + 1, "\xAA"]
                                    }), A("p", {
                                        className: "text-white text-base font-normal",
                                        children: [i.name, " - ", i.value]
                                    })]
                                })
                        }
                        )
                    })]
                }), A("div", {
                    className: "w-[27.3125rem] h-[46.875rem] bg-cover bg-no-repeat bg-center relative",
                    children: [P("img", {
                        src: qv,
                        alt: "",
                        className: "absolute right-0 bottom-0 -z-10"
                    }), P("div", {
                        className: "flex flex-col gap-4 absolute left-1/2 -translate-x-1/2 top-80",
                        children: (n = e == null ? void 0 : e.rankings) == null ? void 0 : n.richs.map( (i, o) => {
                            if (!(o >= 5))
                                return A("div", {
                                    className: "w-[21.4375rem] h-[3.25rem] bg-black/60 flex items-center justify-center relative rounded-[.3125rem]",
                                    children: [o === 0 ? P("img", {
                                        src: Us,
                                        className: "absolute left-[.69rem] w-[3rem]"
                                    }) : o === 1 ? P("img", {
                                        src: Hs,
                                        className: "absolute left-[.69rem] w-[3rem]"
                                    }) : o === 2 ? P("img", {
                                        src: $s,
                                        className: "absolute left-[.69rem] w-[3rem]"
                                    }) : A("span", {
                                        className: "text-white text-base font-normal bg-white/[.08] rounded-[.25rem] w-[2.875rem] h-[1.875rem] flex items-center justify-center absolute left-[.69rem]",
                                        children: [o + 1, "\xAA"]
                                    }), A("p", {
                                        className: "text-white text-base font-normal",
                                        children: [i.name, " - ", i.value]
                                    })]
                                })
                        }
                        )
                    })]
                }), A("div", {
                    className: "w-[27.3125rem] h-[46.875rem] bg-cover bg-no-repeat bg-center bg-factions relative",
                    children: [P("img", {
                        src: ey,
                        alt: "",
                        className: "absolute right-0 bottom-0 -z-10"
                    }), P("div", {
                        className: "flex flex-col gap-4 absolute left-1/2 -translate-x-1/2 top-80",
                        children: (r = e == null ? void 0 : e.rankings) == null ? void 0 : r.factions.map( (i, o) => {
                            if (!(o >= 5))
                                return A("div", {
                                    className: "w-[21.4375rem] h-[3.25rem] bg-black/60 flex items-center justify-center relative rounded-[.3125rem]",
                                    children: [o === 0 ? P("img", {
                                        src: Us,
                                        className: "absolute left-[.69rem] w-[3rem]"
                                    }) : o === 1 ? P("img", {
                                        src: Hs,
                                        className: "absolute left-[.69rem] w-[3rem]"
                                    }) : o === 2 ? P("img", {
                                        src: $s,
                                        className: "absolute left-[.69rem] w-[3rem]"
                                    }) : A("span", {
                                        className: "text-white text-base font-normal bg-white/[.08] rounded-[.25rem] w-[2.875rem] h-[1.875rem] flex items-center justify-center absolute left-[.69rem]",
                                        children: [o + 1, "\xAA"]
                                    }), A("p", {
                                        className: "text-white text-base font-normal",
                                        children: [i.name, " - ", i.value]
                                    })]
                                })
                        }
                        )
                    })]
                })]
            })]
        })
    })
}
function ny(e) {
    if (typeof Proxy > "u")
        return e;
    const t = new Map
      , n = (...r) => e(...r);
    return new Proxy(n,{
        get: (r, i) => i === "create" ? e : (t.has(i) || t.set(i, e(i)),
        t.get(i))
    })
}
function ls(e) {
    return e !== null && typeof e == "object" && typeof e.start == "function"
}
const ql = e => Array.isArray(e);
function t1(e, t) {
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
function ii(e) {
    return typeof e == "string" || Array.isArray(e)
}
function pf(e) {
    const t = [{}, {}];
    return e == null || e.values.forEach( (n, r) => {
        t[0][r] = n.get(),
        t[1][r] = n.getVelocity()
    }
    ),
    t
}
function gu(e, t, n, r) {
    if (typeof t == "function") {
        const [i,o] = pf(r);
        t = t(n !== void 0 ? n : e.custom, i, o)
    }
    if (typeof t == "string" && (t = e.variants && e.variants[t]),
    typeof t == "function") {
        const [i,o] = pf(r);
        t = t(n !== void 0 ? n : e.custom, i, o)
    }
    return t
}
function as(e, t, n) {
    const r = e.getProps();
    return gu(r, t, n !== void 0 ? n : r.custom, e)
}
const vu = ["animate", "whileInView", "whileFocus", "whileHover", "whileTap", "whileDrag", "exit"]
  , yu = ["initial", ...vu]
  , gi = ["transformPerspective", "x", "y", "z", "translateX", "translateY", "translateZ", "scale", "scaleX", "scaleY", "rotate", "rotateX", "rotateY", "rotateZ", "skew", "skewX", "skewY"]
  , Sn = new Set(gi)
  , mt = e => e * 1e3
  , gt = e => e / 1e3
  , ry = {
    type: "spring",
    stiffness: 500,
    damping: 25,
    restSpeed: 10
}
  , iy = e => ({
    type: "spring",
    stiffness: 550,
    damping: e === 0 ? 2 * Math.sqrt(550) : 30,
    restSpeed: 10
})
  , oy = {
    type: "keyframes",
    duration: .8
}
  , sy = {
    type: "keyframes",
    ease: [.25, .1, .35, 1],
    duration: .3
}
  , ly = (e, {keyframes: t}) => t.length > 2 ? oy : Sn.has(e) ? e.startsWith("scale") ? iy(t[1]) : ry : sy;
function wu(e, t) {
    return e ? e[t] || e.default || e : void 0
}
const ay = {
    skipAnimations: !1,
    useManualTiming: !1
}
  , uy = e => e !== null;
function us(e, {repeat: t, repeatType: n="loop"}, r) {
    const i = e.filter(uy)
      , o = t && n !== "loop" && t % 2 === 1 ? 0 : i.length - 1;
    return !o || r === void 0 ? i[o] : r
}
const ye = e => e;
let n1 = ye;
function cy(e) {
    let t = new Set
      , n = new Set
      , r = !1
      , i = !1;
    const o = new WeakSet;
    let s = {
        delta: 0,
        timestamp: 0,
        isProcessing: !1
    };
    function l(u) {
        o.has(u) && (a.schedule(u),
        e()),
        u(s)
    }
    const a = {
        schedule: (u, c=!1, f=!1) => {
            const g = f && r ? t : n;
            return c && o.add(u),
            g.has(u) || g.add(u),
            u
        }
        ,
        cancel: u => {
            n.delete(u),
            o.delete(u)
        }
        ,
        process: u => {
            if (s = u,
            r) {
                i = !0;
                return
            }
            r = !0,
            [t,n] = [n, t],
            n.clear(),
            t.forEach(l),
            r = !1,
            i && (i = !1,
            a.process(u))
        }
    };
    return a
}
const Er = ["read", "resolveKeyframes", "update", "preRender", "render", "postRender"]
  , fy = 40;
function r1(e, t) {
    let n = !1
      , r = !0;
    const i = {
        delta: 0,
        timestamp: 0,
        isProcessing: !1
    }
      , o = () => n = !0
      , s = Er.reduce( (p, h) => (p[h] = cy(o),
    p), {})
      , {read: l, resolveKeyframes: a, update: u, preRender: c, render: f, postRender: d} = s
      , g = () => {
        const p = performance.now();
        n = !1,
        i.delta = r ? 1e3 / 60 : Math.max(Math.min(p - i.timestamp, fy), 1),
        i.timestamp = p,
        i.isProcessing = !0,
        l.process(i),
        a.process(i),
        u.process(i),
        c.process(i),
        f.process(i),
        d.process(i),
        i.isProcessing = !1,
        n && t && (r = !1,
        e(g))
    }
      , y = () => {
        n = !0,
        r = !0,
        i.isProcessing || e(g)
    }
    ;
    return {
        schedule: Er.reduce( (p, h) => {
            const m = s[h];
            return p[h] = (x, S=!1, T=!1) => (n || y(),
            m.schedule(x, S, T)),
            p
        }
        , {}),
        cancel: p => {
            for (let h = 0; h < Er.length; h++)
                s[Er[h]].cancel(p)
        }
        ,
        state: i,
        steps: s
    }
}
const {schedule: z, cancel: Ct, state: ce, steps: Ws} = r1(typeof requestAnimationFrame < "u" ? requestAnimationFrame : ye, !0)
  , i1 = (e, t, n) => (((1 - 3 * n + 3 * t) * e + (3 * n - 6 * t)) * e + 3 * t) * e
  , dy = 1e-7
  , hy = 12;
function py(e, t, n, r, i) {
    let o, s, l = 0;
    do
        s = t + (n - t) / 2,
        o = i1(s, r, i) - e,
        o > 0 ? n = s : t = s;
    while (Math.abs(o) > dy && ++l < hy);
    return s
}
function vi(e, t, n, r) {
    if (e === t && n === r)
        return ye;
    const i = o => py(o, 0, 1, e, n);
    return o => o === 0 || o === 1 ? o : i1(i(o), t, r)
}
const o1 = e => t => t <= .5 ? e(2 * t) / 2 : (2 - e(2 * (1 - t))) / 2
  , s1 = e => t => 1 - e(1 - t)
  , l1 = vi(.33, 1.53, .69, .99)
  , xu = s1(l1)
  , a1 = o1(xu)
  , u1 = e => (e *= 2) < 1 ? .5 * xu(e) : .5 * (2 - Math.pow(2, -10 * (e - 1)))
  , Cu = e => 1 - Math.sin(Math.acos(e))
  , c1 = s1(Cu)
  , f1 = o1(Cu)
  , d1 = e => /^0[^.\s]+$/u.test(e);
function my(e) {
    return typeof e == "number" ? e === 0 : e !== null ? e === "none" || e === "0" || d1(e) : !0
}
const h1 = e => /^-?(?:\d+(?:\.\d+)?|\.\d+)$/u.test(e)
  , p1 = e => t => typeof t == "string" && t.startsWith(e)
  , m1 = p1("--")
  , gy = p1("var(--")
  , Su = e => gy(e) ? vy.test(e.split("/*")[0].trim()) : !1
  , vy = /var\(--(?:[\w-]+\s*|[\w-]+\s*,(?:\s*[^)(\s]|\s*\((?:[^)(]|\([^)(]*\))*\))+\s*)\)$/iu
  , yy = /^var\(--(?:([\w-]+)|([\w-]+), ?([a-zA-Z\d ()%#.,-]+))\)/u;
function wy(e) {
    const t = yy.exec(e);
    if (!t)
        return [, ];
    const [,n,r,i] = t;
    return [`--${n != null ? n : r}`, i]
}
function g1(e, t, n=1) {
    const [r,i] = wy(e);
    if (!r)
        return;
    const o = window.getComputedStyle(t).getPropertyValue(r);
    if (o) {
        const s = o.trim();
        return h1(s) ? parseFloat(s) : s
    }
    return Su(i) ? g1(i, t, n + 1) : i
}
const St = (e, t, n) => n > t ? t : n < e ? e : n
  , ar = {
    test: e => typeof e == "number",
    parse: parseFloat,
    transform: e => e
}
  , oi = {
    ...ar,
    transform: e => St(0, 1, e)
}
  , Ui = {
    ...ar,
    default: 1
}
  , yi = e => ({
    test: t => typeof t == "string" && t.endsWith(e) && t.split(" ").length === 1,
    parse: parseFloat,
    transform: t => `${t}${e}`
})
  , Rt = yi("deg")
  , it = yi("%")
  , M = yi("px")
  , xy = yi("vh")
  , Cy = yi("vw")
  , mf = {
    ...it,
    parse: e => it.parse(e) / 100,
    transform: e => it.transform(e * 100)
}
  , Sy = new Set(["width", "height", "top", "left", "right", "bottom", "x", "y", "translateX", "translateY"])
  , gf = e => e === ar || e === M
  , vf = (e, t) => parseFloat(e.split(", ")[t])
  , yf = (e, t) => (n, {transform: r}) => {
    if (r === "none" || !r)
        return 0;
    const i = r.match(/^matrix3d\((.+)\)$/u);
    if (i)
        return vf(i[1], t);
    {
        const o = r.match(/^matrix\((.+)\)$/u);
        return o ? vf(o[1], e) : 0
    }
}
  , Py = new Set(["x", "y", "z"])
  , ky = gi.filter(e => !Py.has(e));
function Ey(e) {
    const t = [];
    return ky.forEach(n => {
        const r = e.getValue(n);
        r !== void 0 && (t.push([n, r.get()]),
        r.set(n.startsWith("scale") ? 1 : 0))
    }
    ),
    t
}
const er = {
    width: ({x: e}, {paddingLeft: t="0", paddingRight: n="0"}) => e.max - e.min - parseFloat(t) - parseFloat(n),
    height: ({y: e}, {paddingTop: t="0", paddingBottom: n="0"}) => e.max - e.min - parseFloat(t) - parseFloat(n),
    top: (e, {top: t}) => parseFloat(t),
    left: (e, {left: t}) => parseFloat(t),
    bottom: ({y: e}, {top: t}) => parseFloat(t) + (e.max - e.min),
    right: ({x: e}, {left: t}) => parseFloat(t) + (e.max - e.min),
    x: yf(4, 13),
    y: yf(5, 14)
};
er.translateX = er.x;
er.translateY = er.y;
const v1 = e => t => t.test(e)
  , Ty = {
    test: e => e === "auto",
    parse: e => e
}
  , y1 = [ar, M, it, Rt, Cy, xy, Ty]
  , wf = e => y1.find(v1(e))
  , hn = new Set;
let ea = !1
  , ta = !1;
function w1() {
    if (ta) {
        const e = Array.from(hn).filter(r => r.needsMeasurement)
          , t = new Set(e.map(r => r.element))
          , n = new Map;
        t.forEach(r => {
            const i = Ey(r);
            !i.length || (n.set(r, i),
            r.render())
        }
        ),
        e.forEach(r => r.measureInitialState()),
        t.forEach(r => {
            r.render();
            const i = n.get(r);
            i && i.forEach( ([o,s]) => {
                var l;
                (l = r.getValue(o)) === null || l === void 0 || l.set(s)
            }
            )
        }
        ),
        e.forEach(r => r.measureEndState()),
        e.forEach(r => {
            r.suspendedScrollY !== void 0 && window.scrollTo(0, r.suspendedScrollY)
        }
        )
    }
    ta = !1,
    ea = !1,
    hn.forEach(e => e.complete()),
    hn.clear()
}
function x1() {
    hn.forEach(e => {
        e.readKeyframes(),
        e.needsMeasurement && (ta = !0)
    }
    )
}
function Ry() {
    x1(),
    w1()
}
class Pu {
    constructor(t, n, r, i, o, s=!1) {
        this.isComplete = !1,
        this.isAsync = !1,
        this.needsMeasurement = !1,
        this.isScheduled = !1,
        this.unresolvedKeyframes = [...t],
        this.onComplete = n,
        this.name = r,
        this.motionValue = i,
        this.element = o,
        this.isAsync = s
    }
    scheduleResolve() {
        this.isScheduled = !0,
        this.isAsync ? (hn.add(this),
        ea || (ea = !0,
        z.read(x1),
        z.resolveKeyframes(w1))) : (this.readKeyframes(),
        this.complete())
    }
    readKeyframes() {
        const {unresolvedKeyframes: t, name: n, element: r, motionValue: i} = this;
        for (let o = 0; o < t.length; o++)
            if (t[o] === null)
                if (o === 0) {
                    const s = i == null ? void 0 : i.get()
                      , l = t[t.length - 1];
                    if (s !== void 0)
                        t[0] = s;
                    else if (r && n) {
                        const a = r.readValue(n, l);
                        a != null && (t[0] = a)
                    }
                    t[0] === void 0 && (t[0] = l),
                    i && s === void 0 && i.set(t[0])
                } else
                    t[o] = t[o - 1]
    }
    setFinalKeyframe() {}
    measureInitialState() {}
    renderEndStyles() {}
    measureEndState() {}
    complete() {
        this.isComplete = !0,
        this.onComplete(this.unresolvedKeyframes, this.finalKeyframe),
        hn.delete(this)
    }
    cancel() {
        this.isComplete || (this.isScheduled = !1,
        hn.delete(this))
    }
    resume() {
        this.isComplete || this.scheduleResolve()
    }
}
const _r = e => Math.round(e * 1e5) / 1e5
  , ku = /-?(?:\d+(?:\.\d+)?|\.\d+)/gu;
function Ly(e) {
    return e == null
}
const Ay = /^(?:#[\da-f]{3,8}|(?:rgb|hsl)a?\((?:-?[\d.]+%?[,\s]+){2}-?[\d.]+%?\s*(?:[,/]\s*)?(?:\b\d+(?:\.\d+)?|\.\d+)?%?\))$/iu
  , Eu = (e, t) => n => Boolean(typeof n == "string" && Ay.test(n) && n.startsWith(e) || t && !Ly(n) && Object.prototype.hasOwnProperty.call(n, t))
  , C1 = (e, t, n) => r => {
    if (typeof r != "string")
        return r;
    const [i,o,s,l] = r.match(ku);
    return {
        [e]: parseFloat(i),
        [t]: parseFloat(o),
        [n]: parseFloat(s),
        alpha: l !== void 0 ? parseFloat(l) : 1
    }
}
  , Ny = e => St(0, 255, e)
  , bs = {
    ...ar,
    transform: e => Math.round(Ny(e))
}
  , cn = {
    test: Eu("rgb", "red"),
    parse: C1("red", "green", "blue"),
    transform: ({red: e, green: t, blue: n, alpha: r=1}) => "rgba(" + bs.transform(e) + ", " + bs.transform(t) + ", " + bs.transform(n) + ", " + _r(oi.transform(r)) + ")"
};
function Dy(e) {
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
const na = {
    test: Eu("#"),
    parse: Dy,
    transform: cn.transform
}
  , In = {
    test: Eu("hsl", "hue"),
    parse: C1("hue", "saturation", "lightness"),
    transform: ({hue: e, saturation: t, lightness: n, alpha: r=1}) => "hsla(" + Math.round(e) + ", " + it.transform(_r(t)) + ", " + it.transform(_r(n)) + ", " + _r(oi.transform(r)) + ")"
}
  , me = {
    test: e => cn.test(e) || na.test(e) || In.test(e),
    parse: e => cn.test(e) ? cn.parse(e) : In.test(e) ? In.parse(e) : na.parse(e),
    transform: e => typeof e == "string" ? e : e.hasOwnProperty("red") ? cn.transform(e) : In.transform(e)
}
  , My = /(?:#[\da-f]{3,8}|(?:rgb|hsl)a?\((?:-?[\d.]+%?[,\s]+){2}-?[\d.]+%?\s*(?:[,/]\s*)?(?:\b\d+(?:\.\d+)?|\.\d+)?%?\))/giu;
function Vy(e) {
    var t, n;
    return isNaN(e) && typeof e == "string" && (((t = e.match(ku)) === null || t === void 0 ? void 0 : t.length) || 0) + (((n = e.match(My)) === null || n === void 0 ? void 0 : n.length) || 0) > 0
}
const S1 = "number"
  , P1 = "color"
  , Oy = "var"
  , Fy = "var("
  , xf = "${}"
  , Iy = /var\s*\(\s*--(?:[\w-]+\s*|[\w-]+\s*,(?:\s*[^)(\s]|\s*\((?:[^)(]|\([^)(]*\))*\))+\s*)\)|#[\da-f]{3,8}|(?:rgb|hsl)a?\((?:-?[\d.]+%?[,\s]+){2}-?[\d.]+%?\s*(?:[,/]\s*)?(?:\b\d+(?:\.\d+)?|\.\d+)?%?\)|-?(?:\d+(?:\.\d+)?|\.\d+)/giu;
function si(e) {
    const t = e.toString()
      , n = []
      , r = {
        color: [],
        number: [],
        var: []
    }
      , i = [];
    let o = 0;
    const l = t.replace(Iy, a => (me.test(a) ? (r.color.push(o),
    i.push(P1),
    n.push(me.parse(a))) : a.startsWith(Fy) ? (r.var.push(o),
    i.push(Oy),
    n.push(a)) : (r.number.push(o),
    i.push(S1),
    n.push(parseFloat(a))),
    ++o,
    xf)).split(xf);
    return {
        values: n,
        split: l,
        indexes: r,
        types: i
    }
}
function k1(e) {
    return si(e).values
}
function E1(e) {
    const {split: t, types: n} = si(e)
      , r = t.length;
    return i => {
        let o = "";
        for (let s = 0; s < r; s++)
            if (o += t[s],
            i[s] !== void 0) {
                const l = n[s];
                l === S1 ? o += _r(i[s]) : l === P1 ? o += me.transform(i[s]) : o += i[s]
            }
        return o
    }
}
const _y = e => typeof e == "number" ? 0 : e;
function By(e) {
    const t = k1(e);
    return E1(e)(t.map(_y))
}
const Qt = {
    test: Vy,
    parse: k1,
    createTransformer: E1,
    getAnimatableNone: By
}
  , zy = new Set(["brightness", "contrast", "saturate", "opacity"]);
function jy(e) {
    const [t,n] = e.slice(0, -1).split("(");
    if (t === "drop-shadow")
        return e;
    const [r] = n.match(ku) || [];
    if (!r)
        return e;
    const i = n.replace(r, "");
    let o = zy.has(t) ? 1 : 0;
    return r !== n && (o *= 100),
    t + "(" + o + i + ")"
}
const Uy = /\b([a-z-]*)\(.*?\)/gu
  , ra = {
    ...Qt,
    getAnimatableNone: e => {
        const t = e.match(Uy);
        return t ? t.map(jy).join(" ") : e
    }
}
  , Hy = {
    borderWidth: M,
    borderTopWidth: M,
    borderRightWidth: M,
    borderBottomWidth: M,
    borderLeftWidth: M,
    borderRadius: M,
    radius: M,
    borderTopLeftRadius: M,
    borderTopRightRadius: M,
    borderBottomRightRadius: M,
    borderBottomLeftRadius: M,
    width: M,
    maxWidth: M,
    height: M,
    maxHeight: M,
    top: M,
    right: M,
    bottom: M,
    left: M,
    padding: M,
    paddingTop: M,
    paddingRight: M,
    paddingBottom: M,
    paddingLeft: M,
    margin: M,
    marginTop: M,
    marginRight: M,
    marginBottom: M,
    marginLeft: M,
    backgroundPositionX: M,
    backgroundPositionY: M
}
  , $y = {
    rotate: Rt,
    rotateX: Rt,
    rotateY: Rt,
    rotateZ: Rt,
    scale: Ui,
    scaleX: Ui,
    scaleY: Ui,
    scaleZ: Ui,
    skew: Rt,
    skewX: Rt,
    skewY: Rt,
    distance: M,
    translateX: M,
    translateY: M,
    translateZ: M,
    x: M,
    y: M,
    z: M,
    perspective: M,
    transformPerspective: M,
    opacity: oi,
    originX: mf,
    originY: mf,
    originZ: M
}
  , Cf = {
    ...ar,
    transform: Math.round
}
  , Tu = {
    ...Hy,
    ...$y,
    zIndex: Cf,
    size: M,
    fillOpacity: oi,
    strokeOpacity: oi,
    numOctaves: Cf
}
  , Wy = {
    ...Tu,
    color: me,
    backgroundColor: me,
    outlineColor: me,
    fill: me,
    stroke: me,
    borderColor: me,
    borderTopColor: me,
    borderRightColor: me,
    borderBottomColor: me,
    borderLeftColor: me,
    filter: ra,
    WebkitFilter: ra
}
  , Ru = e => Wy[e];
function T1(e, t) {
    let n = Ru(e);
    return n !== ra && (n = Qt),
    n.getAnimatableNone ? n.getAnimatableNone(t) : void 0
}
const by = new Set(["auto", "none", "0"]);
function Ky(e, t, n) {
    let r = 0, i;
    for (; r < e.length && !i; ) {
        const o = e[r];
        typeof o == "string" && !by.has(o) && si(o).values.length && (i = e[r]),
        r++
    }
    if (i && n)
        for (const o of t)
            e[o] = T1(n, i)
}
class R1 extends Pu {
    constructor(t, n, r, i, o) {
        super(t, n, r, i, o, !0)
    }
    readKeyframes() {
        const {unresolvedKeyframes: t, element: n, name: r} = this;
        if (!n || !n.current)
            return;
        super.readKeyframes();
        for (let a = 0; a < t.length; a++) {
            let u = t[a];
            if (typeof u == "string" && (u = u.trim(),
            Su(u))) {
                const c = g1(u, n.current);
                c !== void 0 && (t[a] = c),
                a === t.length - 1 && (this.finalKeyframe = u)
            }
        }
        if (this.resolveNoneKeyframes(),
        !Sy.has(r) || t.length !== 2)
            return;
        const [i,o] = t
          , s = wf(i)
          , l = wf(o);
        if (s !== l)
            if (gf(s) && gf(l))
                for (let a = 0; a < t.length; a++) {
                    const u = t[a];
                    typeof u == "string" && (t[a] = parseFloat(u))
                }
            else
                this.needsMeasurement = !0
    }
    resolveNoneKeyframes() {
        const {unresolvedKeyframes: t, name: n} = this
          , r = [];
        for (let i = 0; i < t.length; i++)
            my(t[i]) && r.push(i);
        r.length && Ky(t, r, n)
    }
    measureInitialState() {
        const {element: t, unresolvedKeyframes: n, name: r} = this;
        if (!t || !t.current)
            return;
        r === "height" && (this.suspendedScrollY = window.pageYOffset),
        this.measuredOrigin = er[r](t.measureViewportBox(), window.getComputedStyle(t.current)),
        n[0] = this.measuredOrigin;
        const i = n[n.length - 1];
        i !== void 0 && t.getValue(r, i).jump(i, !1)
    }
    measureEndState() {
        var t;
        const {element: n, name: r, unresolvedKeyframes: i} = this;
        if (!n || !n.current)
            return;
        const o = n.getValue(r);
        o && o.jump(this.measuredOrigin, !1);
        const s = i.length - 1
          , l = i[s];
        i[s] = er[r](n.measureViewportBox(), window.getComputedStyle(n.current)),
        l !== null && this.finalKeyframe === void 0 && (this.finalKeyframe = l),
        !((t = this.removedTransforms) === null || t === void 0) && t.length && this.removedTransforms.forEach( ([a,u]) => {
            n.getValue(a).set(u)
        }
        ),
        this.resolveNoneKeyframes()
    }
}
function Lu(e) {
    return typeof e == "function"
}
let ro;
function Qy() {
    ro = void 0
}
const ot = {
    now: () => (ro === void 0 && ot.set(ce.isProcessing || ay.useManualTiming ? ce.timestamp : performance.now()),
    ro),
    set: e => {
        ro = e,
        queueMicrotask(Qy)
    }
}
  , Sf = (e, t) => t === "zIndex" ? !1 : !!(typeof e == "number" || Array.isArray(e) || typeof e == "string" && (Qt.test(e) || e === "0") && !e.startsWith("url("));
function Yy(e) {
    const t = e[0];
    if (e.length === 1)
        return !0;
    for (let n = 0; n < e.length; n++)
        if (e[n] !== t)
            return !0
}
function Gy(e, t, n, r) {
    const i = e[0];
    if (i === null)
        return !1;
    if (t === "display" || t === "visibility")
        return !0;
    const o = e[e.length - 1]
      , s = Sf(i, t)
      , l = Sf(o, t);
    return !s || !l ? !1 : Yy(e) || (n === "spring" || Lu(n)) && r
}
const Zy = 40;
class L1 {
    constructor({autoplay: t=!0, delay: n=0, type: r="keyframes", repeat: i=0, repeatDelay: o=0, repeatType: s="loop", ...l}) {
        this.isStopped = !1,
        this.hasAttemptedResolve = !1,
        this.createdAt = ot.now(),
        this.options = {
            autoplay: t,
            delay: n,
            type: r,
            repeat: i,
            repeatDelay: o,
            repeatType: s,
            ...l
        },
        this.updateFinishedPromise()
    }
    calcStartTime() {
        return this.resolvedAt ? this.resolvedAt - this.createdAt > Zy ? this.resolvedAt : this.createdAt : this.createdAt
    }
    get resolved() {
        return !this._resolved && !this.hasAttemptedResolve && Ry(),
        this._resolved
    }
    onKeyframesResolved(t, n) {
        this.resolvedAt = ot.now(),
        this.hasAttemptedResolve = !0;
        const {name: r, type: i, velocity: o, delay: s, onComplete: l, onUpdate: a, isGenerator: u} = this.options;
        if (!u && !Gy(t, r, i, o))
            if (s)
                this.options.duration = 0;
            else {
                a == null || a(us(t, this.options, n)),
                l == null || l(),
                this.resolveFinishedPromise();
                return
            }
        const c = this.initPlayback(t, n);
        c !== !1 && (this._resolved = {
            keyframes: t,
            finalKeyframe: n,
            ...c
        },
        this.onPostResolved())
    }
    onPostResolved() {}
    then(t, n) {
        return this.currentFinishedPromise.then(t, n)
    }
    flatten() {
        this.options.type = "keyframes",
        this.options.ease = "linear"
    }
    updateFinishedPromise() {
        this.currentFinishedPromise = new Promise(t => {
            this.resolveFinishedPromise = t
        }
        )
    }
}
const tr = (e, t, n) => {
    const r = t - e;
    return r === 0 ? 1 : (n - e) / r
}
  , A1 = (e, t, n=10) => {
    let r = "";
    const i = Math.max(Math.round(t / n), 2);
    for (let o = 0; o < i; o++)
        r += e(tr(0, i - 1, o)) + ", ";
    return `linear(${r.substring(0, r.length - 2)})`
}
;
function N1(e, t) {
    return t ? e * (1e3 / t) : 0
}
const Xy = 5;
function D1(e, t, n) {
    const r = Math.max(t - Xy, 0);
    return N1(n - e(r), t - r)
}
const G = {
    stiffness: 100,
    damping: 10,
    mass: 1,
    velocity: 0,
    duration: 800,
    bounce: .3,
    visualDuration: .3,
    restSpeed: {
        granular: .01,
        default: 2
    },
    restDelta: {
        granular: .005,
        default: .5
    },
    minDuration: .01,
    maxDuration: 10,
    minDamping: .05,
    maxDamping: 1
}
  , Ks = .001;
function Jy({duration: e=G.duration, bounce: t=G.bounce, velocity: n=G.velocity, mass: r=G.mass}) {
    let i, o, s = 1 - t;
    s = St(G.minDamping, G.maxDamping, s),
    e = St(G.minDuration, G.maxDuration, gt(e)),
    s < 1 ? (i = u => {
        const c = u * s
          , f = c * e
          , d = c - n
          , g = ia(u, s)
          , y = Math.exp(-f);
        return Ks - d / g * y
    }
    ,
    o = u => {
        const f = u * s * e
          , d = f * n + n
          , g = Math.pow(s, 2) * Math.pow(u, 2) * e
          , y = Math.exp(-f)
          , v = ia(Math.pow(u, 2), s);
        return (-i(u) + Ks > 0 ? -1 : 1) * ((d - g) * y) / v
    }
    ) : (i = u => {
        const c = Math.exp(-u * e)
          , f = (u - n) * e + 1;
        return -Ks + c * f
    }
    ,
    o = u => {
        const c = Math.exp(-u * e)
          , f = (n - u) * (e * e);
        return c * f
    }
    );
    const l = 5 / e
      , a = e5(i, o, l);
    if (e = mt(e),
    isNaN(a))
        return {
            stiffness: G.stiffness,
            damping: G.damping,
            duration: e
        };
    {
        const u = Math.pow(a, 2) * r;
        return {
            stiffness: u,
            damping: s * 2 * Math.sqrt(r * u),
            duration: e
        }
    }
}
const qy = 12;
function e5(e, t, n) {
    let r = n;
    for (let i = 1; i < qy; i++)
        r = r - e(r) / t(r);
    return r
}
function ia(e, t) {
    return e * Math.sqrt(1 - t * t)
}
const oa = 2e4;
function M1(e) {
    let t = 0;
    const n = 50;
    let r = e.next(t);
    for (; !r.done && t < oa; )
        t += n,
        r = e.next(t);
    return t >= oa ? 1 / 0 : t
}
const t5 = ["duration", "bounce"]
  , n5 = ["stiffness", "damping", "mass"];
function Pf(e, t) {
    return t.some(n => e[n] !== void 0)
}
function r5(e) {
    let t = {
        velocity: G.velocity,
        stiffness: G.stiffness,
        damping: G.damping,
        mass: G.mass,
        isResolvedFromDuration: !1,
        ...e
    };
    if (!Pf(e, n5) && Pf(e, t5))
        if (e.visualDuration) {
            const n = e.visualDuration
              , r = 2 * Math.PI / (n * 1.2)
              , i = r * r
              , o = 2 * St(.05, 1, 1 - e.bounce) * Math.sqrt(i);
            t = {
                ...t,
                mass: G.mass,
                stiffness: i,
                damping: o
            }
        } else {
            const n = Jy(e);
            t = {
                ...t,
                ...n,
                mass: G.mass
            },
            t.isResolvedFromDuration = !0
        }
    return t
}
function V1(e=G.visualDuration, t=G.bounce) {
    const n = typeof e != "object" ? {
        visualDuration: e,
        keyframes: [0, 1],
        bounce: t
    } : e;
    let {restSpeed: r, restDelta: i} = n;
    const o = n.keyframes[0]
      , s = n.keyframes[n.keyframes.length - 1]
      , l = {
        done: !1,
        value: o
    }
      , {stiffness: a, damping: u, mass: c, duration: f, velocity: d, isResolvedFromDuration: g} = r5({
        ...n,
        velocity: -gt(n.velocity || 0)
    })
      , y = d || 0
      , v = u / (2 * Math.sqrt(a * c))
      , C = s - o
      , p = gt(Math.sqrt(a / c))
      , h = Math.abs(C) < 5;
    r || (r = h ? G.restSpeed.granular : G.restSpeed.default),
    i || (i = h ? G.restDelta.granular : G.restDelta.default);
    let m;
    if (v < 1) {
        const S = ia(p, v);
        m = T => {
            const R = Math.exp(-v * p * T);
            return s - R * ((y + v * p * C) / S * Math.sin(S * T) + C * Math.cos(S * T))
        }
    } else if (v === 1)
        m = S => s - Math.exp(-p * S) * (C + (y + p * C) * S);
    else {
        const S = p * Math.sqrt(v * v - 1);
        m = T => {
            const R = Math.exp(-v * p * T)
              , k = Math.min(S * T, 300);
            return s - R * ((y + v * p * C) * Math.sinh(k) + S * C * Math.cosh(k)) / S
        }
    }
    const x = {
        calculatedDuration: g && f || null,
        next: S => {
            const T = m(S);
            if (g)
                l.done = S >= f;
            else {
                let R = 0;
                v < 1 && (R = S === 0 ? mt(y) : D1(m, S, T));
                const k = Math.abs(R) <= r
                  , V = Math.abs(s - T) <= i;
                l.done = k && V
            }
            return l.value = l.done ? s : T,
            l
        }
        ,
        toString: () => {
            const S = Math.min(M1(x), oa)
              , T = A1(R => x.next(S * R).value, S, 30);
            return S + "ms " + T
        }
    };
    return x
}
function kf({keyframes: e, velocity: t=0, power: n=.8, timeConstant: r=325, bounceDamping: i=10, bounceStiffness: o=500, modifyTarget: s, min: l, max: a, restDelta: u=.5, restSpeed: c}) {
    const f = e[0]
      , d = {
        done: !1,
        value: f
    }
      , g = k => l !== void 0 && k < l || a !== void 0 && k > a
      , y = k => l === void 0 ? a : a === void 0 || Math.abs(l - k) < Math.abs(a - k) ? l : a;
    let v = n * t;
    const C = f + v
      , p = s === void 0 ? C : s(C);
    p !== C && (v = p - f);
    const h = k => -v * Math.exp(-k / r)
      , m = k => p + h(k)
      , x = k => {
        const V = h(k)
          , D = m(k);
        d.done = Math.abs(V) <= u,
        d.value = d.done ? p : D
    }
    ;
    let S, T;
    const R = k => {
        !g(d.value) || (S = k,
        T = V1({
            keyframes: [d.value, y(d.value)],
            velocity: D1(m, k, d.value),
            damping: i,
            stiffness: o,
            restDelta: u,
            restSpeed: c
        }))
    }
    ;
    return R(0),
    {
        calculatedDuration: null,
        next: k => {
            let V = !1;
            return !T && S === void 0 && (V = !0,
            x(k),
            R(k)),
            S !== void 0 && k >= S ? T.next(k - S) : (!V && x(k),
            d)
        }
    }
}
const i5 = vi(.42, 0, 1, 1)
  , o5 = vi(0, 0, .58, 1)
  , O1 = vi(.42, 0, .58, 1)
  , s5 = e => Array.isArray(e) && typeof e[0] != "number"
  , Au = e => Array.isArray(e) && typeof e[0] == "number"
  , l5 = {
    linear: ye,
    easeIn: i5,
    easeInOut: O1,
    easeOut: o5,
    circIn: Cu,
    circInOut: f1,
    circOut: c1,
    backIn: xu,
    backInOut: a1,
    backOut: l1,
    anticipate: u1
}
  , Ef = e => {
    if (Au(e)) {
        n1(e.length === 4);
        const [t,n,r,i] = e;
        return vi(t, n, r, i)
    } else if (typeof e == "string")
        return l5[e];
    return e
}
  , a5 = (e, t) => n => t(e(n))
  , Ht = (...e) => e.reduce(a5)
  , b = (e, t, n) => e + (t - e) * n;
function Qs(e, t, n) {
    return n < 0 && (n += 1),
    n > 1 && (n -= 1),
    n < 1 / 6 ? e + (t - e) * 6 * n : n < 1 / 2 ? t : n < 2 / 3 ? e + (t - e) * (2 / 3 - n) * 6 : e
}
function u5({hue: e, saturation: t, lightness: n, alpha: r}) {
    e /= 360,
    t /= 100,
    n /= 100;
    let i = 0
      , o = 0
      , s = 0;
    if (!t)
        i = o = s = n;
    else {
        const l = n < .5 ? n * (1 + t) : n + t - n * t
          , a = 2 * n - l;
        i = Qs(a, l, e + 1 / 3),
        o = Qs(a, l, e),
        s = Qs(a, l, e - 1 / 3)
    }
    return {
        red: Math.round(i * 255),
        green: Math.round(o * 255),
        blue: Math.round(s * 255),
        alpha: r
    }
}
function Oo(e, t) {
    return n => n > 0 ? t : e
}
const Ys = (e, t, n) => {
    const r = e * e
      , i = n * (t * t - r) + r;
    return i < 0 ? 0 : Math.sqrt(i)
}
  , c5 = [na, cn, In]
  , f5 = e => c5.find(t => t.test(e));
function Tf(e) {
    const t = f5(e);
    if (!Boolean(t))
        return !1;
    let n = t.parse(e);
    return t === In && (n = u5(n)),
    n
}
const Rf = (e, t) => {
    const n = Tf(e)
      , r = Tf(t);
    if (!n || !r)
        return Oo(e, t);
    const i = {
        ...n
    };
    return o => (i.red = Ys(n.red, r.red, o),
    i.green = Ys(n.green, r.green, o),
    i.blue = Ys(n.blue, r.blue, o),
    i.alpha = b(n.alpha, r.alpha, o),
    cn.transform(i))
}
  , sa = new Set(["none", "hidden"]);
function d5(e, t) {
    return sa.has(e) ? n => n <= 0 ? e : t : n => n >= 1 ? t : e
}
function h5(e, t) {
    return n => b(e, t, n)
}
function Nu(e) {
    return typeof e == "number" ? h5 : typeof e == "string" ? Su(e) ? Oo : me.test(e) ? Rf : g5 : Array.isArray(e) ? F1 : typeof e == "object" ? me.test(e) ? Rf : p5 : Oo
}
function F1(e, t) {
    const n = [...e]
      , r = n.length
      , i = e.map( (o, s) => Nu(o)(o, t[s]));
    return o => {
        for (let s = 0; s < r; s++)
            n[s] = i[s](o);
        return n
    }
}
function p5(e, t) {
    const n = {
        ...e,
        ...t
    }
      , r = {};
    for (const i in n)
        e[i] !== void 0 && t[i] !== void 0 && (r[i] = Nu(e[i])(e[i], t[i]));
    return i => {
        for (const o in r)
            n[o] = r[o](i);
        return n
    }
}
function m5(e, t) {
    var n;
    const r = []
      , i = {
        color: 0,
        var: 0,
        number: 0
    };
    for (let o = 0; o < t.values.length; o++) {
        const s = t.types[o]
          , l = e.indexes[s][i[s]]
          , a = (n = e.values[l]) !== null && n !== void 0 ? n : 0;
        r[o] = a,
        i[s]++
    }
    return r
}
const g5 = (e, t) => {
    const n = Qt.createTransformer(t)
      , r = si(e)
      , i = si(t);
    return r.indexes.var.length === i.indexes.var.length && r.indexes.color.length === i.indexes.color.length && r.indexes.number.length >= i.indexes.number.length ? sa.has(e) && !i.values.length || sa.has(t) && !r.values.length ? d5(e, t) : Ht(F1(m5(r, i), i.values), n) : Oo(e, t)
}
;
function I1(e, t, n) {
    return typeof e == "number" && typeof t == "number" && typeof n == "number" ? b(e, t, n) : Nu(e)(e, t)
}
function v5(e, t, n) {
    const r = []
      , i = n || I1
      , o = e.length - 1;
    for (let s = 0; s < o; s++) {
        let l = i(e[s], e[s + 1]);
        if (t) {
            const a = Array.isArray(t) ? t[s] || ye : t;
            l = Ht(a, l)
        }
        r.push(l)
    }
    return r
}
function y5(e, t, {clamp: n=!0, ease: r, mixer: i}={}) {
    const o = e.length;
    if (n1(o === t.length),
    o === 1)
        return () => t[0];
    if (o === 2 && e[0] === e[1])
        return () => t[1];
    e[0] > e[o - 1] && (e = [...e].reverse(),
    t = [...t].reverse());
    const s = v5(t, r, i)
      , l = s.length
      , a = u => {
        let c = 0;
        if (l > 1)
            for (; c < e.length - 2 && !(u < e[c + 1]); c++)
                ;
        const f = tr(e[c], e[c + 1], u);
        return s[c](f)
    }
    ;
    return n ? u => a(St(e[0], e[o - 1], u)) : a
}
function w5(e, t) {
    const n = e[e.length - 1];
    for (let r = 1; r <= t; r++) {
        const i = tr(0, t, r);
        e.push(b(n, 1, i))
    }
}
function x5(e) {
    const t = [0];
    return w5(t, e.length - 1),
    t
}
function C5(e, t) {
    return e.map(n => n * t)
}
function S5(e, t) {
    return e.map( () => t || O1).splice(0, e.length - 1)
}
function Fo({duration: e=300, keyframes: t, times: n, ease: r="easeInOut"}) {
    const i = s5(r) ? r.map(Ef) : Ef(r)
      , o = {
        done: !1,
        value: t[0]
    }
      , s = C5(n && n.length === t.length ? n : x5(t), e)
      , l = y5(s, t, {
        ease: Array.isArray(i) ? i : S5(t, i)
    });
    return {
        calculatedDuration: e,
        next: a => (o.value = l(a),
        o.done = a >= e,
        o)
    }
}
const P5 = e => {
    const t = ({timestamp: n}) => e(n);
    return {
        start: () => z.update(t, !0),
        stop: () => Ct(t),
        now: () => ce.isProcessing ? ce.timestamp : ot.now()
    }
}
  , k5 = {
    decay: kf,
    inertia: kf,
    tween: Fo,
    keyframes: Fo,
    spring: V1
}
  , E5 = e => e / 100;
class Du extends L1 {
    constructor(t) {
        super(t),
        this.holdTime = null,
        this.cancelTime = null,
        this.currentTime = 0,
        this.playbackSpeed = 1,
        this.pendingPlayState = "running",
        this.startTime = null,
        this.state = "idle",
        this.stop = () => {
            if (this.resolver.cancel(),
            this.isStopped = !0,
            this.state === "idle")
                return;
            this.teardown();
            const {onStop: a} = this.options;
            a && a()
        }
        ;
        const {name: n, motionValue: r, element: i, keyframes: o} = this.options
          , s = (i == null ? void 0 : i.KeyframeResolver) || Pu
          , l = (a, u) => this.onKeyframesResolved(a, u);
        this.resolver = new s(o,l,n,r,i),
        this.resolver.scheduleResolve()
    }
    flatten() {
        super.flatten(),
        this._resolved && Object.assign(this._resolved, this.initPlayback(this._resolved.keyframes))
    }
    initPlayback(t) {
        const {type: n="keyframes", repeat: r=0, repeatDelay: i=0, repeatType: o, velocity: s=0} = this.options
          , l = Lu(n) ? n : k5[n] || Fo;
        let a, u;
        l !== Fo && typeof t[0] != "number" && (a = Ht(E5, I1(t[0], t[1])),
        t = [0, 100]);
        const c = l({
            ...this.options,
            keyframes: t
        });
        o === "mirror" && (u = l({
            ...this.options,
            keyframes: [...t].reverse(),
            velocity: -s
        })),
        c.calculatedDuration === null && (c.calculatedDuration = M1(c));
        const {calculatedDuration: f} = c
          , d = f + i
          , g = d * (r + 1) - i;
        return {
            generator: c,
            mirroredGenerator: u,
            mapPercentToKeyframes: a,
            calculatedDuration: f,
            resolvedDuration: d,
            totalDuration: g
        }
    }
    onPostResolved() {
        const {autoplay: t=!0} = this.options;
        this.play(),
        this.pendingPlayState === "paused" || !t ? this.pause() : this.state = this.pendingPlayState
    }
    tick(t, n=!1) {
        const {resolved: r} = this;
        if (!r) {
            const {keyframes: k} = this.options;
            return {
                done: !0,
                value: k[k.length - 1]
            }
        }
        const {finalKeyframe: i, generator: o, mirroredGenerator: s, mapPercentToKeyframes: l, keyframes: a, calculatedDuration: u, totalDuration: c, resolvedDuration: f} = r;
        if (this.startTime === null)
            return o.next(0);
        const {delay: d, repeat: g, repeatType: y, repeatDelay: v, onUpdate: C} = this.options;
        this.speed > 0 ? this.startTime = Math.min(this.startTime, t) : this.speed < 0 && (this.startTime = Math.min(t - c / this.speed, this.startTime)),
        n ? this.currentTime = t : this.holdTime !== null ? this.currentTime = this.holdTime : this.currentTime = Math.round(t - this.startTime) * this.speed;
        const p = this.currentTime - d * (this.speed >= 0 ? 1 : -1)
          , h = this.speed >= 0 ? p < 0 : p > c;
        this.currentTime = Math.max(p, 0),
        this.state === "finished" && this.holdTime === null && (this.currentTime = c);
        let m = this.currentTime
          , x = o;
        if (g) {
            const k = Math.min(this.currentTime, c) / f;
            let V = Math.floor(k)
              , D = k % 1;
            !D && k >= 1 && (D = 1),
            D === 1 && V--,
            V = Math.min(V, g + 1),
            Boolean(V % 2) && (y === "reverse" ? (D = 1 - D,
            v && (D -= v / f)) : y === "mirror" && (x = s)),
            m = St(0, 1, D) * f
        }
        const S = h ? {
            done: !1,
            value: a[0]
        } : x.next(m);
        l && (S.value = l(S.value));
        let {done: T} = S;
        !h && u !== null && (T = this.speed >= 0 ? this.currentTime >= c : this.currentTime <= 0);
        const R = this.holdTime === null && (this.state === "finished" || this.state === "running" && T);
        return R && i !== void 0 && (S.value = us(a, this.options, i)),
        C && C(S.value),
        R && this.finish(),
        S
    }
    get duration() {
        const {resolved: t} = this;
        return t ? gt(t.calculatedDuration) : 0
    }
    get time() {
        return gt(this.currentTime)
    }
    set time(t) {
        t = mt(t),
        this.currentTime = t,
        this.holdTime !== null || this.speed === 0 ? this.holdTime = t : this.driver && (this.startTime = this.driver.now() - t / this.speed)
    }
    get speed() {
        return this.playbackSpeed
    }
    set speed(t) {
        const n = this.playbackSpeed !== t;
        this.playbackSpeed = t,
        n && (this.time = gt(this.currentTime))
    }
    play() {
        if (this.resolver.isScheduled || this.resolver.resume(),
        !this._resolved) {
            this.pendingPlayState = "running";
            return
        }
        if (this.isStopped)
            return;
        const {driver: t=P5, onPlay: n, startTime: r} = this.options;
        this.driver || (this.driver = t(o => this.tick(o))),
        n && n();
        const i = this.driver.now();
        this.holdTime !== null ? this.startTime = i - this.holdTime : this.startTime ? this.state === "finished" && (this.startTime = i) : this.startTime = r != null ? r : this.calcStartTime(),
        this.state === "finished" && this.updateFinishedPromise(),
        this.cancelTime = this.startTime,
        this.holdTime = null,
        this.state = "running",
        this.driver.start()
    }
    pause() {
        var t;
        if (!this._resolved) {
            this.pendingPlayState = "paused";
            return
        }
        this.state = "paused",
        this.holdTime = (t = this.currentTime) !== null && t !== void 0 ? t : 0
    }
    complete() {
        this.state !== "running" && this.play(),
        this.pendingPlayState = this.state = "finished",
        this.holdTime = null
    }
    finish() {
        this.teardown(),
        this.state = "finished";
        const {onComplete: t} = this.options;
        t && t()
    }
    cancel() {
        this.cancelTime !== null && this.tick(this.cancelTime),
        this.teardown(),
        this.updateFinishedPromise()
    }
    teardown() {
        this.state = "idle",
        this.stopDriver(),
        this.resolveFinishedPromise(),
        this.updateFinishedPromise(),
        this.startTime = this.cancelTime = null,
        this.resolver.cancel()
    }
    stopDriver() {
        !this.driver || (this.driver.stop(),
        this.driver = void 0)
    }
    sample(t) {
        return this.startTime = 0,
        this.tick(t, !0)
    }
}
const T5 = new Set(["opacity", "clipPath", "filter", "transform"]);
function Mu(e) {
    let t;
    return () => (t === void 0 && (t = e()),
    t)
}
const R5 = {
    linearEasing: void 0
};
function L5(e, t) {
    const n = Mu(e);
    return () => {
        var r;
        return (r = R5[t]) !== null && r !== void 0 ? r : n()
    }
}
const Io = L5( () => {
    try {
        document.createElement("div").animate({
            opacity: 0
        }, {
            easing: "linear(0, 1)"
        })
    } catch {
        return !1
    }
    return !0
}
, "linearEasing");
function _1(e) {
    return Boolean(typeof e == "function" && Io() || !e || typeof e == "string" && (e in la || Io()) || Au(e) || Array.isArray(e) && e.every(_1))
}
const Tr = ([e,t,n,r]) => `cubic-bezier(${e}, ${t}, ${n}, ${r})`
  , la = {
    linear: "linear",
    ease: "ease",
    easeIn: "ease-in",
    easeOut: "ease-out",
    easeInOut: "ease-in-out",
    circIn: Tr([0, .65, .55, 1]),
    circOut: Tr([.55, 0, 1, .45]),
    backIn: Tr([.31, .01, .66, -.59]),
    backOut: Tr([.33, 1.53, .69, .99])
};
function B1(e, t) {
    if (e)
        return typeof e == "function" && Io() ? A1(e, t) : Au(e) ? Tr(e) : Array.isArray(e) ? e.map(n => B1(n, t) || la.easeOut) : la[e]
}
function A5(e, t, n, {delay: r=0, duration: i=300, repeat: o=0, repeatType: s="loop", ease: l="easeInOut", times: a}={}) {
    const u = {
        [t]: n
    };
    a && (u.offset = a);
    const c = B1(l, i);
    return Array.isArray(c) && (u.easing = c),
    e.animate(u, {
        delay: r,
        duration: i,
        easing: Array.isArray(c) ? "linear" : c,
        fill: "both",
        iterations: o + 1,
        direction: s === "reverse" ? "alternate" : "normal"
    })
}
function Lf(e, t) {
    e.timeline = t,
    e.onfinish = null
}
const N5 = Mu( () => Object.hasOwnProperty.call(Element.prototype, "animate"))
  , _o = 10
  , D5 = 2e4;
function M5(e) {
    return Lu(e.type) || e.type === "spring" || !_1(e.ease)
}
function V5(e, t) {
    const n = new Du({
        ...t,
        keyframes: e,
        repeat: 0,
        delay: 0,
        isGenerator: !0
    });
    let r = {
        done: !1,
        value: e[0]
    };
    const i = [];
    let o = 0;
    for (; !r.done && o < D5; )
        r = n.sample(o),
        i.push(r.value),
        o += _o;
    return {
        times: void 0,
        keyframes: i,
        duration: o - _o,
        ease: "linear"
    }
}
const z1 = {
    anticipate: u1,
    backInOut: a1,
    circInOut: f1
};
function O5(e) {
    return e in z1
}
class Af extends L1 {
    constructor(t) {
        super(t);
        const {name: n, motionValue: r, element: i, keyframes: o} = this.options;
        this.resolver = new R1(o, (s, l) => this.onKeyframesResolved(s, l),n,r,i),
        this.resolver.scheduleResolve()
    }
    initPlayback(t, n) {
        var r;
        let {duration: i=300, times: o, ease: s, type: l, motionValue: a, name: u, startTime: c} = this.options;
        if (!(!((r = a.owner) === null || r === void 0) && r.current))
            return !1;
        if (typeof s == "string" && Io() && O5(s) && (s = z1[s]),
        M5(this.options)) {
            const {onComplete: d, onUpdate: g, motionValue: y, element: v, ...C} = this.options
              , p = V5(t, C);
            t = p.keyframes,
            t.length === 1 && (t[1] = t[0]),
            i = p.duration,
            o = p.times,
            s = p.ease,
            l = "keyframes"
        }
        const f = A5(a.owner.current, u, t, {
            ...this.options,
            duration: i,
            times: o,
            ease: s
        });
        return f.startTime = c != null ? c : this.calcStartTime(),
        this.pendingTimeline ? (Lf(f, this.pendingTimeline),
        this.pendingTimeline = void 0) : f.onfinish = () => {
            const {onComplete: d} = this.options;
            a.set(us(t, this.options, n)),
            d && d(),
            this.cancel(),
            this.resolveFinishedPromise()
        }
        ,
        {
            animation: f,
            duration: i,
            times: o,
            type: l,
            ease: s,
            keyframes: t
        }
    }
    get duration() {
        const {resolved: t} = this;
        if (!t)
            return 0;
        const {duration: n} = t;
        return gt(n)
    }
    get time() {
        const {resolved: t} = this;
        if (!t)
            return 0;
        const {animation: n} = t;
        return gt(n.currentTime || 0)
    }
    set time(t) {
        const {resolved: n} = this;
        if (!n)
            return;
        const {animation: r} = n;
        r.currentTime = mt(t)
    }
    get speed() {
        const {resolved: t} = this;
        if (!t)
            return 1;
        const {animation: n} = t;
        return n.playbackRate
    }
    set speed(t) {
        const {resolved: n} = this;
        if (!n)
            return;
        const {animation: r} = n;
        r.playbackRate = t
    }
    get state() {
        const {resolved: t} = this;
        if (!t)
            return "idle";
        const {animation: n} = t;
        return n.playState
    }
    get startTime() {
        const {resolved: t} = this;
        if (!t)
            return null;
        const {animation: n} = t;
        return n.startTime
    }
    attachTimeline(t) {
        if (!this._resolved)
            this.pendingTimeline = t;
        else {
            const {resolved: n} = this;
            if (!n)
                return ye;
            const {animation: r} = n;
            Lf(r, t)
        }
        return ye
    }
    play() {
        if (this.isStopped)
            return;
        const {resolved: t} = this;
        if (!t)
            return;
        const {animation: n} = t;
        n.playState === "finished" && this.updateFinishedPromise(),
        n.play()
    }
    pause() {
        const {resolved: t} = this;
        if (!t)
            return;
        const {animation: n} = t;
        n.pause()
    }
    stop() {
        if (this.resolver.cancel(),
        this.isStopped = !0,
        this.state === "idle")
            return;
        this.resolveFinishedPromise(),
        this.updateFinishedPromise();
        const {resolved: t} = this;
        if (!t)
            return;
        const {animation: n, keyframes: r, duration: i, type: o, ease: s, times: l} = t;
        if (n.playState === "idle" || n.playState === "finished")
            return;
        if (this.time) {
            const {motionValue: u, onUpdate: c, onComplete: f, element: d, ...g} = this.options
              , y = new Du({
                ...g,
                keyframes: r,
                duration: i,
                type: o,
                ease: s,
                times: l,
                isGenerator: !0
            })
              , v = mt(this.time);
            u.setWithVelocity(y.sample(v - _o).value, y.sample(v).value, _o)
        }
        const {onStop: a} = this.options;
        a && a(),
        this.cancel()
    }
    complete() {
        const {resolved: t} = this;
        !t || t.animation.finish()
    }
    cancel() {
        const {resolved: t} = this;
        !t || t.animation.cancel()
    }
    static supports(t) {
        const {motionValue: n, name: r, repeatDelay: i, repeatType: o, damping: s, type: l} = t;
        return N5() && r && T5.has(r) && n && n.owner && n.owner.current instanceof HTMLElement && !n.owner.getProps().onUpdate && !i && o !== "mirror" && s !== 0 && l !== "inertia"
    }
}
const F5 = Mu( () => window.ScrollTimeline !== void 0);
class I5 {
    constructor(t) {
        this.stop = () => this.runAll("stop"),
        this.animations = t.filter(Boolean)
    }
    then(t, n) {
        return Promise.all(this.animations).then(t).catch(n)
    }
    getAll(t) {
        return this.animations[0][t]
    }
    setAll(t, n) {
        for (let r = 0; r < this.animations.length; r++)
            this.animations[r][t] = n
    }
    attachTimeline(t, n) {
        const r = this.animations.map(i => F5() && i.attachTimeline ? i.attachTimeline(t) : n(i));
        return () => {
            r.forEach( (i, o) => {
                i && i(),
                this.animations[o].stop()
            }
            )
        }
    }
    get time() {
        return this.getAll("time")
    }
    set time(t) {
        this.setAll("time", t)
    }
    get speed() {
        return this.getAll("speed")
    }
    set speed(t) {
        this.setAll("speed", t)
    }
    get startTime() {
        return this.getAll("startTime")
    }
    get duration() {
        let t = 0;
        for (let n = 0; n < this.animations.length; n++)
            t = Math.max(t, this.animations[n].duration);
        return t
    }
    runAll(t) {
        this.animations.forEach(n => n[t]())
    }
    flatten() {
        this.runAll("flatten")
    }
    play() {
        this.runAll("play")
    }
    pause() {
        this.runAll("pause")
    }
    cancel() {
        this.runAll("cancel")
    }
    complete() {
        this.runAll("complete")
    }
}
function _5({when: e, delay: t, delayChildren: n, staggerChildren: r, staggerDirection: i, repeat: o, repeatType: s, repeatDelay: l, from: a, elapsed: u, ...c}) {
    return !!Object.keys(c).length
}
const Vu = (e, t, n, r={}, i, o) => s => {
    const l = wu(r, e) || {}
      , a = l.delay || r.delay || 0;
    let {elapsed: u=0} = r;
    u = u - mt(a);
    let c = {
        keyframes: Array.isArray(n) ? n : [null, n],
        ease: "easeOut",
        velocity: t.getVelocity(),
        ...l,
        delay: -u,
        onUpdate: d => {
            t.set(d),
            l.onUpdate && l.onUpdate(d)
        }
        ,
        onComplete: () => {
            s(),
            l.onComplete && l.onComplete()
        }
        ,
        name: e,
        motionValue: t,
        element: o ? void 0 : i
    };
    _5(l) || (c = {
        ...c,
        ...ly(e, c)
    }),
    c.duration && (c.duration = mt(c.duration)),
    c.repeatDelay && (c.repeatDelay = mt(c.repeatDelay)),
    c.from !== void 0 && (c.keyframes[0] = c.from);
    let f = !1;
    if ((c.type === !1 || c.duration === 0 && !c.repeatDelay) && (c.duration = 0,
    c.delay === 0 && (f = !0)),
    f && !o && t.get() !== void 0) {
        const d = us(c.keyframes, l);
        if (d !== void 0)
            return z.update( () => {
                c.onUpdate(d),
                c.onComplete()
            }
            ),
            new I5([])
    }
    return !o && Af.supports(c) ? new Af(c) : new Du(c)
}
  , B5 = e => Boolean(e && typeof e == "object" && e.mix && e.toValue)
  , z5 = e => ql(e) ? e[e.length - 1] || 0 : e;
function Ou(e, t) {
    e.indexOf(t) === -1 && e.push(t)
}
function Fu(e, t) {
    const n = e.indexOf(t);
    n > -1 && e.splice(n, 1)
}
class Iu {
    constructor() {
        this.subscriptions = []
    }
    add(t) {
        return Ou(this.subscriptions, t),
        () => Fu(this.subscriptions, t)
    }
    notify(t, n, r) {
        const i = this.subscriptions.length;
        if (!!i)
            if (i === 1)
                this.subscriptions[0](t, n, r);
            else
                for (let o = 0; o < i; o++) {
                    const s = this.subscriptions[o];
                    s && s(t, n, r)
                }
    }
    getSize() {
        return this.subscriptions.length
    }
    clear() {
        this.subscriptions.length = 0
    }
}
const Nf = 30
  , j5 = e => !isNaN(parseFloat(e));
class U5 {
    constructor(t, n={}) {
        this.version = "11.13.1",
        this.canTrackVelocity = null,
        this.events = {},
        this.updateAndNotify = (r, i=!0) => {
            const o = ot.now();
            this.updatedAt !== o && this.setPrevFrameValue(),
            this.prev = this.current,
            this.setCurrent(r),
            this.current !== this.prev && this.events.change && this.events.change.notify(this.current),
            i && this.events.renderRequest && this.events.renderRequest.notify(this.current)
        }
        ,
        this.hasAnimated = !1,
        this.setCurrent(t),
        this.owner = n.owner
    }
    setCurrent(t) {
        this.current = t,
        this.updatedAt = ot.now(),
        this.canTrackVelocity === null && t !== void 0 && (this.canTrackVelocity = j5(this.current))
    }
    setPrevFrameValue(t=this.current) {
        this.prevFrameValue = t,
        this.prevUpdatedAt = this.updatedAt
    }
    onChange(t) {
        return this.on("change", t)
    }
    on(t, n) {
        this.events[t] || (this.events[t] = new Iu);
        const r = this.events[t].add(n);
        return t === "change" ? () => {
            r(),
            z.read( () => {
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
        this.prev = void 0,
        this.prevFrameValue = t,
        this.prevUpdatedAt = this.updatedAt - r
    }
    jump(t, n=!0) {
        this.updateAndNotify(t),
        this.prev = t,
        this.prevUpdatedAt = this.prevFrameValue = void 0,
        n && this.stop(),
        this.stopPassiveEffect && this.stopPassiveEffect()
    }
    get() {
        return this.current
    }
    getPrevious() {
        return this.prev
    }
    getVelocity() {
        const t = ot.now();
        if (!this.canTrackVelocity || this.prevFrameValue === void 0 || t - this.updatedAt > Nf)
            return 0;
        const n = Math.min(this.updatedAt - this.prevUpdatedAt, Nf);
        return N1(parseFloat(this.current) - parseFloat(this.prevFrameValue), n)
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
function li(e, t) {
    return new U5(e,t)
}
function H5(e, t, n) {
    e.hasValue(t) ? e.getValue(t).set(n) : e.addValue(t, li(n))
}
function $5(e, t) {
    const n = as(e, t);
    let {transitionEnd: r={}, transition: i={}, ...o} = n || {};
    o = {
        ...o,
        ...r
    };
    for (const s in o) {
        const l = z5(o[s]);
        H5(e, s, l)
    }
}
const _u = e => e.replace(/([a-z])([A-Z])/gu, "$1-$2").toLowerCase()
  , W5 = "framerAppearId"
  , j1 = "data-" + _u(W5);
function U1(e) {
    return e.props[j1]
}
const ve = e => Boolean(e && e.getVelocity);
function b5(e) {
    return Boolean(ve(e) && e.add)
}
function aa(e, t) {
    const n = e.getValue("willChange");
    if (b5(n))
        return n.add(t)
}
function K5({protectedKeys: e, needsAnimating: t}, n) {
    const r = e.hasOwnProperty(n) && t[n] !== !0;
    return t[n] = !1,
    r
}
function H1(e, t, {delay: n=0, transitionOverride: r, type: i}={}) {
    var o;
    let {transition: s=e.getDefaultTransition(), transitionEnd: l, ...a} = t;
    r && (s = r);
    const u = []
      , c = i && e.animationState && e.animationState.getState()[i];
    for (const f in a) {
        const d = e.getValue(f, (o = e.latestValues[f]) !== null && o !== void 0 ? o : null)
          , g = a[f];
        if (g === void 0 || c && K5(c, f))
            continue;
        const y = {
            delay: n,
            ...wu(s || {}, f)
        };
        let v = !1;
        if (window.MotionHandoffAnimation) {
            const p = U1(e);
            if (p) {
                const h = window.MotionHandoffAnimation(p, f, z);
                h !== null && (y.startTime = h,
                v = !0)
            }
        }
        aa(e, f),
        d.start(Vu(f, d, g, e.shouldReduceMotion && Sn.has(f) ? {
            type: !1
        } : y, e, v));
        const C = d.animation;
        C && u.push(C)
    }
    return l && Promise.all(u).then( () => {
        z.update( () => {
            l && $5(e, l)
        }
        )
    }
    ),
    u
}
function ua(e, t, n={}) {
    var r;
    const i = as(e, t, n.type === "exit" ? (r = e.presenceContext) === null || r === void 0 ? void 0 : r.custom : void 0);
    let {transition: o=e.getDefaultTransition() || {}} = i || {};
    n.transitionOverride && (o = n.transitionOverride);
    const s = i ? () => Promise.all(H1(e, i, n)) : () => Promise.resolve()
      , l = e.variantChildren && e.variantChildren.size ? (u=0) => {
        const {delayChildren: c=0, staggerChildren: f, staggerDirection: d} = o;
        return Q5(e, t, c + u, f, d, n)
    }
    : () => Promise.resolve()
      , {when: a} = o;
    if (a) {
        const [u,c] = a === "beforeChildren" ? [s, l] : [l, s];
        return u().then( () => c())
    } else
        return Promise.all([s(), l(n.delay)])
}
function Q5(e, t, n=0, r=0, i=1, o) {
    const s = []
      , l = (e.variantChildren.size - 1) * r
      , a = i === 1 ? (u=0) => u * r : (u=0) => l - u * r;
    return Array.from(e.variantChildren).sort(Y5).forEach( (u, c) => {
        u.notify("AnimationStart", t),
        s.push(ua(u, t, {
            ...o,
            delay: n + a(c)
        }).then( () => u.notify("AnimationComplete", t)))
    }
    ),
    Promise.all(s)
}
function Y5(e, t) {
    return e.sortNodePosition(t)
}
function G5(e, t, n={}) {
    e.notify("AnimationStart", t);
    let r;
    if (Array.isArray(t)) {
        const i = t.map(o => ua(e, o, n));
        r = Promise.all(i)
    } else if (typeof t == "string")
        r = ua(e, t, n);
    else {
        const i = typeof t == "function" ? as(e, t, n.custom) : t;
        r = Promise.all(H1(e, i, n))
    }
    return r.then( () => {
        e.notify("AnimationComplete", t)
    }
    )
}
const Z5 = yu.length;
function $1(e) {
    if (!e)
        return;
    if (!e.isControllingVariants) {
        const n = e.parent ? $1(e.parent) || {} : {};
        return e.props.initial !== void 0 && (n.initial = e.props.initial),
        n
    }
    const t = {};
    for (let n = 0; n < Z5; n++) {
        const r = yu[n]
          , i = e.props[r];
        (ii(i) || i === !1) && (t[r] = i)
    }
    return t
}
const X5 = [...vu].reverse()
  , J5 = vu.length;
function q5(e) {
    return t => Promise.all(t.map( ({animation: n, options: r}) => G5(e, n, r)))
}
function e3(e) {
    let t = q5(e)
      , n = Df()
      , r = !0;
    const i = a => (u, c) => {
        var f;
        const d = as(e, c, a === "exit" ? (f = e.presenceContext) === null || f === void 0 ? void 0 : f.custom : void 0);
        if (d) {
            const {transition: g, transitionEnd: y, ...v} = d;
            u = {
                ...u,
                ...v,
                ...y
            }
        }
        return u
    }
    ;
    function o(a) {
        t = a(e)
    }
    function s(a) {
        const {props: u} = e
          , c = $1(e.parent) || {}
          , f = []
          , d = new Set;
        let g = {}
          , y = 1 / 0;
        for (let C = 0; C < J5; C++) {
            const p = X5[C]
              , h = n[p]
              , m = u[p] !== void 0 ? u[p] : c[p]
              , x = ii(m)
              , S = p === a ? h.isActive : null;
            S === !1 && (y = C);
            let T = m === c[p] && m !== u[p] && x;
            if (T && r && e.manuallyAnimateOnMount && (T = !1),
            h.protectedKeys = {
                ...g
            },
            !h.isActive && S === null || !m && !h.prevProp || ls(m) || typeof m == "boolean")
                continue;
            const R = t3(h.prevProp, m);
            let k = R || p === a && h.isActive && !T && x || C > y && x
              , V = !1;
            const D = Array.isArray(m) ? m : [m];
            let X = D.reduce(i(p), {});
            S === !1 && (X = {});
            const {prevResolvedValues: Et={}} = h
              , Jt = {
                ...Et,
                ...X
            }
              , ur = ne => {
                k = !0,
                d.has(ne) && (V = !0,
                d.delete(ne)),
                h.needsAnimating[ne] = !0;
                const L = e.getValue(ne);
                L && (L.liveStyle = !1)
            }
            ;
            for (const ne in Jt) {
                const L = X[ne]
                  , O = Et[ne];
                if (g.hasOwnProperty(ne))
                    continue;
                let F = !1;
                ql(L) && ql(O) ? F = !t1(L, O) : F = L !== O,
                F ? L != null ? ur(ne) : d.add(ne) : L !== void 0 && d.has(ne) ? ur(ne) : h.protectedKeys[ne] = !0
            }
            h.prevProp = m,
            h.prevResolvedValues = X,
            h.isActive && (g = {
                ...g,
                ...X
            }),
            r && e.blockInitialAnimation && (k = !1),
            k && (!(T && R) || V) && f.push(...D.map(ne => ({
                animation: ne,
                options: {
                    type: p
                }
            })))
        }
        if (d.size) {
            const C = {};
            d.forEach(p => {
                const h = e.getBaseTarget(p)
                  , m = e.getValue(p);
                m && (m.liveStyle = !0),
                C[p] = h != null ? h : null
            }
            ),
            f.push({
                animation: C
            })
        }
        let v = Boolean(f.length);
        return r && (u.initial === !1 || u.initial === u.animate) && !e.manuallyAnimateOnMount && (v = !1),
        r = !1,
        v ? t(f) : Promise.resolve()
    }
    function l(a, u) {
        var c;
        if (n[a].isActive === u)
            return Promise.resolve();
        (c = e.variantChildren) === null || c === void 0 || c.forEach(d => {
            var g;
            return (g = d.animationState) === null || g === void 0 ? void 0 : g.setActive(a, u)
        }
        ),
        n[a].isActive = u;
        const f = s(a);
        for (const d in n)
            n[d].protectedKeys = {};
        return f
    }
    return {
        animateChanges: s,
        setActive: l,
        setAnimateFunction: o,
        getState: () => n,
        reset: () => {
            n = Df(),
            r = !0
        }
    }
}
function t3(e, t) {
    return typeof t == "string" ? t !== e : Array.isArray(t) ? !t1(t, e) : !1
}
function tn(e=!1) {
    return {
        isActive: e,
        protectedKeys: {},
        needsAnimating: {},
        prevResolvedValues: {}
    }
}
function Df() {
    return {
        animate: tn(!0),
        whileInView: tn(),
        whileHover: tn(),
        whileTap: tn(),
        whileDrag: tn(),
        whileFocus: tn(),
        exit: tn()
    }
}
class Xt {
    constructor(t) {
        this.isMounted = !1,
        this.node = t
    }
    update() {}
}
class n3 extends Xt {
    constructor(t) {
        super(t),
        t.animationState || (t.animationState = e3(t))
    }
    updateAnimationControlsSubscription() {
        const {animate: t} = this.node.getProps();
        ls(t) && (this.unmountControls = t.subscribe(this.node))
    }
    mount() {
        this.updateAnimationControlsSubscription()
    }
    update() {
        const {animate: t} = this.node.getProps()
          , {animate: n} = this.node.prevProps || {};
        t !== n && this.updateAnimationControlsSubscription()
    }
    unmount() {
        var t;
        this.node.animationState.reset(),
        (t = this.unmountControls) === null || t === void 0 || t.call(this)
    }
}
let r3 = 0;
class i3 extends Xt {
    constructor() {
        super(...arguments),
        this.id = r3++
    }
    update() {
        if (!this.node.presenceContext)
            return;
        const {isPresent: t, onExitComplete: n} = this.node.presenceContext
          , {isPresent: r} = this.node.prevPresenceContext || {};
        if (!this.node.animationState || t === r)
            return;
        const i = this.node.animationState.setActive("exit", !t);
        n && !t && i.then( () => n(this.id))
    }
    mount() {
        const {register: t} = this.node.presenceContext || {};
        t && (this.unmount = t(this.id))
    }
    unmount() {}
}
const o3 = {
    animation: {
        Feature: n3
    },
    exit: {
        Feature: i3
    }
}
  , Ke = {
    x: !1,
    y: !1
};
function W1() {
    return Ke.x || Ke.y
}
function s3(e) {
    return e === "x" || e === "y" ? Ke[e] ? null : (Ke[e] = !0,
    () => {
        Ke[e] = !1
    }
    ) : Ke.x || Ke.y ? null : (Ke.x = Ke.y = !0,
    () => {
        Ke.x = Ke.y = !1
    }
    )
}
const b1 = e => e.pointerType === "mouse" ? typeof e.button != "number" || e.button <= 0 : e.isPrimary !== !1;
function wi(e) {
    return {
        point: {
            x: e.pageX,
            y: e.pageY
        }
    }
}
const l3 = e => t => b1(t) && e(t, wi(t));
function dt(e, t, n, r={
    passive: !0
}) {
    return e.addEventListener(t, n, r),
    () => e.removeEventListener(t, n)
}
function $t(e, t, n, r) {
    return dt(e, t, l3(n), r)
}
const Mf = (e, t) => Math.abs(e - t);
function a3(e, t) {
    const n = Mf(e.x, t.x)
      , r = Mf(e.y, t.y);
    return Math.sqrt(n ** 2 + r ** 2)
}
class K1 {
    constructor(t, n, {transformPagePoint: r, contextWindow: i, dragSnapToOrigin: o=!1}={}) {
        if (this.startEvent = null,
        this.lastMoveEvent = null,
        this.lastMoveEventInfo = null,
        this.handlers = {},
        this.contextWindow = window,
        this.updatePoint = () => {
            if (!(this.lastMoveEvent && this.lastMoveEventInfo))
                return;
            const f = Zs(this.lastMoveEventInfo, this.history)
              , d = this.startEvent !== null
              , g = a3(f.offset, {
                x: 0,
                y: 0
            }) >= 3;
            if (!d && !g)
                return;
            const {point: y} = f
              , {timestamp: v} = ce;
            this.history.push({
                ...y,
                timestamp: v
            });
            const {onStart: C, onMove: p} = this.handlers;
            d || (C && C(this.lastMoveEvent, f),
            this.startEvent = this.lastMoveEvent),
            p && p(this.lastMoveEvent, f)
        }
        ,
        this.handlePointerMove = (f, d) => {
            this.lastMoveEvent = f,
            this.lastMoveEventInfo = Gs(d, this.transformPagePoint),
            z.update(this.updatePoint, !0)
        }
        ,
        this.handlePointerUp = (f, d) => {
            this.end();
            const {onEnd: g, onSessionEnd: y, resumeAnimation: v} = this.handlers;
            if (this.dragSnapToOrigin && v && v(),
            !(this.lastMoveEvent && this.lastMoveEventInfo))
                return;
            const C = Zs(f.type === "pointercancel" ? this.lastMoveEventInfo : Gs(d, this.transformPagePoint), this.history);
            this.startEvent && g && g(f, C),
            y && y(f, C)
        }
        ,
        !b1(t))
            return;
        this.dragSnapToOrigin = o,
        this.handlers = n,
        this.transformPagePoint = r,
        this.contextWindow = i || window;
        const s = wi(t)
          , l = Gs(s, this.transformPagePoint)
          , {point: a} = l
          , {timestamp: u} = ce;
        this.history = [{
            ...a,
            timestamp: u
        }];
        const {onSessionStart: c} = n;
        c && c(t, Zs(l, this.history)),
        this.removeListeners = Ht($t(this.contextWindow, "pointermove", this.handlePointerMove), $t(this.contextWindow, "pointerup", this.handlePointerUp), $t(this.contextWindow, "pointercancel", this.handlePointerUp))
    }
    updateHandlers(t) {
        this.handlers = t
    }
    end() {
        this.removeListeners && this.removeListeners(),
        Ct(this.updatePoint)
    }
}
function Gs(e, t) {
    return t ? {
        point: t(e.point)
    } : e
}
function Vf(e, t) {
    return {
        x: e.x - t.x,
        y: e.y - t.y
    }
}
function Zs({point: e}, t) {
    return {
        point: e,
        delta: Vf(e, Q1(t)),
        offset: Vf(e, u3(t)),
        velocity: c3(t, .1)
    }
}
function u3(e) {
    return e[0]
}
function Q1(e) {
    return e[e.length - 1]
}
function c3(e, t) {
    if (e.length < 2)
        return {
            x: 0,
            y: 0
        };
    let n = e.length - 1
      , r = null;
    const i = Q1(e);
    for (; n >= 0 && (r = e[n],
    !(i.timestamp - r.timestamp > mt(t))); )
        n--;
    if (!r)
        return {
            x: 0,
            y: 0
        };
    const o = gt(i.timestamp - r.timestamp);
    if (o === 0)
        return {
            x: 0,
            y: 0
        };
    const s = {
        x: (i.x - r.x) / o,
        y: (i.y - r.y) / o
    };
    return s.x === 1 / 0 && (s.x = 0),
    s.y === 1 / 0 && (s.y = 0),
    s
}
function _n(e) {
    return e && typeof e == "object" && Object.prototype.hasOwnProperty.call(e, "current")
}
const Y1 = 1e-4
  , f3 = 1 - Y1
  , d3 = 1 + Y1
  , G1 = .01
  , h3 = 0 - G1
  , p3 = 0 + G1;
function Ve(e) {
    return e.max - e.min
}
function m3(e, t, n) {
    return Math.abs(e - t) <= n
}
function Of(e, t, n, r=.5) {
    e.origin = r,
    e.originPoint = b(t.min, t.max, e.origin),
    e.scale = Ve(n) / Ve(t),
    e.translate = b(n.min, n.max, e.origin) - e.originPoint,
    (e.scale >= f3 && e.scale <= d3 || isNaN(e.scale)) && (e.scale = 1),
    (e.translate >= h3 && e.translate <= p3 || isNaN(e.translate)) && (e.translate = 0)
}
function Br(e, t, n, r) {
    Of(e.x, t.x, n.x, r ? r.originX : void 0),
    Of(e.y, t.y, n.y, r ? r.originY : void 0)
}
function Ff(e, t, n) {
    e.min = n.min + t.min,
    e.max = e.min + Ve(t)
}
function g3(e, t, n) {
    Ff(e.x, t.x, n.x),
    Ff(e.y, t.y, n.y)
}
function If(e, t, n) {
    e.min = t.min - n.min,
    e.max = e.min + Ve(t)
}
function zr(e, t, n) {
    If(e.x, t.x, n.x),
    If(e.y, t.y, n.y)
}
function v3(e, {min: t, max: n}, r) {
    return t !== void 0 && e < t ? e = r ? b(t, e, r.min) : Math.max(e, t) : n !== void 0 && e > n && (e = r ? b(n, e, r.max) : Math.min(e, n)),
    e
}
function _f(e, t, n) {
    return {
        min: t !== void 0 ? e.min + t : void 0,
        max: n !== void 0 ? e.max + n - (e.max - e.min) : void 0
    }
}
function y3(e, {top: t, left: n, bottom: r, right: i}) {
    return {
        x: _f(e.x, n, i),
        y: _f(e.y, t, r)
    }
}
function Bf(e, t) {
    let n = t.min - e.min
      , r = t.max - e.max;
    return t.max - t.min < e.max - e.min && ([n,r] = [r, n]),
    {
        min: n,
        max: r
    }
}
function w3(e, t) {
    return {
        x: Bf(e.x, t.x),
        y: Bf(e.y, t.y)
    }
}
function x3(e, t) {
    let n = .5;
    const r = Ve(e)
      , i = Ve(t);
    return i > r ? n = tr(t.min, t.max - r, e.min) : r > i && (n = tr(e.min, e.max - i, t.min)),
    St(0, 1, n)
}
function C3(e, t) {
    const n = {};
    return t.min !== void 0 && (n.min = t.min - e.min),
    t.max !== void 0 && (n.max = t.max - e.min),
    n
}
const ca = .35;
function S3(e=ca) {
    return e === !1 ? e = 0 : e === !0 && (e = ca),
    {
        x: zf(e, "left", "right"),
        y: zf(e, "top", "bottom")
    }
}
function zf(e, t, n) {
    return {
        min: jf(e, t),
        max: jf(e, n)
    }
}
function jf(e, t) {
    return typeof e == "number" ? e : e[t] || 0
}
const Uf = () => ({
    translate: 0,
    scale: 1,
    origin: 0,
    originPoint: 0
})
  , Bn = () => ({
    x: Uf(),
    y: Uf()
})
  , Hf = () => ({
    min: 0,
    max: 0
})
  , q = () => ({
    x: Hf(),
    y: Hf()
});
function _e(e) {
    return [e("x"), e("y")]
}
function Z1({top: e, left: t, right: n, bottom: r}) {
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
function P3({x: e, y: t}) {
    return {
        top: t.min,
        right: e.max,
        bottom: t.max,
        left: e.min
    }
}
function k3(e, t) {
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
function Xs(e) {
    return e === void 0 || e === 1
}
function fa({scale: e, scaleX: t, scaleY: n}) {
    return !Xs(e) || !Xs(t) || !Xs(n)
}
function on(e) {
    return fa(e) || X1(e) || e.z || e.rotate || e.rotateX || e.rotateY || e.skewX || e.skewY
}
function X1(e) {
    return $f(e.x) || $f(e.y)
}
function $f(e) {
    return e && e !== "0%"
}
function Bo(e, t, n) {
    const r = e - n
      , i = t * r;
    return n + i
}
function Wf(e, t, n, r, i) {
    return i !== void 0 && (e = Bo(e, i, r)),
    Bo(e, n, r) + t
}
function da(e, t=0, n=1, r, i) {
    e.min = Wf(e.min, t, n, r, i),
    e.max = Wf(e.max, t, n, r, i)
}
function J1(e, {x: t, y: n}) {
    da(e.x, t.translate, t.scale, t.originPoint),
    da(e.y, n.translate, n.scale, n.originPoint)
}
const bf = .999999999999
  , Kf = 1.0000000000001;
function E3(e, t, n, r=!1) {
    const i = n.length;
    if (!i)
        return;
    t.x = t.y = 1;
    let o, s;
    for (let l = 0; l < i; l++) {
        o = n[l],
        s = o.projectionDelta;
        const {visualElement: a} = o.options;
        a && a.props.style && a.props.style.display === "contents" || (r && o.options.layoutScroll && o.scroll && o !== o.root && jn(e, {
            x: -o.scroll.offset.x,
            y: -o.scroll.offset.y
        }),
        s && (t.x *= s.x.scale,
        t.y *= s.y.scale,
        J1(e, s)),
        r && on(o.latestValues) && jn(e, o.latestValues))
    }
    t.x < Kf && t.x > bf && (t.x = 1),
    t.y < Kf && t.y > bf && (t.y = 1)
}
function zn(e, t) {
    e.min = e.min + t,
    e.max = e.max + t
}
function Qf(e, t, n, r, i=.5) {
    const o = b(e.min, e.max, i);
    da(e, t, n, o, r)
}
function jn(e, t) {
    Qf(e.x, t.x, t.scaleX, t.scale, t.originX),
    Qf(e.y, t.y, t.scaleY, t.scale, t.originY)
}
function q1(e, t) {
    return Z1(k3(e.getBoundingClientRect(), t))
}
function T3(e, t, n) {
    const r = q1(e, n)
      , {scroll: i} = t;
    return i && (zn(r.x, i.offset.x),
    zn(r.y, i.offset.y)),
    r
}
const em = ({current: e}) => e ? e.ownerDocument.defaultView : null
  , R3 = new WeakMap;
class L3 {
    constructor(t) {
        this.openDragLock = null,
        this.isDragging = !1,
        this.currentDirection = null,
        this.originPoint = {
            x: 0,
            y: 0
        },
        this.constraints = !1,
        this.hasMutatedConstraints = !1,
        this.elastic = q(),
        this.visualElement = t
    }
    start(t, {snapToCursor: n=!1}={}) {
        const {presenceContext: r} = this.visualElement;
        if (r && r.isPresent === !1)
            return;
        const i = c => {
            const {dragSnapToOrigin: f} = this.getProps();
            f ? this.pauseAnimation() : this.stopAnimation(),
            n && this.snapToCursor(wi(c).point)
        }
          , o = (c, f) => {
            const {drag: d, dragPropagation: g, onDragStart: y} = this.getProps();
            if (d && !g && (this.openDragLock && this.openDragLock(),
            this.openDragLock = s3(d),
            !this.openDragLock))
                return;
            this.isDragging = !0,
            this.currentDirection = null,
            this.resolveConstraints(),
            this.visualElement.projection && (this.visualElement.projection.isAnimationBlocked = !0,
            this.visualElement.projection.target = void 0),
            _e(C => {
                let p = this.getAxisMotionValue(C).get() || 0;
                if (it.test(p)) {
                    const {projection: h} = this.visualElement;
                    if (h && h.layout) {
                        const m = h.layout.layoutBox[C];
                        m && (p = Ve(m) * (parseFloat(p) / 100))
                    }
                }
                this.originPoint[C] = p
            }
            ),
            y && z.postRender( () => y(c, f)),
            aa(this.visualElement, "transform");
            const {animationState: v} = this.visualElement;
            v && v.setActive("whileDrag", !0)
        }
          , s = (c, f) => {
            const {dragPropagation: d, dragDirectionLock: g, onDirectionLock: y, onDrag: v} = this.getProps();
            if (!d && !this.openDragLock)
                return;
            const {offset: C} = f;
            if (g && this.currentDirection === null) {
                this.currentDirection = A3(C),
                this.currentDirection !== null && y && y(this.currentDirection);
                return
            }
            this.updateAxis("x", f.point, C),
            this.updateAxis("y", f.point, C),
            this.visualElement.render(),
            v && v(c, f)
        }
          , l = (c, f) => this.stop(c, f)
          , a = () => _e(c => {
            var f;
            return this.getAnimationState(c) === "paused" && ((f = this.getAxisMotionValue(c).animation) === null || f === void 0 ? void 0 : f.play())
        }
        )
          , {dragSnapToOrigin: u} = this.getProps();
        this.panSession = new K1(t,{
            onSessionStart: i,
            onStart: o,
            onMove: s,
            onSessionEnd: l,
            resumeAnimation: a
        },{
            transformPagePoint: this.visualElement.getTransformPagePoint(),
            dragSnapToOrigin: u,
            contextWindow: em(this.visualElement)
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
        o && z.postRender( () => o(t, n))
    }
    cancel() {
        this.isDragging = !1;
        const {projection: t, animationState: n} = this.visualElement;
        t && (t.isAnimationBlocked = !1),
        this.panSession && this.panSession.end(),
        this.panSession = void 0;
        const {dragPropagation: r} = this.getProps();
        !r && this.openDragLock && (this.openDragLock(),
        this.openDragLock = null),
        n && n.setActive("whileDrag", !1)
    }
    updateAxis(t, n, r) {
        const {drag: i} = this.getProps();
        if (!r || !Hi(t, i, this.currentDirection))
            return;
        const o = this.getAxisMotionValue(t);
        let s = this.originPoint[t] + r[t];
        this.constraints && this.constraints[t] && (s = v3(s, this.constraints[t], this.elastic[t])),
        o.set(s)
    }
    resolveConstraints() {
        var t;
        const {dragConstraints: n, dragElastic: r} = this.getProps()
          , i = this.visualElement.projection && !this.visualElement.projection.layout ? this.visualElement.projection.measure(!1) : (t = this.visualElement.projection) === null || t === void 0 ? void 0 : t.layout
          , o = this.constraints;
        n && _n(n) ? this.constraints || (this.constraints = this.resolveRefConstraints()) : n && i ? this.constraints = y3(i.layoutBox, n) : this.constraints = !1,
        this.elastic = S3(r),
        o !== this.constraints && i && this.constraints && !this.hasMutatedConstraints && _e(s => {
            this.constraints !== !1 && this.getAxisMotionValue(s) && (this.constraints[s] = C3(i.layoutBox[s], this.constraints[s]))
        }
        )
    }
    resolveRefConstraints() {
        const {dragConstraints: t, onMeasureDragConstraints: n} = this.getProps();
        if (!t || !_n(t))
            return !1;
        const r = t.current
          , {projection: i} = this.visualElement;
        if (!i || !i.layout)
            return !1;
        const o = T3(r, i.root, this.visualElement.getTransformPagePoint());
        let s = w3(i.layout.layoutBox, o);
        if (n) {
            const l = n(P3(s));
            this.hasMutatedConstraints = !!l,
            l && (s = Z1(l))
        }
        return s
    }
    startAnimation(t) {
        const {drag: n, dragMomentum: r, dragElastic: i, dragTransition: o, dragSnapToOrigin: s, onDragTransitionEnd: l} = this.getProps()
          , a = this.constraints || {}
          , u = _e(c => {
            if (!Hi(c, n, this.currentDirection))
                return;
            let f = a && a[c] || {};
            s && (f = {
                min: 0,
                max: 0
            });
            const d = i ? 200 : 1e6
              , g = i ? 40 : 1e7
              , y = {
                type: "inertia",
                velocity: r ? t[c] : 0,
                bounceStiffness: d,
                bounceDamping: g,
                timeConstant: 750,
                restDelta: 1,
                restSpeed: 10,
                ...o,
                ...f
            };
            return this.startAxisValueAnimation(c, y)
        }
        );
        return Promise.all(u).then(l)
    }
    startAxisValueAnimation(t, n) {
        const r = this.getAxisMotionValue(t);
        return aa(this.visualElement, t),
        r.start(Vu(t, r, 0, n, this.visualElement, !1))
    }
    stopAnimation() {
        _e(t => this.getAxisMotionValue(t).stop())
    }
    pauseAnimation() {
        _e(t => {
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
        const n = `_drag${t.toUpperCase()}`
          , r = this.visualElement.getProps()
          , i = r[n];
        return i || this.visualElement.getValue(t, (r.initial ? r.initial[t] : void 0) || 0)
    }
    snapToCursor(t) {
        _e(n => {
            const {drag: r} = this.getProps();
            if (!Hi(n, r, this.currentDirection))
                return;
            const {projection: i} = this.visualElement
              , o = this.getAxisMotionValue(n);
            if (i && i.layout) {
                const {min: s, max: l} = i.layout.layoutBox[n];
                o.set(t[n] - b(s, l, .5))
            }
        }
        )
    }
    scalePositionWithinConstraints() {
        if (!this.visualElement.current)
            return;
        const {drag: t, dragConstraints: n} = this.getProps()
          , {projection: r} = this.visualElement;
        if (!_n(n) || !r || !this.constraints)
            return;
        this.stopAnimation();
        const i = {
            x: 0,
            y: 0
        };
        _e(s => {
            const l = this.getAxisMotionValue(s);
            if (l && this.constraints !== !1) {
                const a = l.get();
                i[s] = x3({
                    min: a,
                    max: a
                }, this.constraints[s])
            }
        }
        );
        const {transformTemplate: o} = this.visualElement.getProps();
        this.visualElement.current.style.transform = o ? o({}, "") : "none",
        r.root && r.root.updateScroll(),
        r.updateLayout(),
        this.resolveConstraints(),
        _e(s => {
            if (!Hi(s, t, null))
                return;
            const l = this.getAxisMotionValue(s)
              , {min: a, max: u} = this.constraints[s];
            l.set(b(a, u, i[s]))
        }
        )
    }
    addListeners() {
        if (!this.visualElement.current)
            return;
        R3.set(this.visualElement, this);
        const t = this.visualElement.current
          , n = $t(t, "pointerdown", a => {
            const {drag: u, dragListener: c=!0} = this.getProps();
            u && c && this.start(a)
        }
        )
          , r = () => {
            const {dragConstraints: a} = this.getProps();
            _n(a) && a.current && (this.constraints = this.resolveRefConstraints())
        }
          , {projection: i} = this.visualElement
          , o = i.addEventListener("measure", r);
        i && !i.layout && (i.root && i.root.updateScroll(),
        i.updateLayout()),
        z.read(r);
        const s = dt(window, "resize", () => this.scalePositionWithinConstraints())
          , l = i.addEventListener("didUpdate", ({delta: a, hasLayoutChanged: u}) => {
            this.isDragging && u && (_e(c => {
                const f = this.getAxisMotionValue(c);
                !f || (this.originPoint[c] += a[c].translate,
                f.set(f.get() + a[c].translate))
            }
            ),
            this.visualElement.render())
        }
        );
        return () => {
            s(),
            n(),
            o(),
            l && l()
        }
    }
    getProps() {
        const t = this.visualElement.getProps()
          , {drag: n=!1, dragDirectionLock: r=!1, dragPropagation: i=!1, dragConstraints: o=!1, dragElastic: s=ca, dragMomentum: l=!0} = t;
        return {
            ...t,
            drag: n,
            dragDirectionLock: r,
            dragPropagation: i,
            dragConstraints: o,
            dragElastic: s,
            dragMomentum: l
        }
    }
}
function Hi(e, t, n) {
    return (t === !0 || t === e) && (n === null || n === e)
}
function A3(e, t=10) {
    let n = null;
    return Math.abs(e.y) > t ? n = "y" : Math.abs(e.x) > t && (n = "x"),
    n
}
class N3 extends Xt {
    constructor(t) {
        super(t),
        this.removeGroupControls = ye,
        this.removeListeners = ye,
        this.controls = new L3(t)
    }
    mount() {
        const {dragControls: t} = this.node.getProps();
        t && (this.removeGroupControls = t.subscribe(this.controls)),
        this.removeListeners = this.controls.addListeners() || ye
    }
    unmount() {
        this.removeGroupControls(),
        this.removeListeners()
    }
}
const Yf = e => (t, n) => {
    e && z.postRender( () => e(t, n))
}
;
class D3 extends Xt {
    constructor() {
        super(...arguments),
        this.removePointerDownListener = ye
    }
    onPointerDown(t) {
        this.session = new K1(t,this.createPanHandlers(),{
            transformPagePoint: this.node.getTransformPagePoint(),
            contextWindow: em(this.node)
        })
    }
    createPanHandlers() {
        const {onPanSessionStart: t, onPanStart: n, onPan: r, onPanEnd: i} = this.node.getProps();
        return {
            onSessionStart: Yf(t),
            onStart: Yf(n),
            onMove: r,
            onEnd: (o, s) => {
                delete this.session,
                i && z.postRender( () => i(o, s))
            }
        }
    }
    mount() {
        this.removePointerDownListener = $t(this.node.current, "pointerdown", t => this.onPointerDown(t))
    }
    update() {
        this.session && this.session.updateHandlers(this.createPanHandlers())
    }
    unmount() {
        this.removePointerDownListener(),
        this.session && this.session.end()
    }
}
const Bu = w.exports.createContext(null);
function M3() {
    const e = w.exports.useContext(Bu);
    if (e === null)
        return [!0, null];
    const {isPresent: t, onExitComplete: n, register: r} = e
      , i = w.exports.useId();
    w.exports.useEffect( () => r(i), []);
    const o = w.exports.useCallback( () => n && n(i), [i, n]);
    return !t && n ? [!1, o] : [!0]
}
const tm = w.exports.createContext({})
  , nm = w.exports.createContext({})
  , io = {
    hasAnimatedSinceResize: !0,
    hasEverUpdated: !1
};
function Gf(e, t) {
    return t.max === t.min ? 0 : e / (t.max - t.min) * 100
}
const wr = {
    correct: (e, t) => {
        if (!t.target)
            return e;
        if (typeof e == "string")
            if (M.test(e))
                e = parseFloat(e);
            else
                return e;
        const n = Gf(e, t.target.x)
          , r = Gf(e, t.target.y);
        return `${n}% ${r}%`
    }
}
  , V3 = {
    correct: (e, {treeScale: t, projectionDelta: n}) => {
        const r = e
          , i = Qt.parse(e);
        if (i.length > 5)
            return r;
        const o = Qt.createTransformer(e)
          , s = typeof i[0] != "number" ? 1 : 0
          , l = n.x.scale * t.x
          , a = n.y.scale * t.y;
        i[0 + s] /= l,
        i[1 + s] /= a;
        const u = b(l, a, .5);
        return typeof i[2 + s] == "number" && (i[2 + s] /= u),
        typeof i[3 + s] == "number" && (i[3 + s] /= u),
        o(i)
    }
}
  , zo = {};
function O3(e) {
    Object.assign(zo, e)
}
const {schedule: zu, cancel: N6} = r1(queueMicrotask, !1);
class F3 extends w.exports.Component {
    componentDidMount() {
        const {visualElement: t, layoutGroup: n, switchLayoutGroup: r, layoutId: i} = this.props
          , {projection: o} = t;
        O3(I3),
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
        io.hasEverUpdated = !0
    }
    getSnapshotBeforeUpdate(t) {
        const {layoutDependency: n, visualElement: r, drag: i, isPresent: o} = this.props
          , s = r.projection;
        return s && (s.isPresent = o,
        i || t.layoutDependency !== n || n === void 0 ? s.willUpdate() : this.safeToRemove(),
        t.isPresent !== o && (o ? s.promote() : s.relegate() || z.postRender( () => {
            const l = s.getStack();
            (!l || !l.members.length) && this.safeToRemove()
        }
        ))),
        null
    }
    componentDidUpdate() {
        const {projection: t} = this.props.visualElement;
        t && (t.root.didUpdate(),
        zu.postRender( () => {
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
function rm(e) {
    const [t,n] = M3()
      , r = w.exports.useContext(tm);
    return P(F3, {
        ...e,
        layoutGroup: r,
        switchLayoutGroup: w.exports.useContext(nm),
        isPresent: t,
        safeToRemove: n
    })
}
const I3 = {
    borderRadius: {
        ...wr,
        applyTo: ["borderTopLeftRadius", "borderTopRightRadius", "borderBottomLeftRadius", "borderBottomRightRadius"]
    },
    borderTopLeftRadius: wr,
    borderTopRightRadius: wr,
    borderBottomLeftRadius: wr,
    borderBottomRightRadius: wr,
    boxShadow: V3
}
  , im = ["TopLeft", "TopRight", "BottomLeft", "BottomRight"]
  , _3 = im.length
  , Zf = e => typeof e == "string" ? parseFloat(e) : e
  , Xf = e => typeof e == "number" || M.test(e);
function B3(e, t, n, r, i, o) {
    i ? (e.opacity = b(0, n.opacity !== void 0 ? n.opacity : 1, z3(r)),
    e.opacityExit = b(t.opacity !== void 0 ? t.opacity : 1, 0, j3(r))) : o && (e.opacity = b(t.opacity !== void 0 ? t.opacity : 1, n.opacity !== void 0 ? n.opacity : 1, r));
    for (let s = 0; s < _3; s++) {
        const l = `border${im[s]}Radius`;
        let a = Jf(t, l)
          , u = Jf(n, l);
        if (a === void 0 && u === void 0)
            continue;
        a || (a = 0),
        u || (u = 0),
        a === 0 || u === 0 || Xf(a) === Xf(u) ? (e[l] = Math.max(b(Zf(a), Zf(u), r), 0),
        (it.test(u) || it.test(a)) && (e[l] += "%")) : e[l] = u
    }
    (t.rotate || n.rotate) && (e.rotate = b(t.rotate || 0, n.rotate || 0, r))
}
function Jf(e, t) {
    return e[t] !== void 0 ? e[t] : e.borderRadius
}
const z3 = om(0, .5, c1)
  , j3 = om(.5, .95, ye);
function om(e, t, n) {
    return r => r < e ? 0 : r > t ? 1 : n(tr(e, t, r))
}
function qf(e, t) {
    e.min = t.min,
    e.max = t.max
}
function Ie(e, t) {
    qf(e.x, t.x),
    qf(e.y, t.y)
}
function ed(e, t) {
    e.translate = t.translate,
    e.scale = t.scale,
    e.originPoint = t.originPoint,
    e.origin = t.origin
}
function td(e, t, n, r, i) {
    return e -= t,
    e = Bo(e, 1 / n, r),
    i !== void 0 && (e = Bo(e, 1 / i, r)),
    e
}
function U3(e, t=0, n=1, r=.5, i, o=e, s=e) {
    if (it.test(t) && (t = parseFloat(t),
    t = b(s.min, s.max, t / 100) - s.min),
    typeof t != "number")
        return;
    let l = b(o.min, o.max, r);
    e === o && (l -= t),
    e.min = td(e.min, t, n, l, i),
    e.max = td(e.max, t, n, l, i)
}
function nd(e, t, [n,r,i], o, s) {
    U3(e, t[n], t[r], t[i], t.scale, o, s)
}
const H3 = ["x", "scaleX", "originX"]
  , $3 = ["y", "scaleY", "originY"];
function rd(e, t, n, r) {
    nd(e.x, t, H3, n ? n.x : void 0, r ? r.x : void 0),
    nd(e.y, t, $3, n ? n.y : void 0, r ? r.y : void 0)
}
function id(e) {
    return e.translate === 0 && e.scale === 1
}
function sm(e) {
    return id(e.x) && id(e.y)
}
function od(e, t) {
    return e.min === t.min && e.max === t.max
}
function W3(e, t) {
    return od(e.x, t.x) && od(e.y, t.y)
}
function sd(e, t) {
    return Math.round(e.min) === Math.round(t.min) && Math.round(e.max) === Math.round(t.max)
}
function lm(e, t) {
    return sd(e.x, t.x) && sd(e.y, t.y)
}
function ld(e) {
    return Ve(e.x) / Ve(e.y)
}
function ad(e, t) {
    return e.translate === t.translate && e.scale === t.scale && e.originPoint === t.originPoint
}
class b3 {
    constructor() {
        this.members = []
    }
    add(t) {
        Ou(this.members, t),
        t.scheduleRender()
    }
    remove(t) {
        if (Fu(this.members, t),
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
function K3(e, t, n) {
    let r = "";
    const i = e.x.translate / t.x
      , o = e.y.translate / t.y
      , s = (n == null ? void 0 : n.z) || 0;
    if ((i || o || s) && (r = `translate3d(${i}px, ${o}px, ${s}px) `),
    (t.x !== 1 || t.y !== 1) && (r += `scale(${1 / t.x}, ${1 / t.y}) `),
    n) {
        const {transformPerspective: u, rotate: c, rotateX: f, rotateY: d, skewX: g, skewY: y} = n;
        u && (r = `perspective(${u}px) ${r}`),
        c && (r += `rotate(${c}deg) `),
        f && (r += `rotateX(${f}deg) `),
        d && (r += `rotateY(${d}deg) `),
        g && (r += `skewX(${g}deg) `),
        y && (r += `skewY(${y}deg) `)
    }
    const l = e.x.scale * t.x
      , a = e.y.scale * t.y;
    return (l !== 1 || a !== 1) && (r += `scale(${l}, ${a})`),
    r || "none"
}
const Q3 = (e, t) => e.depth - t.depth;
class Y3 {
    constructor() {
        this.children = [],
        this.isDirty = !1
    }
    add(t) {
        Ou(this.children, t),
        this.isDirty = !0
    }
    remove(t) {
        Fu(this.children, t),
        this.isDirty = !0
    }
    forEach(t) {
        this.isDirty && this.children.sort(Q3),
        this.isDirty = !1,
        this.children.forEach(t)
    }
}
function oo(e) {
    const t = ve(e) ? e.get() : e;
    return B5(t) ? t.toValue() : t
}
function G3(e, t) {
    const n = ot.now()
      , r = ({timestamp: i}) => {
        const o = i - n;
        o >= t && (Ct(r),
        e(o - t))
    }
    ;
    return z.read(r, !0),
    () => Ct(r)
}
function Z3(e) {
    return e instanceof SVGElement && e.tagName !== "svg"
}
function X3(e, t, n) {
    const r = ve(e) ? e : li(e);
    return r.start(Vu("", r, t, n)),
    r.animation
}
const sn = {
    type: "projectionFrame",
    totalNodes: 0,
    resolvedTargetDeltas: 0,
    recalculatedProjection: 0
}
  , Rr = typeof window < "u" && window.MotionDebug !== void 0
  , Js = ["", "X", "Y", "Z"]
  , J3 = {
    visibility: "hidden"
}
  , ud = 1e3;
let q3 = 0;
function qs(e, t, n, r) {
    const {latestValues: i} = t;
    i[e] && (n[e] = i[e],
    t.setStaticValue(e, 0),
    r && (r[e] = 0))
}
function am(e) {
    if (e.hasCheckedOptimisedAppear = !0,
    e.root === e)
        return;
    const {visualElement: t} = e.options;
    if (!t)
        return;
    const n = U1(t);
    if (window.MotionHasOptimisedAnimation(n, "transform")) {
        const {layout: i, layoutId: o} = e.options;
        window.MotionCancelOptimisedAnimation(n, "transform", z, !(i || o))
    }
    const {parent: r} = e;
    r && !r.hasCheckedOptimisedAppear && am(r)
}
function um({attachResizeListener: e, defaultParent: t, measureScroll: n, checkIsScrollRoot: r, resetTransform: i}) {
    return class {
        constructor(s={}, l=t == null ? void 0 : t()) {
            this.id = q3++,
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
            this.hasCheckedOptimisedAppear = !1,
            this.treeScale = {
                x: 1,
                y: 1
            },
            this.eventHandlers = new Map,
            this.hasTreeAnimated = !1,
            this.updateScheduled = !1,
            this.scheduleUpdate = () => this.update(),
            this.projectionUpdateScheduled = !1,
            this.checkUpdateFailed = () => {
                this.isUpdating && (this.isUpdating = !1,
                this.clearAllSnapshots())
            }
            ,
            this.updateProjection = () => {
                this.projectionUpdateScheduled = !1,
                Rr && (sn.totalNodes = sn.resolvedTargetDeltas = sn.recalculatedProjection = 0),
                this.nodes.forEach(n4),
                this.nodes.forEach(l4),
                this.nodes.forEach(a4),
                this.nodes.forEach(r4),
                Rr && window.MotionDebug.record(sn)
            }
            ,
            this.resolvedRelativeTargetAt = 0,
            this.hasProjected = !1,
            this.isVisible = !0,
            this.animationProgress = 0,
            this.sharedNodes = new Map,
            this.latestValues = s,
            this.root = l ? l.root || l : this,
            this.path = l ? [...l.path, l] : [],
            this.parent = l,
            this.depth = l ? l.depth + 1 : 0;
            for (let a = 0; a < this.path.length; a++)
                this.path[a].shouldResetTransform = !0;
            this.root === this && (this.nodes = new Y3)
        }
        addEventListener(s, l) {
            return this.eventHandlers.has(s) || this.eventHandlers.set(s, new Iu),
            this.eventHandlers.get(s).add(l)
        }
        notifyListeners(s, ...l) {
            const a = this.eventHandlers.get(s);
            a && a.notify(...l)
        }
        hasListeners(s) {
            return this.eventHandlers.has(s)
        }
        mount(s, l=this.root.hasTreeAnimated) {
            if (this.instance)
                return;
            this.isSVG = Z3(s),
            this.instance = s;
            const {layoutId: a, layout: u, visualElement: c} = this.options;
            if (c && !c.current && c.mount(s),
            this.root.nodes.add(this),
            this.parent && this.parent.children.add(this),
            l && (u || a) && (this.isLayoutDirty = !0),
            e) {
                let f;
                const d = () => this.root.updateBlockedByResize = !1;
                e(s, () => {
                    this.root.updateBlockedByResize = !0,
                    f && f(),
                    f = G3(d, 250),
                    io.hasAnimatedSinceResize && (io.hasAnimatedSinceResize = !1,
                    this.nodes.forEach(fd))
                }
                )
            }
            a && this.root.registerSharedNode(a, this),
            this.options.animate !== !1 && c && (a || u) && this.addEventListener("didUpdate", ({delta: f, hasLayoutChanged: d, hasRelativeTargetChanged: g, layout: y}) => {
                if (this.isTreeAnimationBlocked()) {
                    this.target = void 0,
                    this.relativeTarget = void 0;
                    return
                }
                const v = this.options.transition || c.getDefaultTransition() || h4
                  , {onLayoutAnimationStart: C, onLayoutAnimationComplete: p} = c.getProps()
                  , h = !this.targetLayout || !lm(this.targetLayout, y) || g
                  , m = !d && g;
                if (this.options.layoutRoot || this.resumeFrom && this.resumeFrom.instance || m || d && (h || !this.currentAnimation)) {
                    this.resumeFrom && (this.resumingFrom = this.resumeFrom,
                    this.resumingFrom.resumingFrom = void 0),
                    this.setAnimationOrigin(f, m);
                    const x = {
                        ...wu(v, "layout"),
                        onPlay: C,
                        onComplete: p
                    };
                    (c.shouldReduceMotion || this.options.layoutRoot) && (x.delay = 0,
                    x.type = !1),
                    this.startAnimation(x)
                } else
                    d || fd(this),
                    this.isLead() && this.options.onExitComplete && this.options.onExitComplete();
                this.targetLayout = y
            }
            )
        }
        unmount() {
            this.options.layoutId && this.willUpdate(),
            this.root.nodes.remove(this);
            const s = this.getStack();
            s && s.remove(this),
            this.parent && this.parent.children.delete(this),
            this.instance = void 0,
            Ct(this.updateProjection)
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
            this.nodes && this.nodes.forEach(u4),
            this.animationId++)
        }
        getTransformTemplate() {
            const {visualElement: s} = this.options;
            return s && s.getProps().transformTemplate
        }
        willUpdate(s=!0) {
            if (this.root.hasTreeAnimated = !0,
            this.root.isUpdateBlocked()) {
                this.options.onExitComplete && this.options.onExitComplete();
                return
            }
            if (window.MotionCancelOptimisedAnimation && !this.hasCheckedOptimisedAppear && am(this),
            !this.root.isUpdating && this.root.startUpdate(),
            this.isLayoutDirty)
                return;
            this.isLayoutDirty = !0;
            for (let c = 0; c < this.path.length; c++) {
                const f = this.path[c];
                f.shouldResetTransform = !0,
                f.updateScroll("snapshot"),
                f.options.layoutRoot && f.willUpdate(!1)
            }
            const {layoutId: l, layout: a} = this.options;
            if (l === void 0 && !a)
                return;
            const u = this.getTransformTemplate();
            this.prevTransformTemplateValue = u ? u(this.latestValues, "") : void 0,
            this.updateSnapshot(),
            s && this.notifyListeners("willUpdate")
        }
        update() {
            if (this.updateScheduled = !1,
            this.isUpdateBlocked()) {
                this.unblockUpdate(),
                this.clearAllSnapshots(),
                this.nodes.forEach(cd);
                return
            }
            this.isUpdating || this.nodes.forEach(o4),
            this.isUpdating = !1,
            this.nodes.forEach(s4),
            this.nodes.forEach(e4),
            this.nodes.forEach(t4),
            this.clearAllSnapshots();
            const l = ot.now();
            ce.delta = St(0, 1e3 / 60, l - ce.timestamp),
            ce.timestamp = l,
            ce.isProcessing = !0,
            Ws.update.process(ce),
            Ws.preRender.process(ce),
            Ws.render.process(ce),
            ce.isProcessing = !1
        }
        didUpdate() {
            this.updateScheduled || (this.updateScheduled = !0,
            zu.read(this.scheduleUpdate))
        }
        clearAllSnapshots() {
            this.nodes.forEach(i4),
            this.sharedNodes.forEach(c4)
        }
        scheduleUpdateProjection() {
            this.projectionUpdateScheduled || (this.projectionUpdateScheduled = !0,
            z.preRender(this.updateProjection, !1, !0))
        }
        scheduleCheckAfterUnmount() {
            z.postRender( () => {
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
                for (let a = 0; a < this.path.length; a++)
                    this.path[a].updateScroll();
            const s = this.layout;
            this.layout = this.measure(!1),
            this.layoutCorrected = q(),
            this.isLayoutDirty = !1,
            this.projectionDelta = void 0,
            this.notifyListeners("measure", this.layout.layoutBox);
            const {visualElement: l} = this.options;
            l && l.notify("LayoutMeasure", this.layout.layoutBox, s ? s.layoutBox : void 0)
        }
        updateScroll(s="measure") {
            let l = Boolean(this.options.layoutScroll && this.instance);
            if (this.scroll && this.scroll.animationId === this.root.animationId && this.scroll.phase === s && (l = !1),
            l) {
                const a = r(this.instance);
                this.scroll = {
                    animationId: this.root.animationId,
                    phase: s,
                    isRoot: a,
                    offset: n(this.instance),
                    wasRoot: this.scroll ? this.scroll.isRoot : a
                }
            }
        }
        resetTransform() {
            if (!i)
                return;
            const s = this.isLayoutDirty || this.shouldResetTransform || this.options.alwaysMeasureLayout
              , l = this.projectionDelta && !sm(this.projectionDelta)
              , a = this.getTransformTemplate()
              , u = a ? a(this.latestValues, "") : void 0
              , c = u !== this.prevTransformTemplateValue;
            s && (l || on(this.latestValues) || c) && (i(this.instance, u),
            this.shouldResetTransform = !1,
            this.scheduleRender())
        }
        measure(s=!0) {
            const l = this.measurePageBox();
            let a = this.removeElementScroll(l);
            return s && (a = this.removeTransform(a)),
            p4(a),
            {
                animationId: this.root.animationId,
                measuredBox: l,
                layoutBox: a,
                latestValues: {},
                source: this.id
            }
        }
        measurePageBox() {
            var s;
            const {visualElement: l} = this.options;
            if (!l)
                return q();
            const a = l.measureViewportBox();
            if (!(((s = this.scroll) === null || s === void 0 ? void 0 : s.wasRoot) || this.path.some(m4))) {
                const {scroll: c} = this.root;
                c && (zn(a.x, c.offset.x),
                zn(a.y, c.offset.y))
            }
            return a
        }
        removeElementScroll(s) {
            var l;
            const a = q();
            if (Ie(a, s),
            !((l = this.scroll) === null || l === void 0) && l.wasRoot)
                return a;
            for (let u = 0; u < this.path.length; u++) {
                const c = this.path[u]
                  , {scroll: f, options: d} = c;
                c !== this.root && f && d.layoutScroll && (f.wasRoot && Ie(a, s),
                zn(a.x, f.offset.x),
                zn(a.y, f.offset.y))
            }
            return a
        }
        applyTransform(s, l=!1) {
            const a = q();
            Ie(a, s);
            for (let u = 0; u < this.path.length; u++) {
                const c = this.path[u];
                !l && c.options.layoutScroll && c.scroll && c !== c.root && jn(a, {
                    x: -c.scroll.offset.x,
                    y: -c.scroll.offset.y
                }),
                on(c.latestValues) && jn(a, c.latestValues)
            }
            return on(this.latestValues) && jn(a, this.latestValues),
            a
        }
        removeTransform(s) {
            const l = q();
            Ie(l, s);
            for (let a = 0; a < this.path.length; a++) {
                const u = this.path[a];
                if (!u.instance || !on(u.latestValues))
                    continue;
                fa(u.latestValues) && u.updateSnapshot();
                const c = q()
                  , f = u.measurePageBox();
                Ie(c, f),
                rd(l, u.latestValues, u.snapshot ? u.snapshot.layoutBox : void 0, c)
            }
            return on(this.latestValues) && rd(l, this.latestValues),
            l
        }
        setTargetDelta(s) {
            this.targetDelta = s,
            this.root.scheduleUpdateProjection(),
            this.isProjectionDirty = !0
        }
        setOptions(s) {
            this.options = {
                ...this.options,
                ...s,
                crossfade: s.crossfade !== void 0 ? s.crossfade : !0
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
            !this.relativeParent || this.relativeParent.resolvedRelativeTargetAt !== ce.timestamp && this.relativeParent.resolveTargetDelta(!0)
        }
        resolveTargetDelta(s=!1) {
            var l;
            const a = this.getLead();
            this.isProjectionDirty || (this.isProjectionDirty = a.isProjectionDirty),
            this.isTransformDirty || (this.isTransformDirty = a.isTransformDirty),
            this.isSharedProjectionDirty || (this.isSharedProjectionDirty = a.isSharedProjectionDirty);
            const u = Boolean(this.resumingFrom) || this !== a;
            if (!(s || u && this.isSharedProjectionDirty || this.isProjectionDirty || ((l = this.parent) === null || l === void 0 ? void 0 : l.isProjectionDirty) || this.attemptToResolveRelativeTarget || this.root.updateBlockedByResize))
                return;
            const {layout: f, layoutId: d} = this.options;
            if (!(!this.layout || !(f || d))) {
                if (this.resolvedRelativeTargetAt = ce.timestamp,
                !this.targetDelta && !this.relativeTarget) {
                    const g = this.getClosestProjectingParent();
                    g && g.layout && this.animationProgress !== 1 ? (this.relativeParent = g,
                    this.forceRelativeParentToResolveTarget(),
                    this.relativeTarget = q(),
                    this.relativeTargetOrigin = q(),
                    zr(this.relativeTargetOrigin, this.layout.layoutBox, g.layout.layoutBox),
                    Ie(this.relativeTarget, this.relativeTargetOrigin)) : this.relativeParent = this.relativeTarget = void 0
                }
                if (!(!this.relativeTarget && !this.targetDelta)) {
                    if (this.target || (this.target = q(),
                    this.targetWithTransforms = q()),
                    this.relativeTarget && this.relativeTargetOrigin && this.relativeParent && this.relativeParent.target ? (this.forceRelativeParentToResolveTarget(),
                    g3(this.target, this.relativeTarget, this.relativeParent.target)) : this.targetDelta ? (Boolean(this.resumingFrom) ? this.target = this.applyTransform(this.layout.layoutBox) : Ie(this.target, this.layout.layoutBox),
                    J1(this.target, this.targetDelta)) : Ie(this.target, this.layout.layoutBox),
                    this.attemptToResolveRelativeTarget) {
                        this.attemptToResolveRelativeTarget = !1;
                        const g = this.getClosestProjectingParent();
                        g && Boolean(g.resumingFrom) === Boolean(this.resumingFrom) && !g.options.layoutScroll && g.target && this.animationProgress !== 1 ? (this.relativeParent = g,
                        this.forceRelativeParentToResolveTarget(),
                        this.relativeTarget = q(),
                        this.relativeTargetOrigin = q(),
                        zr(this.relativeTargetOrigin, this.target, g.target),
                        Ie(this.relativeTarget, this.relativeTargetOrigin)) : this.relativeParent = this.relativeTarget = void 0
                    }
                    Rr && sn.resolvedTargetDeltas++
                }
            }
        }
        getClosestProjectingParent() {
            if (!(!this.parent || fa(this.parent.latestValues) || X1(this.parent.latestValues)))
                return this.parent.isProjecting() ? this.parent : this.parent.getClosestProjectingParent()
        }
        isProjecting() {
            return Boolean((this.relativeTarget || this.targetDelta || this.options.layoutRoot) && this.layout)
        }
        calcProjection() {
            var s;
            const l = this.getLead()
              , a = Boolean(this.resumingFrom) || this !== l;
            let u = !0;
            if ((this.isProjectionDirty || ((s = this.parent) === null || s === void 0 ? void 0 : s.isProjectionDirty)) && (u = !1),
            a && (this.isSharedProjectionDirty || this.isTransformDirty) && (u = !1),
            this.resolvedRelativeTargetAt === ce.timestamp && (u = !1),
            u)
                return;
            const {layout: c, layoutId: f} = this.options;
            if (this.isTreeAnimating = Boolean(this.parent && this.parent.isTreeAnimating || this.currentAnimation || this.pendingAnimation),
            this.isTreeAnimating || (this.targetDelta = this.relativeTarget = void 0),
            !this.layout || !(c || f))
                return;
            Ie(this.layoutCorrected, this.layout.layoutBox);
            const d = this.treeScale.x
              , g = this.treeScale.y;
            E3(this.layoutCorrected, this.treeScale, this.path, a),
            l.layout && !l.target && (this.treeScale.x !== 1 || this.treeScale.y !== 1) && (l.target = l.layout.layoutBox,
            l.targetWithTransforms = q());
            const {target: y} = l;
            if (!y) {
                this.prevProjectionDelta && (this.createProjectionDeltas(),
                this.scheduleRender());
                return
            }
            !this.projectionDelta || !this.prevProjectionDelta ? this.createProjectionDeltas() : (ed(this.prevProjectionDelta.x, this.projectionDelta.x),
            ed(this.prevProjectionDelta.y, this.projectionDelta.y)),
            Br(this.projectionDelta, this.layoutCorrected, y, this.latestValues),
            (this.treeScale.x !== d || this.treeScale.y !== g || !ad(this.projectionDelta.x, this.prevProjectionDelta.x) || !ad(this.projectionDelta.y, this.prevProjectionDelta.y)) && (this.hasProjected = !0,
            this.scheduleRender(),
            this.notifyListeners("projectionUpdate", y)),
            Rr && sn.recalculatedProjection++
        }
        hide() {
            this.isVisible = !1
        }
        show() {
            this.isVisible = !0
        }
        scheduleRender(s=!0) {
            var l;
            if ((l = this.options.visualElement) === null || l === void 0 || l.scheduleRender(),
            s) {
                const a = this.getStack();
                a && a.scheduleRender()
            }
            this.resumingFrom && !this.resumingFrom.instance && (this.resumingFrom = void 0)
        }
        createProjectionDeltas() {
            this.prevProjectionDelta = Bn(),
            this.projectionDelta = Bn(),
            this.projectionDeltaWithTransform = Bn()
        }
        setAnimationOrigin(s, l=!1) {
            const a = this.snapshot
              , u = a ? a.latestValues : {}
              , c = {
                ...this.latestValues
            }
              , f = Bn();
            (!this.relativeParent || !this.relativeParent.options.layoutRoot) && (this.relativeTarget = this.relativeTargetOrigin = void 0),
            this.attemptToResolveRelativeTarget = !l;
            const d = q()
              , g = a ? a.source : void 0
              , y = this.layout ? this.layout.source : void 0
              , v = g !== y
              , C = this.getStack()
              , p = !C || C.members.length <= 1
              , h = Boolean(v && !p && this.options.crossfade === !0 && !this.path.some(d4));
            this.animationProgress = 0;
            let m;
            this.mixTargetDelta = x => {
                const S = x / 1e3;
                dd(f.x, s.x, S),
                dd(f.y, s.y, S),
                this.setTargetDelta(f),
                this.relativeTarget && this.relativeTargetOrigin && this.layout && this.relativeParent && this.relativeParent.layout && (zr(d, this.layout.layoutBox, this.relativeParent.layout.layoutBox),
                f4(this.relativeTarget, this.relativeTargetOrigin, d, S),
                m && W3(this.relativeTarget, m) && (this.isProjectionDirty = !1),
                m || (m = q()),
                Ie(m, this.relativeTarget)),
                v && (this.animationValues = c,
                B3(c, u, this.latestValues, S, h, p)),
                this.root.scheduleUpdateProjection(),
                this.scheduleRender(),
                this.animationProgress = S
            }
            ,
            this.mixTargetDelta(this.options.layoutRoot ? 1e3 : 0)
        }
        startAnimation(s) {
            this.notifyListeners("animationStart"),
            this.currentAnimation && this.currentAnimation.stop(),
            this.resumingFrom && this.resumingFrom.currentAnimation && this.resumingFrom.currentAnimation.stop(),
            this.pendingAnimation && (Ct(this.pendingAnimation),
            this.pendingAnimation = void 0),
            this.pendingAnimation = z.update( () => {
                io.hasAnimatedSinceResize = !0,
                this.currentAnimation = X3(0, ud, {
                    ...s,
                    onUpdate: l => {
                        this.mixTargetDelta(l),
                        s.onUpdate && s.onUpdate(l)
                    }
                    ,
                    onComplete: () => {
                        s.onComplete && s.onComplete(),
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
            const s = this.getStack();
            s && s.exitAnimationComplete(),
            this.resumingFrom = this.currentAnimation = this.animationValues = void 0,
            this.notifyListeners("animationComplete")
        }
        finishAnimation() {
            this.currentAnimation && (this.mixTargetDelta && this.mixTargetDelta(ud),
            this.currentAnimation.stop()),
            this.completeAnimation()
        }
        applyTransformsToTarget() {
            const s = this.getLead();
            let {targetWithTransforms: l, target: a, layout: u, latestValues: c} = s;
            if (!(!l || !a || !u)) {
                if (this !== s && this.layout && u && cm(this.options.animationType, this.layout.layoutBox, u.layoutBox)) {
                    a = this.target || q();
                    const f = Ve(this.layout.layoutBox.x);
                    a.x.min = s.target.x.min,
                    a.x.max = a.x.min + f;
                    const d = Ve(this.layout.layoutBox.y);
                    a.y.min = s.target.y.min,
                    a.y.max = a.y.min + d
                }
                Ie(l, a),
                jn(l, c),
                Br(this.projectionDeltaWithTransform, this.layoutCorrected, l, c)
            }
        }
        registerSharedNode(s, l) {
            this.sharedNodes.has(s) || this.sharedNodes.set(s, new b3),
            this.sharedNodes.get(s).add(l);
            const u = l.options.initialPromotionConfig;
            l.promote({
                transition: u ? u.transition : void 0,
                preserveFollowOpacity: u && u.shouldPreserveFollowOpacity ? u.shouldPreserveFollowOpacity(l) : void 0
            })
        }
        isLead() {
            const s = this.getStack();
            return s ? s.lead === this : !0
        }
        getLead() {
            var s;
            const {layoutId: l} = this.options;
            return l ? ((s = this.getStack()) === null || s === void 0 ? void 0 : s.lead) || this : this
        }
        getPrevLead() {
            var s;
            const {layoutId: l} = this.options;
            return l ? (s = this.getStack()) === null || s === void 0 ? void 0 : s.prevLead : void 0
        }
        getStack() {
            const {layoutId: s} = this.options;
            if (s)
                return this.root.sharedNodes.get(s)
        }
        promote({needsReset: s, transition: l, preserveFollowOpacity: a}={}) {
            const u = this.getStack();
            u && u.promote(this, a),
            s && (this.projectionDelta = void 0,
            this.needsReset = !0),
            l && this.setOptions({
                transition: l
            })
        }
        relegate() {
            const s = this.getStack();
            return s ? s.relegate(this) : !1
        }
        resetSkewAndRotation() {
            const {visualElement: s} = this.options;
            if (!s)
                return;
            let l = !1;
            const {latestValues: a} = s;
            if ((a.z || a.rotate || a.rotateX || a.rotateY || a.rotateZ || a.skewX || a.skewY) && (l = !0),
            !l)
                return;
            const u = {};
            a.z && qs("z", s, u, this.animationValues);
            for (let c = 0; c < Js.length; c++)
                qs(`rotate${Js[c]}`, s, u, this.animationValues),
                qs(`skew${Js[c]}`, s, u, this.animationValues);
            s.render();
            for (const c in u)
                s.setStaticValue(c, u[c]),
                this.animationValues && (this.animationValues[c] = u[c]);
            s.scheduleRender()
        }
        getProjectionStyles(s) {
            var l, a;
            if (!this.instance || this.isSVG)
                return;
            if (!this.isVisible)
                return J3;
            const u = {
                visibility: ""
            }
              , c = this.getTransformTemplate();
            if (this.needsReset)
                return this.needsReset = !1,
                u.opacity = "",
                u.pointerEvents = oo(s == null ? void 0 : s.pointerEvents) || "",
                u.transform = c ? c(this.latestValues, "") : "none",
                u;
            const f = this.getLead();
            if (!this.projectionDelta || !this.layout || !f.target) {
                const v = {};
                return this.options.layoutId && (v.opacity = this.latestValues.opacity !== void 0 ? this.latestValues.opacity : 1,
                v.pointerEvents = oo(s == null ? void 0 : s.pointerEvents) || ""),
                this.hasProjected && !on(this.latestValues) && (v.transform = c ? c({}, "") : "none",
                this.hasProjected = !1),
                v
            }
            const d = f.animationValues || f.latestValues;
            this.applyTransformsToTarget(),
            u.transform = K3(this.projectionDeltaWithTransform, this.treeScale, d),
            c && (u.transform = c(d, u.transform));
            const {x: g, y} = this.projectionDelta;
            u.transformOrigin = `${g.origin * 100}% ${y.origin * 100}% 0`,
            f.animationValues ? u.opacity = f === this ? (a = (l = d.opacity) !== null && l !== void 0 ? l : this.latestValues.opacity) !== null && a !== void 0 ? a : 1 : this.preserveOpacity ? this.latestValues.opacity : d.opacityExit : u.opacity = f === this ? d.opacity !== void 0 ? d.opacity : "" : d.opacityExit !== void 0 ? d.opacityExit : 0;
            for (const v in zo) {
                if (d[v] === void 0)
                    continue;
                const {correct: C, applyTo: p} = zo[v]
                  , h = u.transform === "none" ? d[v] : C(d[v], f);
                if (p) {
                    const m = p.length;
                    for (let x = 0; x < m; x++)
                        u[p[x]] = h
                } else
                    u[v] = h
            }
            return this.options.layoutId && (u.pointerEvents = f === this ? oo(s == null ? void 0 : s.pointerEvents) || "" : "none"),
            u
        }
        clearSnapshot() {
            this.resumeFrom = this.snapshot = void 0
        }
        resetTree() {
            this.root.nodes.forEach(s => {
                var l;
                return (l = s.currentAnimation) === null || l === void 0 ? void 0 : l.stop()
            }
            ),
            this.root.nodes.forEach(cd),
            this.root.sharedNodes.clear()
        }
    }
}
function e4(e) {
    e.updateLayout()
}
function t4(e) {
    var t;
    const n = ((t = e.resumeFrom) === null || t === void 0 ? void 0 : t.snapshot) || e.snapshot;
    if (e.isLead() && e.layout && n && e.hasListeners("didUpdate")) {
        const {layoutBox: r, measuredBox: i} = e.layout
          , {animationType: o} = e.options
          , s = n.source !== e.layout.source;
        o === "size" ? _e(f => {
            const d = s ? n.measuredBox[f] : n.layoutBox[f]
              , g = Ve(d);
            d.min = r[f].min,
            d.max = d.min + g
        }
        ) : cm(o, n.layoutBox, r) && _e(f => {
            const d = s ? n.measuredBox[f] : n.layoutBox[f]
              , g = Ve(r[f]);
            d.max = d.min + g,
            e.relativeTarget && !e.currentAnimation && (e.isProjectionDirty = !0,
            e.relativeTarget[f].max = e.relativeTarget[f].min + g)
        }
        );
        const l = Bn();
        Br(l, r, n.layoutBox);
        const a = Bn();
        s ? Br(a, e.applyTransform(i, !0), n.measuredBox) : Br(a, r, n.layoutBox);
        const u = !sm(l);
        let c = !1;
        if (!e.resumeFrom) {
            const f = e.getClosestProjectingParent();
            if (f && !f.resumeFrom) {
                const {snapshot: d, layout: g} = f;
                if (d && g) {
                    const y = q();
                    zr(y, n.layoutBox, d.layoutBox);
                    const v = q();
                    zr(v, r, g.layoutBox),
                    lm(y, v) || (c = !0),
                    f.options.layoutRoot && (e.relativeTarget = v,
                    e.relativeTargetOrigin = y,
                    e.relativeParent = f)
                }
            }
        }
        e.notifyListeners("didUpdate", {
            layout: r,
            snapshot: n,
            delta: a,
            layoutDelta: l,
            hasLayoutChanged: u,
            hasRelativeTargetChanged: c
        })
    } else if (e.isLead()) {
        const {onExitComplete: r} = e.options;
        r && r()
    }
    e.options.transition = void 0
}
function n4(e) {
    Rr && sn.totalNodes++,
    e.parent && (e.isProjecting() || (e.isProjectionDirty = e.parent.isProjectionDirty),
    e.isSharedProjectionDirty || (e.isSharedProjectionDirty = Boolean(e.isProjectionDirty || e.parent.isProjectionDirty || e.parent.isSharedProjectionDirty)),
    e.isTransformDirty || (e.isTransformDirty = e.parent.isTransformDirty))
}
function r4(e) {
    e.isProjectionDirty = e.isSharedProjectionDirty = e.isTransformDirty = !1
}
function i4(e) {
    e.clearSnapshot()
}
function cd(e) {
    e.clearMeasurements()
}
function o4(e) {
    e.isLayoutDirty = !1
}
function s4(e) {
    const {visualElement: t} = e.options;
    t && t.getProps().onBeforeLayoutMeasure && t.notify("BeforeLayoutMeasure"),
    e.resetTransform()
}
function fd(e) {
    e.finishAnimation(),
    e.targetDelta = e.relativeTarget = e.target = void 0,
    e.isProjectionDirty = !0
}
function l4(e) {
    e.resolveTargetDelta()
}
function a4(e) {
    e.calcProjection()
}
function u4(e) {
    e.resetSkewAndRotation()
}
function c4(e) {
    e.removeLeadSnapshot()
}
function dd(e, t, n) {
    e.translate = b(t.translate, 0, n),
    e.scale = b(t.scale, 1, n),
    e.origin = t.origin,
    e.originPoint = t.originPoint
}
function hd(e, t, n, r) {
    e.min = b(t.min, n.min, r),
    e.max = b(t.max, n.max, r)
}
function f4(e, t, n, r) {
    hd(e.x, t.x, n.x, r),
    hd(e.y, t.y, n.y, r)
}
function d4(e) {
    return e.animationValues && e.animationValues.opacityExit !== void 0
}
const h4 = {
    duration: .45,
    ease: [.4, 0, .1, 1]
}
  , pd = e => typeof navigator < "u" && navigator.userAgent && navigator.userAgent.toLowerCase().includes(e)
  , md = pd("applewebkit/") && !pd("chrome/") ? Math.round : ye;
function gd(e) {
    e.min = md(e.min),
    e.max = md(e.max)
}
function p4(e) {
    gd(e.x),
    gd(e.y)
}
function cm(e, t, n) {
    return e === "position" || e === "preserve-aspect" && !m3(ld(t), ld(n), .2)
}
function m4(e) {
    var t;
    return e !== e.root && ((t = e.scroll) === null || t === void 0 ? void 0 : t.wasRoot)
}
const g4 = um({
    attachResizeListener: (e, t) => dt(e, "resize", t),
    measureScroll: () => ({
        x: document.documentElement.scrollLeft || document.body.scrollLeft,
        y: document.documentElement.scrollTop || document.body.scrollTop
    }),
    checkIsScrollRoot: () => !0
})
  , el = {
    current: void 0
}
  , fm = um({
    measureScroll: e => ({
        x: e.scrollLeft,
        y: e.scrollTop
    }),
    defaultParent: () => {
        if (!el.current) {
            const e = new g4({});
            e.mount(window),
            e.setOptions({
                layoutScroll: !0
            }),
            el.current = e
        }
        return el.current
    }
    ,
    resetTransform: (e, t) => {
        e.style.transform = t !== void 0 ? t : "none"
    }
    ,
    checkIsScrollRoot: e => Boolean(window.getComputedStyle(e).position === "fixed")
})
  , v4 = {
    pan: {
        Feature: D3
    },
    drag: {
        Feature: N3,
        ProjectionNode: fm,
        MeasureLayout: rm
    }
};
function y4(e, t, n) {
    var r;
    if (e instanceof Element)
        return [e];
    if (typeof e == "string") {
        let i = document;
        t && (i = t.current);
        const o = (r = n == null ? void 0 : n[e]) !== null && r !== void 0 ? r : i.querySelectorAll(e);
        return o ? Array.from(o) : []
    }
    return Array.from(e)
}
function vd(e) {
    return t => {
        t.pointerType === "touch" || W1() || e(t)
    }
}
function w4(e, t, n={}) {
    const r = new AbortController
      , i = {
        passive: !0,
        ...n,
        signal: r.signal
    }
      , o = vd(s => {
        const {target: l} = s
          , a = t(s);
        if (!a || !l)
            return;
        const u = vd(c => {
            a(c),
            l.removeEventListener("pointerleave", u)
        }
        );
        l.addEventListener("pointerleave", u, i)
    }
    );
    return y4(e).forEach(s => {
        s.addEventListener("pointerenter", o, i)
    }
    ),
    () => r.abort()
}
function yd(e, t, n) {
    const {props: r} = e;
    e.animationState && r.whileHover && e.animationState.setActive("whileHover", n);
    const i = r[n ? "onHoverStart" : "onHoverEnd"];
    i && z.postRender( () => i(t, wi(t)))
}
class x4 extends Xt {
    mount() {
        const {current: t, props: n} = this.node;
        !t || (this.unmount = w4(t, r => (yd(this.node, r, !0),
        i => yd(this.node, i, !1)), {
            passive: !n.onHoverStart && !n.onHoverEnd
        }))
    }
    unmount() {}
}
class C4 extends Xt {
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
        this.unmount = Ht(dt(this.node.current, "focus", () => this.onFocus()), dt(this.node.current, "blur", () => this.onBlur()))
    }
    unmount() {}
}
const dm = (e, t) => t ? e === t ? !0 : dm(e, t.parentElement) : !1;
function tl(e, t) {
    if (!t)
        return;
    const n = new PointerEvent("pointer" + e);
    t(n, wi(n))
}
class S4 extends Xt {
    constructor() {
        super(...arguments),
        this.removeStartListeners = ye,
        this.removeEndListeners = ye,
        this.removeAccessibleListeners = ye,
        this.startPointerPress = (t, n) => {
            if (this.isPressing)
                return;
            this.removeEndListeners();
            const r = this.node.getProps()
              , o = $t(window, "pointerup", (l, a) => {
                if (!this.checkPressEnd())
                    return;
                const {onTap: u, onTapCancel: c, globalTapTarget: f} = this.node.getProps()
                  , d = !f && !dm(this.node.current, l.target) ? c : u;
                d && z.update( () => d(l, a))
            }
            , {
                passive: !(r.onTap || r.onPointerUp)
            })
              , s = $t(window, "pointercancel", (l, a) => this.cancelPress(l, a), {
                passive: !(r.onTapCancel || r.onPointerCancel)
            });
            this.removeEndListeners = Ht(o, s),
            this.startPress(t, n)
        }
        ,
        this.startAccessiblePress = () => {
            const t = o => {
                if (o.key !== "Enter" || this.isPressing)
                    return;
                const s = l => {
                    l.key !== "Enter" || !this.checkPressEnd() || tl("up", (a, u) => {
                        const {onTap: c} = this.node.getProps();
                        c && z.postRender( () => c(a, u))
                    }
                    )
                }
                ;
                this.removeEndListeners(),
                this.removeEndListeners = dt(this.node.current, "keyup", s),
                tl("down", (l, a) => {
                    this.startPress(l, a)
                }
                )
            }
              , n = dt(this.node.current, "keydown", t)
              , r = () => {
                !this.isPressing || tl("cancel", (o, s) => this.cancelPress(o, s))
            }
              , i = dt(this.node.current, "blur", r);
            this.removeAccessibleListeners = Ht(n, i)
        }
    }
    startPress(t, n) {
        this.isPressing = !0;
        const {onTapStart: r, whileTap: i} = this.node.getProps();
        i && this.node.animationState && this.node.animationState.setActive("whileTap", !0),
        r && z.postRender( () => r(t, n))
    }
    checkPressEnd() {
        return this.removeEndListeners(),
        this.isPressing = !1,
        this.node.getProps().whileTap && this.node.animationState && this.node.animationState.setActive("whileTap", !1),
        !W1()
    }
    cancelPress(t, n) {
        if (!this.checkPressEnd())
            return;
        const {onTapCancel: r} = this.node.getProps();
        r && z.postRender( () => r(t, n))
    }
    mount() {
        const t = this.node.getProps()
          , n = $t(t.globalTapTarget ? window : this.node.current, "pointerdown", this.startPointerPress, {
            passive: !(t.onTapStart || t.onPointerStart)
        })
          , r = dt(this.node.current, "focus", this.startAccessiblePress);
        this.removeStartListeners = Ht(n, r)
    }
    unmount() {
        this.removeStartListeners(),
        this.removeEndListeners(),
        this.removeAccessibleListeners()
    }
}
const ha = new WeakMap
  , nl = new WeakMap
  , P4 = e => {
    const t = ha.get(e.target);
    t && t(e)
}
  , k4 = e => {
    e.forEach(P4)
}
;
function E4({root: e, ...t}) {
    const n = e || document;
    nl.has(n) || nl.set(n, {});
    const r = nl.get(n)
      , i = JSON.stringify(t);
    return r[i] || (r[i] = new IntersectionObserver(k4,{
        root: e,
        ...t
    })),
    r[i]
}
function T4(e, t, n) {
    const r = E4(t);
    return ha.set(e, n),
    r.observe(e),
    () => {
        ha.delete(e),
        r.unobserve(e)
    }
}
const R4 = {
    some: 0,
    all: 1
};
class L4 extends Xt {
    constructor() {
        super(...arguments),
        this.hasEnteredView = !1,
        this.isInView = !1
    }
    startObserver() {
        this.unmount();
        const {viewport: t={}} = this.node.getProps()
          , {root: n, margin: r, amount: i="some", once: o} = t
          , s = {
            root: n ? n.current : void 0,
            rootMargin: r,
            threshold: typeof i == "number" ? i : R4[i]
        }
          , l = a => {
            const {isIntersecting: u} = a;
            if (this.isInView === u || (this.isInView = u,
            o && !u && this.hasEnteredView))
                return;
            u && (this.hasEnteredView = !0),
            this.node.animationState && this.node.animationState.setActive("whileInView", u);
            const {onViewportEnter: c, onViewportLeave: f} = this.node.getProps()
              , d = u ? c : f;
            d && d(a)
        }
        ;
        return T4(this.node.current, s, l)
    }
    mount() {
        this.startObserver()
    }
    update() {
        if (typeof IntersectionObserver > "u")
            return;
        const {props: t, prevProps: n} = this.node;
        ["amount", "margin", "root"].some(A4(t, n)) && this.startObserver()
    }
    unmount() {}
}
function A4({viewport: e={}}, {viewport: t={}}={}) {
    return n => e[n] !== t[n]
}
const N4 = {
    inView: {
        Feature: L4
    },
    tap: {
        Feature: S4
    },
    focus: {
        Feature: C4
    },
    hover: {
        Feature: x4
    }
}
  , D4 = {
    layout: {
        ProjectionNode: fm,
        MeasureLayout: rm
    }
}
  , hm = w.exports.createContext({
    transformPagePoint: e => e,
    isStatic: !1,
    reducedMotion: "never"
})
  , cs = w.exports.createContext({})
  , ju = typeof window < "u"
  , M4 = ju ? w.exports.useLayoutEffect : w.exports.useEffect
  , pm = w.exports.createContext({
    strict: !1
});
function V4(e, t, n, r, i) {
    var o, s;
    const {visualElement: l} = w.exports.useContext(cs)
      , a = w.exports.useContext(pm)
      , u = w.exports.useContext(Bu)
      , c = w.exports.useContext(hm).reducedMotion
      , f = w.exports.useRef();
    r = r || a.renderer,
    !f.current && r && (f.current = r(e, {
        visualState: t,
        parent: l,
        props: n,
        presenceContext: u,
        blockInitialAnimation: u ? u.initial === !1 : !1,
        reducedMotionConfig: c
    }));
    const d = f.current
      , g = w.exports.useContext(nm);
    d && !d.projection && i && (d.type === "html" || d.type === "svg") && O4(f.current, n, i, g);
    const y = w.exports.useRef(!1);
    w.exports.useInsertionEffect( () => {
        d && y.current && d.update(n, u)
    }
    );
    const v = n[j1]
      , C = w.exports.useRef(Boolean(v) && !(!((o = window.MotionHandoffIsComplete) === null || o === void 0) && o.call(window, v)) && ((s = window.MotionHasOptimisedAnimation) === null || s === void 0 ? void 0 : s.call(window, v)));
    return M4( () => {
        !d || (y.current = !0,
        window.MotionIsMounted = !0,
        d.updateFeatures(),
        zu.render(d.render),
        C.current && d.animationState && d.animationState.animateChanges())
    }
    ),
    w.exports.useEffect( () => {
        !d || (!C.current && d.animationState && d.animationState.animateChanges(),
        C.current && (queueMicrotask( () => {
            var p;
            (p = window.MotionHandoffMarkAsComplete) === null || p === void 0 || p.call(window, v)
        }
        ),
        C.current = !1))
    }
    ),
    d
}
function O4(e, t, n, r) {
    const {layoutId: i, layout: o, drag: s, dragConstraints: l, layoutScroll: a, layoutRoot: u} = t;
    e.projection = new n(e.latestValues,t["data-framer-portal-id"] ? void 0 : mm(e.parent)),
    e.projection.setOptions({
        layoutId: i,
        layout: o,
        alwaysMeasureLayout: Boolean(s) || l && _n(l),
        visualElement: e,
        animationType: typeof o == "string" ? o : "both",
        initialPromotionConfig: r,
        layoutScroll: a,
        layoutRoot: u
    })
}
function mm(e) {
    if (!!e)
        return e.options.allowProjection !== !1 ? e.projection : mm(e.parent)
}
function F4(e, t, n) {
    return w.exports.useCallback(r => {
        r && e.mount && e.mount(r),
        t && (r ? t.mount(r) : t.unmount()),
        n && (typeof n == "function" ? n(r) : _n(n) && (n.current = r))
    }
    , [t])
}
function fs(e) {
    return ls(e.animate) || yu.some(t => ii(e[t]))
}
function gm(e) {
    return Boolean(fs(e) || e.variants)
}
function I4(e, t) {
    if (fs(e)) {
        const {initial: n, animate: r} = e;
        return {
            initial: n === !1 || ii(n) ? n : void 0,
            animate: ii(r) ? r : void 0
        }
    }
    return e.inherit !== !1 ? t : {}
}
function _4(e) {
    const {initial: t, animate: n} = I4(e, w.exports.useContext(cs));
    return w.exports.useMemo( () => ({
        initial: t,
        animate: n
    }), [wd(t), wd(n)])
}
function wd(e) {
    return Array.isArray(e) ? e.join(" ") : e
}
const xd = {
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
  , nr = {};
for (const e in xd)
    nr[e] = {
        isEnabled: t => xd[e].some(n => !!t[n])
    };
function B4(e) {
    for (const t in e)
        nr[t] = {
            ...nr[t],
            ...e[t]
        }
}
const z4 = Symbol.for("motionComponentSymbol");
function j4({preloadedFeatures: e, createVisualElement: t, useRender: n, useVisualState: r, Component: i}) {
    e && B4(e);
    function o(l, a) {
        let u;
        const c = {
            ...w.exports.useContext(hm),
            ...l,
            layoutId: U4(l)
        }
          , {isStatic: f} = c
          , d = _4(l)
          , g = r(l, f);
        if (!f && ju) {
            H4();
            const y = $4(c);
            u = y.MeasureLayout,
            d.visualElement = V4(i, g, c, t, y.ProjectionNode)
        }
        return A(cs.Provider, {
            value: d,
            children: [u && d.visualElement ? P(u, {
                visualElement: d.visualElement,
                ...c
            }) : null, n(i, l, F4(g, d.visualElement, a), g, f, d.visualElement)]
        })
    }
    const s = w.exports.forwardRef(o);
    return s[z4] = i,
    s
}
function U4({layoutId: e}) {
    const t = w.exports.useContext(tm).id;
    return t && e !== void 0 ? t + "-" + e : e
}
function H4(e, t) {
    w.exports.useContext(pm).strict
}
function $4(e) {
    const {drag: t, layout: n} = nr;
    if (!t && !n)
        return {};
    const r = {
        ...t,
        ...n
    };
    return {
        MeasureLayout: (t == null ? void 0 : t.isEnabled(e)) || (n == null ? void 0 : n.isEnabled(e)) ? r.MeasureLayout : void 0,
        ProjectionNode: r.ProjectionNode
    }
}
const W4 = ["animate", "circle", "defs", "desc", "ellipse", "g", "image", "line", "filter", "marker", "mask", "metadata", "path", "pattern", "polygon", "polyline", "rect", "stop", "switch", "symbol", "svg", "text", "tspan", "use", "view"];
function Uu(e) {
    return typeof e != "string" || e.includes("-") ? !1 : !!(W4.indexOf(e) > -1 || /[A-Z]/u.test(e))
}
function vm(e, {style: t, vars: n}, r, i) {
    Object.assign(e.style, t, i && i.getProjectionStyles(r));
    for (const o in n)
        e.style.setProperty(o, n[o])
}
const ym = new Set(["baseFrequency", "diffuseConstant", "kernelMatrix", "kernelUnitLength", "keySplines", "keyTimes", "limitingConeAngle", "markerHeight", "markerWidth", "numOctaves", "targetX", "targetY", "surfaceScale", "specularConstant", "specularExponent", "stdDeviation", "tableValues", "viewBox", "gradientTransform", "pathLength", "startOffset", "textLength", "lengthAdjust"]);
function wm(e, t, n, r) {
    vm(e, t, void 0, r);
    for (const i in t.attrs)
        e.setAttribute(ym.has(i) ? i : _u(i), t.attrs[i])
}
function xm(e, {layout: t, layoutId: n}) {
    return Sn.has(e) || e.startsWith("origin") || (t || n !== void 0) && (!!zo[e] || e === "opacity")
}
function Hu(e, t, n) {
    var r;
    const {style: i} = e
      , o = {};
    for (const s in i)
        (ve(i[s]) || t.style && ve(t.style[s]) || xm(s, e) || ((r = n == null ? void 0 : n.getValue(s)) === null || r === void 0 ? void 0 : r.liveStyle) !== void 0) && (o[s] = i[s]);
    return o
}
function Cm(e, t, n) {
    const r = Hu(e, t, n);
    for (const i in e)
        if (ve(e[i]) || ve(t[i])) {
            const o = gi.indexOf(i) !== -1 ? "attr" + i.charAt(0).toUpperCase() + i.substring(1) : i;
            r[o] = e[i]
        }
    return r
}
function b4(e) {
    const t = w.exports.useRef(null);
    return t.current === null && (t.current = e()),
    t.current
}
function K4({scrapeMotionValuesFromProps: e, createRenderState: t, onMount: n}, r, i, o) {
    const s = {
        latestValues: Q4(r, i, o, e),
        renderState: t()
    };
    return n && (s.mount = l => n(r, l, s)),
    s
}
const Sm = e => (t, n) => {
    const r = w.exports.useContext(cs)
      , i = w.exports.useContext(Bu)
      , o = () => K4(e, t, r, i);
    return n ? o() : b4(o)
}
;
function Q4(e, t, n, r) {
    const i = {}
      , o = r(e, {});
    for (const d in o)
        i[d] = oo(o[d]);
    let {initial: s, animate: l} = e;
    const a = fs(e)
      , u = gm(e);
    t && u && !a && e.inherit !== !1 && (s === void 0 && (s = t.initial),
    l === void 0 && (l = t.animate));
    let c = n ? n.initial === !1 : !1;
    c = c || s === !1;
    const f = c ? l : s;
    if (f && typeof f != "boolean" && !ls(f)) {
        const d = Array.isArray(f) ? f : [f];
        for (let g = 0; g < d.length; g++) {
            const y = gu(e, d[g]);
            if (y) {
                const {transitionEnd: v, transition: C, ...p} = y;
                for (const h in p) {
                    let m = p[h];
                    if (Array.isArray(m)) {
                        const x = c ? m.length - 1 : 0;
                        m = m[x]
                    }
                    m !== null && (i[h] = m)
                }
                for (const h in v)
                    i[h] = v[h]
            }
        }
    }
    return i
}
const $u = () => ({
    style: {},
    transform: {},
    transformOrigin: {},
    vars: {}
})
  , Pm = () => ({
    ...$u(),
    attrs: {}
})
  , km = (e, t) => t && typeof e == "number" ? t.transform(e) : e
  , Y4 = {
    x: "translateX",
    y: "translateY",
    z: "translateZ",
    transformPerspective: "perspective"
}
  , G4 = gi.length;
function Z4(e, t, n) {
    let r = ""
      , i = !0;
    for (let o = 0; o < G4; o++) {
        const s = gi[o]
          , l = e[s];
        if (l === void 0)
            continue;
        let a = !0;
        if (typeof l == "number" ? a = l === (s.startsWith("scale") ? 1 : 0) : a = parseFloat(l) === 0,
        !a || n) {
            const u = km(l, Tu[s]);
            if (!a) {
                i = !1;
                const c = Y4[s] || s;
                r += `${c}(${u}) `
            }
            n && (t[s] = u)
        }
    }
    return r = r.trim(),
    n ? r = n(t, i ? "" : r) : i && (r = "none"),
    r
}
function Wu(e, t, n) {
    const {style: r, vars: i, transformOrigin: o} = e;
    let s = !1
      , l = !1;
    for (const a in t) {
        const u = t[a];
        if (Sn.has(a)) {
            s = !0;
            continue
        } else if (m1(a)) {
            i[a] = u;
            continue
        } else {
            const c = km(u, Tu[a]);
            a.startsWith("origin") ? (l = !0,
            o[a] = c) : r[a] = c
        }
    }
    if (t.transform || (s || n ? r.transform = Z4(t, e.transform, n) : r.transform && (r.transform = "none")),
    l) {
        const {originX: a="50%", originY: u="50%", originZ: c=0} = o;
        r.transformOrigin = `${a} ${u} ${c}`
    }
}
function Cd(e, t, n) {
    return typeof e == "string" ? e : M.transform(t + n * e)
}
function X4(e, t, n) {
    const r = Cd(t, e.x, e.width)
      , i = Cd(n, e.y, e.height);
    return `${r} ${i}`
}
const J4 = {
    offset: "stroke-dashoffset",
    array: "stroke-dasharray"
}
  , q4 = {
    offset: "strokeDashoffset",
    array: "strokeDasharray"
};
function e6(e, t, n=1, r=0, i=!0) {
    e.pathLength = 1;
    const o = i ? J4 : q4;
    e[o.offset] = M.transform(-r);
    const s = M.transform(t)
      , l = M.transform(n);
    e[o.array] = `${s} ${l}`
}
function bu(e, {attrX: t, attrY: n, attrScale: r, originX: i, originY: o, pathLength: s, pathSpacing: l=1, pathOffset: a=0, ...u}, c, f) {
    if (Wu(e, u, f),
    c) {
        e.style.viewBox && (e.attrs.viewBox = e.style.viewBox);
        return
    }
    e.attrs = e.style,
    e.style = {};
    const {attrs: d, style: g, dimensions: y} = e;
    d.transform && (y && (g.transform = d.transform),
    delete d.transform),
    y && (i !== void 0 || o !== void 0 || g.transform) && (g.transformOrigin = X4(y, i !== void 0 ? i : .5, o !== void 0 ? o : .5)),
    t !== void 0 && (d.x = t),
    n !== void 0 && (d.y = n),
    r !== void 0 && (d.scale = r),
    s !== void 0 && e6(d, s, l, a, !1)
}
const Ku = e => typeof e == "string" && e.toLowerCase() === "svg"
  , t6 = {
    useVisualState: Sm({
        scrapeMotionValuesFromProps: Cm,
        createRenderState: Pm,
        onMount: (e, t, {renderState: n, latestValues: r}) => {
            z.read( () => {
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
            z.render( () => {
                bu(n, r, Ku(t.tagName), e.transformTemplate),
                wm(t, n)
            }
            )
        }
    })
}
  , n6 = {
    useVisualState: Sm({
        scrapeMotionValuesFromProps: Hu,
        createRenderState: $u
    })
};
function Em(e, t, n) {
    for (const r in t)
        !ve(t[r]) && !xm(r, n) && (e[r] = t[r])
}
function r6({transformTemplate: e}, t) {
    return w.exports.useMemo( () => {
        const n = $u();
        return Wu(n, t, e),
        Object.assign({}, n.vars, n.style)
    }
    , [t])
}
function i6(e, t) {
    const n = e.style || {}
      , r = {};
    return Em(r, n, e),
    Object.assign(r, r6(e, t)),
    r
}
function o6(e, t) {
    const n = {}
      , r = i6(e, t);
    return e.drag && e.dragListener !== !1 && (n.draggable = !1,
    r.userSelect = r.WebkitUserSelect = r.WebkitTouchCallout = "none",
    r.touchAction = e.drag === !0 ? "none" : `pan-${e.drag === "x" ? "y" : "x"}`),
    e.tabIndex === void 0 && (e.onTap || e.onTapStart || e.whileTap) && (n.tabIndex = 0),
    n.style = r,
    n
}
const s6 = new Set(["animate", "exit", "variants", "initial", "style", "values", "variants", "transition", "transformTemplate", "custom", "inherit", "onBeforeLayoutMeasure", "onAnimationStart", "onAnimationComplete", "onUpdate", "onDragStart", "onDrag", "onDragEnd", "onMeasureDragConstraints", "onDirectionLock", "onDragTransitionEnd", "_dragX", "_dragY", "onHoverStart", "onHoverEnd", "onViewportEnter", "onViewportLeave", "globalTapTarget", "ignoreStrict", "viewport"]);
function jo(e) {
    return e.startsWith("while") || e.startsWith("drag") && e !== "draggable" || e.startsWith("layout") || e.startsWith("onTap") || e.startsWith("onPan") || e.startsWith("onLayout") || s6.has(e)
}
let Tm = e => !jo(e);
function l6(e) {
    !e || (Tm = t => t.startsWith("on") ? !jo(t) : e(t))
}
try {
    l6(require("@emotion/is-prop-valid").default)
} catch {}
function a6(e, t, n) {
    const r = {};
    for (const i in e)
        i === "values" && typeof e.values == "object" || (Tm(i) || n === !0 && jo(i) || !t && !jo(i) || e.draggable && i.startsWith("onDrag")) && (r[i] = e[i]);
    return r
}
function u6(e, t, n, r) {
    const i = w.exports.useMemo( () => {
        const o = Pm();
        return bu(o, t, Ku(r), e.transformTemplate),
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
        Em(o, e.style, e),
        i.style = {
            ...o,
            ...i.style
        }
    }
    return i
}
function c6(e=!1) {
    return (n, r, i, {latestValues: o}, s) => {
        const a = (Uu(n) ? u6 : o6)(r, o, s, n)
          , u = a6(r, typeof n == "string", e)
          , c = n !== w.exports.Fragment ? {
            ...u,
            ...a,
            ref: i
        } : {}
          , {children: f} = r
          , d = w.exports.useMemo( () => ve(f) ? f.get() : f, [f]);
        return w.exports.createElement(n, {
            ...c,
            children: d
        })
    }
}
function f6(e, t) {
    return function(r, {forwardMotionProps: i}={
        forwardMotionProps: !1
    }) {
        const s = {
            ...Uu(r) ? t6 : n6,
            preloadedFeatures: e,
            useRender: c6(i),
            createVisualElement: t,
            Component: r
        };
        return j4(s)
    }
}
const pa = {
    current: null
}
  , Rm = {
    current: !1
};
function d6() {
    if (Rm.current = !0,
    !!ju)
        if (window.matchMedia) {
            const e = window.matchMedia("(prefers-reduced-motion)")
              , t = () => pa.current = e.matches;
            e.addListener(t),
            t()
        } else
            pa.current = !1
}
function h6(e, t, n) {
    for (const r in t) {
        const i = t[r]
          , o = n[r];
        if (ve(i))
            e.addValue(r, i);
        else if (ve(o))
            e.addValue(r, li(i, {
                owner: e
            }));
        else if (o !== i)
            if (e.hasValue(r)) {
                const s = e.getValue(r);
                s.liveStyle === !0 ? s.jump(i) : s.hasAnimated || s.set(i)
            } else {
                const s = e.getStaticValue(r);
                e.addValue(r, li(s !== void 0 ? s : i, {
                    owner: e
                }))
            }
    }
    for (const r in n)
        t[r] === void 0 && e.removeValue(r);
    return t
}
const Sd = new WeakMap
  , p6 = [...y1, me, Qt]
  , m6 = e => p6.find(v1(e))
  , Pd = ["AnimationStart", "AnimationComplete", "Update", "BeforeLayoutMeasure", "LayoutMeasure", "LayoutAnimationStart", "LayoutAnimationComplete"];
class g6 {
    scrapeMotionValuesFromProps(t, n, r) {
        return {}
    }
    constructor({parent: t, props: n, presenceContext: r, reducedMotionConfig: i, blockInitialAnimation: o, visualState: s}, l={}) {
        this.current = null,
        this.children = new Set,
        this.isVariantNode = !1,
        this.isControllingVariants = !1,
        this.shouldReduceMotion = null,
        this.values = new Map,
        this.KeyframeResolver = Pu,
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
        this.renderScheduledAt = 0,
        this.scheduleRender = () => {
            const d = ot.now();
            this.renderScheduledAt < d && (this.renderScheduledAt = d,
            z.render(this.render, !1, !0))
        }
        ;
        const {latestValues: a, renderState: u} = s;
        this.latestValues = a,
        this.baseTarget = {
            ...a
        },
        this.initialValues = n.initial ? {
            ...a
        } : {},
        this.renderState = u,
        this.parent = t,
        this.props = n,
        this.presenceContext = r,
        this.depth = t ? t.depth + 1 : 0,
        this.reducedMotionConfig = i,
        this.options = l,
        this.blockInitialAnimation = Boolean(o),
        this.isControllingVariants = fs(n),
        this.isVariantNode = gm(n),
        this.isVariantNode && (this.variantChildren = new Set),
        this.manuallyAnimateOnMount = Boolean(t && t.current);
        const {willChange: c, ...f} = this.scrapeMotionValuesFromProps(n, {}, this);
        for (const d in f) {
            const g = f[d];
            a[d] !== void 0 && ve(g) && g.set(a[d], !1)
        }
    }
    mount(t) {
        this.current = t,
        Sd.set(t, this),
        this.projection && !this.projection.instance && this.projection.mount(t),
        this.parent && this.isVariantNode && !this.isControllingVariants && (this.removeFromVariantTree = this.parent.addVariantChild(this)),
        this.values.forEach( (n, r) => this.bindToMotionValue(r, n)),
        Rm.current || d6(),
        this.shouldReduceMotion = this.reducedMotionConfig === "never" ? !1 : this.reducedMotionConfig === "always" ? !0 : pa.current,
        this.parent && this.parent.children.add(this),
        this.update(this.props, this.presenceContext)
    }
    unmount() {
        Sd.delete(this.current),
        this.projection && this.projection.unmount(),
        Ct(this.notifyUpdate),
        Ct(this.render),
        this.valueSubscriptions.forEach(t => t()),
        this.valueSubscriptions.clear(),
        this.removeFromVariantTree && this.removeFromVariantTree(),
        this.parent && this.parent.children.delete(this);
        for (const t in this.events)
            this.events[t].clear();
        for (const t in this.features) {
            const n = this.features[t];
            n && (n.unmount(),
            n.isMounted = !1)
        }
        this.current = null
    }
    bindToMotionValue(t, n) {
        this.valueSubscriptions.has(t) && this.valueSubscriptions.get(t)();
        const r = Sn.has(t)
          , i = n.on("change", l => {
            this.latestValues[t] = l,
            this.props.onUpdate && z.preRender(this.notifyUpdate),
            r && this.projection && (this.projection.isTransformDirty = !0)
        }
        )
          , o = n.on("renderRequest", this.scheduleRender);
        let s;
        window.MotionCheckAppearSync && (s = window.MotionCheckAppearSync(this, t, n)),
        this.valueSubscriptions.set(t, () => {
            i(),
            o(),
            s && s(),
            n.owner && n.stop()
        }
        )
    }
    sortNodePosition(t) {
        return !this.current || !this.sortInstanceNodePosition || this.type !== t.type ? 0 : this.sortInstanceNodePosition(this.current, t.current)
    }
    updateFeatures() {
        let t = "animation";
        for (t in nr) {
            const n = nr[t];
            if (!n)
                continue;
            const {isEnabled: r, Feature: i} = n;
            if (!this.features[t] && i && r(this.props) && (this.features[t] = new i(this)),
            this.features[t]) {
                const o = this.features[t];
                o.isMounted ? o.update() : (o.mount(),
                o.isMounted = !0)
            }
        }
    }
    triggerBuild() {
        this.build(this.renderState, this.latestValues, this.props)
    }
    measureViewportBox() {
        return this.current ? this.measureInstanceViewportBox(this.current, this.props) : q()
    }
    getStaticValue(t) {
        return this.latestValues[t]
    }
    setStaticValue(t, n) {
        this.latestValues[t] = n
    }
    update(t, n) {
        (t.transformTemplate || this.props.transformTemplate) && this.scheduleRender(),
        this.prevProps = this.props,
        this.props = t,
        this.prevPresenceContext = this.presenceContext,
        this.presenceContext = n;
        for (let r = 0; r < Pd.length; r++) {
            const i = Pd[r];
            this.propEventSubscriptions[i] && (this.propEventSubscriptions[i](),
            delete this.propEventSubscriptions[i]);
            const o = "on" + i
              , s = t[o];
            s && (this.propEventSubscriptions[i] = this.on(i, s))
        }
        this.prevMotionValues = h6(this, this.scrapeMotionValuesFromProps(t, this.prevProps, this), this.prevMotionValues),
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
    addVariantChild(t) {
        const n = this.getClosestVariantNode();
        if (n)
            return n.variantChildren && n.variantChildren.add(t),
            () => n.variantChildren.delete(t)
    }
    addValue(t, n) {
        const r = this.values.get(t);
        n !== r && (r && this.removeValue(t),
        this.bindToMotionValue(t, n),
        this.values.set(t, n),
        this.latestValues[t] = n.get())
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
        return r === void 0 && n !== void 0 && (r = li(n === null ? void 0 : n, {
            owner: this
        }),
        this.addValue(t, r)),
        r
    }
    readValue(t, n) {
        var r;
        let i = this.latestValues[t] !== void 0 || !this.current ? this.latestValues[t] : (r = this.getBaseTargetFromProps(this.props, t)) !== null && r !== void 0 ? r : this.readValueFromInstance(this.current, t, this.options);
        return i != null && (typeof i == "string" && (h1(i) || d1(i)) ? i = parseFloat(i) : !m6(i) && Qt.test(n) && (i = T1(t, n)),
        this.setBaseTarget(t, ve(i) ? i.get() : i)),
        ve(i) ? i.get() : i
    }
    setBaseTarget(t, n) {
        this.baseTarget[t] = n
    }
    getBaseTarget(t) {
        var n;
        const {initial: r} = this.props;
        let i;
        if (typeof r == "string" || typeof r == "object") {
            const s = gu(this.props, r, (n = this.presenceContext) === null || n === void 0 ? void 0 : n.custom);
            s && (i = s[t])
        }
        if (r && i !== void 0)
            return i;
        const o = this.getBaseTargetFromProps(this.props, t);
        return o !== void 0 && !ve(o) ? o : this.initialValues[t] !== void 0 && i === void 0 ? void 0 : this.baseTarget[t]
    }
    on(t, n) {
        return this.events[t] || (this.events[t] = new Iu),
        this.events[t].add(n)
    }
    notify(t, ...n) {
        this.events[t] && this.events[t].notify(...n)
    }
}
class Lm extends g6 {
    constructor() {
        super(...arguments),
        this.KeyframeResolver = R1
    }
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
    handleChildMotionValue() {
        this.childSubscription && (this.childSubscription(),
        delete this.childSubscription);
        const {children: t} = this.props;
        ve(t) && (this.childSubscription = t.on("change", n => {
            this.current && (this.current.textContent = `${n}`)
        }
        ))
    }
}
function v6(e) {
    return window.getComputedStyle(e)
}
class y6 extends Lm {
    constructor() {
        super(...arguments),
        this.type = "html",
        this.renderInstance = vm
    }
    readValueFromInstance(t, n) {
        if (Sn.has(n)) {
            const r = Ru(n);
            return r && r.default || 0
        } else {
            const r = v6(t)
              , i = (m1(n) ? r.getPropertyValue(n) : r[n]) || 0;
            return typeof i == "string" ? i.trim() : i
        }
    }
    measureInstanceViewportBox(t, {transformPagePoint: n}) {
        return q1(t, n)
    }
    build(t, n, r) {
        Wu(t, n, r.transformTemplate)
    }
    scrapeMotionValuesFromProps(t, n, r) {
        return Hu(t, n, r)
    }
}
class w6 extends Lm {
    constructor() {
        super(...arguments),
        this.type = "svg",
        this.isSVGTag = !1,
        this.measureInstanceViewportBox = q
    }
    getBaseTargetFromProps(t, n) {
        return t[n]
    }
    readValueFromInstance(t, n) {
        if (Sn.has(n)) {
            const r = Ru(n);
            return r && r.default || 0
        }
        return n = ym.has(n) ? n : _u(n),
        t.getAttribute(n)
    }
    scrapeMotionValuesFromProps(t, n, r) {
        return Cm(t, n, r)
    }
    build(t, n, r) {
        bu(t, n, this.isSVGTag, r.transformTemplate)
    }
    renderInstance(t, n, r, i) {
        wm(t, n, r, i)
    }
    mount(t) {
        this.isSVGTag = Ku(t.tagName),
        super.mount(t)
    }
}
const x6 = (e, t) => Uu(e) ? new w6(t) : new y6(t,{
    allowProjection: e !== w.exports.Fragment
})
  , C6 = f6({
    ...o3,
    ...N4,
    ...v4,
    ...D4
}, x6)
  , ae = ny(C6);
w.exports.createContext(null);
Er.reduce( (e, t) => (e[t] = n => Ct(n),
e), {});
w.exports.createContext(null);
function xr() {
    var t, n, r;
    const e = w.exports.useRef(null);
    return A("svg", {
        ref: e,
        className: "w-full h-full absolute left-0 top-0 -z-10 overflow-visible",
        width: Number((t = e.current) == null ? void 0 : t.width),
        height: "100%",
        viewBox: `0 0 ${(n = e.current) == null ? void 0 : n.width} ${(r = e.current) == null ? void 0 : r.height}`,
        fill: "none",
        xmlns: "http://www.w3.org/2000/svg",
        children: [P("rect", {
            className: "w-full h-full",
            rx: "4",
            fill: "url(#paint0_linear_322_174)",
            "fill-opacity": "0.5"
        }), P("rect", {
            className: "w-full h-full",
            rx: "4",
            fill: "url(#paint1_linear_322_174)",
            "fill-opacity": "0.25"
        }), P("rect", {
            className: "w-[calc(100%-0.8px)] h-full",
            x: "0.4",
            y: "0.4",
            rx: "3.6",
            stroke: "url(#paint2_linear_322_174)",
            "stroke-opacity": "0.7",
            "stroke-width": "0.8"
        }), P("rect", {
            className: "w-[calc(100%-0.8px)] h-full",
            x: "0.4",
            y: "0.4",
            rx: "3.6",
            stroke: "white",
            "stroke-opacity": "0.08",
            "stroke-width": "0.8"
        }), A("defs", {
            children: [A("linearGradient", {
                id: "paint0_linear_322_174",
                x1: "0",
                y1: "25",
                x2: "1293",
                y2: "25",
                gradientUnits: "userSpaceOnUse",
                children: [P("stop", {}), P("stop", {
                    offset: "1",
                    stopOpacity: "0.85"
                })]
            }), A("linearGradient", {
                id: "paint1_linear_322_174",
                x1: "646.5",
                y1: "0",
                x2: "646.5",
                y2: "64.2857",
                gradientUnits: "userSpaceOnUse",
                children: [P("stop", {
                    stopColor: "#FE3800",
                    "stop-opacity": "0"
                }), P("stop", {
                    offset: "1",
                    stopColor: "#FE3800"
                })]
            }), A("linearGradient", {
                id: "paint2_linear_322_174",
                x1: "646.5",
                y1: "0",
                x2: "646.5",
                y2: "50",
                gradientUnits: "userSpaceOnUse",
                children: [P("stop", {
                    stopColor: "#FE3800",
                    "stop-opacity": "0"
                }), P("stop", {
                    offset: "1",
                    stopColor: "#FE3800"
                })]
            })]
        })]
    })
}
const S6 = "" + new URL("../banners/shop.png",import.meta.url).href
  , P6 = "" + new URL("../banners/bet.png",import.meta.url).href
  , k6 = "" + new URL("../banners/skins.png",import.meta.url).href
  , E6 = "" + new URL("../banners/ranking.png",import.meta.url).href
  , T6 = "" + new URL("../banners/cases.png",import.meta.url).href
  , R6 = "" + new URL("../banners/pass.png",import.meta.url).href
  , L6 = "" + new URL("default_avatar.44e3f6e5.svg",import.meta.url).href;
function A6() {
    const e = os()
      , {data: t} = Xp();
    function n() {
        je("OpenSkins", {}, !0)
    }
    function r() {
        je("OpenPass", {}, !0)
    }
    function i() {
        je("OpenBet", {})
    }
    function o() {
        je("OpenVips", {}, !0)
    }
    function s() {
        je("OpenCases", {}, !0)
    }
    const l = {
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
      , a = {
        hidden: {
            opacity: 0,
            y: 20
        },
        visible: {
            opacity: 1,
            y: 0,
            transition: {
                duration: .5
            }
        }
    }
      , u = {
        hover: {
            scale: 1.05,
            transition: {
                duration: .2
            }
        },
        tap: {
            scale: .95
        }
    };
    return A(ae.div, {
        className: "w-[80.8125rem] h-[52.125rem] absolute left-1/2 -translate-x-1/2 top-1/2 -translate-y-1/2 flex flex-col gap-3",
        initial: "hidden",
        animate: "visible",
        variants: l,
        children: [P(e1, {}), A("div", {
            className: "w-full h-full flex gap-3",
            children: [A("div", {
                className: "h-full grid grid-components gap-3",
                children: [A(ae.div, {
                    className: "relative [grid-area:profile] w-full h-full flex items-center justify-between gap-3 px-3 overflow-hidden",
                    variants: a,
                    children: [P(xr, {}), A("div", {
                        className: "w-[14.125rem] flex items-center gap-3",
                        children: [P("img", {
                            src: t == null ? void 0 : t.avatar,
                            onError: c => c.currentTarget.src = L6,
                            alt: "Avatar",
                            className: "w-[4.5rem] h-[4.5rem] rounded-full border-[0.8px] border-primary flex-none"
                        }), A("div", {
                            className: "flex flex-col gap-1",
                            children: [P("span", {
                                className: "text-white text-[1.125rem] font-bold leading-[1] line-clamp-1",
                                children: t == null ? void 0 : t.name
                            }), P("span", {
                                className: "text-white/[.5] text-[1rem] leading-[1] text-primary",
                                children: t == null ? void 0 : t.id
                            })]
                        })]
                    }), A("div", {
                        className: "w-full flex-1 flex items-center justify-between",
                        children: [A("div", {
                            className: "flex items-center gap-2 flex-none",
                            children: [P("svg", {
                                className: "size-8",
                                width: "32",
                                height: "32",
                                viewBox: "0 0 32 32",
                                fill: "none",
                                xmlns: "http://www.w3.org/2000/svg",
                                children: P("path", {
                                    d: "M16 3.25C13.4783 3.25 11.0132 3.99777 8.91648 5.39876C6.81976 6.79975 5.18556 8.79103 4.22054 11.1208C3.25552 13.4505 3.00303 16.0141 3.49499 18.4874C3.98696 20.9607 5.20127 23.2325 6.98439 25.0156C8.76751 26.7987 11.0393 28.0131 13.5126 28.505C15.9859 28.997 18.5495 28.7445 20.8792 27.7795C23.209 26.8144 25.2003 25.1802 26.6012 23.0835C28.0022 20.9868 28.75 18.5217 28.75 16C28.746 12.6197 27.4015 9.379 25.0112 6.98877C22.621 4.59854 19.3803 3.25397 16 3.25ZM8.93001 24.75C9.66349 23.5303 10.7 22.5212 11.9389 21.8206C13.1777 21.12 14.5768 20.7518 16 20.7518C17.4232 20.7518 18.8223 21.12 20.0611 21.8206C21.3 22.5212 22.3365 23.5303 23.07 24.75C21.0705 26.3714 18.5743 27.2563 16 27.2563C13.4257 27.2563 10.9296 26.3714 8.93001 24.75ZM11.75 15C11.75 14.1594 11.9993 13.3377 12.4663 12.6388C12.9333 11.9399 13.597 11.3952 14.3736 11.0735C15.1502 10.7518 16.0047 10.6677 16.8291 10.8317C17.6536 10.9956 18.4108 11.4004 19.0052 11.9948C19.5996 12.5892 20.0044 13.3464 20.1683 14.1709C20.3323 14.9953 20.2482 15.8498 19.9265 16.6264C19.6048 17.403 19.0601 18.0668 18.3612 18.5337C17.6623 19.0007 16.8406 19.25 16 19.25C14.8728 19.25 13.7918 18.8022 12.9948 18.0052C12.1978 17.2082 11.75 16.1272 11.75 15ZM24.1888 23.705C23.0103 21.8727 21.2489 20.4908 19.1888 19.7825C20.216 19.0983 20.9959 18.1016 21.413 16.9399C21.8301 15.7783 21.8623 14.5132 21.5049 13.3318C21.1475 12.1504 20.4194 11.1153 19.4282 10.3797C18.4371 9.64404 17.2356 9.24686 16.0013 9.24686C14.767 9.24686 13.5654 9.64404 12.5743 10.3797C11.5832 11.1153 10.8551 12.1504 10.4976 13.3318C10.1402 14.5132 10.1724 15.7783 10.5895 16.9399C11.0066 18.1016 11.7865 19.0983 12.8138 19.7825C10.7536 20.4908 8.99217 21.8727 7.81376 23.705C6.30729 22.1064 5.30179 20.1017 4.92131 17.9382C4.54082 15.7748 4.80201 13.5474 5.67264 11.5307C6.54327 9.51396 7.98524 7.79624 9.82066 6.58946C11.6561 5.38267 13.8046 4.7396 16.0013 4.7396C18.1979 4.7396 20.3464 5.38267 22.1818 6.58946C24.0173 7.79624 25.4592 9.51396 26.3299 11.5307C27.2005 13.5474 27.4617 15.7748 27.0812 17.9382C26.7007 20.1017 25.6952 22.1064 24.1888 23.705Z",
                                    fill: "#FE3800"
                                })
                            }), A("div", {
                                className: "flex flex-col ",
                                children: [P("span", {
                                    className: "text-xs leading-[1] text-white/60",
                                    children: "IDADE"
                                }), A("p", {
                                    className: "text-white font-bold text-[.9375rem]",
                                    children: [t == null ? void 0 : t.age, " ANOS"]
                                })]
                            })]
                        }), A("div", {
                            className: "flex items-center gap-2 flex-none",
                            children: [P("svg", {
                                className: "size-8",
                                width: "32",
                                height: "32",
                                viewBox: "0 0 32 32",
                                fill: "none",
                                xmlns: "http://www.w3.org/2000/svg",
                                children: P("path", {
                                    d: "M27.6988 20.0375L21.7938 17.3913C21.5262 17.2766 21.2343 17.2305 20.9444 17.2572C20.6546 17.2838 20.3759 17.3823 20.1338 17.5438C20.1092 17.5595 20.0858 17.5771 20.0638 17.5963L16.9775 20.2213C16.9455 20.2387 16.9098 20.2485 16.8734 20.2498C16.837 20.2511 16.8007 20.2439 16.7675 20.2288C14.7838 19.2713 12.7288 17.2288 11.7675 15.2725C11.7515 15.2398 11.7432 15.2039 11.7432 15.1675C11.7432 15.1311 11.7515 15.0952 11.7675 15.0625L14.4013 11.9375C14.4202 11.9144 14.4377 11.8902 14.4538 11.865C14.613 11.6219 14.7092 11.3429 14.7336 11.0533C14.7581 10.7638 14.71 10.4726 14.5938 10.2063L11.9663 4.31126C11.8171 3.96327 11.559 3.67306 11.2308 3.48419C10.9027 3.29532 10.5221 3.21797 10.1463 3.26376C8.5128 3.47851 7.01341 4.28068 5.92829 5.52039C4.84318 6.76009 4.24659 8.35249 4.25001 10C4.25001 19.7875 12.2125 27.75 22 27.75C23.6475 27.7532 25.2397 27.1565 26.4794 26.0714C27.719 24.9864 28.5213 23.4871 28.7363 21.8538C28.782 21.4797 28.7057 21.1008 28.5187 20.7736C28.3318 20.4463 28.0442 20.1882 27.6988 20.0375ZM22 26.25C13.04 26.25 5.75001 18.96 5.75001 10C5.74584 8.71742 6.20877 7.47719 7.05232 6.51102C7.89587 5.54486 9.06233 4.91887 10.3338 4.75001H10.3625C10.4129 4.75095 10.4618 4.76709 10.5028 4.79631C10.5439 4.82553 10.5751 4.86647 10.5925 4.91376L13.23 10.8025C13.2451 10.8353 13.2528 10.8709 13.2528 10.9069C13.2528 10.9429 13.2451 10.9785 13.23 11.0113L10.5913 14.1438C10.5716 14.1661 10.5536 14.1899 10.5375 14.215C10.3724 14.4671 10.2752 14.7575 10.2552 15.0582C10.2353 15.3589 10.2934 15.6596 10.4238 15.9313C11.5325 18.2013 13.82 20.4713 16.115 21.58C16.3883 21.7097 16.6905 21.7663 16.9921 21.7444C17.2938 21.7225 17.5846 21.6228 17.8363 21.455C17.86 21.4388 17.8838 21.4213 17.9063 21.4025L20.9913 18.7775C21.0217 18.7611 21.0554 18.7515 21.0899 18.7494C21.1244 18.7472 21.159 18.7526 21.1913 18.765L27.0975 21.4113C27.1458 21.4318 27.1863 21.467 27.2135 21.5119C27.2406 21.5567 27.253 21.609 27.2488 21.6613C27.0808 22.9333 26.4554 24.1006 25.4894 24.9451C24.5235 25.7896 23.2831 26.2535 22 26.25Z",
                                    fill: "#FE3800"
                                })
                            }), A("div", {
                                className: "flex flex-col ",
                                children: [P("span", {
                                    className: "text-xs leading-[1] text-white/60",
                                    children: "TELEFONE"
                                }), P("p", {
                                    className: "text-white font-bold text-[.9375rem]",
                                    children: t == null ? void 0 : t.phone
                                })]
                            })]
                        }), A("div", {
                            className: "flex items-center gap-2 flex-none",
                            children: [P("svg", {
                                className: "size-8",
                                width: "32",
                                height: "32",
                                viewBox: "0 0 32 32",
                                fill: "none",
                                xmlns: "http://www.w3.org/2000/svg",
                                children: P("path", {
                                    d: "M26.3529 10.6327H21.4118V10.398C21.4118 8.96633 20.8416 7.59334 19.8267 6.58103C18.8118 5.56871 17.4353 5 16 5C14.5647 5 13.1882 5.56871 12.1733 6.58103C11.1584 7.59334 10.5882 8.96633 10.5882 10.398V10.6327H5.64706C5.21023 10.6327 4.7913 10.8057 4.48241 11.1138C4.17353 11.4219 4 11.8398 4 12.2755V26.3571C4 26.7929 4.17353 27.2107 4.48241 27.5188C4.7913 27.8269 5.21023 28 5.64706 28H26.3529C26.7898 28 27.2087 27.8269 27.5176 27.5188C27.8265 27.2107 28 26.7929 28 26.3571V12.2755C28 11.8398 27.8265 11.4219 27.5176 11.1138C27.2087 10.8057 26.7898 10.6327 26.3529 10.6327ZM12 10.398C12 9.3398 12.4214 8.32498 13.1716 7.57675C13.9217 6.82852 14.9391 6.40816 16 6.40816C17.0609 6.40816 18.0783 6.82852 18.8284 7.57675C19.5786 8.32498 20 9.3398 20 10.398V10.6327H12V10.398ZM26.5882 26.3571C26.5882 26.4194 26.5634 26.4791 26.5193 26.5231C26.4752 26.5671 26.4153 26.5918 26.3529 26.5918H5.64706C5.58465 26.5918 5.52481 26.5671 5.48068 26.5231C5.43655 26.4791 5.41176 26.4194 5.41176 26.3571V12.2755C5.41176 12.2133 5.43655 12.1536 5.48068 12.1096C5.52481 12.0655 5.58465 12.0408 5.64706 12.0408H26.3529C26.4153 12.0408 26.4752 12.0655 26.5193 12.1096C26.5634 12.1536 26.5882 12.2133 26.5882 12.2755V26.3571Z",
                                    fill: "#FE3800"
                                })
                            }), A("div", {
                                className: "flex flex-col ",
                                children: [P("span", {
                                    className: "text-xs leading-[1] text-white/60",
                                    children: "ORG"
                                }), P("p", {
                                    className: "text-white font-bold text-[.9375rem]",
                                    children: t == null ? void 0 : t.org
                                })]
                            })]
                        }), A("div", {
                            className: "flex items-center gap-2 flex-none",
                            children: [P("svg", {
                                className: "size-8",
                                width: "32",
                                height: "32",
                                viewBox: "0 0 32 32",
                                fill: "none",
                                xmlns: "http://www.w3.org/2000/svg",
                                children: P("path", {
                                    d: "M26.3529 10.6327H21.4118V10.398C21.4118 8.96633 20.8416 7.59334 19.8267 6.58103C18.8118 5.56871 17.4353 5 16 5C14.5647 5 13.1882 5.56871 12.1733 6.58103C11.1584 7.59334 10.5882 8.96633 10.5882 10.398V10.6327H5.64706C5.21023 10.6327 4.7913 10.8057 4.48241 11.1138C4.17353 11.4219 4 11.8398 4 12.2755V26.3571C4 26.7929 4.17353 27.2107 4.48241 27.5188C4.7913 27.8269 5.21023 28 5.64706 28H26.3529C26.7898 28 27.2087 27.8269 27.5176 27.5188C27.8265 27.2107 28 26.7929 28 26.3571V12.2755C28 11.8398 27.8265 11.4219 27.5176 11.1138C27.2087 10.8057 26.7898 10.6327 26.3529 10.6327ZM12 10.398C12 9.3398 12.4214 8.32498 13.1716 7.57675C13.9217 6.82852 14.9391 6.40816 16 6.40816C17.0609 6.40816 18.0783 6.82852 18.8284 7.57675C19.5786 8.32498 20 9.3398 20 10.398V10.6327H12V10.398ZM26.5882 26.3571C26.5882 26.4194 26.5634 26.4791 26.5193 26.5231C26.4752 26.5671 26.4153 26.5918 26.3529 26.5918H5.64706C5.58465 26.5918 5.52481 26.5671 5.48068 26.5231C5.43655 26.4791 5.41176 26.4194 5.41176 26.3571V12.2755C5.41176 12.2133 5.43655 12.1536 5.48068 12.1096C5.52481 12.0655 5.58465 12.0408 5.64706 12.0408H26.3529C26.4153 12.0408 26.4752 12.0655 26.5193 12.1096C26.5634 12.1536 26.5882 12.2133 26.5882 12.2755V26.3571Z",
                                    fill: "#FE3800"
                                })
                            }), A("div", {
                                className: "flex flex-col ",
                                children: [P("span", {
                                    className: "text-xs leading-[1] text-white/60",
                                    children: "STATUS"
                                }), P("p", {
                                    className: "text-white font-bold text-[.9375rem]",
                                    children: t == null ? void 0 : t.status
                                })]
                            })]
                        })]
                    })]
                }), A(ae.div, {
                    className: "relative [grid-area:vips] w-full h-full p-5 flex flex-col gap-2 justify-between",
                    variants: a,
                    children: [P(xr, {}), P("div", {
                        className: "flex flex-col gap-5 overflow-y-auto",
                        children: t == null ? void 0 : t.vips.map(c => A("div", {
                            className: "flex items-center gap-2",
                            children: [P("svg", {
                                width: "32",
                                height: "32",
                                viewBox: "0 0 32 32",
                                fill: "none",
                                xmlns: "http://www.w3.org/2000/svg",
                                children: P("path", {
                                    d: "M27.6446 12.4574C27.4917 12.3189 27.3025 12.2307 27.1012 12.204C26.8998 12.1773 26.6954 12.2134 26.5138 12.3075L21.239 15.0371L16.8795 7.51647C16.788 7.3589 16.6589 7.22854 16.5046 7.13805C16.3503 7.04755 16.1761 7 15.9988 7C15.8216 7 15.6474 7.04755 15.4931 7.13805C15.3388 7.22854 15.2096 7.3589 15.1182 7.51647L10.7586 15.0371L5.48588 12.3086C5.30435 12.2145 5.10004 12.1783 4.89872 12.2047C4.69741 12.231 4.50812 12.3186 4.35473 12.4565C4.20135 12.5943 4.09074 12.7763 4.03687 12.9793C3.98299 13.1824 3.98827 13.3974 4.05202 13.5974L7.81464 25.5628C7.84298 25.6531 7.89052 25.7357 7.95375 25.8043C8.01698 25.873 8.09427 25.926 8.17992 25.9594C8.26556 25.9929 8.35735 26.0059 8.4485 25.9975C8.53965 25.9892 8.62782 25.9597 8.70648 25.9111C8.7136 25.9111 9.37358 25.5058 10.598 25.111C11.7278 24.7458 13.5796 24.311 15.9988 24.311C18.4181 24.311 20.2699 24.7458 21.4007 25.111C22.621 25.5058 23.2851 25.9069 23.2902 25.9101C23.3688 25.9588 23.457 25.9886 23.5482 25.9971C23.6394 26.0056 23.7313 25.9927 23.8171 25.9594C23.9028 25.926 23.9803 25.8731 24.0436 25.8044C24.107 25.7358 24.1546 25.6532 24.183 25.5628L27.9457 13.5995C28.0112 13.3997 28.0176 13.1841 27.964 12.9805C27.9103 12.7769 27.7991 12.5947 27.6446 12.4574ZM23.2424 24.4725C22.1238 23.9531 19.6425 23.0443 15.9988 23.0443C12.3552 23.0443 9.87391 23.9531 8.75529 24.4725L5.35368 13.6554L10.3722 16.252C10.6039 16.3705 10.8699 16.3948 11.118 16.3199C11.366 16.2451 11.5781 16.0767 11.7125 15.8477L15.9988 8.45906L20.2852 15.853C20.4196 16.0817 20.6315 16.25 20.8793 16.3248C21.1271 16.3996 21.3929 16.3755 21.6245 16.2573L26.644 13.6596L23.2424 24.4725Z",
                                    fill: "#FE3800"
                                })
                            }), A("div", {
                                className: "flex flex-col gap-1",
                                children: [P("span", {
                                    className: "text-xs leading-[1] text-white/60",
                                    children: "VIP"
                                }), P("p", {
                                    className: "text-white font-bold text-[.9375rem] leading-[1]",
                                    children: c
                                })]
                            })]
                        }))
                    }), A("div", {
                        className: "flex flex-col items-center gap-2.5",
                        children: [P("span", {
                            className: "text-[10px] text-white/80 leading-[1]",
                            children: "N\xC3O POSSUI VIP? FIQUE CALMO"
                        }), P(ae.button, {
                            className: "w-full h-10 rounded-[.1875rem] bg-primary shadow shadow-primary text-white font-bold text-[.875rem] leading-[1]",
                            variants: u,
                            whileHover: "hover",
                            whileTap: "tap",
                            onClick: o,
                            children: "ADQUIRIR"
                        })]
                    })]
                }), A(ae.div, {
                    className: "relative [grid-area:shop] w-full h-full",
                    variants: a,
                    whileHover: {
                        scale: 1.02
                    },
                    transition: {
                        duration: .2
                    },
                    children: [P(xr, {}), P("img", {
                        src: S6,
                        alt: ""
                    }), A("div", {
                        className: "absolute bottom-6 left-1/2 -translate-x-1/2 w-[13.75rem] flex flex-col items-center gap-2.5",
                        children: [P("span", {
                            className: "text-[10px] text-white/80 leading-[1]",
                            children: "VOC\xCA SER\xC1 REDIRECIONADO AO SITE"
                        }), P(ae.button, {
                            className: "w-full h-10 rounded-[.1875rem] bg-primary shadow shadow-primary text-white font-bold text-[.875rem] leading-[1]",
                            variants: u,
                            whileHover: "hover",
                            whileTap: "tap",
                            onClick: () => je("GetStoreUrl", null, !0).then(c => window.invokeNative("openUrl", c)),
                            children: "ADQUIRIR"
                        })]
                    })]
                }), A(ae.div, {
                    className: "relative [grid-area:bet] w-full h-full p-[1.5625rem] flex flex-col justify-between",
                    variants: a,
                    whileHover: {
                        scale: 1.02
                    },
                    transition: {
                        duration: .2
                    },
                    children: [P(xr, {}), P("img", {
                        src: P6,
                        alt: "",
                        className: "absolute right-0 bottom-0"
                    }), A("div", {
                        className: "flex flex-col",
                        children: [P("span", {
                            className: "text-white font-bold text-[1.875rem] leading-[1]",
                            children: "NOVA BET"
                        }), P("p", {
                            className: "text-white/80 text-[.6875rem] leading-[1]",
                            children: "QUE TAL GANHAR UMA GRANA EXTRA?"
                        })]
                    }), P(ae.button, {
                        className: "z-20 w-[12.5rem] cursor-pointer h-10 rounded-[.1875rem] bg-primary shadow shadow-primary text-white font-bold text-[.875rem] leading-[1]",
                        variants: u,
                        whileHover: "hover",
                        whileTap: "tap",
                        onClick: i,
                        children: "ACESSAR"
                    })]
                }), A(ae.div, {
                    className: "relative [grid-area:skins] w-full h-full flex flex-col justify-center gap-5 p-[1.875rem]",
                    variants: a,
                    whileHover: {
                        scale: 1.02
                    },
                    transition: {
                        duration: .2
                    },
                    children: [A("div", {
                        className: "flex flex-col w-[15.625rem]",
                        children: [P("span", {
                            className: "text-white font-bold text-[1.875rem] leading-[1]",
                            children: "SKINS"
                        }), P("p", {
                            className: "text-white/80 text-[.6875rem] leading-[1]",
                            children: "A CADA 30 DIAS A ROTA\xC7AO DE ARMAS \xC9 ALTERADA."
                        })]
                    }), P(ae.button, {
                        className: "w-[13.125rem] h-10 button-skins",
                        variants: u,
                        whileHover: "hover",
                        whileTap: "tap",
                        onClick: n,
                        children: "ACESSAR"
                    }), P("img", {
                        src: k6,
                        alt: "",
                        className: "absolute right-0 bottom-0 -z-10"
                    })]
                }), A(ae.div, {
                    className: "relative [grid-area:pass] w-full h-full",
                    variants: a,
                    whileHover: {
                        scale: 1.02
                    },
                    transition: {
                        duration: .2
                    },
                    children: [P("img", {
                        src: R6,
                        alt: "",
                        className: "absolute right-0 bottom-0 -z-10"
                    }), A("div", {
                        className: "absolute top-1/2 -translate-y-1/2 right-[1.875rem] w-[13.75rem] flex flex-col items-center gap-2.5",
                        children: [P("span", {
                            className: "text-[10px] text-white/80 leading-[1]",
                            children: "VOC\xCA SER\xC1 REDIRECIONADO AO SITE"
                        }), P(ae.button, {
                            className: "w-full h-10 rounded-[.1875rem] text-white font-bold text-[.875rem] leading-[1] button-pass cursor-pointer",
                            variants: u,
                            whileHover: "hover",
                            whileTap: "tap",
                            onClick: r,
                            children: "ACESSAR"
                        })]
                    })]
                })]
            }), A(ae.div, {
                className: "w-[19.375rem] h-full flex flex-col gap-3",
                variants: l,
                children: [A(ae.div, {
                    className: "relative w-full h-[9.9375rem] p-[1.5625rem] flex flex-col justify-between",
                    variants: a,
                    whileHover: {
                        scale: 1.02
                    },
                    transition: {
                        duration: .2
                    },
                    children: [P(xr, {}), P("img", {
                        src: E6,
                        alt: "",
                        className: "absolute right-0 bottom-0 -z-10"
                    }), A("div", {
                        className: "flex flex-col",
                        children: [P("span", {
                            className: "text-white font-bold text-[1.875rem] leading-[1]",
                            children: "RANKING"
                        }), P("p", {
                            className: "text-white/80 text-[.6875rem] leading-[1]",
                            children: "VEJ\xC1 OS MELHORES"
                        })]
                    }), P(ae.button, {
                        className: "w-[12.5rem] h-10 rounded-[.1875rem] bg-primary shadow shadow-primary text-white font-bold text-[.875rem] leading-[1]",
                        variants: u,
                        whileHover: "hover",
                        whileTap: "tap",
                        onClick: () => e("/rankings"),
                        children: "ACESSAR"
                    })]
                }), A(ae.div, {
                    className: "relative w-full h-[35.6875rem] p-[1.5625rem] flex flex-col justify-between",
                    variants: a,
                    whileHover: {
                        scale: 1.02
                    },
                    transition: {
                        duration: .2
                    },
                    children: [P("img", {
                        src: T6,
                        alt: "",
                        className: "absolute right-0 bottom-0 -z-10 w-full h-full"
                    }), A("div", {
                        className: "absolute bottom-6 left-1/2 -translate-x-1/2 w-[13.75rem] flex flex-col items-center gap-2.5",
                        children: [P("span", {
                            className: "text-[10px] text-white/80 leading-[1]",
                            children: "VOC\xCA SER\xC1 REDIRECIONADO AO SITE"
                        }), P(ae.button, {
                            className: "w-full h-10 rounded-[.1875rem] bg-gradient-to-b from-[#FE0004] to-[#920002] text-white font-bold text-[.875rem] leading-[1]",
                            variants: u,
                            whileHover: "hover",
                            whileTap: "tap",
                            onClick: s,
                            children: "ADQUIRIR"
                        })]
                    })]
                })]
            })]
        })]
    })
}
rl.createRoot(document.getElementById("root")).render(P(so.StrictMode, {
    children: P(Tv, {
        children: P(zv, {
            children: A(tv, {
                children: [P(Xl, {
                    path: "*",
                    element: P(A6, {})
                }), P(Xl, {
                    path: "/rankings",
                    element: P(ty, {})
                })]
            })
        })
    })
}));
