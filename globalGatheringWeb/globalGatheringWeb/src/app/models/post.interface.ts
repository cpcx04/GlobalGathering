export interface Post {
    uuid: string;
    uri: string;
    comment: string;
    relatedEvent: string;
    createdBy: string;
    createdAt: Date;
  }

export interface NewPost{
    relatedEvent : string,
    comment : string
}
  