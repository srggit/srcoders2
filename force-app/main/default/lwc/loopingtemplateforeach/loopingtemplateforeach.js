import { LightningElement } from 'lwc';

export default class Loopingtemplateforeach extends LightningElement {

    carList = ['Audi', 'BMW', 'Mercedes', 'Porsche', 'Fiat', 'Ford'];

    programmingList = [
        {
            id: '0010',
            name: 'JavaScript'
        },
        {
            id: '0020',
            name: 'Java'
        },
        {
            id: '0030',
            name: 'C++'
        },
        {
            id: '0040',
            name: 'Python'
        },
        {
            id: '0050',
            name: 'C#'
        },
        {
            id: '0060',
            name: 'PHP'
        }
    ];

    ceoList = [
    {
      id: 1,
      company: "Google",
      name: "Sundar Pichai"
    },
    {
      id: 2,
      company: "Apple Inc.",
      name: "Tim cook"
    },
    {
      id: 3,
      company: "Facebook",
      name: "Mark Zuckerberg"
    },
    {
      id: 4,
      company: "Amazon.com",
      name: "Jeff Bezos"
    },
    {
      id: 5,
      company: "Capgemini",
      name: "Paul Hermelin"
    }
  ];
}