require_relative "spec_helper"
require_relative "../atbash"

describe Atbash do
  describe ".decrypt" do
    describe "cipher validation" do
      let(:encrypted_text) { "abc" }

      context "when the cipher is empty" do
        let(:cipher) { "" }

        it "raises an error" do
          expect { Atbash.decrypt(cipher, encrypted_text) }.to raise_error(RuntimeError, "Invalid cipher")
        end
      end

      context "when the cipher is not given" do
        let(:cipher) { nil }

        it "raises an error" do
          expect { Atbash.decrypt(cipher, encrypted_text) }.to raise_error(RuntimeError, "Missing cipher")
        end
      end
    end

    describe "encrypted text validation" do
      context "when the encrypted text is empty" do
        let(:cipher) { "xipmuzfkbrlwotjancqgveshdy" }
        let(:encrypted_text) { "" }

        it "returns an empty result" do
          expect(Atbash.decrypt(cipher, encrypted_text)).to be_empty
        end
      end

      context "when the encrypted text is not given" do
        let(:cipher) { "zodvqukgwefbyitmrsplhacxnj" }
        let(:encrypted_text) { nil }

        it "raises an error" do
          expect { Atbash.decrypt(cipher, encrypted_text) }.to raise_error(RuntimeError, "Missing encrypted_text")
        end
      end
    end

    context "when the given strings letter-case varies" do
      context "when the encrypted text only contains uppercase letters" do
        let(:cipher) { "zodvqukgwefbyitmrsplhacxnj" }
        let(:encrypted_text) { "DZS" }
        let(:original_text) { "car" }

        it "decrypts the given encrypted text ignoring the letter-case" do
          expect(Atbash.decrypt(cipher, encrypted_text)).to eq original_text
        end
      end

      context "when the encrypted text has a mixture of letter case" do
        let(:cipher) { "zodvqukgwefbyitmrsplhacxnj" }
        let(:encrypted_text) { "DzS" }
        let(:original_text) { "car" }

        it "decrypts the given encrypted text ignoring the letter-case" do
          expect(Atbash.decrypt(cipher, encrypted_text)).to eq original_text
        end
      end

      context "when the cipher only contains uppercase letters" do
        let(:cipher) { "zodvqukgwefbyitmrsplhacxnj".upcase }
        let(:encrypted_text) { "dzs" }
        let(:original_text) { "car" }

        it "decrypts the given encrypted text ignoring the letter-case" do
          expect(Atbash.decrypt(cipher, encrypted_text)).to eq original_text
        end
      end
    end

    context "when the encrypted text contains non-english alphabet letters" do
      context "when the encrypted text is a question" do
        let(:cipher) { "xipmuzfkbrlwotjancqgveshdy" }
        let(:encrypted_text) { "skd qj qucbjvq?" }
        let(:original_text) { "why so serious?" }

        it "decrypts the given encrypted letters but leaves the rest of the encrypted text untouched" do
          expect(Atbash.decrypt(cipher, encrypted_text)).to eq original_text
        end
      end

      context "when the encrypted text contains letters and punctuation" do
        let(:cipher) { "oephjizkxdawubnytvfglqsrcm" }
        let(:encrypted_text) { "knlfgnb, sj koqj o yvnewju" }
        let(:original_text) { "houston, we have a problem" }

        it "decrypts the given encrypted letters but leaves the rest of the encrypted text untouched" do
          expect(Atbash.decrypt(cipher, encrypted_text)).to eq original_text
        end
      end

      context "when the encrypted text only contains punctuation" do
        let(:cipher) { "xipmuzfkbrlwotjancqgveshdy" }
        let(:encrypted_text) { "?><)(*&^%$%^&*" }

        it "returns the encrypted text" do
          expect(Atbash.decrypt(cipher, encrypted_text)).to eq encrypted_text
        end
      end

      context "when the encrypted text contains letters, punctuation, spaces and numbers" do
        let(:cipher) { "xipmuzfkbrlwotjancqgveshdy" }
        let(:encrypted_text) { "asdef?><)(* sdfds2343 &^%$asdsd asdsad%4546^&*" }
        let(:original_text) { "pwyvg?><)(* wygyw2343 &^%$pwywy pwywpy%4546^&*" }

        it "returns the encrypted text" do
          expect(Atbash.decrypt(cipher, encrypted_text)).to eq original_text
        end
      end
    end

    context "when the encrypted text only contains english alphabet letters" do
      let(:cipher) { "zodvqukgwefbyitmrsplhacxnj" }
      let(:encrypted_text) { "dzs" }
      let(:original_text) { "car" }

      it "decrypts the given encrypted text" do
        expect(Atbash.decrypt(cipher, encrypted_text)).to eq original_text
      end
    end
  end
end