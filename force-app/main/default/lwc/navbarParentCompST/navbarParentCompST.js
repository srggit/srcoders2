import { LightningElement } from 'lwc';

export default class NavbarParentCompST extends LightningElement {
    selectedPlayer = null;

    navList = [
        {
            id: 1,
            name: 'Virat Kohli',
            imgUrl:
                'https://www.cricbuzz.com/a/img/v1/152x152/i1/c170661/virat-kohli.jpg',
            country: 'India',
            rating: '922',
            position: '1',
            selected: false
        },
        {
            id: 2,
            name: 'Steven Smith',
            imgUrl:
                'https://www.cricbuzz.com/a/img/v1/152x152/i1/c170624/steven-smith.jpg',
            country: 'Australia',
            rating: '913',
            position: '2',
            selected: false
        },
        {
            id: 3,
            name: 'Kane Williamson',
            imgUrl:
                'https://www.cricbuzz.com/a/img/v1/152x152/i1/c170733/kane-williamson.jpg',
            country: 'New Zealand',
            rating: '887',
            position: '3',
            selected: false
        },
        {
            id: 4,
            name: 'Joe Root',
            imgUrl:
                'https://www.cricbuzz.com/a/img/v1/152x152/i1/c170942/joe-root.jpg',
            country: 'England',
            rating: '710',
            position: '4',
            selected: false
        },
        {
            id: 5,
            name: 'David Warner',
            imgUrl:
                'https://www.cricbuzz.com/a/img/v1/152x152/i1/c170635/david-warner.jpg',
            country: 'Australia',
            rating: '687',
            position: '5',
            selected: false
        }
    ];

    showSelectedImage(event){
        console.log('Image Displayed');

        const playerName = event.detail;

        console.log('Parent ;',playerName);
        this.selectedPlayer = this.navList.find(player => player.name === playerName);
        console.log('Parent ;',this.selectedPlayer.name );

        /*
        this.navList.forEach(player => {
            if(player.name === playerName){
                player.selected = true;
            }
        });
        */  
    }
}