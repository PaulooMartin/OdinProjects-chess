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

  describe '#transform_player_input_to_origin_destination' do
    context 'when transforming the player_input' do
      it 'returns an array' do
        player_input = 'a1f5'
        result = Player.transform_player_input_to_origin_destination(player_input)
        expect(result).to be_an(Array)
      end

      it 'has two elements' do
        player_input = 'a1f5'
        result = Player.transform_player_input_to_origin_destination(player_input).length
        expect(result).to eq(2)
      end

      it 'all elements are an Array' do
        player_input = 'a1f5'
        origin_destination = Player.transform_player_input_to_origin_destination(player_input)
        result = origin_destination.all? { |element| element.is_a?(Array) }
        expect(result).to be(true)
      end

      it 'all elements has two elements' do
        player_input = 'a1f8'
        origin_destination = Player.transform_player_input_to_origin_destination(player_input)
        result = origin_destination.all? { |coords| coords.length == 2 }
        expect(result).to be(true)
      end

      it 'all elements within all elements are numbers between 0 and 7' do
        player_input = 'a3f8'
        origin_destination = Player.transform_player_input_to_origin_destination(player_input)
        result = origin_destination.all? { |coords| coords.all? { |coord| coord.between?(0, 7) } }
        expect(result).to be(true)
      end
    end
  end
end
