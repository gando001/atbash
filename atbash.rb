class Atbash
  CONSTANT = ('a'..'z').sort.freeze

  def self.decrypt(cipher, encrypted_text)
    raise "Missing cipher" unless cipher
    raise "Missing encrypted_text" unless encrypted_text
    raise "Invalid cipher" unless cipher.length == CONSTANT.length

    cipher_chars = cipher.downcase.chars

    encrypted_text.downcase.chars.collect do |encrypted_letter|
      cipher_index = cipher_chars.index(encrypted_letter)

      cipher_index ? CONSTANT[cipher_index] : encrypted_letter
    end.join
  end
end