require 'player'
require 'chess_pieces'

# rubocop:disable Metrics/BlockLength
describe Player do
  subject(:player) { described_class.new('name', 'light') }
  describe '#prompt_player' do
    context 'when prompting player' do
      before do
        allow(player).to receive(:print)
        allow(player).to receive(:gets).and_return("A1f4\n")
      end

      it 'prompts the player' do
        expect(player).to receive(:gets)
        player.prompt_player
      end

      it "returns player's input" do
        player_input = 'a1f4'
        result = player.prompt_player
        expect(result).to eq(player_input)
      end
    end

    context 'when player gives invalid inputs' do
      before do
        invalid_a = "3f3a\n"
        invalid_b = "%ekjfv\n"
        invalid_c = "a4 a5\n"
        invalid_d = "1356\n"
        valid = "a5D5\n"
        allow(player).to receive(:print)
        allow(player).to receive(:gets).and_return(invalid_a, invalid_b, invalid_c, invalid_d, valid)
      end

      it 'prompts the player again until player gives a valid input' do
        expect(player).to receive(:gets).exactly(5).times
        player.prompt_player
      end

      it 'returns only when player gives a valid input' do
        valid_input = 'a5d5'
        result = player.prompt_player
        expect(result).to eq(valid_input)
      end
    end
  end
end
