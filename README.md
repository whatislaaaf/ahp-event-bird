# ahp-event-bird

private features of Adhd Hyper Planner App

## Install

```bash
npm install ahp-event-bird
npx cap sync
```

## API

<docgen-index>

* [`saveCredentials(...)`](#savecredentials)
* [`startProgressActivity(...)`](#startprogressactivity)
* [`completeProgressActivity(...)`](#completeprogressactivity)
* [`getFCMToken()`](#getfcmtoken)
* [`clearFCMToken()`](#clearfcmtoken)
* [`signInWithGoogle()`](#signinwithgoogle)
* [`signInWithApple()`](#signinwithapple)
* [`pauseProgressActivity()`](#pauseprogressactivity)
* [`resumeProgressActivity(...)`](#resumeprogressactivity)
* [`syncWidgetData(...)`](#syncwidgetdata)
* [`addListener('appUpdateRequired', ...)`](#addlistenerappupdaterequired-)
* [`removeAllListeners()`](#removealllisteners)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### saveCredentials(...)

```typescript
saveCredentials(options: Credentials) => Promise<IsSuccess>
```

| Param         | Type                                                |
| ------------- | --------------------------------------------------- |
| **`options`** | <code><a href="#credentials">Credentials</a></code> |

**Returns:** <code>Promise&lt;<a href="#issuccess">IsSuccess</a>&gt;</code>

--------------------


### startProgressActivity(...)

```typescript
startProgressActivity(data: ProgressActivity) => Promise<void>
```

| Param      | Type                                                          |
| ---------- | ------------------------------------------------------------- |
| **`data`** | <code><a href="#progressactivity">ProgressActivity</a></code> |

--------------------


### completeProgressActivity(...)

```typescript
completeProgressActivity(data: ProgressActivity) => Promise<void>
```

| Param      | Type                                                          |
| ---------- | ------------------------------------------------------------- |
| **`data`** | <code><a href="#progressactivity">ProgressActivity</a></code> |

--------------------


### getFCMToken()

```typescript
getFCMToken() => Promise<{ fcmToken: string; deviceId: string; }>
```

**Returns:** <code>Promise&lt;{ fcmToken: string; deviceId: string; }&gt;</code>

--------------------


### clearFCMToken()

```typescript
clearFCMToken() => Promise<void>
```

--------------------


### signInWithGoogle()

```typescript
signInWithGoogle() => Promise<GoogleSignInResult>
```

**Returns:** <code>Promise&lt;<a href="#googlesigninresult">GoogleSignInResult</a>&gt;</code>

--------------------


### signInWithApple()

```typescript
signInWithApple() => Promise<AppleSignInResult>
```

**Returns:** <code>Promise&lt;<a href="#applesigninresult">AppleSignInResult</a>&gt;</code>

--------------------


### pauseProgressActivity()

```typescript
pauseProgressActivity() => Promise<void>
```

--------------------


### resumeProgressActivity(...)

```typescript
resumeProgressActivity(data: { startedAt: string; }) => Promise<void>
```

| Param      | Type                                |
| ---------- | ----------------------------------- |
| **`data`** | <code>{ startedAt: string; }</code> |

--------------------


### syncWidgetData(...)

```typescript
syncWidgetData(_: WidgetSyncData) => Promise<void>
```

| Param   | Type                                                      |
| ------- | --------------------------------------------------------- |
| **`_`** | <code><a href="#widgetsyncdata">WidgetSyncData</a></code> |

--------------------


### addListener('appUpdateRequired', ...)

```typescript
addListener(eventName: 'appUpdateRequired', listenerFunc: (event: AppUpdateEvent) => void) => Promise<PluginListenerHandle>
```

| Param              | Type                                                                          |
| ------------------ | ----------------------------------------------------------------------------- |
| **`eventName`**    | <code>'appUpdateRequired'</code>                                              |
| **`listenerFunc`** | <code>(event: <a href="#appupdateevent">AppUpdateEvent</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt;</code>

--------------------


### removeAllListeners()

```typescript
removeAllListeners() => Promise<void>
```

--------------------


### Interfaces


#### IsSuccess

| Prop            | Type                 |
| --------------- | -------------------- |
| **`isSuccess`** | <code>boolean</code> |


#### Credentials

| Prop           | Type                |
| -------------- | ------------------- |
| **`username`** | <code>string</code> |
| **`password`** | <code>string</code> |


#### ProgressActivity

| Prop             | Type                |
| ---------------- | ------------------- |
| **`progressId`** | <code>string</code> |
| **`taskName`**   | <code>string</code> |
| **`startedAt`**  | <code>string</code> |


#### GoogleSignInResult

| Prop              | Type                |
| ----------------- | ------------------- |
| **`idToken`**     | <code>string</code> |
| **`email`**       | <code>string</code> |
| **`displayName`** | <code>string</code> |


#### AppleSignInResult

| Prop              | Type                |
| ----------------- | ------------------- |
| **`idToken`**     | <code>string</code> |
| **`email`**       | <code>string</code> |
| **`displayName`** | <code>string</code> |


#### WidgetSyncData

| Prop                 | Type                |
| -------------------- | ------------------- |
| **`tasks`**          | <code>string</code> |
| **`totalCount`**     | <code>number</code> |
| **`completedCount`** | <code>number</code> |
| **`focusTaskName`**  | <code>string</code> |
| **`focusStartedAt`** | <code>string</code> |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### AppUpdateEvent

| Prop                  | Type                               | Description                                                                 |
| --------------------- | ---------------------------------- | --------------------------------------------------------------------------- |
| **`kind`**            | <code>'blocking' \| 'patch'</code> | 'blocking' = minor/major behind, full overlay; 'patch' = non-blocking alert |
| **`currentVersion`**  | <code>string</code>                |                                                                             |
| **`appStoreVersion`** | <code>string</code>                |                                                                             |
| **`appStoreUrl`**     | <code>string</code>                | App Store deep link, e.g. itms-apps://apps.apple.com/app/id6759459572       |
| **`releaseNotes`**    | <code>string</code>                |                                                                             |

</docgen-api>
