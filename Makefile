all : clean
		rails new build -m ./spawnpoint.rb
clean:
		rm -rf ./build
