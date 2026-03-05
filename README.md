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
getFCMToken() => Promise<{ value: string; }>
```

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

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

</docgen-api>
