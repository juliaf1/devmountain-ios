//
//  BookController.swift
//  BookPicks
//
//  Created by Julia Frederico on 05/10/22.
//

import Foundation

class BookController {
    var books: [Book]
    
    init() {
        let b1 = Book(title: "Anarquistas Graças a Deus",
                      author: "Zelia Gattai",
                      description: "Filha de anarquistas chegados de Florença, por parte do pai Ernesto, e de católicos originários do Vêneto, da parte da mãe Angelina, a escritora trazia no sangue o calor de seus livros. Trinta e quatro anos depois de se casar com Jorge Amado, a sempre apaixonada Zélia abandona a posição de coadjuvante no mundo literário e experimenta a própria voz para contar a saga de sua família.",
                      stringDate: "01/01/1979",
                      photo: "anarquistas",
                      rating: 4)
        
        let b2 = Book(title: "Prólogo, Ato, Epílogo",
                      author: "Fernanda Montenegro",
                      description: "Em Prólogo, ato, epílogo, Fernanda Montenegro narra suas memórias numa prosa afetiva, cheia de inteligência e sensibilidade. Com sua voz inconfundível, ela coloca no papel a saga de seus antepassados lavradores portugueses, do lado paterno, e pastores sardos, do lado materno. Lidas hoje, são histórias que podem 'parecer um folhetim. Ou uma tragédia' – gêneros que a atriz domina com maestria.",
                      stringDate: "20/09/2019",
                      photo: "prologo",
                      rating: 5)
        
        let b3 = Book(title: "As Veias Abertas da América Latina",
                      author: "Eduardo Galeano",
                      description: "Remontando a 1970, sua primeira edição, atualizada em 1977, quando a maioria dos países do continente padecia facinorosas ditaduras, este livro tornou-se um 'clássico libertário', um inventário da dependência e da vassalagem de que a América Latina tem sido vítima, desde que nela aportaram os europeus no final do século XV. No começo, espanhóis e portugueses. Depois vieram ingleses, holandeses, franceses, modernamente os norte-americanos, e o ancestral cenário permanece - a mesma submissão, a mesma miséria, a mesma espoliação.",
                      stringDate: "01/01/1971",
                      photo: "galeano1",
                      rating: 4)
        
        let b4 = Book(title: "A Câmara Clara",
                      author: "Roland Barthes",
                      description: "Publicado pela primeira vez 1980, A câmara clara inovou a abordagem da linguagem fotográfica e se tornou uma das maiores referências no assunto até hoje. O clássico de Roland Barthes não é um tratado sobre a fotografia como arte, nem uma história sobre o tema. Como em muitos de seus trabalhos, o escritor francês rejeita os caminhos mais percorridos e se lança à tarefa de decifrar o signo expressivo, o objeto artístico, a “obra” entendida como mecanismo produtor de sentido.",
                      stringDate: "01/01/1980",
                      photo: "camara",
                      rating: 4)
        
        let b5 = Book(title: "A Amiga Genial",
                      author: "Elena Ferrante",
                      description: "A Série Napolitana, formada por quatro romances, conta a história de duas amigas ao longo de suas vidas. O primeiro, A amiga genial, é narrado pela personagem Elena Greco e cobre da infância aos 16 anos. As meninas se conhecem em uma vizinhança pobre de Nápoles, na década de 1950. Elena, a menina mais inteligente da turma, tem sua vida transformada quando a família do sapateiro Cerullo chega ao bairro e Raffaella, uma criança magra, mal comportada e selvagem, se torna o centro das atenções.",
                      stringDate: "30/10/2013",
                      photo: "ferrante1",
                      rating: 5)
        
        let b6 = Book(title: "O Mundo Codificado",
                      author: "Vilem Flusser",
                      description: "A obra de Vilém Flusser (1920-1991) desvenda a tentativa milenar da humanidade de superar suas limitações físicas por meio da tecnologia. Nesse processo, o autor demonstra que os designers, embora tenham um papel central, caminham sobre um chão conceitual muito frágil. As teorias apresentadas destroem lugares comuns e verdades superficiais, além de lançarem luz sobre problemas que sequer começamos a enfrentar.",
                      stringDate: "01/04/2007",
                      photo: "flusser",
                      rating: 5)
        
        self.books = [b1, b2, b3, b4, b5, b6]
    }
    
    // CRUD Functions
    
    func create(bookWithTitle title: String, author: String, description: String, date: String, photo: String, rating: Int) -> Book {
        let book = Book(title: title, author: author, description: description, stringDate: date, photo: photo, rating: rating)
        self.books.append(book)
        return book
    }
    
    func delete(book: Book) -> Bool {
        guard let index = self.books.firstIndex(where: { $0 == book }) else { return false }
        books.remove(at: index)
        return true
    }

}
