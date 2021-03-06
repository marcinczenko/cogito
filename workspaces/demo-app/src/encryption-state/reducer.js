const encryptionReducer = (state = initialState, action) => {
  switch (action.type) {
    case 'ENCRYPTION_SET_PLAINTEXT':
      return { ...state, plainText: action.plainText }
    case 'ENCRYPTION_SET_CIPHERTEXT':
      return { ...state, cipherText: action.cipherText }
    case 'ENCRYPTION_SET_KEY_TAG':
      return { ...state, keyTag: action.tag }
    default:
      return { ...state }
  }
}

const initialState = {
  plainText: '',
  cipherText: ''
}

export { encryptionReducer }
